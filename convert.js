const fs = require('fs');

let content = fs.readFileSync('crud_aktivitas.php', 'utf8');

// Remove PHP blocks at top
content = content.replace(/<\?php[\s\S]*?\?>/, '');

// Replace specific PHP outputs
content = content.replace(/<\?= \$currentWeek \?>/g, ''); // Will set default in JS or remove value for now
content = content.replace(/<\?php if\(isset\(\$_GET\['msg'\]\) && \$_GET\['msg'\] == 'success'\): \?>/g, '<% if(msg == "success") { %>');
content = content.replace(/<\?php if\(isset\(\$_GET\['msg'\]\) && \$_GET\['msg'\] == 'deleted'\): \?>/g, '<% if(msg == "deleted") { %>');
content = content.replace(/<\?php endif; \?>/g, '<% } %>');

// Replace table logic
content = content.replace(/<\?php\s*\$listData = [^]*?if\(empty\(\$listData\)\):\s*\?>/, '<% if(!listData || listData.length === 0) { %>');
content = content.replace(/<\?php\s*else:\s*\$no = 1;\s*\$listData = array_reverse\(\$listData\);\s*foreach\(\$listData as \$row\):\s*\?>/, '<% } else { let no = 1; listData.forEach(row => { %>');
content = content.replace(/<\?php\s*endforeach;\s*endif;\s*\?>/, '<% }) } %>');

// Replace echos
content = content.replace(/<\?= htmlspecialchars\(\$row\['(.+?)'\]\) \?>/g, '<%= row.$1 %>');
content = content.replace(/<\?= \$no\+\+; \?>/g, '<%= no++ %>');
content = content.replace(/<\?= \$row\['id'\] \?>/g, '<%= row.id %>');

// Badge logic
content = content.replace(/<\?= \$row\['jenis_kolaborasi'\] == 'Kolaborasi' \? 'success' : 'secondary' \?>/g, '<%= row.jenis_kolaborasi == "Kolaborasi" ? "success" : "secondary" %>');

// Aspek logic
content = content.replace(/<\?php\s*if\(!empty\(\$row\['aspek'\]\) && is_array\(\$row\['aspek'\]\)\) \{\s*foreach\(\$row\['aspek'\] as \$asp\) \{\s*echo '<span class="badge bg-info text-dark mb-1 me-1">'\.\$asp\.'<\/span>';\s*\}\s*\} else \{\s*echo '-';\s*\}\s*\?>/g, 
  `<% if (row.aspek && Array.isArray(row.aspek) && row.aspek.length > 0) { row.aspek.forEach(asp => { %><span class="badge bg-info text-dark mb-1 me-1"><%= asp %></span><% }) } else { %>-<% } %>`);

// JS logic replacement
content = content.replace(/const dataPilar = <\?= \$pilarJson \?>;/, 'let dataPilar = [];');
content = content.replace(/const dataKelompok = <\?= \$kelompokJson \?>;/, 'let dataKelompok = [];');
content = content.replace(/const dataAspek = <\?= \$aspekJson \?>;/, 'let dataAspek = [];');
content = content.replace(/const dataOrganisasi = <\?= \$organisasiJson \?>;/, 'let dataOrganisasi = {};');

let fetchScript = `
    fetch('/api/data').then(res => res.json()).then(data => {
        dataPilar = data.pilar;
        dataKelompok = data.kelompok;
        dataAspek = data.aspek;
        dataOrganisasi = data.organisasi;
        
        // Trigger initial render for Pilar
        if(Array.isArray(dataPilar)) {
            dataPilar.forEach(p => {
                let opt = new Option(p.kode_pilar + " - " + p.nama_pilar, p.kode_pilar);
                cmbPilar.add(opt);
            });
        }
        
        let listDeputi = [];
        try {
            listDeputi = dataOrganisasi.komisioner.unit_di_bawah.filter(u => u.jabatan);
        } catch(e) { console.warn("Format JSON Organisasi berbeda", e); }

        if(listDeputi.length > 0) {
            listDeputi.forEach((dep, index) => {
                let opt = new Option(dep.jabatan, index);
                cmbDeputi.add(opt);
            });
        }
    });
`;

content = content.replace('document.addEventListener("DOMContentLoaded", () => {', 'document.addEventListener("DOMContentLoaded", () => {\n' + fetchScript);

// Remove the inline setup that was moved to fetch
content = content.replace(/\/\/ --- SETUP PILAR ---[\s\S]*?\/\/ Event Ganti Pilar/, '// Event Ganti Pilar');
content = content.replace(/\/\/ --- SETUP ORGANISASI \(Deputi -> Direktorat\) ---[\s\S]*?\/\/ Event Ganti Deputi/, '// Event Ganti Deputi');

// Fix action path
content = content.replace(/action=""/g, 'action="/aktivitas"');

fs.writeFileSync('views/crud_aktivitas.ejs', content);
console.log('Done converting crud_aktivitas.php to EJS');
