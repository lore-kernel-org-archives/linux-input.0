Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574562;
	b=mDLArhKaz3DDzrxp7qIjfJopd3ofzlL32Q/CgPHNdlEDay/8kmQBPz8wW0SfA2TIeaeb
	 rhWxptBzOcb4l6de5aUMSK4buy9OvHEHOb7WvnUwZXzXUWemrMvNUFt4vnF5NW3fwssCi
	 swQwYz7s3uqaPCS0dt4YrPnq+xtStDcBUJxAhCX1Oqzp2xuVIpnPFptEykNLP7oehwbz4
	 C9r+F75syoaFwm1C3D5UE2bFykimkGc6M3i+QjPDMqwYwsAWm8lawYc9a4OZdgE8R62tL
	 NwPjhcCeco96HIBzPZ9i7tLgpBDT/fxyc8jb7yIykxl+WkdvSr1HR4pP3TpYcjvpyUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574562;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=76bfH9kEqgpCSJkznVW4Swy+6JRgK56Tz4cAetwfNEE=;
	b=IHZoUeRm9099C+25LUmnGeZVlFgaM7ASihAX5b4WX+83b1AojpaG64FMLbU7vRm9l8tt
	 X+jHp8E8/qe0ECFO6tn1VR/9Wm145wa7wrarna2nVflZUv3OHxnfz9mnPisVXQFrWr125
	 H2C4ObBjD9sZG7hHkq38h0Kb2hlyQf16ChDoNIIKI7YB/8It8N2ODtaxjNLXSmmONf1io
	 eSngAG8wfemLAfeVVcCEBHsURfGbP+x4SNLQ/C0oybqLr2+zeM8PL1y2C6iYpxQegLg7w
	 gn8VIXZ7bI3wtgoIE5D40/QSYUEm+NqMazHOV79dFDYZSAFtk2dwsz5tk/ajSh/E6tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RLnLknf8;
	arc=none smtp.remote-ip=43.163.128.54
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FB606A339;
	Wed, 25 Nov 2026 02:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1FB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RLnLknf8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795574553; bh=76bfH9kEqgpCSJkznVW4Swy+6JRgK56Tz4cAetwfNEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLnLknf8t7GOoPcP7q4LdaMs6FXjpTpu0S22rvfH2A4VrOTPftMyDKa9rixyQUJkI
	 KRGZwb9hxDZkIdyo+Rinr8Sb4RkPVmle1C3gzOMd865vJJGTZO28YHcOzG/nN2SMbD
	 XvVWKE+kLYPn5AIPOfICBgutkRdxvBkNBOhCHbww=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574551tub95ibsk
