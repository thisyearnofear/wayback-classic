document.addEventListener("DOMContentLoaded", function () {
  const player = document.querySelector(".music-player");
  const toggleButton = document.querySelector(".toggle-button");
  const iframe = document.getElementById("musicIframe");

  // Set random track on load
  const randomTrack = Math.floor(Math.random() * 6) + 1;
  const baseUrl =
    "https://futuretape.xyz/token/0x3035375461f5cb334d69436bbcfa1aaf812b29ef/1";
  iframe.src = `${baseUrl}?start=${randomTrack}&autoplay=1`;

  toggleButton.addEventListener("click", function () {
    const isMinimized = player.classList.contains("minimized");

    if (isMinimized) {
      player.classList.remove("minimized");
      player.classList.add("expanded");
      toggleButton.textContent = "▼";
    } else {
      player.classList.add("minimized");
      player.classList.remove("expanded");
      toggleButton.textContent = "▲";
    }
  });
});
