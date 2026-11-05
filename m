Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906583;
	b=o4rFm+7vjwt/WzAshvpfrV+qy7Xg6eYbXSy+hMAtJ3zkLOhH9+eV0oxObauUpK+Z0KBT
	 wAvrZzQnQzVVZpZGuDfuZ9Ocw759KJghiS9d17lzuVEhergp8687cbbBP58P66YDh24/y
	 MJ8NZVif9k7nmRW8K3R2H7g+j0TSpkSb2GffGvuPbUVJgPKfPdAGnaEDALeeqnzr1gfqQ
	 ZbUePf+eXZFSkBOhgUfp861ZyjoZAnowkqtalf3LIN8qcstBrA/jAfdT0vb2ADP3KKYRF
	 lULKkg26m99folyFYbS1zau7pknSNNk6YGrxSY1DQWv1ZBPOgWqLCDuM0hq4RdJdqZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906583;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=bdPMC5mceuOg0P0/3lYB3efidNKJEK+LuUexp0E8BpM=;
	b=CFUEXFFgP7xUanZ33AwPHr2A7AqcdLwJ8wXjML2bFisG/lM1nhCGmkyYZr8EAR/IV962
	 CyQk9keaw4Men65cL2l6jbNMJdN/KTAEH5uFFLrDUUd3Pcje0+o2csKmaCRPQa6RvOPot
	 plgCEH5c2XpOcObP3pQL+X9NLJR7bviE+vYCBd8epsKBXK7Cjtk5HtFFo74ofwkd3J8Jl
	 39N76+ABunZdphHiNNA9GLQBSNi8LafdfHmbIhIv+gFMM45WaM+UH/ItQ24u/LWlUs2Xm
	 UUI8Q7xnkh0FK2rBSJfnIVhWR2R6WJJ3VMnuS+NgxKkCf9fcZHrXp4VGbGOwLfSw2YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b="dG/tX76h";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=RvSJDGul;
	arc=none smtp.remote-ip=23.251.234.52
Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25621606A32E;
	Thu,  5 Nov 2026 19:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25621606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=dG/tX76h;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=RvSJDGul
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906582;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=i0G1US0PNqxGcGBAuVqQdGszOKA/TtcZ2u/neQGeHeQ=;
	b=dG/tX76hWdN1wCdGvvg3HYZV7HzigjxSBGTr9yeMIGiq5hL7IYuGAHGbUsvFy5Xv
	V3zonyVGsI+vmsqjTmPxnvn+QildcVoi/dX++eyIBjP2jkxFwTcvw2dWp3P3TyRS4/i
	eQiWQUVr4FiCPL256b5Qxr1hYnpkEuA6E0StSZb8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906581;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=i0G1US0PNqxGcGBAuVqQdGszOKA/TtcZ2u/neQGeHeQ=;
	b=RvSJDGulgIoPR14DBD/gdLWLxoMiXaDt+giD8z+YzYZJEspVaJFtQUnxxRn8gZGp
	aCJDVcczC4/Y/9Yldw1GbFeSigm2Uags4xGlnKCgy5/BrIa2aNoBdjbn1eOCrkUD2On
	BYil6UXGELTwW8Iz4yl4XxAs9+ZehxnB0t+rSsNg=
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
Subject: [RFC PATCH v3 2/5] HID: spi-hid: add spi-mem quad-SPI transfers
Message-ID: <010601a1ad2a20d3-1b2f9628-9334-48de-bca2-628802d8981f-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:23:01 +0000
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
X-SES-Outgoing: 2026.11.05-23.251.234.52

The Romulus13 touchpad uses single-lane opcodes followed by quad-lane
address and data phases. Describe these as spi-mem operations so the
controller receives the command, address, dummy and data phases explicitly.

