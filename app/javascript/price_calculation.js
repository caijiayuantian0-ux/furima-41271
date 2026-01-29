const prices = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const salesProfit = document.getElementById("profit");
  
  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value);
  
    if (isNaN(price)) {
      addTaxDom.textContent = "0";
      salesProfit.textContent = "0";
    return;
    }

    const fee = Math.floor(price * 0.1);

    const profit = price - fee;


    addTaxDom.textContent = fee.toLocaleString();
    salesProfit.textContent = profit.toLocaleString();
  });
};
window.addEventListener("turbo:load", prices);
window.addEventListener("turbo:render", prices);