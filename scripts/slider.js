document.addEventListener("DOMContentLoaded", function () {
  const slider = document.querySelector(".slider");
  const prevBtn = document.querySelector(".slider-btn.prev");
  const nextBtn = document.querySelector(".slider-btn.next");
  let currentSlide = 0;

  function updateSlider() {
    slider.style.transform = `translateX(-${currentSlide * 50}%)`;
  }

  prevBtn.addEventListener("click", () => {
    if (currentSlide > 0) {
      currentSlide--;
      updateSlider();
    }
  });

  nextBtn.addEventListener("click", () => {
    if (currentSlide < 1) {
      currentSlide++;
      updateSlider();
    }
  });
});