Register both frontends through spi-mem while preserving ordinary SPI
transfers for single-lane devices. Controllers without mem_ops can use
the spi-mem fallback. Reject unsupported bus-width combinations and
require the four-byte opcode/address prefix only for quad output.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/Kconf=
ig        |  2 +-
 drivers/hid/spi-hid/spi-hid-acpi.c | 26 +++++-----
 drivers/hid/spi-hid/spi-hid-core.c | 77 +++++++++++++++++++++++-------
 drivers/hid/spi-hid/spi-hid-core.h |  1 +
 drivers/hid/spi-hid/spi-hid-of.=
c   | 29 +++++------
 drivers/hid/spi-hid/spi-hid.h      |  6 +--
 6 files changed, 92 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 656dbda1c5..c84da18ab8 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -6,7 +6,7 @@
 menuconfig SPI_HID
 	tristate "SPI HID support"
 	default y
-	depends on SPI
+	depends on SPI && SPI_MEM
=20
 if SPI_HID
=20
diff --git =
a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
index ea291ca269..72e74da304 100644
--- a/drivers/hid/spi-hid/spi-hid-acpi.=
c
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -194,8 +194,9 @@ static void =
spi_hid_acpi_sleep_minimal_reset_delay(struct spihid_ops *ops)
 	fsleep(1000 * conf->minimal_reset_delay_ms);
 }
=20
-static int spi_hid_acpi_probe(struct spi_device *spi)
+static int spi_hid_acpi_probe(struct spi_mem *mem)
 {
+	struct spi_device *spi =3D mem->spi;
 	struct device *dev =3D &spi->dev;
 	struct acpi_device *adev;
 	struct spi_hid_acpi_config *config;
@@ -232,7 +233,7 @@ static int spi_hid_acpi_probe(struct spi_device *spi)
 		return error;
 	}
=20
-	return spi_hid_core_probe(spi, &config->ops, =
&config->property_conf);
+	return spi_hid_core_probe(mem, &config->ops, =
&config->property_conf);
 }
=20
 static const struct acpi_device_id =
