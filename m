Received: from e234-57.smtp-out.ap-northeast-1.amazonses.com (e234-57.smtp-out.ap-northeast-1.amazonses.com [23.251.234.57])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF447729A;
	Tue, 13 Oct 2026 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862123; cv=none; b=ui3v490qYu+UwNTPNO6TyPZKP+rzDqUClHCeukVNRRUziEhngmzWNFyVuxjFsjCVvXJ8bIxyPKuBNHA04t428UutJdy1LCzAMx7NXlQAgxQ/3K/r13D5iWL+O9lChRThwzyrxVgLT4oj+/o6fA1zXr6kxQlm/bR2fScxaxPaDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862123; c=relaxed/simple;
	bh=ROlGM0exL/yGE2xPI+bQdBLzxd/wtNPOLTmJCEyMQm0=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=HTT6treMiSZ4w01+MpdBHq+n2/j75MmYHVHUP6f+LsMAxUqjD8bwjEQ0WR0K2fYUiM4Z8+9A5jrE0KSem/QZjrq4kOnaEdCsWA5btb0/xgmKYyyT09e3sVFxUOe0Jd2NyYqi3ea5x9r2N0mx9bZZYU5gCWpczvPmHyc5B6C4wvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=FIljL8nq; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=s+M+tYQ4; arc=none smtp.client-ip=23.251.234.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="FIljL8nq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="s+M+tYQ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791862117;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=ROlGM0exL/yGE2xPI+bQdBLzxd/wtNPOLTmJCEyMQm0=;
	b=FIljL8nq4B33aolP/WUC4Fbn7jvZNH1U6yc/2IxTBiYJtEjpbIY4gAkfAm57+OJn
	5bRcW+Pm1Kx05B0LAWEbAyeDP7LjHnOtoP75WRsaMTiyaFr7E3GS+yU8s5PGzW8I3lp
	XeHQ4c42aKQJcU90FxBIlD5C71TbWQDDrbP6cHHk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791862117;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=ROlGM0exL/yGE2xPI+bQdBLzxd/wtNPOLTmJCEyMQm0=;
	b=s+M+tYQ4ZijobPCpnxtdBRw2y4fOpQj1DKT6RuTrjIeePFfGou8sBhD6iPjFmhd7
	UKU5vMSCm95sMJRhLGYixaGrJQfFgkzzgVVtlVn+66TMlZ84al+6NV6SedjlbdCS3T8
	PN0apvge9qx+4FmYMivf732nCza5LA/uvMADX0rA=
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
Subject: [RFC PATCH v2 2/6] HID: spi-hid: add spi-mem quad-SPI transfers
Message-ID: <010601a1334e11ce-a752559f-b39e-41dd-ad92-8cc2c08f53c7-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:28:36 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.57

Use explicit opcode, address, dummy and data phases for the 1-4-4 reads
and 1-4-4 writes used by the Romulus touchpad. Four quad dummy bytes
provide the eight read dummy clocks. The output data phase excludes the
opcode and address already supplied to spi-mem.

Register the frontends =
through spi-mem so controllers exposing memory
operations can execute the =
transactions. Single-lane devices retain
their ordinary spi_sync/spi_write =
transfers. Reject bus-width
combinations this transport cannot encode.

Only quad writes require the four-byte opcode/address prefix; preserve
the existing short-write behavior for single-lane SPI.

Controllers do not need mem_ops to bind these frontends. Single-lane
transfers bypass spi_mem_exec_op(); for supported memory operations,
spi-mem can fall back to ordinary SPI messages when mem_ops are absent.
The new SPI_MEM Kconfig dependency remains required.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/Kconf=
ig        |  2 +-
 drivers/hid/spi-hid/spi-hid-acpi.c | 28 ++++++-----
 drivers/hid/spi-hid/spi-hid-core.c | 80 ++++++++++++++++++++++--------
 drivers/hid/spi-hid/spi-hid-core.h |  1 +
 drivers/hid/spi-hid/spi-hid-of.=
c   | 35 ++++++-------
 drivers/hid/spi-hid/spi-hid.h      |  6 +--
 6 files changed, 96 insertions(+), 56 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 656dbda1c5d873e5bc6c87dda1fbe81460425d30..c84da18ab82819b019cd58a2d3e=
