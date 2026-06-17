<?php

$jsonFile = __DIR__ . '/data/organisasi.json';

if (!file_exists($jsonFile)) {
    die('File data/organisasi.json tidak ditemukan');
}

$data = json_decode(file_get_contents($jsonFile), true);

if (!$data) {
    die('JSON tidak valid');
}

$komisioner = $data['komisioner'];

function card($text, $class = 'green')
{
    return '<div class="card '.$class.'">'.htmlspecialchars($text).'</div>';
}

?>
<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Struktur Organisasi</title>

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    padding:20px;
    background:#f4f6f9;
    font-family:Segoe UI, Arial, sans-serif;
}

h1{
    text-align:center;
    margin-bottom:40px;
}

.wrapper{
    overflow-x:auto;
    min-width:1800px;
}

.row{
    display:flex;
    justify-content:center;
    gap:20px;
}

.row-deputi{
    display:flex;
    justify-content:space-between;
    gap:20px;
    align-items:flex-start;
}

.card{
    border-radius:8px;
    padding:10px 15px;
    text-align:center;
    box-shadow:0 2px 5px rgba(0,0,0,.15);
}

.green{
    background:#198754;
    color:#fff;
    font-weight:600;
}

.blue{
    background:#0d6efd;
    color:#fff;
}

.orange{
    background:#fd7e14;
    color:#fff;
}

.white{
    background:#fff;
    color:#333;
    border:1px solid #ddd;
}

.komisioner{
    width:350px;
    margin:auto;
}

.line{
    width:2px;
    height:30px;
    background:#aaa;
    margin:auto;
}

.h-line{
    height:2px;
    background:#aaa;
    width:90%;
    margin:25px auto;
}

.support .card{
    min-width:220px;
}

.deputy{
    flex:1;
    min-width:350px;
}

.deputy > .card{
    margin-bottom:20px;
}

.direktorat{
    margin-bottom:20px;
    border-left:3px solid #198754;
    padding-left:12px;
}

.direktorat > .card{
    margin-bottom:10px;
}

.divisi{
    display:flex;
    flex-direction:column;
    gap:8px;
}

.divisi .card{
    font-size:13px;
}

.strategis{
    flex:1;
    min-width:350px;
}

.unit-box{
    margin-bottom:15px;
}

</style>
</head>
<body>

<h1>STRUKTUR ORGANISASI BP TAPERA</h1>

<div class="wrapper">

    <!-- KOMISIONER -->
    <div class="komisioner">
        <?= card('Komisioner'); ?>
    </div>

    <div class="line"></div>

    <!-- UNIT PENDUKUNG -->
    <?php if(isset($komisioner['unit_pendukung'])): ?>
    <div class="row support">

        <?php foreach($komisioner['unit_pendukung'] as $unit): ?>

            <?= card($unit['nama'], 'white'); ?>

        <?php endforeach; ?>

    </div>
    <?php endif; ?>

    <div class="h-line"></div>

    <!-- UNIT DIBAWAH -->
    <div class="row-deputi">

        <?php foreach($komisioner['unit_di_bawah'] as $unit): ?>

            <?php if(isset($unit['jabatan'])): ?>

                <!-- DEPUTI -->
                <div class="deputy">

                    <?= card($unit['jabatan'], 'green'); ?>

                    <?php if(isset($unit['direktorat'])): ?>

                        <?php foreach($unit['direktorat'] as $direktorat): ?>

                            <div class="direktorat">

                                <?= card($direktorat['nama'], 'blue'); ?>

                                <?php if(isset($direktorat['divisi'])): ?>

                                    <div class="divisi">

                                        <?php foreach($direktorat['divisi'] as $divisi): ?>

                                            <?= card($divisi, 'orange'); ?>

                                        <?php endforeach; ?>

                                    </div>

                                <?php endif; ?>

                                <?php if(isset($direktorat['unit'])): ?>

                                    <div class="divisi">

                                        <?php foreach($direktorat['unit'] as $u): ?>

                                            <?= card($u, 'white'); ?>

                                        <?php endforeach; ?>

                                    </div>

                                <?php endif; ?>

                            </div>

                        <?php endforeach; ?>

                    <?php endif; ?>

                </div>

            <?php else: ?>

                <!-- DIREKTORAT LANGSUNG DIBAWAH KOMISIONER -->
                <div class="strategis">

                    <?= card($unit['nama'], 'green'); ?>

                    <?php if(isset($unit['divisi'])): ?>

                        <div class="divisi" style="margin-top:15px;">

                            <?php foreach($unit['divisi'] as $divisi): ?>

                                <?= card($divisi, 'orange'); ?>

                            <?php endforeach; ?>

                        </div>

                    <?php endif; ?>

                </div>

            <?php endif; ?>

        <?php endforeach; ?>

    </div>

</div>

</body>
</html>