spi_hid_acpi_match[] =3D {
@@ -242,19 +243,20 @@ static const struct =
acpi_device_id spi_hid_acpi_match[] =3D {
 };
 MODULE_DEVICE_TABLE(acpi, =
spi_hid_acpi_match);
=20
-static struct spi_driver spi_hid_acpi_driver =3D =
{
-	.driver =3D {
-		.name	=3D "spi_hid_acpi",
-		.owner	=3D THIS_MODULE,
-		.pm	=3D &spi_hid_core_pm,
-		.acpi_match_table =3D spi_hid_acpi_match,
-		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+static struct spi_mem_driver=
 spi_hid_acpi_driver =3D {
+	.spidrv =3D {
+		.driver =3D {
+			.name =3D "spi_hid_acpi",
+			.pm =3D &spi_hid_core_pm,
+			.acpi_match_table =3D spi_hid_acpi_match,
+			.probe_type =3D =
PROBE_PREFER_ASYNCHRONOUS,
+		},
 	},
-	.probe		=3D spi_hid_acpi_probe,
-	.remove		=3D spi_hid_core_remove,
+	.probe =3D spi_hid_acpi_probe,
+	.remove =3D spi_hid_core_remove,
 };
=20
-module_spi_driver(spi_hid_acpi_=
driver);
+module_spi_mem_driver(spi_hid_acpi_driver);
=20
 MODULE_DESCRIPTION("HID over SPI ACPI transport driver");
 MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index db04322517..53da68c705 100644
--- a/drivers/hid/spi-hid/spi=
-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -216,7 +216,20 @@ static int spi_hid_input_sync(struct spi_hid *shid, =
void *buf, u16 length,
 				 shid->input_transfer[0].len,
 				 shid->input_transfer[1].rx_buf, 0, 0);
=20
-	error =3D =
spi_sync(shid->spi, &shid->input_message);
+	if (shid->spi->mode & =
SPI_RX_QUAD) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(sh=
id->conf->read_opcode, 1),
+				   SPI_MEM_OP_ADDR(3, is_header ?
+					shid->conf->input_report_header_address :
+					=
shid->conf->input_report_body_address, 4),
+				   SPI_MEM_OP_DUMMY(4, 4),
+				   SPI_MEM_OP_DATA_IN(length, rx, 4));
+
+		error =3D =
spi_mem_exec_op(shid->mem, &op);
+		shid->input_message.status =3D error;
+	} else {
+		error =3D spi_sync(shid->spi, &shid->input_message);
+	}
 	if (error) {
 		dev_err(&shid->spi->dev, "Error starting sync transfer: =
%d\n", error);
 		return error;
@@ -228,11 +241,28 @@ static int =
spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 length,
=20
 static int spi_hid_output(struct spi_hid *shid, const void *buf, u16 =
length)
 {
-	if (length > shid->xfer_size)
+	int error;
+
+	if (length > shid->xfer_size ||
+	    ((shid->spi->mode & SPI_TX_QUAD) &&=
 length < 4))
 		return -EMSGSIZE;
=20
-	memcpy(shid->xfer_buf, buf, =
length);
-	return spi_write(shid->spi, shid->xfer_buf, length);
+	if (shid->spi->mode & SPI_TX_QUAD) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(shid->conf->write_opcode, 1),
+				   SPI_MEM_OP_ADDR(3, shid->conf->output_report_address, 4),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(length - 4, =
shid->xfer_buf, 4));
+
+		/* spi-mem supplies the opcode and address =
outside the data phase. */
+		memcpy(shid->xfer_buf, (const u8 *)buf + 4, =
length - 4);
+		error =3D spi_mem_exec_op(shid->mem, &op);
+	} else {
+		memcpy(shid->xfer_buf, buf, length);
+		error =3D spi_write(shid->spi, =
shid->xfer_buf, length);
+	}
+
+	return error;
 }
=20
 static const char *spi_hid_power_mode_string(enum hidspi_power_state =
power_state)
@@ -1280,7 +1310,7 @@ static void spi_hid_find_max_report(stru=
ct hid_device *hid, u32 type,
 static int spi_hid_ll_start(struct =
hid_device *hid)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D spi_get_drvdata(spi);
+	struct spi_hid *shid =3D=
 spi_mem_get_drvdata(spi_get_drvdata(spi));
 	int error =3D 0;
 	/*
 	 * HID_MIN_BUFFER_SIZE is the minimum transport buffer size, not a
@@ -1314,7 +1344,7 @@ static void spi_hid_ll_stop(struct hid_device *hid)
 static int spi_hid_ll_open(struct hid_device *hid)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
=20
 	set_bit(SPI_HID_STARTED, &shid->flags);
 	return 0;
@@ -1323,7 +1353,7 @@ static int spi_hid_ll_open(struct hid_device *hid)
 static void spi_hid_ll_close(struct hid_device *hid)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
=20
 	clear_bit(SPI_HID_STARTED, &shid->flags);
 }
@@ -1331,7 +1361,7 @@ static void spi_hid_ll_close(struct hid_device *hid)
 static int spi_hid_ll_power(struct hid_device *hid, int level)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
 	int error =3D 0;
=20
 	guard(mutex)(&shid->output_lock);
@@ -1344,7 +1374,7 @@ static int spi_hid_ll_power(struct hid_device *hid, =
int level)
 static int spi_hid_ll_parse(struct hid_device *hid)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
 	struct device *dev =3D &spi->dev;
 	unsigned int rsize =3D shid->desc.report_descriptor_length;
 	int error, len;
@@ -1391,7 +1421,7 @@ static int spi_hid_ll_output_report=
(struct hid_device *hid, __u8 *buf,
 				    size_t len)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
 	struct device *dev =3D &spi->dev;
 	struct spi_hid_output_report report =3D {
 		.report_type =3D =
OUTPUT_REPORT,
@@ -1424,7 +1454,7 @@ static int spi_hid_ll_raw_request(stru=
ct hid_device *hid,
 				  size_t len, unsigned char rtype, int reqtype)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
 	struct device *dev =3D &spi->dev;
 	int ret;
=20
@@ -1589,9 +1619,10 @@ static int spi_hid_register_panel_follower(struct =
spi_hid *shid)
 	return drm_panel_add_follower(dev, &shid->panel_follower);
 }
=20
-int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops =
*ops,
+int spi_hid_core_probe(struct spi_mem *mem, struct spihid_ops *ops,
 		       struct spi_hid_conf *conf)
 {
+	struct spi_device *spi =3D =
mem->spi;
 	struct device *dev =3D &spi->dev;
 	struct spi_hid *shid;
 	int error;
@@ -1599,10 +1630,20 @@ int spi_hid_core_probe(struct =
spi_device *spi, struct spihid_ops *ops,
 	if (spi->irq <=3D 0)
 		return dev_err_probe(dev, spi->irq ?: -EINVAL, "Missing IRQ\n");
=20
+	if ((spi->mode & (SPI_RX_QUAD | SPI_TX_QUAD)) &&
+	    (spi->mode & =
(SPI_RX_QUAD | SPI_TX_QUAD)) !=3D
+	    (SPI_RX_QUAD | SPI_TX_QUAD))
+		return dev_err_probe(dev, -EINVAL,
+				     "Quad mode needs four lanes=
 in both directions\n");
+
+	if (spi->mode & (SPI_RX_DUAL | SPI_TX_DUAL | =
SPI_RX_OCTAL | SPI_TX_OCTAL))
+		return dev_err_probe(dev, -EOPNOTSUPP, =
"Unsupported SPI bus width\n");
+
 	shid =3D devm_kzalloc(dev, =
sizeof(*shid), GFP_KERNEL);
 	if (!shid)
 		return -ENOMEM;
=20
+	shid->mem =3D mem;
 	shid->spi =3D spi;
 	shid->power_state =3D =
HIDSPI_OFF;
 	shid->ops =3D ops;
@@ -1610,7 +1651,7 @@ int =
spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
 	shid->is_panel_follower =
=3D drm_is_panel_follower(&spi->dev);
=20
-	spi_set_drvdata(spi, shid);
+	spi_mem_set_drvdata(mem, shid);
=20
 	/* Using now populated conf let's =
pre-calculate the read approvals */
 	spi_hid_populate_read_approvals(shid-=
>conf, shid->read_approval_header,
@@ -1673,9 +1714,10 @@ int =
spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
=20
-void spi_hid_core_remove(struc=
t spi_device *spi)
+int spi_hid_core_remove(struct spi_mem *mem)
 {
-	struct spi_hid *shid =3D spi_get_drvdata(spi);
+	struct spi_device *spi =
=3D mem->spi;
+	struct spi_hid *shid =3D spi_mem_get_drvdata(mem);
 	struct device *dev =3D &spi->dev;
 	int error;
=20
@@ -1700,12 +1742,13 @@ void spi_hid_core_remove(struct spi_device *spi)
 		if (error)
 			dev_err(dev, "failed to disable regulator: %d\n", error);
 	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
=20
 static int spi_hid_core_pm_suspend(struct device *dev)
 {
-	struct spi_hid *shid =3D dev_get_drvdata(dev);
+	struct spi_hid *shid =3D=
 spi_mem_get_drvdata(dev_get_drvdata(dev));
=20
 	if =
(shid->is_panel_follower)
 		return 0;
@@ -1715,7 +1758,7 @@ static int =
spi_hid_core_pm_suspend(struct device *dev)
=20
 static int =
spi_hid_core_pm_resume(struct device *dev)
 {
-	struct spi_hid *shid =3D =
dev_get_drvdata(dev);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(dev_ge=
t_drvdata(dev));
=20
 	if (shid->is_panel_follower)
 		return 0;
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-h=
id-core.h
index 3419472844..768d900bc7 100644
--- a/drivers/hid/spi-hid/spi=
-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -44,6 +44,7 @@ struct spi_hid_device_descriptor {
=20
 /* Driver context */
 struct spi_hid {
+	struct spi_mem *mem;
 	void *xfer_alloc;
 	u8 *xfer_buf;
 	size_t xfer_size;
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid=
-of.c
index 6de9affbeb..5148b6b1dd 100644
--- a/drivers/hid/spi-hid/spi-hid=
-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -142,8 +142,9 @@ static =
void spi_hid_of_sleep_minimal_reset_delay(struct spihid_ops *ops)
 	fsleep(1000 * conf->data.minimal_reset_delay_ms);
 }
=20
-static int spi_hid_of_probe(struct spi_device *spi)
+static int spi_hid_of_probe(struct spi_mem *mem)
 {
+	struct spi_device *spi =3D mem->spi;
 	struct device *dev =3D &spi->dev;
 	const struct spi_hid_of_data *data;
 	struct spi_hid_of_config *config;
@@ -167,16 +168,11 @@ static int spi_hid_of_probe(struct spi_device *spi)
=20
 	config->data =3D *data;
=20
-	/*
-	 * FIXME: multi-SPI not supported.=
 Once it is, derive the
-	 * HID-over-SPI flags from spi->mode.
-	 */
-
 	error =3D spi_hid_of_populate_config(config, dev);
 	if (error)
 		return dev_err_probe(dev, error, "Unable to populate config data\n");
=20
-	return spi_hid_core_probe(spi, &config->ops, &config->data.conf);
+	return spi_hid_core_probe(mem, &config->ops, &config->data.conf);
 }
=20
 static const struct of_device_id spi_hid_of_match[] =3D {
@@ -191,20 +187,21 @@ static const struct spi_device_id =
spi_hid_of_id_table[] =3D {
 };
 MODULE_DEVICE_TABLE(spi, =
spi_hid_of_id_table);
=20
-static struct spi_driver spi_hid_of_driver =3D {
-	.driver =3D {
-		.name =3D "spi_hid_of",
-		.owner =3D THIS_MODULE,
-		.pm =3D &spi_hid_core_pm,
-		.of_match_table =3D spi_hid_of_match,
-		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+static struct spi_mem_driver=
 spi_hid_of_driver =3D {
+	.spidrv =3D {
+		.driver =3D {
+			.name =3D "spi_hid_of",
+			.pm =3D &spi_hid_core_pm,
+			.of_match_table =3D spi_hid_of_match,
+			.probe_type =3D =
PROBE_PREFER_ASYNCHRONOUS,
+		},
+		.id_table =3D spi_hid_of_id_table,
 	},
 	.probe =3D spi_hid_of_probe,
 	.remove =3D spi_hid_core_remove,
-	.id_table =3D spi_hid_of_id_table,
 };
=20
-module_spi_driver(spi_hid_of_=
driver);
+module_spi_mem_driver(spi_hid_of_driver);
=20
 MODULE_DESCRIPTION("HID over SPI OF transport driver");
 MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index 95acb28452..e87d1cf05e 100644
--- a/drivers/hid/spi-hid/spi-hid.h
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -7,7 +7,7 @@
 #ifndef SPI_HID_H
 #define SPI_HID_H
=20
-#include <linux/spi/spi.h>
+#include =
<linux/spi/spi-mem.h>
 #include <linux/sysfs.h>
=20
 /* struct spi_hid_conf - Conf provided to the core */
@@ -35,10 +35,10 @@ struct spihid_ops {
 	void (*sleep_minimal_reset_delay)=
(struct spihid_ops *ops);
 };
=20
-int spi_hid_core_probe(struct spi_device=
 *spi, struct spihid_ops *ops,
+int spi_hid_core_probe(struct spi_mem *mem,=
 struct spihid_ops *ops,
 		       struct spi_hid_conf *conf);
=20
-void spi_hid_core_remove(struct spi_device *spi);
+int =
spi_hid_core_remove(struct spi_mem *mem);
=20
 extern const struct =
dev_pm_ops spi_hid_core_pm;
=20
