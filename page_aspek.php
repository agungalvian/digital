<?php
$dataDir = __DIR__ . DIRECTORY_SEPARATOR . 'data';

function read_json($file)
{
    if (!file_exists($file)) {
        return [
            'data' => [],
            'error' => 'File tidak ditemukan: ' . basename($file),
        ];
    }

    $json = file_get_contents($file);
    $json = preg_replace('/^\xEF\xBB\xBF/', '', $json);
    $data = json_decode($json, true);

    if (!is_array($data)) {
        return [
            'data' => [],
            'error' => 'JSON tidak valid: ' . json_last_error_msg(),
        ];
    }

    return [
        'data' => $data,
        'error' => '',
    ];
}

function h($value)
{
    return htmlspecialchars((string) $value, ENT_QUOTES, 'UTF-8');
}

$pilarResult = read_json($dataDir . DIRECTORY_SEPARATOR . 'pilar.json');
$kelompokResult = read_json($dataDir . DIRECTORY_SEPARATOR . 'kelompok.json');
$aspekResult = read_json($dataDir . DIRECTORY_SEPARATOR . 'aspek.json');

$pilar = $pilarResult['data'];
$kelompok = $kelompokResult['data'];
$aspek = $aspekResult['data'];

usort($pilar, fn($a, $b) => strcmp($a['kode_pilar'] ?? '', $b['kode_pilar'] ?? ''));
usort($kelompok, fn($a, $b) => strcmp($a['kode_kelompok'] ?? '', $b['kode_kelompok'] ?? ''));
usort($aspek, fn($a, $b) => strcmp($a['kode_aspek'] ?? '', $b['kode_aspek'] ?? ''));

