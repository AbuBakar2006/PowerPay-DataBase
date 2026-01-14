const API_BASE_URL = 'http://127.0.0.1:5000/api';

const API = {
    // --- AUTH ---
    login: async (role, customerId = null) => {
        try {
            console.log("API: Attempting Login", { role, customerId });
            const res = await fetch(`${API_BASE_URL}/login`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ role, customerId })
            });
            if (!res.ok) throw new Error(`Login Failed: ${res.status}`);
            return await res.json();
        } catch (err) {
            console.error('Login Error:', err);
            return { success: false, message: 'Connection Error' };
        }
    },

    signup: async (userData) => {
        try {
            const res = await fetch(`${API_BASE_URL}/signup`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(userData)
            });
            return await res.json();
        } catch (err) {
            console.error('Signup Error:', err);
            return { success: false, message: 'Connection Error' };
        }
    },

    // --- CUSTOMERS ---
    getCustomers: async () => {
        try {
            const res = await fetch(`${API_BASE_URL}/customers`);
            if (!res.ok) throw new Error('API Error');
            return await res.json();
        } catch (e) {
            console.warn('API Failed, using Mock Data');
            return window.mockData.customers;
        }
    },

    getCustomer: async (id) => {
        try {
            const customers = await API.getCustomers();
            return customers.find(c => c.CustomerID === id);
        } catch (e) {
            return window.mockData.customers.find(c => c.CustomerID === id);
        }
    },

    // --- DATA ---
    getMeters: async (customerId) => {
        const res = await fetch(`${API_BASE_URL}/meters/${customerId}`);
        if (!res.ok) throw new Error('API Error: Meters');
        return await res.json();
    },

    getBills: async (customerId) => {
        const url = customerId === 'all' ? `${API_BASE_URL}/bills` : `${API_BASE_URL}/bills/${customerId}`;
        const res = await fetch(url);
        if (!res.ok) throw new Error('API Error: Bills');
        return await res.json();
    },

    getCustomerDetails: async (customerId) => {
        console.log(`API: Fetching details for ${customerId}`);
        const res = await fetch(`${API_BASE_URL}/customer-details/${customerId}`);
        if (!res.ok) throw new Error('API Error: Customer Details');
        return await res.json();
    },

    checkDeletionEligibility: async (customerId) => {
        const res = await fetch(`${API_BASE_URL}/delete-account-check/${customerId}`);
        if (!res.ok) throw new Error('API Error: Deletion Check');
        return await res.json();
    },

    payBill: async (data) => {
        const res = await fetch(`${API_BASE_URL}/pay-bill`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        return await res.json();
    },

    toggleBillStatus: async (billId) => {
        const res = await fetch(`${API_BASE_URL}/toggle-bill-status`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ billId })
        });
        return await res.json();
    },

    // --- ADMIN DATA ---
    getCharges: async () => {
        const res = await fetch(`${API_BASE_URL}/charges`);
        if (!res.ok) throw new Error('API Error: Charges');
        return await res.json();
    },

    updateCharges: async (charges) => {
        const res = await fetch(`${API_BASE_URL}/charges`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(charges)
        });
        return await res.json();
    },

    getRequests: async () => {
        const res = await fetch(`${API_BASE_URL}/requests`);
        if (!res.ok) throw new Error('API Error: Requests');
        return await res.json();
    },

    createRequest: async (reqData) => {
        const res = await fetch(`${API_BASE_URL}/requests`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(reqData)
        });
        return await res.json();
    },

    updateRequest: async (reqId, status, action = null) => {
        const res = await fetch(`${API_BASE_URL}/requests`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ RequestID: reqId, Status: status, action })
        });
        return await res.json();
    },

    getAdminStats: async () => {
        const res = await fetch(`${API_BASE_URL}/admin/stats`);
        if (!res.ok) throw new Error('API Error: Stats');
        return await res.json();
    }
};

window.API = API;
