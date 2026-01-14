/**
 * Main Application Logic
 * Handles dashboard metrics, charts, and table rendering
 */

document.addEventListener('DOMContentLoaded', () => {
    // Check which page we are on
    const path = window.location.pathname;

    // OLD MOCK LOGIC: Always load dashboard stats if elements exist (so we can reuse basic stats logic)
    // loadDashboardStats(); // Disabled to prevent conflict with API data

    // Page specific loaders (Legacy support or Mock items)
    // Note: Most pages now use inline scripts with API.js
    if (path.endsWith('admin/dashboard/dashboard.html')) {
        // initDashboard(); // Disabled: Admin Dashboard uses inline API-based init
    } else if (path.endsWith('customers.html')) {
        // initCustomersPage(); // Disabled: Customers page uses inline API
    } else if (path.endsWith('billing.html')) {
        // initBillingPage(); // Disabled: Billing page uses inline API
    }
});

// --- Formatting Helpers ---
const formatCurrency = (amount) => {
    return new Intl.NumberFormat('en-PK', { style: 'currency', currency: 'PKR' }).format(amount);
};

const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString();
};

// --- Dashboard Logic ---
function loadDashboardStats() {
    // Total Customers
    const totalCustomers = mockData.customers.length;
    const elTotalCustomers = document.getElementById('total-customers');
    if (elTotalCustomers) elTotalCustomers.textContent = totalCustomers;

    // Active Accounts (Based on Customer Status here, or could be account based)
    // SQL Schema has AccountStatus on Customer table
    const activeAccounts = mockData.customers.filter(c => c.AccountStatus === 'Active').length;
    const elActiveAccounts = document.getElementById('active-accounts');
    if (elActiveAccounts) elActiveAccounts.textContent = activeAccounts;

    // Total Revenue (Sum of all payments)
    const totalRevenue = mockData.payments.reduce((sum, p) => sum + p.PaymentAmount, 0);
    const elTotalRevenue = document.getElementById('total-revenue');
    if (elTotalRevenue) elTotalRevenue.textContent = formatCurrency(totalRevenue);

    // Pending Payments (Sum of unpaid bills)
    const pendingPayments = mockData.bills
        .filter(b => b.PaymentStatus === 'Unpaid' || b.PaymentStatus === 'Pending')
        .reduce((sum, b) => sum + b.TotalAmount, 0);
    const elPending = document.getElementById('pending-payments');
    if (elPending) elPending.textContent = formatCurrency(pendingPayments);
}

function initDashboard() {
    // Render Chart
    renderRevenueChart();

    // Render Recent Payments Table
    const recentPayments = [...mockData.payments]
        .sort((a, b) => new Date(b.PaymentDate) - new Date(a.PaymentDate))
        .slice(0, 5);

    const tableBody = document.getElementById('recent-payments-table');
    if (tableBody) {
        tableBody.innerHTML = recentPayments.map(p => `
            <tr>
                <td>${p.PaymentID}</td>
                <td>${p.BillID}</td>
                <td>${formatDate(p.PaymentDate)}</td>
                <td>${formatCurrency(p.PaymentAmount)}</td>
                <td>${p.PaymentMethod}</td>
            </tr>
        `).join('');
    }
}

function renderRevenueChart() {
    const ctx = document.getElementById('revenueChart');
    if (!ctx) return;

    // Group payments by month
    const monthlyRevenue = {};
    mockData.payments.forEach(p => {
        const date = new Date(p.PaymentDate);
        const key = date.toLocaleString('default', { month: 'short', year: 'numeric' });
        monthlyRevenue[key] = (monthlyRevenue[key] || 0) + p.PaymentAmount;
    });

    const labels = Object.keys(monthlyRevenue);
    const data = Object.values(monthlyRevenue);

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Revenue (PKR)',
                data: data,
                borderColor: '#4f46e5',
                backgroundColor: 'rgba(79, 70, 229, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: '#f1f5f9'
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}

// --- Customers Page Logic ---
function initCustomersPage() {
    const tableBody = document.getElementById('customers-table-body');
    if (!tableBody) return;

    // Join Customer with Account Count (optional, showing simple data first)
    // Mapping simple data
    tableBody.innerHTML = mockData.customers.map(c => `
        <tr>
            <td>${c.CustomerID}</td>
            <td>
                <div style="font-weight: 500;">${c.FirstName} ${c.LastName}</div>
                <div style="font-size: 0.75rem; color: var(--text-muted);">${c.Email || '-'}</div>
            </td>
            <td>${c.PhoneNumber}</td>
            <td>${c.City}</td>
            <td>
                <span class="status-badge ${c.AccountStatus === 'Active' ? 'status-active' : 'status-inactive'}">
                    ${c.AccountStatus}
                </span>
            </td>
        </tr>
    `).join('');
}

// --- Billing Page Logic ---
function initBillingPage() {
    const tableBody = document.getElementById('billing-table-body');
    if (!tableBody) return;

    tableBody.innerHTML = mockData.bills.map(b => `
        <tr>
            <td>${b.BillID}</td>
            <td>${b.AccountID}</td>
            <td>${formatDate(b.IssueDate)}</td>
            <td>${formatDate(b.DueDate)}</td>
            <td style="font-weight: 500;">${formatCurrency(b.TotalAmount)}</td>
            <td>
                <span class="status-badge ${b.PaymentStatus === 'Paid' ? 'status-paid' : 'status-unpaid'}">
                    ${b.PaymentStatus}
                </span>
            </td>
        </tr>
    `).join('');
}
