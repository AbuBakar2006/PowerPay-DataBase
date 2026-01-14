const Layout = {
    /**
     * Renders the Sidebar, replacing the container div
     * @param {string} activePage - The filename or identifier of the active page
     */
    renderSidebar: function (activePage) {
        const container = document.getElementById('sidebar-container');
        if (!container) return;

        // Path adjustment: Assuming we are in FrontEnd/customer/[subfolder]/[file].html
        // We need to go up one level to access sibling folders.
        // e.g. from dashboard/dashboard.html to meters/mymeters.html -> ../meters/mymeters.html

        const menuItems = [
            { id: 'dashboard', label: 'My Dashboard', icon: 'fa-home', path: '../dashboard/dashboard.html' },
            { id: 'transactions', label: 'Transactions', icon: 'fa-file-invoice-dollar', path: '../transactions/transactions.html' },
            { id: 'mymeters', label: 'My Meters', icon: 'fa-tachometer-alt', path: '../meters/mymeters.html' },
            { id: 'profile', label: 'Settings', icon: 'fa-user', path: '../profile/profile.html' }
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

        // Create the actual ASIDE element
        const sidebar = document.createElement('aside');
        sidebar.className = 'sidebar slideInLeft';
        sidebar.innerHTML = `
            <div class="sidebar-header">
                <div class="brand">
                    <i class="fa-solid fa-bolt" style="color: var(--primary-color); margin-right: 0.5rem;"></i>
                    PowerPay Client
                </div>
            </div>
            <ul class="nav-menu">
                ${menuHtml}
            </ul>
            <div class="sidebar-footer">
                <div class="user-mini-profile">
                    <div class="user-avatar">ME</div>
                    <div class="user-info">
                        <div class="user-name" id="user-name-sidebar">Loading...</div>
                        <div class="user-role">Customer</div>
                    </div>
                    <button class="btn-logout" onclick="Session.logout()" title="Logout">
                        <i class="fa-solid fa-sign-out-alt"></i>
                    </button>
                </div>
            </div>
        `;

        // Replace the placeholder div with the new aside element
        if (container.parentNode) {
            container.parentNode.replaceChild(sidebar, container);
        }
    },

    /**
     * Renders the Page Header, replacing the container div
     * @param {string} title - The main H1 title
     * @param {string} subtitle - The muted subtitle text
     */
    renderHeader: function (title, subtitle) {
        const container = document.getElementById('header-container');
        if (!container) return;

        const header = document.createElement('header');
        header.className = 'topbar fade-in'; // Added fade-in class if needed, or use existing animations
        header.style.marginBottom = '2rem';

        header.innerHTML = `
            <div class="page-title">
                <h1 style="margin-bottom: 0.25rem;">${title}</h1>
                <p class="text-muted" style="font-size: 0.9rem;">${subtitle}</p>
            </div>
             <div class="topbar-actions">
                <button class="icon-btn">
                    <i class="fa-solid fa-bell"></i>
                </button>
            </div>
        `;

        if (container.parentNode) {
            container.parentNode.replaceChild(header, container);
        }
    }
};