Message-ID: <tencent_C80F7DF059E17C7313CE3E35FF62A1A28D0A@qq.com>
X-QQ-XMAILINFO: MCoRjsEAB/Sxulesoa/8SKggJD3fgksp+p8gcjKrtaCM67tj7xPfYzFfNpcDK0
	 /jCxcmVVEd+zTqXQ3BTfgU7Mv5rDZ3wc0IwDZhbD6X7Xsp0pzktntUYrEcYTgNsv6KePmWzHcPyK
	 tpKNTEkmwfW3eBA1mOOQAf4nbQnp5SIOuE6NrVNqUSFxL5+W1EcrJsnWop4FcT5RUad40iIB/r2x
	 85ZHea9Myg+Q2Q3q6kOv1cJzWx/ndjjCcZmJbS+R/Jp89OKfAF+k/NRDMnQEgeWg2oIpDniNjr7k
	 wgCsiAE+5tPSXP9LAV+JKBj0jazpnyGcjy330+5Dc2Borm0cr3sP2OMU0L5ExNyIQ/orDYiySxT7
	 GnO2xrE0fItKM4qVNXfPDmoWb0xvq01p7dv820kwF7Ubi/ertq29pYaOIsd+VQr2JxZqBFBWsaEl
	 Ll54y1/YhtLL9AVQMXUIw0ermFRe5etrJ4N8JluS/VuTk47RS+f+OHxfyd0Tq1rFffrIgvFFCHMt
	 FNmrzA0WhGNW2yYhOdAXnKZpOvJfZQoc9lJDvH5GGwDUNbt8/XbVvD/mKpyAQ0mS1BIZYGA8hWck
	 Si0Vccps1A0yLrUeIcrsMHLLD0Z3ByMLBA22v4odcKX3P85q7NDgcAIH2BqCJzPlw77LdDCZr0x1
	 31vv3UeafPqh8WEkwGA56FLWB2jwy0DURq0BDCAM817pdSqZku8dcJE5Gq74m9JI5P2yVzIMVFP6
	 ru1nnE2qYZhXi06CQWhM9wHSt4yiuwXfx7y8gWJs7dqU7wNl/LEgDZaglAREirgpLBIOKmGicBzp
	 SvQLEhMgmWTKB5ZG6y3rAOPjkTG7UZv3yh3XHKJlndSTR5TM9Zmsr6vpWz/GN/3pxPzNaPdmbj4A
	 nvCWNjklexZ8GVbdXM5qrAtoXRwpVaCQymuwVWlC1w2phZyHOxK2/nAM0KXaLQg7dptRWvtuSxeN
	 HHDCNwJ1Z5DwuItYtSqJz1w+m0aRB8QiY30JVXKqqc95sZePvJBjiVe8Cz7ZyZR9lWtGfL8nYQ0T
	 PEuLsgXK8KvNHz4/652F30QRg7SI3zoIsHgmxQxTF/LpXRYDsVAzN8Or1psvlVE4EUcV3gMrbo8/
	 qwfIJnWzDxwSd2TOtQ7BBdAJjslg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v4 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Date: Wed, 25 Nov 2026 10:42:24 +0800
X-OQ-MSGID: <20261125024226.1293-5-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125024226.1293-1-3066883572@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DRM panel driver for the VIEWE 7KF82 720x1280 Jadard JD9365TX
2-lane MIPI-DSI module. The TX command set differs from JD9365DA
(page select 0xDE, unlock 0xDF, lane config 0xCC).

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/gpu/drm/panel/Kconfig                |  11 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c | 340 +++++++++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 3100640..5e38bb7 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1141,6 +1141,17 @@ config DRM_PANEL_TRULY_NT35597_WQXGA
 	  Say Y here if you want to enable support for Truly NT35597 WQXGA Dual DSI
 	  Video Mode panel
 
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
 config DRM_PANEL_VISIONOX_G2647FB105
 	tristate "Visionox G2647FB105"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 75f6bf2..f3489cd 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_DRM_PANEL_TPO_TD028TTEC1) += panel-tpo-td028ttec1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_DRM_PANEL_TPO_TPG110) += panel-tpo-tpg110.o
 obj-$(CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA) += panel-truly-nt35597.o
+obj-$(CONFIG_DRM_PANEL_VIEWE_JD9365TX) += panel-viewe-jd9365tx.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_G2647FB105) += panel-visionox-g2647fb105.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_RM69299) += panel-visionox-rm69299.o
 obj-$(CONFIG_DRM_PANEL_VISIONOX_RM692E5) += panel-visionox-rm692e5.o
