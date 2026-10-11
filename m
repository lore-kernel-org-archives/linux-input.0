Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BE44C4FF;
	Sun, 11 Oct 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722885; cv=none; b=ljbk8xm9LwF5FJ4gxvQ9xnMif59KR/KLuKQBr7JX7vyPgkvb0v5WeAf+cMGoQP47YgWb/cPZwrQfJoefwm0J8kNwFCZVzYFzjbF8hDFZmC2Ow+cQDi7w2XvxgNK6fNkQoQnhgKgBkSQdSQnooA8jDXsCSuZc6THaFNlpI5QKzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722885; c=relaxed/simple;
	bh=WuXKJ6sbReliksHBcknnmyYgz2Bd9qFZxSWnJqdhnDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujyZuDue6KB02ynamEeyHOeyzNauHsam1REt1D+ZmCn8pF7tV8eLXmnwlK/q4aKHd/y/rB6Jd1vO0e4GJgIbLD7SIpcXCRoVxZdaqS+Gl3PMiZiyNPopKODeOdHZlhZv2O66th4wqfHKEOAI9yl3mZL9n2myn6t4e1aFER89Kx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=oxtjHs8d; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="oxtjHs8d"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j2gPD451RzKnrx;
	Sun, 11 Oct 2026 14:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DhCaH/ApFbmFi0zQ1UdjPcLD4YaiQA7veraP4igJlw=;
	b=oxtjHs8da5wqvKa7MRtoRwnal74DIotM3FGI9+50XMtwxsimyPWoLaFzc//nabdssTjczr
	E9Pu7Tfrfpo/HCHulXAiaLzyT+EZNTq0QMoN2jsxz+0VVT1Vwsy9ZdZLGaHSC2xrXhpXEU
	uFEU1uGrDDuMP1Kl52le97tv4yFJQVZ9BcNrrS9CbNHLgujG93ed4iagunLCZUYc2XjjTi
	G4206r6LkMyUjtR/nbTSeVxRuTnK2rwYztbzo1+Obazooo3XKjc+IVM8WdQnupvbLDAnBE
	Ja8HscNvadgfgA6pvIsZ3bTUUyUqcC0oXqDGPdIeFJx9noXVpPjMBEoCZ11FGw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Sun, 11 Oct 2026 14:44:59 +0200
Subject: [PATCH 4/7] Input: s6sy761 - add SPI support for S6SY791
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-4-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
To: Lukas Timmermann <foss@timmermann.space>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4j2gPD451RzKnrx

The S6SY791 uses the same commands as the S6SY761, wrapped in an SPI
frame: a sync byte, length fields, the opcode, the payload and an 8-bit
checksum, padded to a multiple of 4 bytes. Reads are a request frame
followed by a reply frame after an opcode-specific delay, taken from
Google's downstream driver.

The reply is clocked out full duplex with zeroed tx data. On gs101
(spi-s3c64xx) a receive-only transfer leaves MOSI undefined, and the
controller then ignores the next command.

Tested on a Google Pixel 6 Pro (raven).

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 drivers/input/touchscreen/Kconfig       |  14 ++-
 drivers/input/touchscreen/Makefile      |   1 +
 drivers/input/touchscreen/s6sy761_spi.c | 172 ++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 76651a61324f..49788ca10d80 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -528,20 +528,26 @@ config TOUCHSCREEN_IPROC
 	  module will be called bcm_iproc_tsc.
 
 config TOUCHSCREEN_S6SY761
-	tristate "Samsung S6SY761 Touchscreen driver"
-	depends on I2C
+	tristate "Samsung S6SY761/S6SY791 Touchscreen driver"
+	depends on I2C || SPI
 	help
-	  Say Y if you have the Samsung S6SY761 driver
+	  Say Y here if you have a Samsung S6SY761 or S6SY791
+	  touchscreen controller connected to your system via I2C or SPI.
 
 	  If unsure, say N
 
 	  To compile this driver as a module, choose M here: the
