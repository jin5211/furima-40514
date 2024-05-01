function commission (){
  const price = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');
  price.addEventListener('keyup', () =>{

    if (!isNaN(price.value)) {
      let priceValue = price.value;
      let taxValue = (priceValue * 0.1).toFixed(0);
      let profitVale = (priceValue - taxValue).toFixed(0);
      addTaxPrice.innerHTML = taxValue;
      profit.innerHTML = profitVale;
    }
  });
};