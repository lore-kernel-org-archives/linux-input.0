Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602110;
	b=lOIjw30GGV/QXzwSMtnr7mgb8qevHMY48gRDVhL5XxM4rP3isaNZ/HyGVc650nxn3ovJ
	 /UaU7R83d1ONEsQ+R8PZ1H6yXCJdDKyI6f1OBvrGa5lXCsv5drG4EM+T4AB7WqaCrkTw+
	 74guHvXG9iyaayyhXDNvlVCyF3Sso+Z+5l0/TQi0lR27UXr9Se91tAbbpxNwUpSS4XlDL
	 rRVcEU/jAkaJ9nkWnsM65vKgKy2i2k5u5mbyEYcZcjGphi+DJUoDFBT5rdNIbG2N9hCzB
	 Vvh58ijYNDeK0t2whqqisv+zQ4z+8eiRN2UbkOpEFMKIJBfYG+FKJseRAYlIsuGzwyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602110;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mW/42GTNM3u029GrlvjKVxveK9yKQX5QU4i36liSKZ8=;
	b=UW9BZajEdN6U12fZY+l6tXCf9o9AiNzEGnlC32U61NmOLKWNEtkR0pk+mBEs9vGLa0zG
	 XcqApnBwC7M4fLkIDnrIkTEqxDBcRWkWfrWv27/pzGgf84JZm9tQk9SGR8Qa1jx5722eA
	 4qtQ+333aiLn8oj8wBY7jpi22CNRIynsKHhOdDOJEMoQN5+f4TKSEfiryTAUXdzVekYsZ
	 X4VDZG/e5DhmuSYxzfdc8qQqgStLqzQC6i+sXqphONS5l12vnvMRcwlR/gK1IXx4CwP4/
	 vEcdXmvcmiT29VxixefuKfksL/EcGE8EZ8dvjiJlEHhAuPSV76bvT3Ebo3iMQWEldHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=j5HbqhOy;
	arc=none smtp.remote-ip=203.205.221.210
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B07606A329;
	Wed, 25 Nov 2026 10:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B07606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=j5HbqhOy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602101; bh=mW/42GTNM3u029GrlvjKVxveK9yKQX5QU4i36liSKZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5HbqhOyX6lY2MqivdCOXkNV44iBdboezVfucRN6OdSL2fUJCHT+DZdOiDf2YXXKo
	 IUeWrZ5Owgp9kkCvxIZQlGNp0QDxYnp4jR22ojGJIcmCanzJioUdsACK0OxwuousYW
	 L8jM/i6zTehOt63/Vxv+iAburt2bsgPsQnTmB3Xw=
