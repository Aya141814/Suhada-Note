function previewImage(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      document.getElementById("preview").src = e.target.result;
    };

    reader.readAsDataURL(input.files[0]);
  }
}

// イベントリスナーを設定する関数
function setupImagePreview() {
  const fileInput = document.querySelector(
    'input[type="file"][accept="image/*"]'
  );
  if (fileInput) {
    fileInput.addEventListener("change", function () {
      previewImage(this);
    });
  }
}

// DOMContentLoadedイベントとTurbo用のイベントの両方に対応
document.addEventListener("DOMContentLoaded", setupImagePreview);
document.addEventListener("turbo:render", setupImagePreview);
