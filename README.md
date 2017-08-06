# Data Uji Penerjemahan Mesin Bahasa Indonesia

Ini adalah repository (gudang penyimpanan) data yang dikhususkan untuk proyek penelitian dan pengembangan teknologi penerjemahan mesin dari dan ke bahasa Indonesia (GARENG). Hanya data uji yang tersimpan di sini. Data latih yang digunakan masih bersifat privat dan belum dapat dibuat publik dengan alasan perizinan.

Proyek penelitian dan pengembangan sistem penerjemahan mesin GARENG adalah kerjasama antara [Rekanalar](http://rekanalar.com) dan [Beritagar](https://beritagar.id).


### Isi

Data uji yang terdapat dalam repository ini diperoleh dari transkripsi TED Talks dan sejumlah sumber pemberitaan daring nasional dan internasional. Saat ini data yang tersedia adalah pasangan paralel kalimat berbahasa Inggris dan Indonesia. Untuk bahasa-bahasa lain akan ditambahkan seiring pengembangan lanjutan sistem.

Data uji sebanyak 10.000 pasang kalimat tersebut bertopik umum seperti pemberitaan nasional dan internasional, politik, ekonomi, olah raga, hiburan, kesehatan, dan teknologi.

Semua data yang ada di sini berformat teks dan bersifat mentah. Dalam direktori `outputs` adalah hasil sejumlah sistem penerjemahan mesin terhadap data yang terdapat di direktori `data`. Data dalam sub-direktori `gareng` adalah hasil sistem penerjemahan mesin GARENG dan sebagai pembanding data pada sub-direktori `gnmt` adalah hasil sistem penerjemahan mesin Google Neural Machine Translation.


### Sistem dan Arsitektur

GARENG adalah sistem penerjemahan mesin yang dikembangkan Rekanalar bersama Beritagar untuk keperluan pemantauan pemberitaan, peringkasan konten dan transfer pembelajaran linguistik. GARENG merupakan pengembangan lanjutan dari sistem penerjemahan mesin [AmuNMT (sekarang bernama Marian)](http://workshop2016.iwslt.org/downloads/IWSLT_2016_paper_4.pdf) yang dikembangkan di Adam Mickiewicz University dan University of Edinburgh dengan sebagian besar pengembangan yang dilakukan terfokus pada optimalisasi kecepatan CPU untuk melayani tugas penerjemahan (*inference*) tanpa mengurangi akurasi.

GARENG menggunakan 1 layer *GRU-based bidirectional encoder*, 1 layer *GRU-based decoder*, dan 1 layer *attention* dengan ukuran vektor *word embedding* sebesar 512 dan ukuran vektor *GRU-based layers* sebesar 1024. Satu-satunya trik yang digunakan dalam proses pelatihan namun belum terpublikasikan adalah pemanfaatan *word alignment* untuk memandu pergerakan vektor pada layer *attention*, selebihnya menggunakan trik yang sudah umum seperti *layer normalization*, *dynamic batching*, *averaging*, dan *dropout*.

Implementasi *Deep RNN* dengan *Deep Transition Cells*, *LSTM-based encoder/decoder* atau *residual/skip connection* antar layer-layer RNN tidak digunakan dengan alasan keterbatasan memory pada kartu grafis. Pertimbangan tersebut adalah pemicu utama pemilihan arsitektur GARENG yang cenderung *shallow*.

Model yang dihasilkan GARENG diperoleh dari data latih sebanyak 70 juta pasang kalimat bahasa Inggris dan bahasa Indonesia. Model-model tersebut dilatih secara terpisah selama 7 hari dengan menggunakan masing-masing satu kartu grafis Nvidia GTX 1080.

GNMT (Google Neural Machine Translation) adalah sistem penerjemahan mesin yang dikembangkan oleh Google. Informasi lebih lanjut mengenai sistem dan arsitektur GNMT dapat dibaca pada [laman ini](https://research.googleblog.com/2016/09/a-neural-network-for-machine.html).


### Penilaian

Penilaian terhadap hasil penerjemahan mesin dilakukan dengan menggunakan program `multi-bleu.pl` yang juga disertakan dalam direktori `scripts`. Informasi lebih lanjut mengenai penilaian BLEU dapat dibaca pada [laman ini](https://en.wikipedia.org/wiki/BLEU).

Program tokenisasi sederhana `tokenizer.py` juga disertakan dalam direktori `scripts` untuk memecah kalimat menjadi sejumlah token (unit yang lebih kecil).


#### Penilaian BLEU: Bahasa Inggris ke Bahasa Indonesia

| Sistem   | Huruf campur | Huruf kecil |
| -------- |:------------ |:----------- |
| GNMT     | 59.14        | 59.99       |
| GARENG   | **61.48**    | **62.35**   |

#### Penilaian BLEU: Bahasa Indonesia ke Bahasa Inggris

| Sistem   | Huruf campur | Huruf kecil |
| -------- |:------------ |:----------- |
| GNMT     | 66.90        | 67.43       |
| GARENG   | **68.50**    | **69.00**   |


