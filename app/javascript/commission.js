function commission() {
  const price = document.getElementById('item-price');
  if (price) {
    price.addEventListener('input', () => {
      if (!isNaN(price.value)) {
        let priceValue = parseFloat(price.value);
        let taxValue = Math.floor(priceValue * 0.1);
        let profitValue = priceValue - taxValue;
        document.getElementById('add-tax-price').innerHTML = taxValue;
        document.getElementById('profit').innerHTML = profitValue;
      }
    });
  }
}

window.addEventListener("turbo:load", commission);
window.addEventListener("turbo:render", commission);