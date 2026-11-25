Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575408;
	b=aHpa76j3AUVkjjBwaWpwoDx1pVFZvVrassHez/Sl+zna/kQ037qRqqmpW2cAl2AskTfB
	 XfNhD0hwzLYZcIFQQcloJ9Ty0EYa67jH48HaUT9TH1EZcS41dh40990bBkA4np3vEQ1K6
	 Iu09cLoUYXS3rjl+FFI8QEMxdjXV/0t7eLYeHpnX2O/VIrC6IdZsbQbJvdkPByPAoaIbe
	 BHiO62DjNH8wLs5LR7GMUmhuq28Q9icw/UQyysvT25L+H0er8uziRSopM/hFUaja2N4Gf
	 NetAbBIt7uehLaPm1fJa3ZFAVPcDVv5d8IO6RxSiSRmaycGbte6tgo1eR6JZ0+b6XFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575408;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=76bfH9kEqgpCSJkznVW4Swy+6JRgK56Tz4cAetwfNEE=;
	b=mNMJBZreN8wd8LOhVTrNyMxY1qBpe5oX6sxFuGbP5PVzZf3eZ/AmVRseOHOZNbcBH5d1
	 KF6E+SOVPN2yBCFH/Xy57KB0pYTPwMm5/fTDf3mcZtUQDmi188LmLZeoETThORucqkDTW
	 m836+YAHhkhkW5xTzITTypZMYFJMXNVWR6rPDU6stAuEe1GhkpJnMcHLzwPLaYcfrGpSj
	 RznRnts1J7MGip3vUblORFRzL/NiECd3T2WrqK7bGm6kjDZ8cfD/fmhiaIdtDhAqDmjoT
	 YYvny5HUbWsd5vbO9eEJcPETWzHCDAq1hn/UpfSWrILWCDTSpCVpyiNIrjZHrqbzqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="Qh0/t6If";
	arc=none smtp.remote-ip=43.163.128.43
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC0606A326;
	Wed, 25 Nov 2026 02:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46EC0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Qh0/t6If
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575405; bh=76bfH9kEqgpCSJkznVW4Swy+6JRgK56Tz4cAetwfNEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qh0/t6IfXamZSt5iXl1mfi6sCd/KiodwafuX/2AF4N6WcpKba382FD5ilfqPNiKn3
	 ZSqI9tfjKyi7q/9Zb02g19oc9ocf/+Wbqh/tzJ4+NV5COju/Kk9jgGosDBPXlW8agt
	 ofZ5dK70Tj0M4TQtBgLDvUcP3u6t3qw/CeTUbGmU=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575403t3luxg0l4
Message-ID: <tencent_C2127E2B5045C6293E54AC20BE5908B79F09@qq.com>
X-QQ-XMAILINFO: Nfnx2Z6mc8TO97A+gQNtclZYlRGIIChBxxD8HiKbTjgKOZTKePTgWnwoboivHZ
	 /QEzsWJff0GCJVF+dr8otB4paDdlP5BI7S6vJH/Wxi/FRSJwG82CgDWkr5LZ22ZnP+FmKJmuyqG4
	 w8Ba73RVV6kcmYSDnxSCQ+HeUSu2mcNRRegg8Lb4SXrG+61BvJSzEkSWW9BZJv+HNQailhZsYm+8
	 a/hIGc/sgIJeiGL0qIfp7i+lj6IpJBzi4sYfGRa8cVHGPCklMArGEJG2SAF63YR0PTwO8yDy1zwj
	 SrBKQhRzkL8aXMXbhJXQ0RO/UU9JqrFiWdDehSXYYrpzaTrsgwsFBVA7rRS9nXkxyLbhCm39X2Gd
	 jLbJ60RcEDfixXCIjU4aX4BhM/rn1uGnPN3vKtHNp2ElqCIkq8J6mv01Tvpht2mVqTKOWlDJD9C9
	 13vK56smHT1RIfGqlOJr9aBbPtmV2AWr1nG2zVu98cohTiBxPDimkar3BzeHz9ZU/m4T/n13m9yJ
	 k0MFujcmtUhsKimlhj5hM3vwMeK0QM0TS9KeGYUSIR1tvK3GCPs7Os5QpEWZ+6qU2QKavORNj35E
	 N3LKZvtsK7JW9A86HTfF9ypqoGD9TQ1g0aldn47SK916PDM2w/SqV+suvi6wwwi4qu2Wg0N/nmLO
	 IOTGW9swgO8tJLhaTKgNe8nXqxRyYzO/93PCrcC+QSLU/F4/WBzQhjBNP4syEpDJ1C5mhdvhBjeS
	 wlwYgwS0q4dm9738/gKVyhdRAFoauh/m14vfXkP8PdjDsf2QIffiYk0YAMbmuFvczPKzv53LF6Sv
	 J18TWFv0qYOBxdf+KsYTp7wP7Nj7VSRq7R8vd8fkxnQf0hW0U3GVxNpW3wpHdvE9Q18btOwVDvSM
	 XiVy7zUOQwy1bnlwTJOrubUbEObIdqU3YAicVGNQgj0vzyG8X4hbwkBDXOFjwH3e7tpMNGV+5WGS
	 An6OncGO1pLNN/6flkU6qJ/Z7nzaVGgoURbkcDrxoYS2bJ9PMSkI2xZ1GJbo16i23GbfsGI7TaXM
	 6j6RgetIimPcocsIuRuLOQaDhFCwnbfEXAZjkUF70cvSwrwb6m9CMaq7x+pSKdYw2FSF3EheM52J
	 O7Tc1Koy7joX9l8wPwKveHyKvg+3yNkttSJ/bZh0GOEN58C4tFeEkbUl4lvOh7E+biGQdhp5EyOe
	 hPk+g=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 4/6] drm/panel: add VIEWE JD9365TX 7 inch DSI panel
Date: Wed, 25 Nov 2026 10:56:36 +0800
X-OQ-MSGID: <20261125025638.1171-5-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125025638.1171-1-3066883572@qq.com>
References: <20261125025638.1171-1-3066883572@qq.com>
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

