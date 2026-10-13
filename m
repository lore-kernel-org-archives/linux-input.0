Received: from e234-55.smtp-out.ap-northeast-1.amazonses.com (e234-55.smtp-out.ap-northeast-1.amazonses.com [23.251.234.55])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BA2E06EF;
	Tue, 13 Oct 2026 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862123; cv=none; b=BKjOrFess+1wIPERsDMOCOubb9rGiomOlVlHo2nrs6MHg46qhYe6uDXY5uSOa2w9fRA1SimcYECP3T5vqyQYaPLFOS3F/AZ5upLnyKlDlLwAMD9mF+rXVa7KAVLqPAhbOM+/uMCuRkpXGxKqrenqb5at5U5MqeoOyQL/Ak8Z3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862123; c=relaxed/simple;
	bh=EAHjtUyEutHNXTRtPLQflIbP6+jO6d10TiKaL5o6WkY=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=c1FQ4yXMo79YaJwMuM/3co7aSZw6UmlWJlUR/UjH69P5z+fVPK6C8oL/3DwyomqrqY6sWKkeGUmPz5N7u+hM1JaBHBlgw59ESQIzGjlmqKjT6f9QsQpYvt/Sxkovy6yVHrTtxiJacSod5w2dMhZkMavaqPiqwh4tPeZocn2IxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=Ofvfocxx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=gA9SvLdQ; arc=none smtp.client-ip=23.251.234.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="Ofvfocxx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gA9SvLdQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791862119;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=EAHjtUyEutHNXTRtPLQflIbP6+jO6d10TiKaL5o6WkY=;
	b=OfvfocxxWrqOf1YxEC2/DQeiJYxDnnLk8GkKLLIy6rcMVjqJr+EfZOcSpMAigxI6
	RFiRlGfMpnQ3UPYZx2xaBqL5BI8IyOswR+Fnu2aAYi760oDX+a8luGZz8/gfwr+E705
	JGWeCcd/cQYUD06sXUTCYDy+I9ekyVMfzNr+N1+w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791862119;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=EAHjtUyEutHNXTRtPLQflIbP6+jO6d10TiKaL5o6WkY=;
	b=gA9SvLdQdITeZgA67DTuTqIb2ZonsRklajZSXE8IJfMhKg20tdNfmQEWdun/aRPy
	M0wwKpoiKrZGRWEJzncEN246i23OFaEJIAbObv7iOrWVJjpe61jOYLQOwLujUxigQcP
	2U+hjXSe44s4Xu94KtsIuBE5dfthdW98n9HVcmy0=
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
Subject: [RFC PATCH v2 3/6] HID: spi-hid: assemble bounded fragmented input
 reports
Message-ID: <010601a1334e19cf-6aaf0037-c92d-4814-8d21-4fca36ed0a8d-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:28:38 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.55

Keep fragment lengths separate from complete HID report lengths.
Assemble DATA reports into a dedicated buffer, enforce the declared
content length and final padding, and reject fragmented command
responses. Discard incomplete reports after a one-second gap or during
error recovery and suspend.

Require a body header before parsing and bound=
 allocations to 8 KiB.
Preserve the v5 request serialization and response =
matching.

Use the existing max_fragment_length descriptor field for each =
fragment;
max_input_length describes a complete input report and remains =
distinct.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-hid-core.c | 70 +++++++++++++++++++++++++-----
 drivers/hid/spi-hid/spi-hid-core.h |  4 ++
 2 files changed, 63 =
insertions(+), 11 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-co=
re.c b/drivers/hid/spi-hid/spi-hid-core.c
index 9d02c156fcd641e9c944c0dfe08=
b5aad57a97f6a..2778d147b202ab663928a851198eca8fe628b16a 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-=
core.c
@@ -146,7 +146,6 @@ static void spi_hid_parse_dev_desc(const struct =
hidspi_dev_descriptor *raw,
 	desc->max_input_length =3D =
le16_to_cpu(raw->max_input_len);
 	desc->max_output_length =3D =
le16_to_cpu(raw->max_output_len);
=20
-	/* FIXME: multi-fragment not =
supported, field below not used */
 	desc->max_fragment_length =3D =
le16_to_cpu(raw->max_frag_len);
=20
 	desc->vendor_id =3D =
le16_to_cpu(raw->vendor_id);
@@ -335,6 +334,7 @@ static int =
spi_hid_suspend(struct spi_hid *shid)
 	 */
 	disable_irq(shid->spi->irq);
 	cancel_work_sync(&shid->reset_work);
+	shid->fragment_len =3D 0;
=20
 	guard(mutex)(&shid->power_lock);
 	if (!device_may_wakeup(dev)) {
@@ -468,6 +468,7 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 		return;
=20
 	disable_irq(shid->spi->irq);
+	shid->fragment_len =3D 0;
=20
 	if (shid->reset_attempts++ >=3D SPI_HID_MAX_RESET_ATTEMPTS) {
 		dev_err(dev, "unresponsive device, aborting\n");
@@ -1039,6 +1040,48 @@ static int spi_hid_process_input_report(struct =
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
@@ -1061,24 +1104,20 @@ static int =
spi_hid_bus_validate_header(struct spi_hid *shid,
 	 * report_length is =
device-provided and is used as the size of the body
 	 * transfer, so it must never exceed the input buffer.
 	 */
-	if (header->report_length > max_body) {
+	if (header->report_length < =
HIDSPI_INPUT_BODY_HEADER_SIZE ||
+	    header->report_length > max_body) {
 		dev_err(dev, "Input report too big: %u > %u\n",
 			=
header->report_length, max_body);
 		return -EMSGSIZE;
 	}
=20
-	if (shid->desc.max_input_length !=3D 0 &&
-	    header->report_length > =
shid->desc.max_input_length) {
+	if (shid->desc.max_fragment_length &&
+	    header->report_length > shid->desc.max_fragment_length) {
 		dev_err(dev, "Input report body size %u > max expected of %u\n",
-			header->report_length, shid->desc.max_input_length);
+			header->report_length, shid->desc.max_fragment_length);
 		return -EMSGSIZE;
 	}
=20
-	if (header->last_fragment_flag !=3D 1) {
-		dev_err(dev, "Multi-fragment reports not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (header->sync_const !=3D =
SPI_HID_INPUT_HEADER_SYNC_BYTE) {
 		dev_err(dev, "Invalid input report =
sync constant (0x%x)\n",
 			header->sync_const);
@@ -1149,6 +1188,7 @@ =
static int spi_hid_set_request(struct spi_hid *shid, u8 *arg_buf, u16 =
arg_len,
 /* Schedule a reset to recover from an error in the IRQ handler. =
*/
 static irqreturn_t spi_hid_irq_error(struct spi_hid *shid)
 {
+	shid->fragment_len =3D 0;
 	set_bit(SPI_HID_ERROR, &shid->flags);
 	schedule_work(&shid->reset_work);
=20
@@ -1231,7 +1271,7 @@ static =
irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
 		}
 	}
=20
-	error =3D spi_hid_process_input_report(shid, shid->input);
+	error =3D spi_hid_accept_fragment(shid, &header);
 	if (error) {
 		dev_err(dev, "Failed to process input report: %d\n", error);
 		return spi_hid_irq_error(shid);
@@ -1249,6 +1289,9 @@ static int =
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
@@ -1264,6 +1307,11 @@ static int spi_hid_alloc_buffers(struct spi_hid =
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
index 554288dd17631edc1a503755b04170c0=
4501bcb7..635d66daaf456cdb65c57146758ea7c64a1537f7 100644
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
--=20
2.53.0

