Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906585;
	b=XyxK1yk2B3djtMFWmO+x3apOuFSSnlRRITQrhVTY8BGxeXBV2ms6Z1c7DI4LVOgqPoCU
	 I8MVttoODV6JVwXqp7wweb80e+LWFktLLTFMUae01xDhZDxfu832vSiWOtEBXYp0WnzB9
	 cyNBpEnXoZg0GocmM7o0mKtWmdzxUwW0oqATIn2Fi6ofGWuVNzHCyM80A66a1MVJimg30
	 7LmI8H++COGIcxK/5VNiTf7gfjQzLaJ6ddn5SUT7BJBgGWb3dZBdJx+NISClYxhGnzO/b
	 CGdNvZDUXzivpD0UNI8QY0SoOwQPd2ECaCjzevoS4UqTy7SsULljoFtK+S3IGpzPfiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906585;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=G0R4gWvYN/Fui2EFqJ00V/I4Q2HdfT+HS90IRVFEJKs=;
	b=1r1Eytv5g06i5aGLf1yJljX2nif9SnOcNuJgZMaNbEYnuKwmYyktVPGZOPpyEqJ75ADe
	 PLLgr+NTxJ+YMrc4U3IODBv5UySVih4gNhzNuZanfo3qE09fl1UiT0qY6Wz/On1ScWRcb
	 FU7P/PxAJtyj5ytnRpyA/VJXT7O8MOylgUrF6aZpBf6lD7pOjDTzKiNXdIfQdMYOxIQgM
	 0c+DHBDXI9t7Sr+AVL3XUKHilMsHeYV8tp/Jm9HQMgr4GOD81sn++mopgS5nkEjYylAdT
	 wxOjIidXPsba9wBCsxAvXJPjEXRxLG1mrpFbD977hoaYo6zMZcaBK8HSnOlOUXGg4ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=HQXq3YFH;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=VqpRoGDG;
	arc=none smtp.remote-ip=23.251.234.59
