Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107270;
	b=tCfoDb+PZ928fFz72kcivELgb7+3chzkgPg2ehBRZciUPblLXXPHNqwiIobZCU4owyhL
	 ADNBp0gZ1bX+SRqdaFzH1JpCB9zrJHziRNOmRQgXM68jBTJS7pxYxzaAd+m8H3m7GCWev
	 cvpu/eMe5ze1OLPD1Hs8ke/oZvYL0K0iFrv7Y+u4scxyH4bBtNY0D6CeJEUBc1e1BzXlO
	 6b8VZQeBw2G8neWTJpiwQ7kWbSf+zgLxotnB5QBViDwHQZbaRaAuOPxQpk4g7eb4wEqTv
	 3ytNGCqfgocSDT65zc42puRR8EJg9GukcY6unl7aVjeSV6PyAHmxUHmMK+FXFGidRbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3QHiEqEcNpnPHW4s9DVRwlkHqeysbqfZwb7HdrogQI4=;
	b=A6eZXwtm/W8nlSo443huFxS6IpTny15KOZ1Jvc9DGklAk4ZWwfXab34ISm20pqRBXY6m
	 RiqYspMuGNDpgQ1hK/90tvhwzZ4C5zn87aOQEEqTS/YT0oG6HI2Fep+LQCUu+3Q9B7bR0
	 Y1zWE7ze02gJ3sUDY4CvbHkGofhJ6XHrAwTvM7LBZCbdkAmggh77WkJSwonx2MspRvaND
	 TLpswzSB0WjMYqvHCMfdiUm39RkFUFfZnCfhu5qczGXXUeHlB4FPz8La8zjb6ygVUy3rd
	 ITW+oKHEYPsMkwHZr0SX5T0Bo+YznYhCVXDsPYyWXU9XIs4I+kr+BVBpGu6bK2iyY0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKkW9eAs;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6E60A380D
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B6E60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKkW9eAs
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso34540945e9.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107268; x=1795712068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QHiEqEcNpnPHW4s9DVRwlkHqeysbqfZwb7HdrogQI4=;
        b=UKkW9eAsL5h3FKtQH3JvnPT/vj6eFHqmiTAeU4G8r//GD/msP8agddKdsZlgwDtn6z
         kmG83+V1Dxgi5nn8BkKXaN44kXLatyiltAIwubXU+jewNomnY5wLQTPqPy01p2sCMCrH
         Mgw2/Whkz9LR+rs4g97vn+kXNODQNv26akkMRWm678CYXzRNemflt/6bsqmmBCahpWwJ
         2pASjP7aBZcUZbaWP+LmVQbI3YufqhgfDRVMeWX09v/0oLWc6lcpIIlCxw24N9tpJ0ib
         EmGLXq+9oT8DLoAgvYbB9jtJOcGYjZ+xrq0Qp+oGl2cbn2cdpYYfBA19O7Jl66eqtGkz
         DMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107268; x=1795712068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3QHiEqEcNpnPHW4s9DVRwlkHqeysbqfZwb7HdrogQI4=;
        b=aZdAZOk17CUXvwnd717y9Eo/M0jalfMRAdCOHlzxQNih1IOTYOYb3jWLsRDNwEBIBK
         uT0aKZ9EL2XP/WAdjXEjNbR6GjmWsduGGTNDmCkH0NdU+AyNSB57twYmBqNrZCLPjaBa
         GkjEYdjzvb2H7VRAa47VZczhmtYKiKTNI3ZXI3kxQc1ZC9HnrXtlTgZQUbSI3+zKl0lq
         Abg1sZqtNfFWdLPjZDZua+TZfvKX2kVbTjmJnhqKB2WoW0MrJU6GYdCJF2ImRmWsWSX0
         D9drTCBRmTwllIujnINIfkXisoXDyRAAghrZ304IxRr0mQQOeWs/LwvkguwZDSSjan4U
         yr/g==
X-Forwarded-Encrypted: i=1; AL+hErFpSAUGfJCpqX7VtVcJ5lM2Vgilu49wSjIhlDp7AIt8zUEdcKkQIQanfCan7+DKEFqF+/wZuEpMbiX2ow==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nQzBFW13Umf3+HsuwC40lZFeMpsGCx0UtLSuoneL79UPWJ1hl
	heeFBpyzNCK79jvc+yrhGGNihZEPGXAwUN8PEJuGeyCSut/s7m/Pvytx