diff --git a/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
new file mode 100644
index 0000000..7455dff
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
@@ -0,0 +1,340 @@
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
+#include <drm/drm_probe_helper.h>
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
+static const struct jd9365tx_cmd jd9365tx_7kf82_init[] = {
+	JD_CMD(0xDF, 0x90, 0x84, 0x14),
+	JD_CMD(0xDE, 0x00),
+	JD_CMD(0xBB, 0x46, 0x55, 0xB5, 0x22, 0x22, 0x55),
+	JD_CMD(0xDE, 0x02),
+	JD_CMD(0xB7, 0x16, 0x00, 0x6E, 0x44, 0x77),
+	JD_CMD(0xDE, 0x00),
+	JD_CMD(0xB3, 0x00, 0x01, 0x50, 0x50, 0x3C, 0x3C, 0xA0, 0x00, 0x20, 0xB6),
+	JD_CMD(0xBC, 0x0C, 0x28, 0x88),
+	JD_CMD(0xBD, 0x00, 0x5C, 0x56),
+	JD_CMD(0xBF, 0x10, 0x35, 0xC3),
+	JD_CMD(0xC0, 0xBD, 0xBD),
+	JD_CMD(0xC3, 0x03, 0x09, 0x00, 0x04, 0x2B, 0xE2),
+	JD_CMD(0xC4, 0x05, 0xE3, 0x0D, 0xD1, 0x05, 0x2C, 0x06, 0x51, 0x06, 0x51, 0x06, 0x51, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0),
+	JD_CMD(0xC5, 0x01, 0x00, 0x8C, 0x00, 0x5E, 0x01, 0x7D, 0x09, 0x60, 0x02, 0xD0, 0x05, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x01, 0x0E, 0x01, 0x92, 0x02, 0x00, 0x02, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+	JD_CMD(0xC6, 0x00, 0xE4, 0x00, 0xC8, 0x00, 0x1D, 0x28, 0x82, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01),
+	JD_CMD(0xC8, 0x20, 0x80, 0xB4),
+	JD_CMD(0xCB, 0x7C, 0x66, 0x57, 0x42, 0x32, 0x2A, 0x1B, 0x1F, 0x0A, 0x26, 0x27, 0x25, 0x44, 0x32, 0x41, 0x35, 0x35, 0x2B, 0x1E, 0x14, 0x06, 0x7C, 0x66, 0x57, 0x42, 0x32, 0x2A, 0x1B, 0x1F, 0x0A, 0x26, 0x27, 0x2D, 0x4C, 0x3A, 0x41, 0x35, 0x35, 0x2B, 0x1E, 0x14, 0x06),
+	/* 2-lane: 0x31, 4-lane: 0x33 */
+	JD_CMD(0xCC, 0x31),
+	JD_CMD(0xCD, 0x23, 0x0E, 0x23, 0x0E, 0x23, 0x0E, 0x23, 0x0E, 0x23, 0x23, 0x22, 0x22),
+	JD_CMD(0xCE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA),
+	JD_CMD(0xCF, 0x40, 0x00, 0x00, 0x3F, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0xFF, 0xFF, 0x00, 0x00, 0x00),
+	JD_CMD(0xD0, 0x00, 0x3F, 0x3F, 0x64, 0x64, 0x3F, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x1F, 0x1D, 0x1B, 0x19, 0x17, 0x15, 0x13, 0x11, 0x01, 0x03),
+	JD_CMD(0xD1, 0x00, 0x3F, 0x3F, 0x64, 0x64, 0x3F, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x1E, 0x1C, 0x1A, 0x18, 0x16, 0x14, 0x12, 0x10, 0x00, 0x02),
+	JD_CMD(0xD2, 0x00, 0x3F, 0x3F, 0x24, 0x24, 0x3F, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x10, 0x12, 0x14, 0x16, 0x18, 0x1A, 0x1C, 0x1E, 0x02, 0x00),
+	JD_CMD(0xD3, 0x00, 0xBF, 0xBF, 0xA4, 0xA4, 0xBF, 0x3F, 0x3E, 0x3E, 0x2A, 0x2B, 0x3F, 0x3F, 0x11, 0x13, 0x15, 0x17, 0x19, 0x1B, 0x1D, 0x1F, 0x03, 0x01),
+	JD_CMD(0xD4, 0x00, 0x60, 0x0C, 0x01, 0x03, 0x20, 0x04, 0x00, 0x00, 0x00, 0x07, 0x00, 0x05, 0x1D, 0x01, 0x23, 0x45, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x05, 0x20, 0x05, 0x22, 0x01, 0x03, 0x80, 0x0A, 0x00, 0x0A, 0x05, 0x24, 0x05, 0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x20, 0x00),
+	JD_CMD(0xD5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3E, 0x00, 0x00, 0x00, 0x0A, 0x78, 0x00, 0x00, 0x05, 0xE6, 0xF7, 0xA0, 0x0F, 0x08, 0x08, 0x10, 0x00, 0x2F, 0x04),
+	JD_CMD(0xD7, 0x00, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D, 0x09, 0x7D),
+	JD_CMD(0xDE, 0x01),
+	JD_CMD(0xC7, 0x14, 0x14, 0x04, 0x04, 0x47),
+	JD_CMD(0xCD, 0x30, 0x53),
+	JD_CMD(0xCE, 0x09, 0x00, 0xE0, 0x00, 0xE0),
+	JD_CMD(0xDE, 0x02),
+	JD_CMD(0xB3, 0x4A, 0xA3, 0xE2, 0x2F, 0x43),
+	JD_CMD(0xB4, 0x7F),
+	JD_CMD(0xBB, 0x00, 0x7D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x40, 0x43, 0x04),
+	JD_CMD(0xBD, 0x1B),
+	JD_CMD(0xBF, 0x0F, 0x03),
+	JD_CMD(0xC1, 0x50, 0x40, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00),
+	JD_CMD(0xC2, 0x02, 0x42, 0x50, 0x00, 0x02, 0xE0, 0x31),
+	JD_CMD(0xC3, 0x20, 0xFF),
+	JD_CMD(0xC4, 0x00, 0x11, 0x07, 0x00, 0x0E, 0x01, 0x08),
+	JD_CMD(0xC6, 0x4A, 0x00),
+	JD_CMD(0xE5, 0x00, 0x70, 0x70, 0x19, 0xC8, 0x09, 0x00, 0x42, 0x01, 0x30, 0x05, 0x00, 0x00, 0x05, 0x07),
+	JD_CMD(0xE6, 0x10, 0x0F, 0x88, 0x00, 0x00),
+	JD_CMD(0xE9, 0x10, 0xA0, 0xA0),
+	JD_CMD(0xEC, 0x10, 0x77, 0x0D),
+	JD_CMD(0xDE, 0x03),
+	JD_CMD(0xD1, 0x00, 0x00, 0x39, 0xFF, 0x08),
+	JD_CMD(0xED, 0x00),
+	JD_CMD(0xDE, 0x00),
+	/* TEAR_ON; Sleep Out / Display On follow in prepare() */
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
+static void jd9365tx_panel_reset(struct jd9365tx_panel *ctx)
+{
+	if (!ctx->reset)
+		return;
+
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	msleep(20);
+	gpiod_set_value_cansleep(ctx->reset, 0);
+	msleep(20);
+}
+
+static int jd9365tx_prepare(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
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
+	jd9365tx_panel_reset(ctx);
+
+	ret = jd9365tx_send_cmds(dsi, jd9365tx_7kf82_init,
+				 ARRAY_SIZE(jd9365tx_7kf82_init));
+	if (ret)
+		goto err_power;
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, JD9365TX_DISPON_DELAY_MS);
+	if (dsi_ctx.accum_err)
+		goto err_power;
+
+	return 0;
+
+err_power:
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	regulator_disable(ctx->vdd);
+	regulator_disable(ctx->iovcc);
+	return ret ? ret : dsi_ctx.accum_err;
+}
+
+static int jd9365tx_disable(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, JD9365TX_DISPOFF_DELAY_MS);
+	return 0;
+}
+
+static int jd9365tx_unprepare(struct drm_panel *panel)
+{
+	struct jd9365tx_panel *ctx = to_jd9365tx(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, JD9365TX_SLPIN_DELAY_MS);
+
+	if (ctx->reset) {
+		gpiod_set_value_cansleep(ctx->reset, 1);
+		msleep(20);
+	}
+
+	regulator_disable(ctx->vdd);
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
+	return drm_connector_helper_get_modes_fixed(connector,
+						    &jd9365tx_7kf82_mode);
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
+	ctx = devm_drm_panel_alloc(dev, struct jd9365tx_panel, panel,
+				   &jd9365tx_funcs, DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
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
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get orientation\n");
+
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

