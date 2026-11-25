Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575409;
	b=IsTyVwZK9GNV7Q4y/Y0nEMOYV/Vl9dfArrkfwDm5gSX6GknB5IV9KdnQSF/JtvE4CLE+
	 E/hw4mIuG2Ad3rtKXa6PGY5hdDaLOReO2oN8oXgEb07IJFtqdnAx4qz3HYP+j2OErZYAv
	 aGGCB3nY+m+z9o3T1NwnQDiDt4HJ2WEvqoNorvqSuE969U9eiobRVaW4Q04Do7qeA5nOq
	 j7sjg0CX1i2Ddd6gZZoC8N9R89T5MAR6GX+5eU1krUCXs61wR82KwkpCiC3VJ5LbK7c8+
	 sPFEDOfzZdTBgzZy8HcnFOE/KPfc3t+uu9KIW51FBh+3pmQVGW/BkgHVNIX/ejz+DLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575409;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fbu9uDIZ7L32gOC7ibbK3yEo/s2Yqhso0UM/iF/DqSw=;
	b=1QaZ8uKZ9Ao57lSkha+6dttnwzPXzLTG8FXjfhlvj56UCSevrxAPvJr66lSf5wp4eN6W
	 pKinxC5vyjO5uRLkNjc0Df7I8lBakV2U0nPZLBIRGLh5srswwqAPjCGxBuNnsH5VR/eAj
	 /oiPkrcs0vq2TA6+yD+RL6/xsrJwRqB/CY+ozBDtc0GHp97Yy/yA6KfyGUeeJ9U4S7LfS
	 K7MSOxqvXJA8Atp8bUGU6qfkRfxFiJu4d5eOY7molpPH+UHrOPJc9AJcrs7RXdWWupoYH
	 Uqy5W4HsSmgAJ+tophVisfHm4xMBnMyqS9LiRcP6g4dsjGtGR1vE3MeokxByv8puzoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JD6rEod0;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148C606A333;
	Wed, 25 Nov 2026 02:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8148C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JD6rEod0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575406; bh=fbu9uDIZ7L32gOC7ibbK3yEo/s2Yqhso0UM/iF/DqSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JD6rEod0O6lBZJQv3JXsQ6AmCMqcueylZjTsH4Mg8YR4QSNnRZbJPYQ0FSMO4wLyS
	 vPBKdOhI+88lSCZ+GRD3doc/oUmcCLlV2g/Fmbe5yTILC/ss/dXYADnNSlEevxNB81
	 M5vnApAxJg/qJ47GkdQLdLmgWuR31oxUTYKpgR4I=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575405tspp6hzh2
Message-ID: <tencent_BFE1A9E03700F565DCE663D30AE77B8B5005@qq.com>
X-QQ-XMAILINFO: MnyA3vAndR/VFxm9L0VwHaURWIQn4qp0P8vkSakoy9TYUgOhyqNr0mug295VlY
	 MigNYF7UmLPiTaz7i7ivOcVCW30wJk+tHBlNpT/M+ug76WFRGPGnuYTne2J4nyTpXr6wL0PmugvE
	 1yorDNDcY/gOlETcS6GWkJkvGkZmZyTX8RB4AZE1tkf3p9lqiC+KCY22NeVvUcPfrT+1cr8D07bj
	 TYDnTUQMp41Lh/vvQqaMHH02W4jrem6m01Dy1H+cBV+tnjsgQmNcYAZoHk2sfABFdqwYNKNxL7zJ
	 scbqaoGu1WxQ3wDly8m5KPrSE5HdP7tyoRzuFV59u59t3iuu+/XtgqlxGj286a9/iQDQdxKAPN0u
	 qf4NO0haPr50ocxhsrJWrDbcYaHnwQmYEgKo0CcwQDQUHfOpdP8lC8lxys9lSsP5Q7/5rvmMpBdB
	 D295K7G/a5v/omBiyNDTWv5WjW4ptiWvEEj/+L7zx/i+IQLk9VURU/uYvwzl8NxerlYBHsZsGDg2
	 AUi/kterh0E0XvVplHCMd2Wir5IUUyHnMh4Mi5STRrf5Xr/pU1eaMWIeiUaaFp8IKJldtJZjmAYE
	 hfEWueVmQsIGmYfzxDbDOj3bI8BCocJPiJAPL7zXR97qheShw+bnCBzK6/E21A5ebL0Xkx0hpC/a
	 vV+fRY/HkHeWTtiK+XmlBJnA58FL3zro3cV3zjwbrNnyUHHdWA8uKia71W615/uWrtQHdSP43xYA
	 X3ynSZ9aqQ2Fd/waHZSHmuddklR7DijpN8ve2ollOMGl7mZAS2TSyegUY7VX6GkwLfcWuYfrsVTh
	 4UtaZL0xRvc+K86hBdZNGdF8RId7JeDXiEivH4WUQCfLTk+hUUmvQMccR+L18eeJreO5f67ElxND
	 YiOtzNig31CUO6RWpFKZsEfgfjiL8FtDcA+paDQOxp83Lrpko7sQ0N0wDqQXUfturgsRoDzRntL+
	 KJGU9A8VhR36n5B1jJSH7YzvWRN1dO89uDTHg3o+bdtNsthZg4THXrYHrmR8Cx5S1hHcTFkP6AAv
	 bt1EBk0kHx348F65wDpzNl6XUl7jvcBL5dwzkJBa0ZXEvPt1CquRn4YGh2xWNuK8PaqhYSo55wiT
	 DSv7RyBPNE51AOQCkNZVTOI6oo6+sLt6xQOIfaIrtJpnfV8nb38URkb7Y4Tf+O0gXF1Hw5qH9KWG
	 ENMaE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 6/6] backlight: add VIEWE 7KF82 I2C backlight driver