X-Gm-Gg: AYBFou0eSIwp/+25YvGOYneolfTwcD8jqG4d/BXDkRRrMA7Ln3iZgSp/H2G8DLnEgzV
	PMw+q/X4azbcgocfL3kN03OVHv0Tgvo/7IY3b9pghC93W+IDk86BlGT6NLuwCuTBuakFeaVKRzg
	6vChyt/lVhwPmgbz7YYS4fT+t3nsMNmuTAqCI4P6SjPEu7U2MCZ9KYAmU9f8CCMX0jS22NVokmE
	dalfTcjZZ3GzTMavezk1J4IxuKoNq/J0l0FdkmjF46JPn55m+ynSu1uF7zXhdQXR9Q8nE8WWIJe
	lxfoE+1d2Kxx+4HttjPoViOHvgWigb07fp150YfLvWFt6S3o32U8xpNGYdSLUjVpcOlZ1pN01Kp
	9j5QDEa+16QT+HJQ4WFWUBim91Y5Yr4NYrTpzhop9b0ysO0PsCiGGjWLvHQM1a1U5Ko6VSNY4TK
	YWOpIHUkwAQhEAUG6tyRG6g8/QRN6v3uMQiUMd98Mh8EouA7+F3CBbf7heBRoL/1tSzTC+ipjnX
	fYrQPV8UTXlz0h7nMIhUJu6kwvriN7ed8m6RUqm4sKTdxz9jWGPUq8bStpeAwCgm9ya0d+nI7KJ
	Vj8h9hOwdOaUwMiYplTHyUeacEPLTOCtuj8pSTU/1Q2jA+b4TFdt8OwYE1asfsaetN3tl6W46Ho
	=
X-Received: by 2002:a05:600c:4f07:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb88804d58mr2180815e9.9.1795107267649;
        Thu, 19 Nov 2026 08:54:27 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:27 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 04/10] drm/panel: add LG SW43103 panel driver
Date: Thu, 19 Nov 2026 17:54:14 +0100
Message-Id: <20261119165420.24466-5-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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

Add support for the 1080x2460 SW43103 AMOLED panel. Handle power and
reset sequencing, DCS backlight control, and the DSC configuration
required by the panel.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 MAINTAINERS                              |   1 +
 drivers/gpu/drm/panel/Kconfig            |  13 +
 drivers/gpu/drm/panel/Makefile           |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c | 587 +++++++++++++++++++++++
 4 files changed, 602 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 594863936fb5c..28e4aac18d44a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15215,6 +15215,7 @@ LG SW43103 PANEL DRIVER
 M:	Abdur Rofik <rofikcoga@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
+F:	drivers/gpu/drm/panel/panel-lg-sw43103.c
 
 LG V60 THINQ 5G (TIMELM) SUPPORT
 M:	Abdur Rofik <rofikcoga@gmail.com>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d60fef..a3b86364d6825 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -540,6 +540,19 @@ config DRM_PANEL_LG_LG4573
 	  Say Y here if you want to enable support for LG4573 RGB panel.
 	  To compile this driver as a module, choose M here.
 
+config DRM_PANEL_LG_SW43103
+	tristate "LG / BOE SW43103 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
+	help
+	  Say Y here if you want to enable support for the LG / BOE SW43103
+	  1080x2460 AMOLED panel used in the LG V60 ThinQ 5G smartphone.
+	  The panel operates in DSI command mode with Display Stream
+	  Compression (DSC).
+
 config DRM_PANEL_LG_SW43408
 	tristate "LG SW43408 panel"
 	depends on GPIOLIB
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index da5175909d540..c6f3280cd5828 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
 obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
 obj-$(CONFIG_DRM_PANEL_LG_LD070WX3) += panel-lg-ld070wx3.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
+obj-$(CONFIG_DRM_PANEL_LG_SW43103) += panel-lg-sw43103.o
 obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
 obj-$(CONFIG_DRM_PANEL_LXD_M9189A) += panel-lxd-m9189a.o
 obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
