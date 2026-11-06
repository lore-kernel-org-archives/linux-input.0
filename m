Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982773;
	b=fGuoDNdLJw0N/g/Gf3CxxaFCSkczDHRO9b/qfJhC/j1AshapmYmzxCIizPOJ8DonphWJ
	 72DGVUIjwqGelSZA/shsHyiLAOl3dtiLFzRTLdPn/1+4DDnI4hCaPfb/HIfOJGUw566Xz
	 gXT5lCDk6qIqhwscZOodSfPoPgFDqSn+dMI1uzq1dNxuEDAGjELM8lr8NJ4pF1JFeM+v2
	 9c6eud6aF1g8941WZ4chqiuxhZbXt4LWscuURkAAfqUORjHoOVWdTzU8SZXdUDtue5nD7
	 85+Z9lM3GhrhD71lRIiIEd5t7ceLkih5Tj+ZuK32dgDf6nlEvxM8GuUVHE6w82OEu+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982773;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=RWWfhSpd8qA/0y2M9vARy5V41qdGSPFp81t+GAu2VoM=;
	b=oRCQUqf2RYUQLqy9R/BKULq5gNXxuI5ZJO8ycARirghKyM2+t3ipj2vdAlDXyWsU//Ud
	 4offcYLBJyBl7czs/twlYGq9Z5tCnC68aPMzIjCzEJ3Zi3jOnozewQC6bLEOhxh+Nh0qd
	 +d1BaLO3gO6E2hcGf+STCDnvXMBVAr5IQy3F/rxhKhqwBRmYqQZ25rOcVGVB6AtFRxYSg
	 KVb4S/Lio71y1MydmwL3swk/jmPy/cVanEKOQX9D+Xxa+H/zB7M/cVN3jtPcww8B4pfDm
	 R8TcIcNykLDdY1PTFG+nQMZU5BoILe17Fm/kocXN/AAVdhmjq85kQNKlBGDQelwrhfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=gS7fmlJW;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=LGhIascM;
	arc=none smtp.remote-ip=23.251.234.56
Received: from e234-56.smtp-out.ap-northeast-1.amazonses.com (e234-56.smtp-out.ap-northeast-1.amazonses.com [23.251.234.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8421606EE91;
	Fri,  6 Nov 2026 16:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8421606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=gS7fmlJW;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=LGhIascM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793982771;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=k2DtG2Ms2OYCMdXF/mo4RMf+MlrhGYphet6JR+lLl7c=;
	b=gS7fmlJWP3YYLnpyi3msaKzzrKCpc7JN+u+qkFBA0D4pv1kLNzcI2K49k78/cGrO
	2DvOdibpFUVeUVOcjYiyZVxaTIDYFjn5d4MazQF1zU23Kz5CSaiqpacdmrxVkdLSTqJ
	floFYGrKy8lJ14rEtG/2zL7lW6EbglIwQ1s5htF4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793982771;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=k2DtG2Ms2OYCMdXF/mo4RMf+MlrhGYphet6JR+lLl7c=;
	b=LGhIascMaBEzjXXNAvh+J5doGKFozUyY9bPnbbrH683BueCXEqnbETI/IZBi8MYW
	vVrWiwvvUM1qnmlhqykbAobOeWs75oakFC8blME17E1q18ls/Irzw5TiFRlNp8/kTZ/
	4cw1Ac2nN8oD4mXdTVwUN7RXgkl+wxnwshpqm9gg=
In-Reply-To: <sashiko-outbox-199924@kernel.org>
References: <sashiko-outbox-199924@kernel.org>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org, sashiko-bot@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	daleyo@gmail.com, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/5] HID: spi-hid: isolate DMA transfers from
 protocol buffers
Message-ID: <010601a1b1b4affa-319434db-5e00-4bad-abde-7fb5400733de-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Nov 2026 16:32:51 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.06-23.251.234.56

Hi,

The overlap is real when ARCH_DMA_MINALIGN is smaller than the =
five-byte
read approval. I reproduced it with the actual input-transfer =
function
using alignment values of two and four. My earlier tests started =
at
eight and missed these cases.

The correction below rounds the full =
approval length up to the DMA
alignment and uses that value for the RX =
offset, bounds check and
allocation. It is an incremental diff against v3. =
I have also folded it
into patch 1 of a local v4 draft and will collect =
further review before
resending the complete series.

The actual allocator and single-lane/quad transfer functions now pass
ASan/UBSan tests at alignments 2, 4, 8, 16, 32, 64, 128 and 256. These
check non-overlap, exact RX capacity, allocation failures and rollback.
The v3 allocator and transfer path fail the new small-alignment tests.
The SPI-HID core, ACPI and OF modules build with W=3D1 on ARM64.

The 128-byte layout used on my SL7 is unchanged.

Signed-off-by: Jizhou =
Tong <fqwqf@fqwqf.xyz>
---
diff --git a/drivers/hid/spi-hid/spi-hid-core.c =
b/drivers/hid/spi-hid/spi-hid-core.c
index 901c8d9ace..d0ef3e7106 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-=
core.c
@@ -67,6 +67,7 @@
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
 #define SPI_HID_OUTPUT_HEADER_LEN		8
+#define SPI_HID_RX_OFFSET	ALIGN(SPI_HID_READ_APPROVAL_LEN, =
ARCH_DMA_MINALIGN)
=20
 /* flags */
 /*
@@ -192,10 +193,10 @@ static void =
spi_hid_populate_output_header(u8 *buf,
 static int =
spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
 			      bool is_header)
 {
-	u8 *rx =3D shid->xfer_buf + =
ARCH_DMA_MINALIGN;
+	u8 *rx =3D shid->xfer_buf + SPI_HID_RX_OFFSET;
 	int error;
=20
-	if (length > shid->xfer_size - ARCH_DMA_MINALIGN)
+	if (length > shid->xfer_size - SPI_HID_RX_OFFSET)
 		return -EMSGSIZE;
=20
 	memcpy(shid->xfer_buf, is_header ? shid->read_approval_header :
@@ -1322,7 +1323,7 @@ static int spi_hid_alloc_buffers(struct spi_hid *shid=
, size_t report_size)
=20
 	/* io_lock serializes the separate, DMA-aligned=
 TX and RX regions. */
 	xfer_size =3D ALIGN(max(inbufsize, outbufsize), =
ARCH_DMA_MINALIGN) +
-		    ARCH_DMA_MINALIGN;
+		    SPI_HID_RX_OFFSET;
 	/* Keep ownership separate from the explicitly aligned DMA view. */
 	tmp =3D devm_krealloc(dev, shid->xfer_alloc,
 			    xfer_size + =
ARCH_DMA_MINALIGN - 1,