Date: Wed, 25 Nov 2026 10:56:38 +0800
X-OQ-MSGID: <20261125025638.1171-7-3066883572@qq.com>
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

Drive the VIEWE 7KF82 backlight MCU over I2C (register 0x86).
The MCU has no public discrete part number on the FPC silk.

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/video/backlight/Kconfig        |  7 +++
 drivers/video/backlight/Makefile       |  1 +
 drivers/video/backlight/viewe_bl_i2c.c | 82 ++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7b836f9..8ea7332 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -501,6 +501,13 @@ config BACKLIGHT_LED
 	  If you have a LCD backlight adjustable by LED class driver, say Y
 	  to enable this driver.
 
+config BACKLIGHT_VIEWE_I2C
+	tristate "VIEWE I2C backlight"
+	depends on I2C
+	help
+	  Backlight driver for VIEWE DSI panels. Brightness is written to
+	  the panel MCU at I2C address 0x45, register 0x86.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endmenu
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index bcb568a..b82d959 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
 obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
 obj-$(CONFIG_BACKLIGHT_LED)		+= led_bl.o
+obj-$(CONFIG_BACKLIGHT_VIEWE_I2C)	+= viewe_bl_i2c.o
diff --git a/drivers/video/backlight/viewe_bl_i2c.c b/drivers/video/backlight/viewe_bl_i2c.c
new file mode 100644
index 0000000..fe9ed47
--- /dev/null
+++ b/drivers/video/backlight/viewe_bl_i2c.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * I2C backlight for VIEWE 7KF82 DSI modules (MCU @0x45, register 0x86, 0..255).
+ */
+
+#include <linux/backlight.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+#define VIEWE_BL_REG		0x86
+#define VIEWE_BL_MAX		255
+#define VIEWE_BL_DEFAULT	200
+
+static int viewe_bl_update_status(struct backlight_device *bd)
+{
+	struct i2c_client *client = bl_get_data(bd);
+
+	return i2c_smbus_write_byte_data(client, VIEWE_BL_REG,
+					 backlight_get_brightness(bd));
+}
+
+static const struct backlight_ops viewe_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = viewe_bl_update_status,
+};
+
+static int viewe_bl_probe(struct i2c_client *client)
+{
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.max_brightness = VIEWE_BL_MAX,
+	};
+	struct backlight_device *bd;
+	u32 brightness = VIEWE_BL_DEFAULT;
+	int error;
+
+	device_property_read_u32(&client->dev, "default-brightness", &brightness);
+	if (brightness > VIEWE_BL_MAX)
+		brightness = VIEWE_BL_MAX;
+	props.brightness = brightness;
+
+	bd = devm_backlight_device_register(&client->dev, dev_name(&client->dev),
+					   &client->dev, client, &viewe_bl_ops,
+					   &props);
+	if (IS_ERR(bd))
+		return PTR_ERR(bd);
+
+	error = backlight_update_status(bd);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct of_device_id viewe_bl_of_match[] = {
+	{ .compatible = "viewe,7kf82-backlight" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, viewe_bl_of_match);
+
+static const struct i2c_device_id viewe_bl_id[] = {
+	{ .name = "7kf82-backlight" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, viewe_bl_id);
+
+static struct i2c_driver viewe_bl_driver = {
+	.driver = {
+		.name = "viewe_bl_i2c",
+		.of_match_table = viewe_bl_of_match,
+	},
+	.probe = viewe_bl_probe,
+	.id_table = viewe_bl_id,
+};
+module_i2c_driver(viewe_bl_driver);
+
+MODULE_AUTHOR("Hefei <3066883572@qq.com>");
+MODULE_DESCRIPTION("VIEWE 7KF82 I2C backlight");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