diff --git a/drivers/gpu/drm/panel/panel-lg-sw43103.c b/drivers/gpu/drm/panel/panel-lg-sw43103.c
new file mode 100644
index 0000000000000..94a6bd905b713
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-lg-sw43103.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Abdur Rofik <rofikcoga@gmail.com>
+ * Panel driver for LG / BOE SW43103 FHD+ DSC Command Mode AMOLED panel
+ * (LG V60 ThinQ 5G - timelm)
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+
+#define NUM_SUPPLIES 2
+
+struct sw43103_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *link;
+
+	struct regulator_bulk_data supplies[NUM_SUPPLIES];
+
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *enable_gpio;
+
+	struct drm_dsc_config dsc;
+	bool prepared;
+};
+
+static inline struct sw43103_panel *to_panel_info(struct drm_panel *panel)
+{
+	return container_of(panel, struct sw43103_panel, base);
+}
+
+static void sw43103_init_sequence(struct mipi_dsi_multi_context *ctx)
+{
+	/* Manufacturer Command Protect Unlock */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa1);
+
+	/* Column Address Set: 0 to 1079 (0x0437) */
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_COLUMN_ADDRESS,
+				     0x00, 0x00, 0x04, 0x37);
+
+	/* Page Address Set: 0 to 2459 (0x099b) */
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PAGE_ADDRESS,
+				     0x00, 0x00, 0x09, 0x9b);
+
+	/* HBM Mode2 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x08);
+
+	/* Partial Address Row Set: 0 to 2459 */
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PARTIAL_ROWS,
+				     0x00, 0x00, 0x09, 0x9b);
+
+	/* Partial Address Column Set: 0 to 1079 */
+	mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PARTIAL_COLUMNS,
+				     0x00, 0x00, 0x04, 0x37);
+
+	/* Tear Effect On */
+	mipi_dsi_dcs_set_tear_on_multi(ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+
+	/* Manufacturer Command Protect */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xca);
+
+	/* Sleep Out */
+	mipi_dsi_dcs_exit_sleep_mode_multi(ctx);
+	mipi_dsi_msleep(ctx, 120);
+
+	/* MCS Lv1 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa1);
+
+	/* Workaround for AOD VBP Issue */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3,
+				     0x91, 0x49, 0x00, 0x0f, 0x0c, 0x00,
+				     0x0f, 0x0c, 0x28, 0x00, 0x02, 0x14);
+
+	/* Global IRC */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1,
+				     0x61, 0xc0, 0x00, 0x00, 0x00, 0x10, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb2,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0xea, 0x6b, 0x60, 0x58, 0x50, 0x49, 0x41,
+				     0x3a, 0x33, 0x2c, 0x25, 0x1e, 0x17, 0x11, 0x0b,
+				     0x05, 0x6c, 0x61, 0x58, 0x50, 0x48, 0x40, 0x38,
+				     0x31, 0x29, 0x22, 0x1b, 0x14, 0x0d, 0x06, 0x00,
+				     0x62, 0x57, 0x4d, 0x44, 0x3c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x34, 0x2d, 0x25, 0x1e, 0x16, 0x0f, 0x08,
+				     0x01, 0x00, 0x57, 0x4c, 0x42, 0x3a, 0x31, 0x29,
+				     0x22, 0x1a, 0x12, 0x0b, 0x03, 0x00, 0x00, 0x4c,
+				     0x42, 0x38, 0x2e, 0x26, 0x1e, 0x16, 0x0e, 0x07,
+				     0x00, 0x00, 0x00, 0x45, 0x39);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x2f, 0x25, 0x1c, 0x14, 0x0c, 0x04, 0x00,
+				     0x00, 0x00, 0x34, 0x2a, 0x21, 0x19, 0x10, 0x09,
+				     0x01, 0x00, 0x00, 0x00, 0x2e, 0x23, 0x19, 0x10,
+				     0x08, 0x00, 0x00, 0x00, 0x00, 0x25, 0x1b, 0x11,
+				     0x08, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb5,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f,
+				     0x13, 0x09, 0x00, 0x00, 0x00, 0x00, 0x16, 0x0c,
+				     0x03, 0x00, 0x00, 0x00, 0x0e, 0x06, 0x00, 0x00,
+				     0x00, 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6,
+				     0x44, 0x31, 0x10, 0x00, 0x00, 0x64, 0x00, 0x59,
+				     0xf3, 0x10, 0x80, 0x30, 0x20, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00);
+
+	/* Global IRC DCC Control */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd1,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0xd0, 0x10, 0x02,
+				     0x00, 0x00, 0x00);
+
+	/* V256 Enable */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa3);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xee, 0x02, 0x00, 0x00);
+
+	/* Gamma Band 1 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8,
+				     0x00, 0x00, 0x83, 0xff, 0x5c, 0x96, 0xf2, 0x29,
+				     0x84, 0xb4, 0xd2, 0x77, 0x70, 0xa3, 0xcb, 0xe4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9,
+				     0x00, 0x00, 0x02, 0xff, 0x4d, 0xd7, 0xb4, 0xfe,
+				     0x66, 0xa0, 0xca, 0x6f, 0x6f, 0xa8, 0xce, 0xe6);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xba,
+				     0x00, 0x00, 0x84, 0xff, 0x89, 0x3d, 0xec, 0x28,
+				     0x83, 0xae, 0xd2, 0x7e, 0x77, 0xa8, 0xcb, 0xe0);
+
+	/* Gamma Band 2 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb,
+				     0x00, 0x13, 0x83, 0xff, 0x61, 0x66, 0xed, 0x24,
+				     0x81, 0xaf, 0xd4, 0x7b, 0x6b, 0xa8, 0xce, 0xe4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbc,
+				     0x00, 0x13, 0x02, 0xff, 0x53, 0xb4, 0xad, 0xf4,
+				     0x5e, 0x9d, 0xc7, 0x71, 0x68, 0xaa, 0xcf, 0xe6);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbd,
+				     0x00, 0x13, 0x84, 0xff, 0x8a, 0x05, 0xea, 0x23,
+				     0x80, 0xaf, 0xd3, 0x82, 0x74, 0xab, 0xce, 0xe3);
+
+	/* Gamma Band 3 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbe,
+				     0x00, 0x37, 0x83, 0xff, 0x77, 0x5c, 0xdd, 0x15,
+				     0x79, 0xaf, 0xcf, 0x72, 0x6f, 0xa7, 0xce, 0xe5);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbf,
+				     0x00, 0x37, 0x02, 0xff, 0x65, 0xaa, 0xa0, 0xe5,
+				     0x52, 0x96, 0xc4, 0x64, 0x6b, 0xa9, 0xcf, 0xe7);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc0,
+				     0x00, 0x37, 0x83, 0xff, 0x9d, 0xfd, 0xd8, 0x1c,
+				     0x7c, 0xac, 0xd0, 0x7b, 0x78, 0xac, 0xce, 0xe4);
+
+	/* Gamma Band 4 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1,
+				     0x02, 0x24, 0x82, 0xff, 0x7e, 0xf1, 0xcc, 0x05,
+				     0x6e, 0xa4, 0xca, 0x6f, 0x6e, 0xab, 0xd2, 0xe8);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2,
+				     0x02, 0x24, 0x02, 0xff, 0x6e, 0x58, 0xa3, 0xd5,
+				     0x3d, 0x8c, 0xbc, 0x59, 0x66, 0xaa, 0xd2, 0xe8);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc3,
+				     0x02, 0x24, 0x83, 0xff, 0x9e, 0x7e, 0xc5, 0x10,
+				     0x72, 0xab, 0xcd, 0x78, 0x79, 0xb0, 0xd5, 0xe9);
+
+	/* Gamma Band 5 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc4,
+				     0x04, 0x0f, 0x02, 0xff, 0x88, 0xa4, 0xc4, 0xe9,
+				     0x60, 0xa0, 0xc8, 0x64, 0x6b, 0xac, 0xd3, 0xe9);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc5,
+				     0x04, 0x0f, 0x02, 0xff, 0x7a, 0x20, 0xac, 0xca,
+				     0x30, 0x7d, 0xb6, 0x4a, 0x5c, 0xa8, 0xd2, 0xe9);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc6,
+				     0x04, 0x0f, 0x03, 0xff, 0xa8, 0x2e, 0xbd, 0xfa,
+				     0x65, 0xa3, 0xcc, 0x6e, 0x76, 0xb3, 0xd6, 0xea);
+
+	/* Gamma Band 6 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc7,
+				     0x06, 0x12, 0x02, 0xff, 0x99, 0x7d, 0xbc, 0xde,
+				     0x51, 0x8e, 0xc6, 0x58, 0x63, 0xaa, 0xd2, 0xe9);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc8,
+				     0x06, 0x12, 0x02, 0xff, 0x8d, 0x02, 0x9a, 0xcf,
+				     0x1e, 0x6b, 0xb0, 0x37, 0x50, 0xa3, 0xd0, 0xe7);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc9,
+				     0x06, 0x12, 0x03, 0xff, 0xbc, 0x04, 0xb3, 0xdb,
+				     0x63, 0x8f, 0xc6, 0x67, 0x6f, 0xb1, 0xd5, 0xea);
+
+	/* Gamma Band 7 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xca,
+				     0x08, 0x0a, 0x02, 0xff, 0xa3, 0x44, 0xca, 0xda,
+				     0x2d, 0x8d, 0xbc, 0x4c, 0x5a, 0xa7, 0xd0, 0xea);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcb,
+				     0x08, 0x0a, 0x01, 0xff, 0x97, 0xd5, 0xb4, 0xdb,
+				     0x21, 0x6f, 0xa1, 0x24, 0x42, 0x9d, 0xcd, 0xe7);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcc,
+				     0x08, 0x0a, 0x02, 0xff, 0xc6, 0xc5, 0xb8, 0xc7,
+				     0x46, 0x98, 0xbd, 0x5a, 0x68, 0xaf, 0xd4, 0xea);
+
+	/* Gamma Band 8 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcd,
+				     0x0c, 0x02, 0x01, 0xff, 0xb2, 0xfd, 0xac, 0xd5,
+				     0x25, 0x6d, 0xb7, 0x3b, 0x45, 0x9e, 0xd0, 0xe6);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xce,
+				     0x0c, 0x02, 0x01, 0xff, 0xa5, 0x9a, 0xac, 0xe2,
+				     0x31, 0x68, 0xab, 0x0e, 0x2a, 0x90, 0xc9, 0xe3);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcf,
+				     0x0c, 0x02, 0x02, 0xff, 0xd5, 0x74, 0xad, 0xe6,
+				     0x2f, 0x7c, 0xbf, 0x43, 0x58, 0xa6, 0xd3, 0xe9);
+
+	/* Gamma Band 9 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd0,
+				     0x12, 0x00, 0x01, 0xff, 0xc8, 0x97, 0x01, 0xb6,
+				     0x0b, 0x82, 0xab, 0x0a, 0x26, 0x8d, 0xc7, 0xe4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd1,
+				     0x12, 0x00, 0x01, 0xff, 0xbe, 0x4a, 0x01, 0xc0,
+				     0x44, 0x80, 0xb3, 0x03, 0x06, 0x76, 0xba, 0xde);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd2,
+				     0x12, 0x00, 0x02, 0xff, 0xf2, 0x00, 0x01, 0xb1,
+				     0x11, 0x5f, 0xa8, 0x16, 0x30, 0x94, 0xc8, 0xe7);
+
+	/* Gamma Band 10 */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd3,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd4,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd5,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcd,
+				     0x10, 0x12, 0x01, 0x5a, 0x90, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x5d);
+
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55,
+				     0x08, 0x00, 0x82, 0xa8, 0x1c, 0x61, 0x0a, 0x90,
+				     0x04, 0x00);
+
+	/* Dimming Frame Setting */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa3);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3,
+				     0x1f, 0x63, 0x00, 0x00, 0x06);
+
+	/* Default Color Mode (Natural) */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x84);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4,
+				     0x00, 0x03, 0x05, 0xaf, 0x03, 0x05, 0xaf, 0x03,
+				     0x05, 0xaf);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb5,
+				     0x00, 0xff, 0x94, 0x1f, 0xae, 0x37, 0xae, 0x1f,
+				     0x94, 0x00, 0xfb, 0x94, 0x1e, 0xad, 0x35, 0xab,
+				     0x1c, 0x90, 0x00, 0xdd, 0x8f, 0x16, 0x9f, 0x24,
+				     0x97, 0x04, 0x75);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb7,
+				     0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				     0x80, 0x80, 0x80, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8,
+				     0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				     0x80, 0x80, 0x80, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9,
+				     0x35, 0x2d, 0x2d, 0x37, 0x34, 0x35, 0x36, 0x36,
+				     0x36, 0x2d, 0x35, 0x33);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xba,
+				     0x80, 0x80, 0x80, 0x80, 0x88, 0x80, 0x80, 0x80,
+				     0x80, 0x80, 0x80, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb,
+				     0x80, 0x5a, 0x7b, 0x95, 0x65, 0x70, 0x96, 0x90,
+				     0x90, 0x90, 0x83, 0x72);
+
+	/* DCC(GCC) Off */
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2,
+				     0xf3, 0x20, 0x00, 0x00, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd1,
+				     0x0a, 0x00, 0x01);
+	mipi_dsi_msleep(ctx, 20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd1,
+				     0x02, 0x00, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd1,
+				     0x00, 0x00, 0x01);
+}
+
+static int sw43103_program(struct drm_panel *panel)
+{
+	struct sw43103_panel *sw43103 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43103->link };
+	struct drm_dsc_picture_parameter_set pps;
+
+	sw43103_init_sequence(&ctx);
+
+	/* Transmit PPS in high speed mode */
+	sw43103->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	drm_dsc_pps_payload_pack(&pps, sw43103->link->dsc);
+
+	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
+
+	/* Switch back to low power mode for DSC compression enable */
+	sw43103->link->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	/* Enable DSC compression mode with PPS 0 */
+	mipi_dsi_compression_mode_ext_multi(&ctx, true,
+					    MIPI_DSI_COMPRESSION_DSC, 0);
+
+	return ctx.accum_err;
+}
+
+static int sw43103_prepare(struct drm_panel *panel)
+{
+	struct sw43103_panel *ctx = to_panel_info(panel);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	if (ctx->enable_gpio)
+		gpiod_set_value_cansleep(ctx->enable_gpio, 1);
+
+	usleep_range(5000, 6000);
+
+	/* Hardware reset sequence: deassert, assert 2ms, deassert */
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(2000, 3000);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 11000);
+
+	ret = sw43103_program(panel);
+	if (ret)
+		goto poweroff;
+
+	ctx->prepared = true;
+	return 0;
+
+poweroff:
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	if (ctx->enable_gpio)
+		gpiod_set_value_cansleep(ctx->enable_gpio, 0);
+	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	return ret;
+}
+
+static int sw43103_enable(struct drm_panel *panel)
+{
+	struct sw43103_panel *sw43103 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43103->link };
+
+	/* Display On */
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+
+	return ctx.accum_err;
+}
+
+static int sw43103_disable(struct drm_panel *panel)
+{
+	struct sw43103_panel *sw43103 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43103->link };
+
+	/* Display Off (0x28) */
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+
+	/* Sleep In (0x10) */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 80);
+
+	return ctx.accum_err;
+}
+
+static int sw43103_unprepare(struct drm_panel *panel)
+{
+	struct sw43103_panel *sw43103 = to_panel_info(panel);
+
+	sw43103->prepared = false;
+
+	gpiod_set_value_cansleep(sw43103->reset_gpio, 1);
+	if (sw43103->enable_gpio)
+		gpiod_set_value_cansleep(sw43103->enable_gpio, 0);
+
+	return regulator_bulk_disable(ARRAY_SIZE(sw43103->supplies), sw43103->supplies);
+}
+
+static const struct drm_display_mode sw43103_mode = {
+	.clock = 179177,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 50,
+	.hsync_end = 1080 + 50 + 30,
+	.htotal = 1080 + 50 + 30 + 50,
+	.vdisplay = 2460,
+	.vsync_start = 2460 + 4,
+	.vsync_end = 2460 + 4 + 2,
+	.vtotal = 2460 + 4 + 2 + 2,
+	.width_mm = 69,
+	.height_mm = 158,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static int sw43103_get_modes(struct drm_panel *panel,
+			     struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &sw43103_mode);
+}
+
+static int sw43103_backlight_update_status(struct backlight_device *bl)
+{
+	struct sw43103_panel *ctx = bl_get_data(bl);
+	struct mipi_dsi_device *dsi = ctx->link;
+	u16 brightness = backlight_get_brightness(bl);
+	u8 ctrl = 0x2c;
+	int ret;
+
+	if (!ctx->prepared)
+		return 0;
+
+	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, &ctrl, sizeof(ctrl));
+	if (ret < 0)
+		return ret;
+
+	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+}
+
+static const struct backlight_ops sw43103_backlight_ops = {
+	.update_status = sw43103_backlight_update_status,
+};
+
+static int sw43103_backlight_init(struct sw43103_panel *ctx)
+{
+	struct device *dev = &ctx->link->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_PLATFORM,
+		.brightness = 1024,
+		.max_brightness = 2047,
+	};
+
+	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
+							     ctx,
+							     &sw43103_backlight_ops,
+							     &props);
+
+	if (IS_ERR(ctx->base.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->base.backlight),
+				     "Failed to create backlight\n");
+
+	return 0;
+}
+
+static const struct drm_panel_funcs sw43103_funcs = {
+	.prepare = sw43103_prepare,
+	.unprepare = sw43103_unprepare,
+	.enable = sw43103_enable,
+	.disable = sw43103_disable,
+	.get_modes = sw43103_get_modes,
+};
+
+static const struct of_device_id sw43103_of_match[] = {
+	{ .compatible = "lg,sw43103" },
+	{ .compatible = "boe,sw43103" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sw43103_of_match);
+
+static int sw43103_add(struct sw43103_panel *ctx)
+{
+	struct device *dev = &ctx->link->dev;
+	int ret;
+
+	ctx->supplies[0].supply = "vddi"; /* 1.8 V */
+	ctx->supplies[0].init_load_uA = 62000;
+	ctx->supplies[1].supply = "vpnl"; /* 3.0 V */
+	ctx->supplies[1].init_load_uA = 857000;
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		ret = PTR_ERR(ctx->reset_gpio);
+		return dev_err_probe(dev, ret, "cannot get reset gpio\n");
+	}
+
+	ctx->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->enable_gpio)) {
+		ret = PTR_ERR(ctx->enable_gpio);
+		return dev_err_probe(dev, ret, "cannot get enable gpio\n");
+	}
+
+	ret = sw43103_backlight_init(ctx);
+	if (ret < 0)
+		return ret;
+
+	ctx->base.prepare_prev_first = true;
+
+	drm_panel_add(&ctx->base);
+	return 0;
+}
+
+static int sw43103_probe(struct mipi_dsi_device *dsi)
+{
+	struct sw43103_panel *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(&dsi->dev, __typeof(*ctx), base,
+				   &sw43103_funcs, DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	dsi->mode_flags = MIPI_DSI_MODE_LPM;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	ctx->link = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ret = sw43103_add(ctx);
+	if (ret < 0)
+		return ret;
+
+	/* The panel works only in DSC mode. Set DSC params. */
+	ctx->dsc.dsc_version_major = 1;
+	ctx->dsc.dsc_version_minor = 1;
+
+	/* slice_count * slice_width == 2 * 540 = 1080 */
+	ctx->dsc.pic_width = 1080;
+	ctx->dsc.pic_height = 2460;
+	ctx->dsc.slice_height = 60;
+	ctx->dsc.slice_width = 540;
+	ctx->dsc.slice_count = 2;
+	ctx->dsc.slice_chunk_size = 540;
+	ctx->dsc.bits_per_component = 8;
+	ctx->dsc.bits_per_pixel = 8 << 4;
+	ctx->dsc.block_pred_enable = true;
+
+	dsi->dsc = &ctx->dsc;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		drm_panel_remove(&ctx->base);
+
+	return ret;
+}
+
+static void sw43103_remove(struct mipi_dsi_device *dsi)
+{
+	struct sw43103_panel *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->base);
+}
+
+static struct mipi_dsi_driver sw43103_driver = {
+	.driver = {
+		.name = "panel-lg-sw43103",
+		.of_match_table = sw43103_of_match,
+	},
+	.probe = sw43103_probe,
+	.remove = sw43103_remove,
+};
+module_mipi_dsi_driver(sw43103_driver);
+
+MODULE_AUTHOR("Abdur Rofik <rofikcoga@gmail.com>");
+MODULE_DESCRIPTION("LG / BOE SW43103 FHD+ DSC Command Mode AMOLED panel");
+MODULE_LICENSE("GPL");
-- 
2.39.5

