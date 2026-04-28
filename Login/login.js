const teacherBtn=document.getElementById("teacher-login-btn");
const studentBtn=document.getElementById("student-login-btn");
const userLabel=document.getElementById("user-label");



teacherBtn.addEventListener("click", () => {
    userLabel.textContent = "Username";
    document.getElementById("role").value = "teacher";
});

studentBtn.addEventListener("click", () => {
    userLabel.textContent = "Moodle ID";
    document.getElementById("role").value = "student";
});


function loginUser() {
    const loginId = document.getElementById("loginInput").value;
    const password = document.getElementById("password").value;
    const role = document.getElementById("role").value;

    fetch("http://127.0.0.1:5000/login", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            login_id: loginId,
            password: password,
            role: role
        })
    })
    .then(async res => {
        const data = await res.json();
        if (res.ok) {
            if (data.role === "teacher") {
                window.location.href = "../Admin/admin.html";
            } else if (data.role === "student") {
                window.location.href = "../Profile/profile.html";
            } else {
                alert("Login successful, but unknown role.");
            }
        } else {
            alert(data.message);
        }
    })
    .catch(err => {
        alert("Error logging in.");
    });
}