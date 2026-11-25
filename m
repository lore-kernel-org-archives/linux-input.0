Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572603;
	b=hA2D4TY2MDRCBBmPZ7v7mrvWdiFAmbDzW6Bju41Urbgc3TbtW7fWul/KJjLPw5/WDEPO
	 b7qNoc0YYQOU6vjd/A8FNiwlgOtVYwCYxt8kJFCglpWIjv1ilLhUr9BGr95F/G6aepTKZ
	 m0/ceLlKrYH9VkuOSnjqLusAUE1ChmH1W8CdnH5xUrudj1jiAd0rMmD+ljjr/kkyHlolu
	 arrdLX7Ilild/wYUh3gLJBVQ3d5LyAA9P3TKqz3cdtRdo6Z31Iw09DqC3Uh3nQ7VlzpIH
	 BNUrtorP3AkksW1R0pINBDoDx2E066LN+AAN27qrtT0PDC/hOkCH1IwcN7BUX2MN7dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572603;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0oJdvttkxU0i0y40La9zHpYAzZjXWhAZE4nXYC1fcFY=;
	b=g8n0G6+TAdGaimQzqTY8UmlJgnw/jwSPr0bzHL+jqDYJ3e1XRmeZvOLvCp7nb3Ru3QUA
	 4FdTWsLWK8sN3KjphjOV4zNhdd19NVG8vC6cLJnXPO9SE9SS43R+ZJbSuQS/lvG77CXtW
	 ouS/uflqJGvRqrX0l/Y5LFyZxo0CE5LKGwBOwUvM5LIz50qZDL4smX3JNV46q6fuDF7/x
	 k7daHoGHtVn75PVa436gmu0o0IulgkMeLD0BTdvQPNS5OFj+uYpMlBrpWidT+MDBT8vrS
	 nJUuA0oBvyPD3KVIuvz3m/h38jlCeTKofA+T6jGObDvievfLBq0ziIRNAfI+DtGDHfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nxvP1682;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0C606A682;
	Wed, 25 Nov 2026 02:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F0C606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nxvP1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795572594; bh=0oJdvttkxU0i0y40La9zHpYAzZjXWhAZE4nXYC1fcFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxvP1682HWzN8DQlswRPvuC39+mOkWS1oI87SPtUwunNL4JKpw2jTLo4KJDJOg0Kd
	 7Z6BwbJWp2bX9ZK4C8RpJ9GlvGYHDA1LGCca+CxXvrPqH5BfwEXtk2Xiihf3JR2xaR
	 5Qbv6totQCXdIibldNgd7huftUi7g86+Eql1WSvw=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572592te4du5ev4
Message-ID: <tencent_42CFAF0E2AFDF8C8C784D5DCB700E1E65306@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlRvPH68syz+NWAahhRs4fHVKVW7dBQKudoAjUVsXSpA2/DLjE/k
	 Iacyv+RwpfVjb7o8JzPmIUWm2bkIoFrNFfNiRh+pd0rGC2ZIH6O/uZkO/u/uspJR/bYsEV1cvGRo
	 VDADQBnMfnvDU7HE30LNvLce0FmpZCLO/xmBcZ3fx2oe/9hPAX+DVK+IiKn14J5idA7rQuo0fB2U
	 cRRiQzjgJGCeMSrA8QutAwc5rKvZQZ9re8w9/XyjXXHETV6vDB0DvhIQVQXPWE0OsM5OJyRIlpto
	 MiUsZSpAbuxZIVGYSBBym+yUCMrJ8B9W68IqKUEvSBRxlsn3tXr5ft5k0SV/Uq9h+KghvXY+nJl2
	 TOR7Dt4oqKyyaPtmK+yuV99a9uwVl48zsJ71hRePrJqigrb4+6CJdizc6Yd5AyuPoa4eArdEmKXa
	 LYlg7VFg0+wxK4wBU10Py66dYwTYtpu74YPug2leDsxgeaqrE+UWLbK/vVKMRxwna4HbwOX8Y6nd
	 Qc0t5DQLFH69DTaXtVadkM/6S3uBUaEzCERZBaGxlX3mz3e01AOtR4dFAhTRZCEmpe433Q03Tg3r
	 QXGZC6t9C5xTaj9tgG4o+edrGihVU9dFuBvkcypTbe+mEvABvDknHyxHSDQuVvE2nheRJ5/DeXxt
	 SDVOpaTcADTP7WH8k4gqRWFL0Ze27QdocyUKpTsborrNTcOmoCyOtr35ntrCdUVWU8DPHIwWcuDH
	 41IkRj1hh2vVS1wEDuSZ+RTpd+raEX7J4egxz5OKwmgCI+4+omE+Frc+9ROYeZ53smOt3YwfsYj1
	 W3wxrSv6kJUeknDcmvdJQAzxla95vK7lorqBix4jhpCXOtouOzVQacaUx+FDXJsqBOBcGbkwiQLz
	 c4SYEjqqocGzrmauHWZ83An1yUcEXaZLSs710rGFdT6Gb85lG6X3qDj+IadbO63y0jHcQmf9RtQw
	 ufdAQPSN23rMMov/XySWFn51YtchPaPNQGIgZtZ5qmUGkjFcnDRzIhitbUpeph/VMHI0n3+AA/jC
	 kdJtOmWl8p03tuuxRgnDNCcUT3W8NobklTu6/uLIfXDhLvvq46a907seJL2T88LDAmNPEbWO5Pbk
	 etFpwt
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>,
	Cursor <cursoragent@cursor.com>
Subject: [PATCH v2 6/6] backlight: add VIEWE I2C backlight driver
Date: Wed, 25 Nov 2026 10:09:44 +0800
X-OQ-MSGID: <20261125020944.137-7-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125020944.137-1-3066883572@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
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

Signed-off-by: Hefei <3066883572@qq.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/video/backlight/Kconfig        |  7 +++
 drivers/video/backlight/Makefile       |  1 +
 drivers/video/backlight/viewe_bl_i2c.c | 79 ++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
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
index 0000000..53dcf08
--- /dev/null
+++ b/drivers/video/backlight/viewe_bl_i2c.c
@@ -0,0 +1,79 @@
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
+
+#define VIEWE_BL_REG		0x86
+#define VIEWE_BL_MAX		255
+#define VIEWE_BL_DEFAULT	200
+
+static int viewe_bl_update_status(struct backlight_device *bd)
+{
+	struct i2c_client *client = bl_get_data(bd);
+	u8 buf[2] = { VIEWE_BL_REG, (u8)backlight_get_brightness(bd) };
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = 0,
+		.len = sizeof(buf),
+		.buf = buf,
+	};
+	int ret;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret == 1 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static const struct backlight_ops viewe_bl_ops = {
+	.update_status = viewe_bl_update_status,
+};
+
+static int viewe_bl_probe(struct i2c_client *client)
+{
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = VIEWE_BL_DEFAULT,
+		.max_brightness = VIEWE_BL_MAX,
+	};
+	struct backlight_device *bd;
+
+	bd = devm_backlight_device_register(&client->dev, "viewe_bl",
+					   &client->dev, client, &viewe_bl_ops,
+					   &props);
+	if (IS_ERR(bd))
+		return PTR_ERR(bd);
+
+	i2c_set_clientdata(client, bd);
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
+	{ "viewe_bl", 0 },
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

