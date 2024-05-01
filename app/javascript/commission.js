function commission (){
  const price = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');
  price.addEventListener('keyup', () =>{

    if (!isNaN(price.value)) {
      let priceValue = price.value;
      let taxValue = Math.floor(priceValue * 0.1);
      let profitVale = priceValue - taxValue;
      addTaxPrice.innerHTML = taxValue;
      profit.innerHTML = profitVale;
    }
  });
};

window.addEventListener('turbo:load', commission);