$errors = array_filter([
    $pilarResult['error'],
    $kelompokResult['error'],
    $aspekResult['error'],
]);
?>
<!doctype html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Data Aspek</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            background: #eef7ff;
            color: #102033;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }
        .wrap {
            width: min(1280px, calc(100% - 20px));
            margin: 10px auto;
        }
        .top {
            background: #075985;
            color: #fff;
            padding: 12px 14px;
            border-radius: 6px 6px 0 0;
            display: flex;
            justify-content: space-between;
            gap: 12px;
            align-items: center;
        }
        h1 {
            margin: 0;
            font-size: 17px;
            font-weight: 700;
        }
        .meta {
            font-size: 11px;
            color: #dbeafe;
            text-align: right;
        }
        .meta strong {
            color: #fff;
            font-size: 18px;
        }
        .panel {
            background: #fff;
            border: 1px solid #bfdbfe;
            border-top: 0;
            padding: 10px;
        }
        .filters {
            display: grid;
            grid-template-columns: 1fr 1.35fr 1.35fr 1fr auto;
            gap: 8px;
            align-items: end;
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 4px;
            color: #0c4a6e;
            font-weight: 700;
            font-size: 11px;
        }
        select, input, button {
            width: 100%;
            height: 30px;
            border: 1px solid #93c5fd;
            border-radius: 4px;
            padding: 5px 7px;
            font-size: 12px;
            background: #fff;
        }
        button {
            background: #0369a1;
            color: #fff;
            border-color: #0369a1;
            font-weight: 700;
            cursor: pointer;
        }
        .notice {
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #facc15;
            background: #fefce8;
            color: #713f12;
            border-radius: 4px;
        }
        .table-box {
            overflow: auto;
            border: 1px solid #bfdbfe;
            max-height: calc(100vh - 160px);
        }
        table {
            width: 100%;
            min-width: 980px;
            border-collapse: collapse;
        }
        th, td {
            border-right: 1px solid #bfdbfe;
            border-bottom: 1px solid #bfdbfe;
            padding: 6px 7px;
            text-align: left;
            vertical-align: top;
        }
        th {
            position: sticky;
            top: 0;
            background: #0c4a6e;
            color: #fff;
            z-index: 1;
            font-size: 11px;
        }
        tbody tr:nth-child(even) { background: #f8fbff; }
        tbody tr:hover { background: #e0f2fe; }
        .code {
            color: #075985;
            font-weight: 700;
            white-space: nowrap;
        }
        .desc {
            min-width: 340px;
            color: #475569;
        }
        .empty {
            padding: 18px;
            text-align: center;
            color: #64748b;
        }
        @media (max-width: 850px) {
            .top { display: block; }
            .meta { text-align: left; margin-top: 8px; }
            .filters { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="top">
        <div>
            <h1>Data Aspek Ekosistem Perumahan</h1>
            <div>Filter berjenjang dari pilar, kelompok, lalu aspek.</div>
        </div>
        <div class="meta">
            Data tampil<br>
            <strong id="visibleCount"><?= count($aspek) ?></strong> dari <?= count($aspek) ?> aspek
        </div>
    </div>

    <div class="panel">
        <?php if ($errors): ?>
            <div class="notice">
                <?= h(implode(' | ', $errors)) ?>
            </div>
        <?php endif; ?>

        <div class="filters">
            <div>
                <label for="pilarFilter">Pilar</label>
                <select id="pilarFilter">
                    <option value="">Semua Pilar</option>
                    <?php foreach ($pilar as $row): ?>
                        <option value="<?= h($row['kode_pilar'] ?? '') ?>">
                            <?= h(($row['kode_pilar'] ?? '') . ' - ' . ($row['nama_pilar'] ?? '')) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div>
                <label for="kelompokFilter">Kelompok</label>
                <select id="kelompokFilter">
                    <option value="">Semua Kelompok</option>
                    <?php foreach ($kelompok as $row): ?>
                        <option value="<?= h($row['kode_kelompok'] ?? '') ?>" data-pilar="<?= h($row['kode_pilar'] ?? '') ?>">
                            <?= h(($row['kode_kelompok'] ?? '') . ' - ' . ($row['nama_kelompok'] ?? '')) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div>
                <label for="aspekFilter">Aspek</label>
                <select id="aspekFilter">
                    <option value="">Semua Aspek</option>
                    <?php foreach ($aspek as $row): ?>
                        <option
                            value="<?= h($row['kode_aspek'] ?? '') ?>"
                            data-pilar="<?= h($row['kode_pilar'] ?? '') ?>"
                            data-kelompok="<?= h($row['kode_kelompok'] ?? '') ?>"
                        >
                            <?= h(($row['kode_aspek'] ?? '') . ' - ' . ($row['nama_aspek'] ?? '')) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div>
                <label for="searchBox">Cari</label>
                <input id="searchBox" type="search" placeholder="Cari data...">
            </div>

            <div>
                <label>&nbsp;</label>
                <button type="button" id="resetBtn">Reset</button>
            </div>
        </div>

        <div class="table-box">
            <table id="aspekTable">
                <thead>
                <tr>
                    <th>No</th>
                    <th>Kode Pilar</th>
                    <th>Nama Pilar</th>
                    <th>Kode Kelompok</th>
                    <th>Nama Kelompok</th>
                    <th>Kode Aspek</th>
                    <th>Nama Aspek</th>
                    <th>Keterangan Aspek</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($aspek as $i => $row): ?>
                    <tr
                        data-pilar="<?= h($row['kode_pilar'] ?? '') ?>"
                        data-kelompok="<?= h($row['kode_kelompok'] ?? '') ?>"
                        data-aspek="<?= h($row['kode_aspek'] ?? '') ?>"
                    >
                        <td><?= $i + 1 ?></td>
                        <td class="code"><?= h($row['kode_pilar'] ?? '') ?></td>
                        <td><?= h($row['nama_pilar'] ?? '') ?></td>
                        <td class="code"><?= h($row['kode_kelompok'] ?? '') ?></td>
                        <td><?= h($row['nama_kelompok'] ?? '') ?></td>
                        <td class="code"><?= h($row['kode_aspek'] ?? '') ?></td>
                        <td><?= h($row['nama_aspek'] ?? '') ?></td>
                        <td class="desc"><?= h($row['keterangan_aspek'] ?? '') ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>

            <?php if (count($aspek) === 0): ?>
                <div class="empty">Data Aspek belum tersedia.</div>
            <?php endif; ?>
        </div>
    </div>
</div>

<script>
const pilarFilter = document.getElementById('pilarFilter');
const kelompokFilter = document.getElementById('kelompokFilter');
const aspekFilter = document.getElementById('aspekFilter');
const searchBox = document.getElementById('searchBox');
const visibleCount = document.getElementById('visibleCount');
const rows = Array.from(document.querySelectorAll('#aspekTable tbody tr'));
const kelompokOptions = Array.from(kelompokFilter.options);
const aspekOptions = Array.from(aspekFilter.options);

function filterOptions() {
    const pilar = pilarFilter.value;
    const kelompok = kelompokFilter.value;

    kelompokOptions.forEach(option => {
        option.hidden = option.value !== '' && pilar !== '' && option.dataset.pilar !== pilar;
    });

    if (kelompokFilter.selectedOptions[0] && kelompokFilter.selectedOptions[0].hidden) {
        kelompokFilter.value = '';
    }

    aspekOptions.forEach(option => {
        if (option.value === '') {
            option.hidden = false;
            return;
        }

        const matchPilar = pilar === '' || option.dataset.pilar === pilar;
        const matchKelompok = kelompokFilter.value === '' || option.dataset.kelompok === kelompokFilter.value;
        option.hidden = !(matchPilar && matchKelompok);
    });

    if (aspekFilter.selectedOptions[0] && aspekFilter.selectedOptions[0].hidden) {
        aspekFilter.value = '';
    }
}

function applyFilter() {
    const pilar = pilarFilter.value;
    const kelompok = kelompokFilter.value;
    const aspek = aspekFilter.value;
    const keyword = searchBox.value.trim().toLowerCase();
    let count = 0;

    rows.forEach(row => {
        const visible =
            (pilar === '' || row.dataset.pilar === pilar) &&
            (kelompok === '' || row.dataset.kelompok === kelompok) &&
            (aspek === '' || row.dataset.aspek === aspek) &&
            (keyword === '' || row.innerText.toLowerCase().includes(keyword));

        row.style.display = visible ? '' : 'none';
        if (visible) {
            count++;
        }
    });

    visibleCount.textContent = count;
}

function refresh() {
    filterOptions();
    applyFilter();
}

pilarFilter.addEventListener('change', refresh);
kelompokFilter.addEventListener('change', refresh);
aspekFilter.addEventListener('change', applyFilter);
searchBox.addEventListener('input', applyFilter);
document.getElementById('resetBtn').addEventListener('click', () => {
    pilarFilter.value = '';
    kelompokFilter.value = '';
    aspekFilter.value = '';
    searchBox.value = '';
    refresh();
});

refresh();
</script>
</body>
</html>