-	  modules will be called s6sy761_core and s6sy761_i2c.
+	  modules will be called s6sy761_core, s6sy761_i2c and
+	  s6sy761_spi.
 	select TOUCHSCREEN_S6SY761_I2C if I2C
+	select TOUCHSCREEN_S6SY761_SPI if SPI
 
 config TOUCHSCREEN_S6SY761_I2C
 	tristate
 
+config TOUCHSCREEN_S6SY761_SPI
+	tristate
+
 config TOUCHSCREEN_GUNZE
 	tristate "Gunze AHL-51S touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 24b8fb1e38d3..b76009f89bec 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+= raydium_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S6SY761)	+= s6sy761_core.o
 obj-$(CONFIG_TOUCHSCREEN_S6SY761_I2C)	+= s6sy761_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_S6SY761_SPI)	+= s6sy761_spi.o
 obj-$(CONFIG_TOUCHSCREEN_SILEAD)	+= silead.o
 obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)	+= sis_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
diff --git a/drivers/input/touchscreen/s6sy761_spi.c b/drivers/input/touchscreen/s6sy761_spi.c
new file mode 100644
index 000000000000..c6627e61c285
--- /dev/null
+++ b/drivers/input/touchscreen/s6sy761_spi.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+// Samsung S6SY761 SPI Touchscreen device driver
+//
+// Copyright (c) 2026 Lukas Timmermann <foss@timmermann.space>
+
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+
+#include "s6sy761_core.h"
+
+#define S6SY761_SPI_SYNC_CODE		0xaa
+#define S6SY761_SPI_HEADER_SIZE		5 /* sync, 2 len, 2 reserved */
+#define S6SY761_SPI_CHECKSUM_SIZE	1
+#define S6SY761_SPI_READ_HEADER_SIZE	7 /* sync, 4 len, opcode, status */
+
+/* opcodes that need a longer wait before the reply is ready */
+#define S6SY761_SPI_CMD_FW_INTEGRITY	0x21
+#define S6SY761_SPI_CMD_READ_ALL_EVENT	0x61
+
+static u8 s6sy761_spi_checksum(const u8 *buf, size_t len)
+{
+	u8 sum = 0;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		sum += buf[i];
+
+	return sum;
+}
+
+static int s6sy761_spi_write(struct device *dev, u8 *xfer_buf,
+			     u8 cmd, size_t length, const void *values)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	/* header + opcode + payload + checksum */
+	size_t frame_len = S6SY761_SPI_HEADER_SIZE + 1 + length +
+				S6SY761_SPI_CHECKSUM_SIZE;
+	size_t xfer_len = ALIGN(frame_len, 4);
+
+	if (xfer_len > S6SY761_XFER_BUFFER_SIZE)
+		return -EINVAL;
+
+	xfer_buf[0] = S6SY761_SPI_SYNC_CODE;
+	put_unaligned_be16(length + 1, xfer_buf + 1);
+	xfer_buf[3] = 0;
+	xfer_buf[4] = 0;
+	xfer_buf[5] = cmd;
+
+	if (length)
+		memcpy(xfer_buf + 6, values, length);
+
+	xfer_buf[frame_len - 1] = s6sy761_spi_checksum(xfer_buf, frame_len - 1);
+
+	/* the chip expects transfers in multiples of 4 bytes */
+	memset(xfer_buf + frame_len, 0, xfer_len - frame_len);
+
+	return spi_write(spi, xfer_buf, xfer_len);
+}
+
+static unsigned int s6sy761_spi_read_delay_us(u8 cmd)
+{
+	switch (cmd) {
+	case S6SY761_SPI_CMD_FW_INTEGRITY:
+		return 20000;
+	case S6SY761_SPI_CMD_READ_ALL_EVENT:
+		return 550;
+	default:
+		return 100;
+	}
+}
+
+static int s6sy761_spi_read(struct device *dev, u8 *xfer_buf,
+			    u8 cmd, size_t length, void *values)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_transfer reply = { };
+	/* request: header + opcode + checksum, no payload */
+	size_t req_len = S6SY761_SPI_HEADER_SIZE + 1 +
+			 S6SY761_SPI_CHECKSUM_SIZE;
+	/* reply: header + data + checksum */
+	size_t resp_len = S6SY761_SPI_READ_HEADER_SIZE + length +
+			  S6SY761_SPI_CHECKSUM_SIZE;
+	int ret;
+
+	if (ALIGN(resp_len, 4) > S6SY761_XFER_BUFFER_SIZE)
+		return -EINVAL;
+
+	/* tell the chip what to read and how much */
+	xfer_buf[0] = S6SY761_SPI_SYNC_CODE;
+	put_unaligned_be16(1, xfer_buf + 1);		/* write length: opcode */
+	put_unaligned_be16(length, xfer_buf + 3);	/* read length */
+	xfer_buf[5] = cmd;
+	xfer_buf[req_len - 1] = s6sy761_spi_checksum(xfer_buf, req_len - 1);
+	memset(xfer_buf + req_len, 0, ALIGN(req_len, 4) - req_len);
+
+	ret = spi_write(spi, xfer_buf, ALIGN(req_len, 4));
+	if (ret)
+		return ret;
+
+	/* give the chip time to prepare the reply */
+	fsleep(s6sy761_spi_read_delay_us(cmd));
+
+	memset(xfer_buf, 0, ALIGN(resp_len, 4));
+	reply.tx_buf = xfer_buf;
+	reply.rx_buf = xfer_buf;
+	reply.len = ALIGN(resp_len, 4);
+	ret = spi_sync_transfer(spi, &reply, 1);
+	if (ret)
+		return ret;
+
+	if (xfer_buf[0] != S6SY761_SPI_SYNC_CODE ||
+	    xfer_buf[5] != cmd ||
+	    xfer_buf[resp_len - 1] !=
+			s6sy761_spi_checksum(xfer_buf, resp_len - 1))
+		return -EIO;
+
+	memcpy(values, xfer_buf + S6SY761_SPI_READ_HEADER_SIZE, length);
+
+	return 0;
+}
+
+static const struct s6sy761_bus_ops s6sy761_spi_bus_ops = {
+	.bustype = BUS_SPI,
+	.read = s6sy761_spi_read,
+	.write = s6sy761_spi_write,
+};
+
+static int s6sy761_spi_probe(struct spi_device *spi)
+{
+	return s6sy761_probe(&spi->dev, &s6sy761_spi_bus_ops, spi->irq);
+}
+
+static void s6sy761_spi_remove(struct spi_device *spi)
+{
+	s6sy761_remove(&spi->dev);
+}
+
+static const struct of_device_id s6sy761_of_match[] = {
+	{ .compatible = "samsung,s6sy791", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, s6sy761_of_match);
+
+static const struct spi_device_id s6sy761_id[] = {
+	{ "s6sy791" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, s6sy761_id);
+
+static struct spi_driver s6sy761_driver = {
+	.driver = {
+		.name = S6SY761_DEV_NAME,
+		.dev_groups = s6sy761_sysfs_groups,
+		.of_match_table = s6sy761_of_match,
+		.pm = pm_ptr(&s6sy761_pm_ops),
+	},
+	.probe = s6sy761_spi_probe,
+	.remove = s6sy761_spi_remove,
+	.id_table = s6sy761_id,
+};
+
+module_spi_driver(s6sy761_driver);
+
+MODULE_IMPORT_NS("S6SY761");
+MODULE_AUTHOR("Lukas Timmermann <foss@timmermann.space>");
+MODULE_DESCRIPTION("Samsung S6SY791 Touch Screen");
+MODULE_LICENSE("GPL");

-- 
2.56.0

