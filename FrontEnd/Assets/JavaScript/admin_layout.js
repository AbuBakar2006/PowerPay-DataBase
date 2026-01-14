const AdminLayout = {
    /**
     * Renders the Admin Sidebar
     * @param {string} activePage - The identifier of the active page
     */
    renderSidebar: function (activePage) {
        const container = document.getElementById('sidebar-container');
        if (!container) return;

        const menuItems = [
            { id: 'dashboard', label: 'Dashboard', icon: 'fa-chart-line', path: '../dashboard/dashboard.html' },
            { id: 'customers', label: 'Customers', icon: 'fa-users', path: '../customers/customers.html' },
            { id: 'billing', label: 'Billing', icon: 'fa-file-invoice-dollar', path: '../billing/billing.html' },
            { id: 'charges', label: 'Charges', icon: 'fa-tags', path: '../charges/charges.html' }
        ];

        const menuHtml = menuItems.map(item => {
            const isActive = activePage === item.id ? 'active' : '';
            return `
                <li class="nav-item">
                    <a href="${item.path}" class="nav-link ${isActive}">
                        <span class="nav-icon"><i class="fa-solid ${item.icon}"></i></span>
                        ${item.label}
                    </a>
                </li>
            `;
        }).join('');

        const sidebar = document.createElement('aside');
        sidebar.className = 'sidebar slideInLeft';
        sidebar.innerHTML = `
            <div class="sidebar-header">
                <div class="brand">
                    <i class="fa-solid fa-bolt" style="color: var(--primary-color); margin-right: 0.5rem;"></i>
                    PowerPay Admin
                </div>
            </div>
            <ul class="nav-menu">
                ${menuHtml}
            </ul>
            <div class="sidebar-footer">
                <div class="user-mini-profile">
                    <div class="user-info">
                        <div class="user-role">Administrator</div>
                    </div>
                    <button class="btn-logout" onclick="Session.logout()" title="Logout">
                        <i class="fa-solid fa-sign-out-alt"></i>
                    </button>
                </div>
            </div>
        `;

        if (container.parentNode) {
            container.parentNode.replaceChild(sidebar, container);
        }
    },

    /**
     * Renders the Admin Page Header
     * @param {string} title - The main H1 title
     */
    renderHeader: function (title) {
        const container = document.getElementById('header-container');
        if (!container) return;

        const header = document.createElement('header');
        header.className = 'topbar fade-in';
        // Using same customer layout style if appropriate, or simpler for admin
        header.innerHTML = `
             <div class="header" style="margin-bottom: 2rem;">
                <h1 class="page-title">${title}</h1>
            </div>
        `;

        if (container.parentNode) {
            container.parentNode.replaceChild(header, container);
        }
    }
};
