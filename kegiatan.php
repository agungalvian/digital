<?php
/* Single-file Bootstrap CRUD template */
?><!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Kegiatan Bootstrap</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-3">
<div class="container">
<div class="card">
<div class="card-body">
<h3>Kegiatan</h3>
<button class="btn btn-primary" onclick="openAdd()">+ Tambah Kegiatan</button>
</div>
</div>
</div>

<div class="modal fade" id="formModal" tabindex="-1">
<div class="modal-dialog modal-xl">
<div class="modal-content">
<div class="modal-header bg-primary text-white">
<h5 class="modal-title" id="ttl">Tambah Kegiatan</h5>
<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body">
<form id="frmKegiatan">
<div class="row g-3">
<div class="col-md-6"><label class="form-label">Nama Aktivitas</label><input class="form-control" id="nama"></div>
<div class="col-md-6"><label class="form-label">Jenis</label><select class="form-select" id="jenis"><option>Kolaborasi</option><option>Non Kolaborasi</option></select></div>
</div>
</form>
</div>
<div class="modal-footer">
<button class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
<button class="btn btn-primary">Simpan</button>
</div>
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
const modalForm=new bootstrap.Modal(document.getElementById('formModal'));
function openAdd(){
 document.getElementById('ttl').innerHTML='Tambah Kegiatan';
 modalForm.show();
}
</script>
</body>
</html>