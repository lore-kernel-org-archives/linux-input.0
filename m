Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906581;
	b=UvYKCypA5NJYgbk94LypyXP4oZ31355vVF2O9GRoGFTXu2qOJ19CySIOkE8j2kTPuntj
	 bMJu3hL5h9l9+0XXxxeMca//W6vlnzX3Owumi1q+lRKbxL36n9PexO5B4S6P14pHNO1iO
	 /tcPc9N0AZI0RbmrYV66c7ROLFuA2HxjOvfTN5GZp/ekcZECpdBz3CLX4bGXRNc1vPuLU
	 mm+NaVwOagFRd6n0FJ30e7C18MXdtgRt3o9tEoi/fS0Dyt0HhSw3FEKb34nNBOsZMYwW0
	 xniEeCfLLPzXsYbuGLt8ejAt1QW1vrxEpNgNCVeWcS4oNdLOOUX54sF4QVXjTELO3Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906581;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=+w3Y46USZtRfwboP4/3DVltXYLuzKi3FoL8Kojm7yhE=;
	b=n/Mx2zyOVYhrZMQuOkdtLp0oLuST4S/xKaybu0hPZsLcgYNw0jSHvvNSchxOGRfVoCQM
	 Y0Sg9QeabHfoLnAO09EJxTRxfWdiVg7++3PpymmYn2hYrXolo/khZo7RXe9WGlbw/LE10
	 BTsefXrhBrLFnfPOhRzoakencY1vF3akonJ2Ny7Jftj6o37Jb+9NaMc5BcGIWelrPqmKZ
	 DGS222ptJwY1Kp8uoDqMpDZyoV4RxCC6mrD4zD7xsSOFVJwd/KqN5bX4rRArkEMulxyD3
	 hsSAw5vjytvXm1gb+Hf2CBPeSOrb9L761b5icEm3jvEtlnUsj12Fl8ehAIZBvSbU5cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=gWkgIfZy;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=P8H8WUK4;
	arc=none smtp.remote-ip=23.251.234.61
