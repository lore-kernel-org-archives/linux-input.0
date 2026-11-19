Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056495;
	b=EGR8bmZbKe8ggX6XNIA2kqBBtnxZYCHiLV6rP4nNHdb0PgilwbJnl6SWNMqrOKtOkcoy
	 DhUq61MmuVajMIwT3W1iiI1ci9Q4MF4uynkZCYlu6qbWa76XPHquNs+m9c44GRKZdEcxb
	 D5KZHZ2TgOwCQQYcobfyvpzSIxdgFnaUl+wwNGQV1bLXQjuELSXJv/JR12rAF2WjsL9wX
	 y1zxtMqyWqAHeBDazJvWIsALxGmwxssMk6jTGszOfBQOU2rNwXJ3or5TyTC8apnkc+ClS
	 NpRDU9d0SLrPk038txXMRKzQERzv7Vi3x85lodZs6WG2EA3vR1RXPtoOfhMokJ3u0Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056495;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=6DFvv0ByNp4OGS/zYE1uDM8CJobaS0EIgpjokDqH/O0=;
	b=j+tl72CH+6hobgBPfaBJNRsGLMj8D9d02E67lq14n/cYyV6lAi9Vpwh3bt9J26DKLBWW
	 0TSTzlEG5GTWHwmE0l1/giYApKgkIi+7xNt5oTa4QM7Kvlh1n0IJyByKlWei6zyB/ALve
	 wSwQHJTXoaWFIEWXKWH6mQ2SCzNv+AJm+sNM0Vhi2zGKdXK+bgAohs5wrvsOaiycvf3w+
	 XXJPCBSFSbRuiIrgEjkE6ttw21jbpSd8BgyCgolB1Pf0W2ieCjm4WVqLepS/xGNnBNDMH
	 h85sI30S+VnnMWlsbUe4zbauOVF1JnfTLzcZ47dK5BEjC2v64GBh81uB5KHwPqwf0QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ICr0qd2w;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F4606A31C;
	Thu, 19 Nov 2026 02:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B97F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ICr0qd2w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795056488; bh=6DFvv0ByNp4OGS/zYE1uDM8CJobaS0EIgpjokDqH/O0=;
	h=From:To:Cc:Subject:Date;
	b=ICr0qd2wDD1NgxMouoAFKZ3aOfiDKRdEKLHxSqboLkezXgigc8i4syhWf/Jhtqjfj
	 RUK3VBK/Rgb5A/LlA+Ca5RFv2tQGG4NcSH6es1Td60ctUWfosPgiFW1N3s9hqndhVx
	 jDR2fmHf+d32MdzPTfV2uvv4ZcTFPfnEWmQHS/VM=
Received: from [192.168.2.135] ([113.90.236.90])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056485t3jzn3c1m
Message-ID: <tencent_2EAB09259E347EA551B5C7DB3F20AC7CBE09@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxO6bMbe9VDc4xC+Hdhmx8qEpC4IWMA6OAefENQwyhRitXIaL/H0M
	 EG/w4v5Iuzm22ud336RNjpOLhp6pZp48aqKLS7TB8QIxhcQCJKH3/DA6KEYkohjCot7/HMoL4wc3
	 ugcyAloltNSamERbdSpAK0qW4SuO+GuYMHUXpeweJMUr41+D8dZzR2/S9egTGq0+aymbiI1z3qC6
	 +GAHf/xKUZOGkdQ2ZwGkwHAmjbwt8hNtKUzHe5bgrPsN9ojZE7Uh0kE2fc7WNxt7QIzpjYj1mVwf
	 wl8rpQUYa1tnd+KycmLiCDdkpAg2LkhzU6cPLFLTpJX1GV83x3jWr08CtoIbyQIW0BrVcpDRe1ge
	 5k2Rsfw5Gw1c8BCoQ4Fwzz1hxz6IGonSR+H2T8nYefGoXHHVgByKqmsQsDLAKy28IOP56H7UMiiG
	 ljYo+qFZT+UUi9boExUruwdmnAbi1Hb1T1LVKlVB0rv9/sxUn5MYUy0Uj98vJ9Cc7MESlqNdLPOM
	 QU54rCzDix5b2OC54JIfOi7RgOtg0gH4PMrw8GowynHLLG1f6Cup7BwRS1XrRDkRn8KuNBvP2nw+
	 iWJuWXdiLfFm/zVxbSl5FkgiT8YpMrMSXEBwQ3DGpvypYU/GIEnTPHXeCWl2lr+russUzal9joW+
	 Z1HNTv99fa4DrdF8FB4z7bE4fpc1uN6D+LFT2cELVQmQvlTg1QCNAu/HDqMW3T7lHk1YrMMGwUQh
	 YwLOCtUHWIMb4OWrxvb25d0pATYMSBs1dXP9OIRVi6oiElFh/T0x9nhyOkyrfY6Zqfr+6gBIunqV
	 vFekecXksa4kFSkds1VvqmunMRe1bo5YvN0TZ/b1NEE0Ru/CkB1fZnBZHlU59SD3JfNoY2Qj0fDy
	 a9Z+OIcq7xmoIGbFplB+ogleU+kFh/o6i/Q5igsQU9z9bTfU5CSwvDhfs7usTxhla83UV7eqQOhv
	 q3lubonjM1CKcbJBV6M58x9okrpvZMdTzbDZdfOwi4GwYuxjEZ2B1LDwPvM3MoGCU1IoIlNrmE7C
	 A0Y0M4mEE//Ha3dAbOCPxq0oBFVR0k1nGsSZc5ek8oG7A38NbEtorIJtO8YpuYy/qBx5Hy4g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Date: Thu, 19 Nov 2026 10:48:07 +0800
