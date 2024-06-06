// app/javascript/packs/products.js
document.addEventListener('turbolinks:load', () => {
    document.querySelectorAll('a[data-remote]').forEach(link => {
      link.addEventListener('ajax:success', (event) => {
        const [data, status, xhr] = event.detail;
        if (link.closest('#products-list')) {
          document.getElementById('product-details').innerHTML = xhr.responseText;
        } else {
          document.getElementById('products-list').innerHTML = xhr.responseText;
          document.getElementById('product-details').innerHTML = '<div class="alert alert-info">Select a product to see its details.</div>';
        }
      });
    });
  });
  