Received: from HF ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 56009AF2; Wed, 25 Nov 2026 18:21:32 +0800
X-QQ-mid: xmsmtpt1795602099t9vgagz7m
Message-ID: <tencent_D6B8ED478B95DCB70761EB53E2EF36AACA06@qq.com>
X-QQ-XMAILINFO: NUHe5LW8P76+nmD7vZFpzumTnUhVCTySTVVwONqBt9iY+dAUu9ZZ6bJ5PFLdS3
	 Y60EK3zGZ695c7hDKad8O90S8QgMmAmEMtwf6omVeNcqpVSQbFX1No1fhPnVD1JO2u2mhLdmZxTg
	 MD72S9Wyu1ABX07LLF5rqwYKUZEUOEtCZ6EydiS9vrTdGIpOlsExg6hW/7wIAzhByTx1MYuO4cnD
	 Q0bMkGddwgeNE1E/iQvhOCbHPnAIjdDap/C5z7eYsrtYAl593s89iNaQ/LSayGp5zBofXEQD0AZ5
	 sz0mDadowS3MP8K1TMGFTUyIEXXDTSKet6hZXRMn5y+Czg/hEcUt9NAJ2oxg7Us67rlBU7Yit7is
	 0uhKQmNQhf05KYRA7CfX3iKxLMqipxl7ZUzn+kpl+U89VbmY/H5z9PSe9WVvoCFF/4atNPYHh2Mi
	 jYBTPmUMri5rQFWFry0SceLtmDzxAWAo1eiOip5onQSbbq+LGPH8bH3SQvyIhwOjIvYuflZ2uJjt
	 KfwzTe6su7GNRacY9QA5PRQf3Kaz/3qaOm1QcP/bQtVDHGEWVW+WCC9yVgC2gNyoeqHftsTsQAOZ
	 ozFHQoUH66NJkq0poFwmof8d0Rh85NHnjyhZ+blTK3+Jn9l6uGk4g6iFDIhIeqEpJ9EAnop8XuyY
	 bZOyCHC+ZvMwOPMidiOdH08F1Ra092etLprN70gxYHzLivHhl0eBUC6hwEaiApfqVJMwzQBPWekt
	 KdzuZx6HbOIJG1QibEpG7YVnUmk1L0C4ZN1BxqlECpKuovadxdXumw2pbNt0j7LM11swO7eJ4OdH
	 BIfMVgQKX8JSm5s5jN3V7JEun8j6kL3Zm4eb1t05KSpj/YXecRZ+ioO3dX+laCFU6rr12mdNTkUC
	 k3KXVNbaQHfM3ogr/pL/G8++kOmRyttZgW+k9tFaVX5voMWripDJ91XZMVk6XWtznojfYWtPbWnv
	 z7ArMreWDqy6CJiTTRNNAlZ+1GWhruWW19ST7IAYGqSmMR5QQS+efHgyZ9exWbDpi15p7xB/9Caw
	 Zn4JYGKihXuGFdkxm5CF1XMK05ZuQzrIjPCp9TYzlQpo1iQemTPXvmFzW6XucUJybZiMIP+r7jdj
	 bxKflJ3AbA1NTwwiFg+RppQHDqR2tfLwqysOKklGZXlncrHPbZo6PbPHB/GTE6PZpqSTh0n7AS1J
	 +AvMs=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	Hefei <3066883572@qq.com>
Subject: [PATCH v6 6/6] backlight: add VIEWE 7KF82 I2C backlight driver
Date: Wed, 25 Nov 2026 18:21:30 +0800
X-OQ-MSGID: <20261125102130.256-7-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125102130.256-1-3066883572@qq.com>
References: <20261125102130.256-1-3066883572@qq.com>
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

Add an I2C backlight driver for the VIEWE 7KF82 module MCU at
address 0x45, register 0x86 (brightness 0..255).

Signed-off-by: Hefei <3066883572@qq.com>
---
 MAINTAINERS                            |  7 +++
 drivers/video/backlight/Kconfig        | 11 ++++
 drivers/video/backlight/Makefile       |  1 +
 drivers/video/backlight/viewe_bl_i2c.c | 82 ++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1679f1cc9..1abbe62c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27202,6 +27202,13 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/test-drivers/vimc/*
 
+VIEWE I2C BACKLIGHT DRIVER
+M:	Hefei <3066883572@qq.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
+F:	drivers/video/backlight/viewe_bl_i2c.c
+
 VIRT LIB
 M:	Alex Williamson <alex@shazbot.org>
 M:	Paolo Bonzini <pbonzini@redhat.com>
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7b836f9ad..f57894073 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -501,6 +501,17 @@ config BACKLIGHT_LED
 	  If you have a LCD backlight adjustable by LED class driver, say Y
 	  to enable this driver.
 
+config BACKLIGHT_VIEWE_I2C
+	tristate "VIEWE I2C backlight"
+	depends on I2C
+	help
+	  Say Y here to enable the I2C backlight driver for VIEWE DSI
+	  modules such as 7KF82. Brightness 0..255 is written to the
+	  panel MCU at I2C address 0x45, register 0x86.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called viewe_bl_i2c.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endmenu
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index bcb568afe..b82d959dd 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
 obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
 obj-$(CONFIG_BACKLIGHT_LED)		+= led_bl.o
+obj-$(CONFIG_BACKLIGHT_VIEWE_I2C)	+= viewe_bl_i2c.o
diff --git a/drivers/video/backlight/viewe_bl_i2c.c b/drivers/video/backlight/viewe_bl_i2c.c
new file mode 100644
index 000000000..0f9173dfe
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
+	bd = devm_backlight_device_register(&client->dev,
+					   dev_name(&client->dev), &client->dev,
+					   client, &viewe_bl_ops, &props);
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

