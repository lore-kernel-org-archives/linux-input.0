Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9058470133;
	Tue, 13 Oct 2026 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862117; cv=none; b=oRuSCAyC8Fx5GPqHZIge2zBZTZdJggAV2AajiRw9Xy9DCmqJ6k+B/VbAn95bG3fYB6+kDbjwZL0O+VMul2YDf9y3+/ZcCzesBo7w5+fbmRAUr3rkEozeEeLkaO8AVSNFojmgPh/i9fQLrVS2cCywluhTchJ2cmgQsQQV3r4xDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862117; c=relaxed/simple;
	bh=Kd2QTpaoYSTVO3vMYfGpK4P3mDo+/BA9rNeVEUBhyXs=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=QmknT0WBl85hR4fdT2W5KhrmJQsuqB+bZGsQJBdqs27tIt2TdU+vv3YKsGiU46/N9Bl+gFbp7QnXWf7ZWRLL+XwVbm/hmpMmIWTyqe3/+ORug1ndy44K38F6jIbDaKQOFpbDE7zjeK8BbHa517z5sLT83555xkwY33JX58PB680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=w5Q5sEJR; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PQTkhEaK; arc=none smtp.client-ip=23.251.234.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="w5Q5sEJR";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PQTkhEaK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791862114;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=Kd2QTpaoYSTVO3vMYfGpK4P3mDo+/BA9rNeVEUBhyXs=;
	b=w5Q5sEJRE13vDQbMwwhKJg+3lGRHkHz6zVi8nvNIpO5OIXdZX0HhLl/ue1gd9j8B
	rNp5KKycdmRj0/FCrXhtu/lw7C1jgoXJAf+lBkbxmaZs9r6EFvGfQp40C7np9fipOj+
	56QzCamvMFRu+VhU0fWPrF65hC0uCDF+WBzWLSoQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791862114;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=Kd2QTpaoYSTVO3vMYfGpK4P3mDo+/BA9rNeVEUBhyXs=;
	b=PQTkhEaKLX5ynJOphjjZ9u3Fg/ysnywwsMZwfZMGsY44kPP3gNA0gMQ8zwC/x7xO
	REKzqhGL7fgiwcnEAqz7XFPKx8brLqH09KcoqwpDwrNFI1jH/bfPG39A6g/b4VBGAkK
	Jp6ghTFcBDttlmADB4DxGDnj7Jbf2iHP4UF666R0=
In-Reply-To:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v2 1/6] HID: spi-hid: isolate DMA transfers from
 protocol buffers
Message-ID: <010601a1334e08c3-dd6554c9-3506-4a79-8d07-f04b5990bfe7-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:28:34 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.53

The body starts four bytes into the input buffer. Receiving DMA directly
into it can share a cache line with the header and does not meet
controllers that require aligned DMA buffers. Use separate aligned TX
and RX regions under io_lock, and copy received data only after a
successful transfer. Keep protocol parsing buffers away from streaming
DMA.

Overallocate the managed storage and align the DMA view explicitly to
ARCH_DMA_MINALIGN, keeping the allocation base for realloc/free. Publish
the new transfer capacity only after allocation succeeds.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-h=
id-core.c | 33 ++++++++++++++++++++++++------
 drivers/hid/spi-hid/spi-hid-=
core.h |  3 +++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index 0046dfdd82677bb55c5a0b6742cdfaa8fec224c6..=
65a1cd2c72e8025f50a188e17afd2fa5b359abb1 100644
--- =
a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core=
.c
@@ -193,14 +193,19 @@ static void spi_hid_populate_output_header(u8 *buf=
,
 static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 =
length,
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
@@ -219,6 +224,7 @@ static int spi_hid_input_sync(struct spi_hid *shid, =
void *buf, u16 length,
 		return error;
 	}
=20
+	memcpy(buf, rx, length);
 	return 0;
 }
=20
@@ -226,7 +232,11 @@ static int spi_hid_output(struct =
spi_hid *shid, const void *buf, u16 length)
 {
 	int error;
=20
-	error =3D spi_write(shid->spi, buf, length);
+	if (length > =
shid->xfer_size)
+		return -EMSGSIZE;
+
+	memcpy(shid->xfer_buf, buf, =
length);
+	error =3D spi_write(shid->spi, shid->xfer_buf, length);
=20
 	if (error) {
 		shid->bus_error_count++;
@@ -1210,6 +1220,7 @@ static int=
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
@@ -1227,8 +1238,18 @@ static int spi_hid_alloc_buffers(struct spi_hid =
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
index 631897dd9e8a2f7a7c0ca29a5ae6e79e83e12579..=
9cbe2e57400443bd68056057d08f97c39c403a70 100644
--- =
a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core=
.h
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
--=20
2.53.0

