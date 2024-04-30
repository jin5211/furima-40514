function commission (){
  const price = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');
  price.addEventListener('keyup', () =>{
    let price_value = price.value;
    let tax_value = (price_value * 0.1).toFixed(0);
    let profit_vale = (price_value - tax_value).toFixed(0);
    addTaxPrice.innerHTML = tax_value;
    profit.innerHTML = profit_vale;
  })
};

window.addEventListener('turbo:load', commission);