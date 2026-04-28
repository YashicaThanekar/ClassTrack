// Sidebar open/close logic
document.addEventListener('DOMContentLoaded', function() {
    const sidebar = document.getElementById('sidebar');
    const menuBtn = document.getElementById('menu-btn');
    // Toggle sidebar open/close using class
    menuBtn.addEventListener('click', function() {
        sidebar.classList.toggle('open');
    });
    // Logout button handler
    const logoutBtn = document.getElementById('logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', function() {
            window.location.href = 'Login/index.html';
        });
    }
});
