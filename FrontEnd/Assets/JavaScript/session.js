/**
 * Session Management
 * Simulates login state using localStorage
 */

const Session = {
    // Keys
    TypeKey: 'userType', // 'admin' | 'customer'
    IdKey: 'userId',     // 'CUST-XXX' for customers

    // Login methods
    loginAdmin: () => {
        localStorage.setItem(Session.TypeKey, 'admin');
        localStorage.removeItem(Session.IdKey);
        // Assuming called from auth/login/login.html
        window.location.href = '../../admin/dashboard/dashboard.html';
    },

    loginCustomer: (customerId) => {
        localStorage.setItem(Session.TypeKey, 'customer');
        localStorage.setItem(Session.IdKey, customerId);
        // Assuming called from auth/login/login.html
        window.location.href = '../../customer/dashboard/dashboard.html';
    },

    logout: () => {
        localStorage.clear();
        // Redirect to login page
        // From admin/dashboard/dashboard.html -> ../../auth/login/login.html
        window.location.href = '../../auth/login/login.html';
    },

    // Check auth
    requireAdmin: () => {
        const type = localStorage.getItem(Session.TypeKey);
        if (type !== 'admin') {
            window.location.href = '../../auth/login/login.html';
        }
    },

    requireCustomer: () => {
        const type = localStorage.getItem(Session.TypeKey);
        const id = localStorage.getItem(Session.IdKey);
        if (type !== 'customer' || !id) {
            window.location.href = '../../auth/login/login.html';
        }
        return id; // Returns logged in customer ID
    },

    // Get current user info from mock data (REMOVED: Backend Mode)
    // Frontends should fetch user data via API using the ID.
    getCurrentCustomer: () => {
        return null;
    }
};

// Expose globally
if (typeof window !== 'undefined') {
    window.Session = Session;
}
