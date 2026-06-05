/* ═══════════════════════════════════════════
   SmartTransit — main.js
   ═══════════════════════════════════════════ */

const ctx = document.getElementById('app-context')?.dataset.ctx || '';

/* ── Build one bus result card ── */
function busCard(bus) {
    const cls = {
        'ACTIVE'     : 'badge-active',
        'INACTIVE'   : 'badge-inactive',
        'MAINTENANCE': 'badge-maintenance'
    }[bus.status] || '';

    return `
    <div class="result-card">
        <h4>🚌 ${bus.busNumber}</h4>
        <p><strong>Route &nbsp;:</strong> ${bus.routeName   || '—'}</p>
        <p><strong>At Stop :</strong> ${bus.currentStop || 'Not available'}</p>
        <p><strong>Capacity:</strong> ${bus.capacity} seats</p>
        <p><strong>Status  :</strong>
            <span class="badge ${cls}">${bus.status}</span>
        </p>
    </div>`;
}

/* ── Render results into a container ── */
function renderCards(containerId, buses, emptyMsg) {
    const el = document.getElementById(containerId);
    if (!el) return;
    if (!buses || buses.length === 0) {
        el.innerHTML = `<div class="empty-state"><p>${emptyMsg}</p></div>`;
        return;
    }
    const grid = document.createElement('div');
    grid.className = 'result-grid';
    buses.forEach(b => grid.insertAdjacentHTML('beforeend', busCard(b)));
    el.innerHTML = '';
    el.appendChild(grid);
}

/* ════════════════════════════════════════
   SEARCH PAGE — search by stop name
   ════════════════════════════════════════ */
const searchInput  = document.getElementById('searchInput');
const searchBtn    = document.getElementById('searchBtn');
const searchResult = document.getElementById('searchResult');
const loader       = document.getElementById('loader');

function doSearch() {
    const stop = searchInput?.value.trim();
    if (!stop) { alert('Kripya stop ka naam darj karein.'); return; }

    if (loader) loader.style.display = 'block';
    if (searchResult) searchResult.innerHTML = '';

    fetch(`${ctx}/search?stop=${encodeURIComponent(stop)}`)
        .then(r => r.json())
        .then(buses => {
            if (loader) loader.style.display = 'none';
            renderCards('searchResult', buses,
                `"${stop}" se koi bus nahi mili. Doosra stop try karein.`);
        })
        .catch(() => {
            if (loader) loader.style.display = 'none';
            if (searchResult)
                searchResult.innerHTML = '<p style="color:red;padding:1rem">Server error. Dobara try karein.</p>';
        });
}

searchBtn?.addEventListener('click', doSearch);
searchInput?.addEventListener('keydown', e => { if (e.key === 'Enter') doSearch(); });

/* ════════════════════════════════════════
   TRACK PAGE — real-time bus tracking
   ════════════════════════════════════════ */
const trackInput  = document.getElementById('trackInput');
const trackBtn    = document.getElementById('trackBtn');
const trackLoader = document.getElementById('trackLoader');
let   pollTimer   = null;

function doTrack() {
    clearInterval(pollTimer);
    fetchTrack();
    pollTimer = setInterval(fetchTrack, 15000);   // refresh every 15s
}

function fetchTrack() {
    const bus = trackInput?.value.trim() || '';
    const url = bus ? `${ctx}/track?bus=${encodeURIComponent(bus)}` : `${ctx}/track`;

    if (trackLoader) trackLoader.style.display = 'block';

    fetch(url)
        .then(r => r.json())
        .then(buses => {
            if (trackLoader) trackLoader.style.display = 'none';
            renderCards('trackResult', buses,
                bus ? `Bus "${bus}" nahi mili.` : 'Koi bus available nahi hai.');
        })
        .catch(() => {
            if (trackLoader) trackLoader.style.display = 'none';
            const el = document.getElementById('trackResult');
            if (el) el.innerHTML = '<p style="color:red;padding:1rem">Tracking data load nahi ho saka.</p>';
        });
}

trackBtn?.addEventListener('click', doTrack);
trackInput?.addEventListener('keydown', e => { if (e.key === 'Enter') doTrack(); });

/* Auto-load all buses when track page opens */
if (document.getElementById('trackResult')) doTrack();

/* ════════════════════════════════════════
   DELETE CONFIRM — buses & routes pages
   ════════════════════════════════════════ */
document.querySelectorAll('.btn-delete').forEach(btn => {
    btn.addEventListener('click', e => {
        if (!confirm('Kya aap sach mein delete karna chahte hain?')) e.preventDefault();
    });
});