Received: from e234-61.smtp-out.ap-northeast-1.amazonses.com (e234-61.smtp-out.ap-northeast-1.amazonses.com [23.251.234.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17D606A328;
	Thu,  5 Nov 2026 19:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B17D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=gWkgIfZy;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=P8H8WUK4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906579;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=MdQK0pW3gP+DwQZEbpy5aPlyghAfhAtGTFcivjaQOfA=;
	b=gWkgIfZyHp5kblZaTTRC/Z+kmknnWkmCYIkAyW/5VFVVJkeEnnp50M1SG1bL+Mew
	Q26jur/QdMrbdjHTxqt3NckFcStvhLeRW2vxAW0siIKQL0ur9z1KHEEWvc5FLsL4NRN
	IWaXhhGB6d5v5ST8y+N6EvDsc8bPbVi4koyx/pP4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906579;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=MdQK0pW3gP+DwQZEbpy5aPlyghAfhAtGTFcivjaQOfA=;
	b=P8H8WUK4J3WG7qBEXgMx11FKKQJmMQ2TQ6yXEif1yTG0KK5Nqq35eed02tPqH7Cz
	0w5vPhBKA/B0QOFR/kpeiIeVZjhOHx+OifvVLujhwYabazWKulF+Zg1CeiXPLx4zVe1
	KlBDI//zGQPUnd98FuZFKNKHPTzERs/ofLYGvdnE=
In-Reply-To:
 <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v3 1/5] HID: spi-hid: isolate DMA transfers from
 protocol buffers
Message-ID: <010601a1ad2a17c0-5662bcf3-7e66-41d1-9c33-1edff447995e-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:22:59 +0000
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
X-SES-Outgoing: 2026.11.05-23.251.234.61

SPI controllers may DMA-map the transfer buffers. Pointers into the
packed protocol buffers do not guarantee DMA alignment or isolation from
adjacent data during cache maintenance.

Allocate a separate transfer =
buffer with explicitly aligned TX and RX
regions, and copy protocol data =
into and out of it under io_lock. Keep
the original allocation pointer for =
managed ownership and publish the
new capacity only after allocation =
succeeds.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-hid-core.c | 33 ++++++++++++++++++++++++------
 drivers/hid/spi-hid/spi-hid-core.h |  3 +++
 2 files changed, 30 =
insertions(+), 6 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-cor=
e.c b/drivers/hid/spi-hid/spi-hid-core.c
index f2b2106600..db04322517 =
100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ =
b/drivers/hid/spi-hid/spi-hid-core.c
@@ -193,14 +193,19 @@ static void =
spi_hid_populate_output_header(u8 *buf,
 static int =
spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
 			      bool is_header)
 {
+	u8 *rx =3D shid->xfer_buf + =
ARCH_DMA_MINALIGN;
 	int error;
=20
-	shid->input_transfer[0].tx_buf =3D =
is_header ?
-					 shid->read_approval_header :
-					 =
shid->read_approval_body;
+	if (length > shid->xfer_size - =
ARCH_DMA_MINALIGN)
+		return -EMSGSIZE;
+
+	memcpy(shid->xfer_buf, =
is_header ? shid->read_approval_header :
+					 shid->read_approval_body,
+	       SPI_HID_READ_APPROVAL_LEN);
+	shid->input_transfer[0].tx_buf =3D =
shid->xfer_buf;
 	shid->input_transfer[0].len =3D SPI_HID_READ_APPROVAL_LEN=
;
=20
-	shid->input_transfer[1].rx_buf =3D buf;
+	shid->input_transfer[1].=
rx_buf =3D rx;
 	shid->input_transfer[1].len =3D length;
=20
 	spi_message_init_with_transfers(&shid->input_message,
@@ -217,12 +222,17 @@ static int spi_hid_input_sync(struct spi_hid *shid, =
void *buf, u16 length,
 		return error;
 	}
=20
+	memcpy(buf, rx, length);
 	return 0;
 }
=20
 static int spi_hid_output(struct spi_hid *shid, const =
void *buf, u16 length)
 {
-	return spi_write(shid->spi, buf, length);
+	if (length > shid->xfer_size)
+		return -EMSGSIZE;
+
+	memcpy(shid->xfer_buf, buf, length);
+	return spi_write(shid->spi, =
shid->xfer_buf, length);
 }
=20
 static const char *spi_hid_power_mode_stri=
ng(enum hidspi_power_state power_state)
@@ -1203,6 +1213,7 @@ static int =
spi_hid_alloc_buffers(struct spi_hid *shid, size_t report_size)
 	int inbufsize =3D round_up(sizeof(shid->input->header) +
 				 sizeof(shid->input->body) + report_size, 4);
 	int outbufsize =3D =
round_up(sizeof(shid->output->header) + report_size, 4);
+	size_t xfer_size;
 	void *tmp;
=20
 	tmp =3D devm_krealloc(dev, =
shid->output, outbufsize, GFP_KERNEL | __GFP_ZERO);
@@ -1220,8 +1231,18 @@ static int spi_hid_alloc_buffers(struct spi_hid =
*shid, size_t report_size)
 		return -ENOMEM;
 	shid->response =3D tmp;
=20
-	if (!shid->output || !shid->input || !shid->response)
+	/* io_lock serializes the separate, DMA-aligned TX and RX regions. */
+	xfer_size =3D ALIGN(max(inbufsize, outbufsize), ARCH_DMA_MINALIGN) +
+		    ARCH_DMA_MINALIGN;
+	/* Keep ownership separate from the explicitly =
aligned DMA view. */
+	tmp =3D devm_krealloc(dev, shid->xfer_alloc,
+			    xfer_size + ARCH_DMA_MINALIGN - 1,
+			    GFP_KERNEL | =
__GFP_ZERO);
+	if (!tmp)
 		return -ENOMEM;
+	shid->xfer_alloc =3D tmp;
+	shid->xfer_buf =3D PTR_ALIGN(tmp, ARCH_DMA_MINALIGN);
+	shid->xfer_size =3D xfer_size;
=20
 	shid->bufsize =3D report_size;
=20
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-h=
id-core.h
index 28e9880ad4..3419472844 100644
--- a/drivers/hid/spi-hid/spi=
-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -44,6 +44,9 @@ struct spi_hid_device_descriptor {
=20
 /* Driver context */
 struct spi_hid {
+	void *xfer_alloc;
+	u8 *xfer_buf;
+	size_t xfer_size;
 	struct spi_device	*spi;	/* spi device. */
 	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
=20