b9a7b0f6417b0 100644
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
index a52cafe86c052f0ab8c4761c43355969eb689157..790342073e6f53d61a193429094=
e965c7819aeda 100644
--- a/drivers/hid/spi-hid/spi-hid-acpi.c
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
@@ -242,20 +243,21 @@ static const struct =
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
-		.dev_groups =3D =
spi_hid_groups,
+static struct spi_mem_driver spi_hid_acpi_driver =3D {
+	.spidrv =3D {
+		.driver =3D {
+			.name =3D "spi_hid_acpi",
+			.pm =3D &spi_hid_core_pm,
+			.acpi_match_table =3D spi_hid_acpi_match,
+			.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+			.dev_groups =3D =
spi_hid_groups,
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
index 65a1cd2c72e8025f50a188e17afd2fa5b359abb1..=
9d02c156fcd641e9c944c0dfe08b5aad57a97f6a 100644
--- =
a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core=
.c
@@ -216,7 +216,20 @@ static int spi_hid_input_sync(struct spi_hid *shid,=
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
 		shid->bus_error_count++;
@@ -232,11 +245,24 @@ static int=
 spi_hid_output(struct spi_hid *shid, const void *buf, u16 length)
 {
 	int error;
=20
-	if (length > shid->xfer_size)
+	if (length > =
shid->xfer_size ||
+	    ((shid->spi->mode & SPI_TX_QUAD) && length < 4))
 		return -EMSGSIZE;
=20
-	memcpy(shid->xfer_buf, buf, length);
-	error =3D spi_write(shid->spi, shid->xfer_buf, length);
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
=20
 	if (error) {
 		shid->bus_error_count++;
@@ -1287,7 +1313,7 @@ static void spi_hid_find_max_report(struct hid_device=
 *hid, u32 type,
 static int spi_hid_ll_start(struct hid_device *hid)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D =
spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_ge=
t_drvdata(spi));
 	int error =3D 0;
 	/*
 	 * HID_MIN_BUFFER_SIZE is the =
minimum transport buffer size, not a
@@ -1319,7 +1345,7 @@ static void =
spi_hid_ll_stop(struct hid_device *hid)
 static int spi_hid_ll_open(struct =
hid_device *hid)
 {
 	struct spi_device *spi =3D hid->driver_data;
-	struct spi_hid *shid =3D spi_get_drvdata(spi);
+	struct spi_hid *shid =3D=
 spi_mem_get_drvdata(spi_get_drvdata(spi));
=20
 	set_bit(SPI_HID_STARTED, =
&shid->flags);
 	return 0;
@@ -1328,7 +1354,7 @@ static int =
spi_hid_ll_open(struct hid_device *hid)
 static void =
spi_hid_ll_close(struct hid_device *hid)
 {
 	struct spi_device *spi =3D =
hid->driver_data;
-	struct spi_hid *shid =3D spi_get_drvdata(spi);
+	struct spi_hid *shid =3D spi_mem_get_drvdata(spi_get_drvdata(spi));
=20
 	clear_bit(SPI_HID_STARTED, &shid->flags);
 	shid->reset_attempts =3D 0;
@@ -1337,7 +1363,7 @@ static void spi_hid_ll_close(struct hid_device *hid)
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
@@ -1350,7 +1376,7 @@ static int spi_hid_ll_power(struct hid_device *hid, =
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
@@ -1395,7 +1421,7 @@ static int spi_hid_ll_output_report=
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
@@ -1428,7 +1454,7 @@ static int spi_hid_ll_raw_request(stru=
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
@@ -1490,7 +1516,7 @@ static struct hid_ll_driver spi_hid_ll_driver =3D {
 static ssize_t bus_error_count_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct spi_hid *shid =3D dev_get_drvdata(dev);
+	struct spi_hid *shid =3D=
 spi_mem_get_drvdata(dev_get_drvdata(dev));
=20
 	return sysfs_emit(buf, =
"%u (%d)\n",
 			  shid->bus_error_count, shid->bus_last_error);
@@ -1501,7 +1527,7 @@ static ssize_t regulator_error_count_show(struct =
device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct spi_hid *shid =3D dev_get_drvdata(dev);
+	struct spi_hid *shid =3D=
 spi_mem_get_drvdata(dev_get_drvdata(dev));
=20
 	return sysfs_emit(buf, =
"%u (%d)\n",
 			  shid->regulator_error_count,
@@ -1513,7 +1539,7 @@ =
static ssize_t device_initiated_reset_count_show(struct device *dev,
 						 struct device_attribute *attr,
 						 char *buf)
 {
-	struct spi_hid *shid =3D dev_get_drvdata(dev);
+	struct spi_hid *shid =3D=
 spi_mem_get_drvdata(dev_get_drvdata(dev));
=20
 	return sysfs_emit(buf, =
"%u\n", shid->dir_count);
 }
@@ -1644,9 +1670,10 @@ static int =
spi_hid_register_panel_follower(struct spi_hid *shid)
 	return drm_panel_add_follower(dev, &shid->panel_follower);
 }
=20
-int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
+int spi_hid_core_probe(struct spi_mem *mem, struct spihid_ops *ops,
 		       struct spi_hid_conf *conf)
 {
+	struct spi_device *spi =3D =
mem->spi;
 	struct device *dev =3D &spi->dev;
 	struct spi_hid *shid;
 	int error;
@@ -1654,10 +1681,20 @@ int spi_hid_core_probe(struct =
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
@@ -1665,7 +1702,7 @@ int =
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
@@ -1726,9 +1763,10 @@ int =
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
@@ -1753,12 +1791,14 @@ void spi_hid_core_remove(struct spi_device *spi)
 		if (error)
 			dev_err(dev, "failed to disable regulator\n");
 	}
+
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
@@ -1768,7 +1808,7 @@ static int =
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
index 9cbe2e57400443bd68056057d08f97c39c403a70..=
554288dd17631edc1a503755b04170c04501bcb7 100644
--- =
a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core=
.h
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
index 605edecc4f7ee0423c37f0960cd4974b04ab387c..=
51bcb1a1b2a85480044c6514890f790e2930f523 100644
--- =
a/drivers/hid/spi-hid/spi-hid-of.c
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -175,8 +175,9 @@ static void spi_hid_of_sleep_minimal_reset_delay(struct=
 spihid_ops *ops)
 	fsleep(1000 * conf->timing_data->minimal_reset_delay_ms=
);
 }
=20
-static int spi_hid_of_probe(struct spi_device *spi)
+static int spi_hid_of_probe(struct spi_mem *mem)
 {
+	struct spi_device *spi =3D mem->spi;
 	struct device *dev =3D &spi->dev;
 	struct spi_hid_of_config *config;
 	int error;
@@ -197,16 +198,11 @@ =
static int spi_hid_of_probe(struct spi_device *spi)
 	if (!config->timing_data)
 		config->timing_data =3D &timing_data;
=20
-	/*
-	 * FIXME: multi-SPI not supported. Once it is, derive the
-	 * HID-over-SPI flags from spi->mode.
-	 */
-
 	error =3D =
spi_hid_of_populate_config(config, dev);
 	if (error)
 		return dev_err_probe(dev, error, "Unable to populate config data\n");
=20
-	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+	return spi_hid_core_probe(mem, &config->ops, &config->property_conf);
 }
=20
 static const struct of_device_id spi_hid_of_match[] =3D {
@@ -222,21 +218,22 @@ static const struct spi_device_id =
spi_hid_of_id_table[] =3D {
 };
 MODULE_DEVICE_TABLE(spi, =
spi_hid_of_id_table);
=20
-static struct spi_driver spi_hid_of_driver =3D {
-	.driver =3D {
-		.name	=3D "spi_hid_of",
-		.owner	=3D THIS_MODULE,
-		.pm	=3D &spi_hid_core_pm,
-		.of_match_table =3D spi_hid_of_match,
-		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
-		.dev_groups =3D =
spi_hid_groups,
+static struct spi_mem_driver spi_hid_of_driver =3D {
+	.spidrv =3D {
+		.driver =3D {
+			.name =3D "spi_hid_of",
+			.pm =3D &spi_hid_core_pm,
+			.of_match_table =3D spi_hid_of_match,
+			.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+			.dev_groups =3D =
spi_hid_groups,
+		},
+		.id_table =3D spi_hid_of_id_table,
 	},
-	.probe		=3D spi_hid_of_probe,
-	.remove		=3D spi_hid_core_remove,
-	.id_table	=3D spi_hid_of_id_table,
+	.probe =3D spi_hid_of_probe,
+	.remove =3D spi_hid_core_remove,
 };
=20
-module_spi_driver(spi_hid_of_dr=
iver);
+module_spi_mem_driver(spi_hid_of_driver);
=20
 MODULE_DESCRIPTION("HID over SPI OF transport driver");
 MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
index 17b2fdf192ed2cf40db0638874112c72595fdd6d..dd3a851777a22eefa9005dc6f7a=
18bf62c5ac6b3 100644
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
attribute_group *spi_hid_groups[];
 extern const struct dev_pm_ops =
spi_hid_core_pm;
--=20
2.53.0

