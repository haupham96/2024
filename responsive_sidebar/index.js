const toggleBtn = document.getElementById('toggle-btn');

const sidebar = document.getElementById('sidebar');

function toggleSubMenu(button) {
  if (sidebarClosed()) {
    toggleSidebar();
  }
  let submenuEl = button.nextElementSibling;
  toggleClass(button, 'rotate');
  toggleClass(submenuEl, 'show');

  if (isMobile()) {
    let submeuShowArr = Array.from(sidebar.getElementsByClassName('show'));
    if (submeuShowArr && submeuShowArr.length) {
      submeuShowArr.forEach((ul) => {
        if (ul != submenuEl) {
          ul.classList.remove('show');
          ul.previousElementSibling.classList.remove('rotate');
        }
      });
    }
  }
}

function isMobile() {
  var width = window.innerWidth > 0 ? window.innerWidth : screen.width;
  return width <= 800;
}

function hasOpenSubmenu() {
  let submeuShowArr = Array.from(sidebar.getElementsByClassName('show'));
  return submeuShowArr && submeuShowArr.length > 0;
}

function sidebarClosed() {
  return sidebar.classList.contains('close');
}

function closeAllSubmenu() {
  let submeuShowArr = Array.from(sidebar.getElementsByClassName('show'));
  if (submeuShowArr && submeuShowArr.length) {
    submeuShowArr.forEach((ul) => {
      ul.classList.remove('show');
      ul.previousElementSibling.classList.remove('rotate');
    });
  }
}

function toggleSidebar() {
  toggleClass(sidebar, 'close');
  toggleClass(toggleBtn, 'rotate');
  closeAllSubmenu();
}

function toggleClass(el, className) {
  el.classList.toggle(className);
}
