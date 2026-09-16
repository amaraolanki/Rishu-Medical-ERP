(()=>{
const CATALOG_URL='./medicine_catalog_seed.json';
async function getCatalog(){const r=await fetch(CATALOG_URL,{cache:'no-store'});if(!r.ok)throw new Error('Catalogue file not found');return await r.json();}
async function loadStarterCatalogue(silent=false){
  if(!window.db||!Array.isArray(window.db.items)) return;
  try{const rows=await getCatalog();const existing=new Set(window.db.items.map(x=>(x.product+'|'+(x.batch||'')).toLowerCase()));let added=0;
    rows.forEach(x=>{const k=(x.product+'|'+(x.batch||'')).toLowerCase();if(x.product&&!existing.has(k)){window.db.items.push(window.normalizeItem(x));existing.add(k);added++;}});
    window.saveERP();
    if(!silent)alert(`Starter Medicine Catalogue loaded: ${added} new items.`);
    if(!silent)show('item');
    return added;
  }catch(e){if(!silent)alert('Catalogue load failed: '+e.message);return 0;}
}
async function autoSeedStarterCatalogue(){
  if(localStorage.getItem('rishu_catalog_seed_v1')) return;
  if(!window.db||!Array.isArray(window.db.items)) return;
  if(window.db.items.length===0){const n=await loadStarterCatalogue(true);if(n>0)localStorage.setItem('rishu_catalog_seed_v1','1');}
  else localStorage.setItem('rishu_catalog_seed_v1','1');
}
window.loadStarterCatalogue=loadStarterCatalogue;
// Mega catalogue is searched on demand; it is not copied into local Item Master automatically.

})();
