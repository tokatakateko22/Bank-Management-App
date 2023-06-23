function check() {
   eel.isEmployeeLoggedIn()((result) => {
    if (!result) {
           eel.isCustomerLoggedIn()((result) => {
            if (!result) {
                window.location.href = "../index.html";
            }
          });
    }
  });
}

check();
