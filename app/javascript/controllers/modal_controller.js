// モーダルの制御を行うコントローラー
window.openModal = function (modalId) {
  const modal = document.getElementById(modalId);
  modal.classList.remove("hidden");
  modal.classList.add("flex");
  document.body.style.overflow = "hidden";
};

window.closeModal = function (modalId) {
  const modal = document.getElementById(modalId);
  modal.classList.add("hidden");
  modal.classList.remove("flex");
  document.body.style.overflow = "auto";
};

// モーダルの外側をクリックした時に閉じる
document.addEventListener("click", function (event) {
  const modals = document.querySelectorAll('[id$="-modal"]');
  modals.forEach((modal) => {
    if (event.target === modal) {
      window.closeModal(modal.id);
    }
  });
});