Received: from e234-59.smtp-out.ap-northeast-1.amazonses.com (e234-59.smtp-out.ap-northeast-1.amazonses.com [23.251.234.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA35606A339;
	Thu,  5 Nov 2026 19:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA35606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=HQXq3YFH;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=VqpRoGDG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906583;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=LIWEb6peK8EEkTB3s0L8O1rPp9b1JrnBw3v/+S1Gtqc=;
	b=HQXq3YFH0EYQhRoai+5k3M8nNWTt8vkQnyE9T3R1HyAeu0CHfitVUa8TeajLNka3
	X0TwWYAsxq0pZD8tJ0fiZVF3Q0/YLxIwp0NPD7lOi9k1P7WJHey+3cbuhkkqjfG2Ah2
	1ktQB7LugH0lpxnyXVEDTlCJd660IzaZ3gulAjBI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906583;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=LIWEb6peK8EEkTB3s0L8O1rPp9b1JrnBw3v/+S1Gtqc=;
	b=VqpRoGDGs/2rN0pBDOg78/9BOculTToWkTXLS/vZgIAurQUELqA57dUamvOv1e5W
	z9WG1UM6yHwJCNI2Hyqmy+YDIhwAPQlQ+6+yHxQn0SE6alx4d2DUKWaFsnzzRz0SsDI
	r3q+h307+if9HpwDyHJHdYVbwVK3WOB2ed63EKoI=
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
Subject: [RFC PATCH v3 3/5] HID: spi-hid: assemble bounded fragmented input
 reports
Message-ID: <010601a1ad2a2689-52fe023d-9a6c-4a13-b679-602c4e115921-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:23:03 +0000
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
X-SES-Outgoing: 2026.11.05-23.251.234.59

The driver rejects every report split across multiple wire fragments.
Assemble DATA fragments before passing a complete report to the HID
layer, checking the declared length, final padding and inter-fragment
timeout. Command responses remain atomic.

Limit report_size to 8 KiB =
before allocating buffers and discard partial
reports on suspend and =
recovery. Preserve minimum-body validation and
check each wire fragment =
against max_fragment_length independently of
the complete input-report size=
.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-hid-core.c | 64 +++++++++++++++++++++++++++---
 drivers/hid/spi-hid/spi-hid-core.h |  4 ++
 2 files changed, 63 =
insertions(+), 5 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-cor=
e.c b/drivers/hid/spi-hid/spi-hid-core.c
index 53da68c705..ef5fb11f23 =
100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ =
b/drivers/hid/spi-hid/spi-hid-core.c
@@ -146,7 +146,6 @@ static void =
spi_hid_parse_dev_desc(const struct hidspi_dev_descriptor *raw,
 	desc->max_input_length =3D le16_to_cpu(raw->max_input_len);
 	desc->max_output_length =3D le16_to_cpu(raw->max_output_len);
=20
-	/* FIXME: multi-fragment not supported, field below not used */
 	desc->max_fragment_length =3D le16_to_cpu(raw->max_frag_len);
=20
 	desc->vendor_id =3D le16_to_cpu(raw->vendor_id);
@@ -330,6 +329,7 @@ =
static int spi_hid_suspend(struct spi_hid *shid)
=20
 	/* disable_irq() waits for a running IRQ thread. */
 	disable_irq(shid->spi->irq);
+	shid->fragment_len =3D 0;
=20
 	guard(mutex)(&shid->power_lock);
 	if (!device_may_wakeup(dev)) {
@@ -461,6 +461,7 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 		return;
=20
 	disable_irq(shid->spi->irq);
+	shid->fragment_len =3D 0;
=20
 	if (shid->reset_attempts++ >=3D SPI_HID_MAX_RESET_ATTEMPTS) {
 		dev_err(dev, "unresponsive device, aborting\n");
@@ -1035,6 +1036,48 @@ static int spi_hid_process_input_report(struct =
spi_hid *shid,
 	return 0;
 }
=20
+/* Only DATA reports may be fragmented; =
command responses remain atomic. */
+static int spi_hid_accept_fragment(str=
uct spi_hid *shid,
+				   const struct spi_hid_input_header *header)
+{
+	struct spi_hid_input_report body;
+	u16 len =3D header->report_length;
+	unsigned int total;
+	int error;
+
+	if (shid->fragment_len &&
+	    time_after(jiffies, shid->fragment_time + msecs_to_jiffies(1000)))
+		goto invalid;
+	if (!shid->fragment_len) {
+		if =
(header->last_fragment_flag)
+			return spi_hid_process_input_report(shid, =
shid->input);
+		spi_hid_populate_input_body(shid->input->body, &body);
+		if (body.report_type !=3D DATA || body.content_length > shid->bufsize)
+			goto invalid;
+		shid->fragment_expected =3D HIDSPI_INPUT_BODY_SIZE(bod=
y.content_length);
+	}
+	total =3D shid->fragment_len + len;
+	if (total > round_up(shid->bufsize + HIDSPI_INPUT_BODY_HEADER_SIZE, 4) ||
+	    (!header->last_fragment_flag && total >=3D shid->fragment_expected) =
||
+	    (header->last_fragment_flag && total !=3D ALIGN(shid->fragment_exp=
ected, 4)))
+		goto invalid;
+	memcpy((u8 *)shid->fragment + =
offsetof(struct spi_hid_input_buf, body) +
+	       shid->fragment_len, =
shid->input->body, len);
+	shid->fragment_len =3D total;
+	shid->fragment_time =3D jiffies;
+	if (!header->last_fragment_flag)
+		return 0;
+
+	memcpy(shid->fragment->header, shid->input->header, =
HIDSPI_INPUT_HEADER_SIZE);
+	put_unaligned_le16((total / 4) | BIT(14), =
&shid->fragment->header[1]);
+	error =3D spi_hid_process_input_report(shid,=
 shid->fragment);
+	shid->fragment_len =3D 0;
+	return error;
+invalid:
+	shid->fragment_len =3D 0;
+	return -EPROTO;
+}
+
 static int =
spi_hid_bus_validate_header(struct spi_hid *shid,
 				       struct =
spi_hid_input_header *header)
 {
@@ -1070,9 +1113,11 @@ static int =
spi_hid_bus_validate_header(struct spi_hid *shid,
 		return -EMSGSIZE;
 	}
=20
-	if (header->last_fragment_flag !=3D 1) {
-		dev_err(dev, =
"Multi-fragment reports not supported\n");
-		return -EOPNOTSUPP;
+	if (shid->desc.max_fragment_length &&
+	    header->report_length > =
shid->desc.max_fragment_length) {
+		dev_err(dev, "Input fragment size %u >=
 max expected of %u\n",
+			header->report_length, shid->desc.=
max_fragment_length);
+		return -EMSGSIZE;
 	}
=20
 	if (header->sync_const=
 !=3D SPI_HID_INPUT_HEADER_SYNC_BYTE) {
@@ -1152,6 +1197,7 @@ static int =
spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 arg_len,
 /* Schedule a reset to recover from an error in the IRQ handler. */
 static irqreturn_t spi_hid_irq_error(struct spi_hid *shid)
 {
+	shid->fragment_len =3D 0;
 	set_bit(SPI_HID_ERROR, &shid->flags);
 	schedule_work(&shid->reset_work);
=20
@@ -1228,7 +1274,7 @@ static =
irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 		}
 	}
=20
-	error =3D spi_hid_process_input_report(shid, shid->input);
+	error =3D spi_hid_accept_fragment(shid, &header);
 	if (error) {
 		dev_err(dev, "Failed to process input report: %d\n", error);
 		return spi_hid_irq_error(shid);
@@ -1246,6 +1292,9 @@ static int =
spi_hid_alloc_buffers(struct spi_hid *shid, size_t report_size)
 	size_t xfer_size;
 	void *tmp;
=20
+	if (report_size > SZ_8K)
+		return -EMSGSIZE;
+
 	tmp =3D devm_krealloc(dev, shid->output, =
outbufsize, GFP_KERNEL | __GFP_ZERO);
 	if (!tmp)
 		return -ENOMEM;
@@ -1261,6 +1310,11 @@ static int spi_hid_alloc_buffers(struct spi_hid =
*shid, size_t report_size)
 		return -ENOMEM;
 	shid->response =3D tmp;
=20
+	tmp =3D devm_krealloc(dev, shid->fragment, inbufsize, GFP_KERNEL | =
__GFP_ZERO);
+	if (!tmp)
+		return -ENOMEM;
+	shid->fragment =3D tmp;
+
 	/* io_lock serializes the separate, DMA-aligned TX and RX regions. */
 	xfer_size =3D ALIGN(max(inbufsize, outbufsize), ARCH_DMA_MINALIGN) +
 		    ARCH_DMA_MINALIGN;
diff --git a/drivers/hid/spi-hid/spi-hid-core.h =
b/drivers/hid/spi-hid/spi-hid-core.h
index 768d900bc7..a65a764d0b 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-=
core.h
@@ -61,6 +61,10 @@ struct spi_hid {
 	struct spi_hid_output_buf =
*output;	/* Output buffer. */
 	struct spi_hid_input_buf *input;	/* Input =
buffer. */
 	struct spi_hid_input_buf *response;	/* Response buffer. */
+	struct spi_hid_input_buf *fragment;
+	u16 fragment_len;
+	u16 fragment_expected;
+	unsigned long fragment_time;
=20
 	struct drm_panel_follower panel_follower;
 	bool	is_panel_follower;
