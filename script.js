function updateDateTime() {
    var now = new Date();
    var datetimeElement = document.getElementById("datetime");
    datetimeElement.textContent = now.toLocaleString();
}

// Update date and time every second
setInterval(updateDateTime, 1000);

// Initial update
updateDateTime();