X-OQ-MSGID: <179505648761.50956.9969074586642093186@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Add a DRM MIPI-DSI panel driver for the VIEWE 7KF82 module based on
Jadard JD9365TX (2-lane video mode).

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/gpu/drm/panel/Kconfig                |  11 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c | 381 +++++++++++++++++++
 3 files changed, 393 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 3100640..ad1eee3 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -324,6 +324,17 @@ config DRM_PANEL_INNOLUX_P079ZCA
 	  24 bit RGB per pixel. It provides a MIPI DSI interface to
 	  the host and has a built-in LED backlight.
 
+config DRM_PANEL_VIEWE_JD9365TX
+	tristate "VIEWE 7\" JD9365TX DSI panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here to enable the VIEWE 7" 720x1280 Jadard JD9365TX
+	  MIPI-DSI panel.
+
+	  If unsure, say N.
+
 config DRM_PANEL_JADARD_JD9365DA_H3
 	tristate "Jadard JD9365DA-H3 WXGA DSI panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 75f6bf2..2933489 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) += panel-ilitek-ili9882t.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) += panel-innolux-ej030na.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
+obj-$(CONFIG_DRM_PANEL_VIEWE_JD9365TX) += panel-viewe-jd9365tx.o
 obj-$(CONFIG_DRM_PANEL_JADARD_JD9365DA_H3) += panel-jadard-jd9365da-h3.o
 obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) += panel-jdi-lt070me05000.o
 obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) += panel-jdi-lpm102a188a.o
diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
new file mode 100644
index 0000000..b06bd74
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * DRM panel driver for VIEWE 7" 720x1280 Jadard JD9365TX (module 7KF82).
+ * 2-lane MIPI-DSI video mode. Optional reset-gpios; many FPCs use POR only.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+#define JD9365TX_DISPOFF_DELAY_MS	80
+#define JD9365TX_SLPIN_DELAY_MS		200
+#define JD9365TX_DISPON_DELAY_MS	20
+
+struct jd9365tx_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct gpio_desc *reset;
+	struct regulator *vdd;
+	struct regulator *iovcc;
+	enum drm_panel_orientation orientation;
+};
+
+struct jd9365tx_cmd {
+	u8 len;
+	u8 data[64];
+	u16 delay_ms;
+};
+
+#define JD_CMD(...) {					\
+	.len = sizeof((u8[]){ __VA_ARGS__ }),		\
+	.data = { __VA_ARGS__ },			\
+	.delay_ms = 0,					\
+}
+
+#define JD_CMD_DELAY(ms, ...) {				\
+	.len = sizeof((u8[]){ __VA_ARGS__ }),		\
+	.data = { __VA_ARGS__ },			\
+	.delay_ms = (ms),				\
+}
+
+static const struct jd9365tx_cmd jd9365tx_7kf82_init[] = {	JD_CMD_DELAY(1, 0xDF, 0x90, 0x84, 0x14),
+	JD_CMD(0xDE, 0x00),
+	JD_CMD_DELAY(1, 0xBB, 0x46, 0x55, 0xB5, 0x22, 0x22, 0x55),
+	JD_CMD(0xDE, 0x02),
+	JD_CMD_DELAY(1, 0xB7, 0x16, 0x00, 0x6E, 0x44, 0x77),
+	JD_CMD(0xDE, 0x00),
+	JD_CMD_DELAY(1, 0xB3, 0x00, 0x01, 0x50, 0x50, 0x3C, 0x3C, 0xA0, 0x00, 0x20, 0xB6),
+	JD_CMD_DELAY(1, 0xBC, 0x0C, 0x28, 0x88),
+	JD_CMD_DELAY(1, 0xBD, 0x00, 0x5C, 0x56),
+	JD_CMD_DELAY(1, 0xBF, 0x10, 0x35, 0xC3),
+	JD_CMD_DELAY(1, 0xC0, 0xBD, 0xBD),
+	JD_CMD_DELAY(1, 0xC3, 0x03, 0x09, 0x00, 0x04, 0x2B, 0xE2),
+	JD_CMD_DELAY(1, 0xC4, 0x05, 0xE3, 0x0D, 0xD1, 0x05, 0x2C, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0),
+	JD_CMD_DELAY(1, 0xC5, 0x01, 0x00, 0x8C, 0x00, 0x5E, 0x01, 0x7D, 0x09, 0x60, 0x02, 0xD0, 0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0E, 0x01, 0x92, 0x02, 0x00, 0x02, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+	JD_CMD_DELAY(1, 0xC6, 0x00, 0xE4, 0x00, 0xC8, 0x00, 0x1D, 0x28, 0x82, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01),
+	JD_CMD_DELAY(1, 0xC8, 0x20, 0x80, 0xB4),
+	JD_CMD_DELAY(1, 0xCB, 0x7C, 0x66, 0x57, 0x42, 0x32, 0x2A, 0x1B, 0x1F, 0x0A, 0x26, 0x27, 0x25, 0x44, 0x32, 0x41, 0x35, 0x35, 0x2B, 0x1E, 0x14, 0x06, 0x7C, 0x66, 0x57, 0x42, 0x32, 0x2A, 0x1B, 0x1F, 0x0A, 0x26, 0x27, 0x2D, 0x4C, 0x3A, 0x41, 0x35, 0x35, 0x2B, 0x1E, 0x14, 0x06),
+	/* 2-lane: 0x31, 4-lane: 0x33 */
+	JD_CMD_DELAY(1, 0xCC, 0x31),
+	JD_CMD_DELAY(1, 0xCD, 0x23, 0x0E, 0x23, 0x0E, 0x23, 0x0E, 0x23, 0x0E, 0x23, 0x23, 0x22, 0x22),
+	JD_CMD_DELAY(1, 0xCE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA),
+	JD_CMD_DELAY(1, 0xCF, 0x40, 0x00, 0x00, 0x3F, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0xFF, 0xFF, 0x00, 0x00, 0x00),
+	JD_CMD_DELAY(1, 0xD0, 0x00, 0x3F, 0x3F, 0x64, 0x64, 0x3F, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x1F, 0x1D, 0x1B, 0x19, 0x17, 0x15, 0x13, 0x11, 0x01, 0x03),
+	JD_CMD_DELAY(1, 0xD1, 0x00, 0x3F, 0x3F, 0x64, 0x64, 0x3F, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x1E, 0x1C, 0x1A, 0x18, 0x16, 0x14, 0x12, 0x10, 0x00, 0x02),
+	JD_CMD_DELAY(1, 0xD2, 0x00, 0x3F, 0x3F, 0x24, 0x24, 0x3F, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x10, 0x12, 0x14, 0x16, 0x18, 0x1A, 0x1C, 0x1E, 0x02, 0x00),
+	JD_CMD_DELAY(1, 0xD3, 0x00, 0xBF, 0xBF, 0xA4, 0xA4, 0xBF, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x11, 0x13, 0x15, 0x17, 0x19, 0x1B, 0x1D, 0x1F, 0x03, 0x01),
+	JD_CMD_DELAY(1, 0xD4, 0x00, 0x60, 0x0C, 0x01, 0x03, 0x20, 0x04, 0x00, 0x00, 0x00, 0x07, 0x00, 0x05, 0x1D, 0x01, 0x23, 0x45, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x05, 0x20, 0x05, 0x22, 0x01, 0x03, 0x80, 0x0A, 0x00, 0x0A, 0x05, 0x24, 0x05, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x20, 0x00),
+	JD_CMD_DELAY(1, 0xD5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x0A, 0x78, 0x00, 0x00, 0x05, 0xE6, 0xF7, 0xA0, 0x0F, 0x08, 0x08, 0x10, 0x00, 0x2F, 0x04),
+	JD_CMD_DELAY(1, 0xD7, 0x00, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D),
+	JD_CMD(0xDE, 0x01),
+	JD_CMD_DELAY(1, 0xC7, 0x14, 0x14, 0x04, 0x04, 0x47),
+	JD_CMD_DELAY(1, 0xCD, 0x30, 0x53),
+	JD_CMD_DELAY(1, 0xCE, 0x09, 0x00, 0xE0, 0x00, 0xE0),
+	JD_CMD(0xDE, 0x02),
+	JD_CMD_DELAY(1, 0xB3, 0x4A, 0xA3, 0xE2, 0x2F, 0x43),
+	JD_CMD_DELAY(1, 0xB4, 0x7F),
+	JD_CMD_DELAY(1, 0xBB, 0x00, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x40, 0x43, 0x04),
+	JD_CMD_DELAY(1, 0xBD, 0x1B),
+	JD_CMD_DELAY(1, 0xBF, 0x0F, 0x03),
+	JD_CMD_DELAY(1, 0xC1, 0x50, 0x40, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00),
+	JD_CMD_DELAY(1, 0xC2, 0x02, 0x42, 0x50, 0x00, 0x02, 0xE0, 0x31),
+	JD_CMD_DELAY(1, 0xC3, 0x20, 0xFF),
+	JD_CMD_DELAY(1, 0xC4, 0x00, 0x11, 0x07, 0x00, 0x0E, 0x01, 0x08),
+	JD_CMD_DELAY(1, 0xC6, 0x4A, 0x00),
+	JD_CMD_DELAY(1, 0xE5, 0x00, 0x70, 0x70, 0x19, 0xC8, 0x09, 0x00, 0x42, 0x01, 0x30, 0x05, 0x00, 0x00, 0x05, 0x07),
+	JD_CMD_DELAY(1, 0xE6, 0x10, 0x0F, 0x88, 0x00, 0x00),
+	JD_CMD_DELAY(1, 0xE9, 0x10, 0xA0, 0xA0),
+	JD_CMD_DELAY(1, 0xEC, 0x10, 0x77, 0x0D),
+	JD_CMD(0xDE, 0x03),
+	JD_CMD_DELAY(1, 0xD1, 0x00, 0x00, 0x39, 0xFF, 0x08),
+	JD_CMD_DELAY(1, 0xED, 0x00),
+	JD_CMD(0xDE, 0x00),
+	/* TEAR_ON only; Sleep Out / Display On are sent in enable() after video starts */
+	JD_CMD_DELAY(30, 0x35),
+};
+
+static inline struct jd9365tx_panel *to_jd9365tx(struct drm_panel *panel)
+{
+	return container_of(panel, struct jd9365tx_panel, panel);
+}
+
+static int jd9365tx_send_cmds(struct mipi_dsi_device *dsi,
+			      const struct jd9365tx_cmd *cmds,
+			      unsigned int count)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		const struct jd9365tx_cmd *cmd = &cmds[i];
+
+		if (cmd->len) {
+			ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
+			if (ret < 0) {
+				dev_err(&dsi->dev,
+					"DCS write 0x%02x failed: %d\n",
+					cmd->data[0], ret);
+				return ret;
+			}
+		}
+		if (cmd->delay_ms)
+			msleep(cmd->delay_ms);
+	}
+	return 0;
+}
+
+static int jd9365tx_panel_reset(struct jd9365tx_panel *ctx)
+{
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(20);
+		gpiod_set_value_cansleep(ctx->reset, 0);
+		msleep(20);
+		return 0;
+	}
+	msleep(50);
+	return 0;
+}
+
+static int jd9365tx_prepare(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	int ret;
+
+	ret = regulator_enable(ctx->iovcc);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(ctx->vdd);
+	if (ret) {
+		regulator_disable(ctx->iovcc);
+		return ret;
+	}
+
+	msleep(150);
+
+	ret = mipi_dsi_dcs_nop(dsi);
+	if (ret)
+		dev_warn(&dsi->dev, "DSI NOP failed: %d\n", ret);
+	msleep(10);
+
+	ret = jd9365tx_panel_reset(ctx);
+	if (ret)
+		goto err_power;
+
+	ret = jd9365tx_send_cmds(dsi, jd9365tx_7kf82_init,
+				 ARRAY_SIZE(jd9365tx_7kf82_init));
+	if (ret)
+		goto err_power;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret)
+		goto err_power;
+	msleep(120);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret)
+		goto err_power;
+	msleep(JD9365TX_DISPON_DELAY_MS);
+
+	return 0;
+
+err_power:
+	if (ctx->reset)
+		gpiod_set_value_cansleep(ctx->reset, 1);
+	regulator_disable(ctx->vdd);
+	regulator_disable(ctx->iovcc);
+	return ret;
+}
+
+static int jd9365tx_enable(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
+	if (ret)
+		dev_warn(&ctx->dsi->dev, "display on: %d\n", ret);
+	msleep(JD9365TX_DISPON_DELAY_MS);
+	return 0;
+}
+
+static int jd9365tx_disable(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		dev_warn(&ctx->dsi->dev, "display off failed: %d\n", ret);
+	msleep(JD9365TX_DISPOFF_DELAY_MS);
+	return 0;
+}
+
+static int jd9365tx_unprepare(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+
+	if (mipi_dsi_dcs_enter_sleep_mode(dsi) < 0)
+		dev_warn(&dsi->dev, "enter sleep mode failed\n");
+	msleep(JD9365TX_SLPIN_DELAY_MS);
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(20);
+	}
+
+	regulator_disable(ctx->vdd);
+	msleep(10);
+	regulator_disable(ctx->iovcc);
+	msleep(20);
+
+	return 0;
+}
+
+/* 800 * 1510 * 50 / 1000 = 60400 */
+static const struct drm_display_mode jd9365tx_7kf82_mode = {
+	.clock		= 60400,
+	.hdisplay	= 720,
+	.hsync_start	= 720 + 20,
+	.hsync_end	= 720 + 20 + 20,
+	.htotal		= 720 + 20 + 20 + 40,
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 200,
+	.vsync_end	= 1280 + 200 + 2,
+	.vtotal		= 1280 + 200 + 2 + 28,
+	.width_mm	= 87,
+	.height_mm	= 155,
+	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int jd9365tx_get_modes(struct drm_panel *panel,
+			      struct drm_connector *connector)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &jd9365tx_7kf82_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+	drm_connector_set_panel_orientation(connector, ctx->orientation);
+	return 1;
+}
+
+static enum drm_panel_orientation
+jd9365tx_get_orientation(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+
+	return ctx->orientation;
+}
+
+static const struct drm_panel_funcs jd9365tx_funcs = {
+	.prepare = jd9365tx_prepare,
+	.enable = jd9365tx_enable,
+	.disable = jd9365tx_disable,
+	.unprepare = jd9365tx_unprepare,
+	.get_modes = jd9365tx_get_modes,
+	.get_orientation = jd9365tx_get_orientation,
+};
+
+static int jd9365tx_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct jd9365tx_panel *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 2;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_LPM;
+
+	ctx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset))
+		return PTR_ERR(ctx->reset);
+
+	ctx->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(ctx->vdd))
+		return PTR_ERR(ctx->vdd);
+
+	ctx->iovcc = devm_regulator_get(dev, "iovcc");
+	if (IS_ERR(ctx->iovcc))
+		return PTR_ERR(ctx->iovcc);
+
+	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	if (ret)
+		return ret;
+
+	drm_panel_init(&ctx->panel, dev, &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
+	ctx->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void jd9365tx_remove(struct mipi_dsi_device *dsi)
+{
+	struct jd9365tx_panel *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id jd9365tx_of_match[] = {
+	{ .compatible = "viewe,7kf82" },
+	{ .compatible = "jadard,jd9365tx-7kf82" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jd9365tx_of_match);
+
+static struct mipi_dsi_driver jd9365tx_driver = {
+	.probe = jd9365tx_probe,
+	.remove = jd9365tx_remove,
+	.driver = {
+		.name = "panel-viewe-jd9365tx",
+		.of_match_table = jd9365tx_of_match,
+	},
+};
+module_mipi_dsi_driver(jd9365tx_driver);
+
+MODULE_AUTHOR("Hefei <3066883572@qq.com>");
+MODULE_DESCRIPTION("VIEWE 7\" JD9365TX MIPI-DSI panel");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

