Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056518;
	b=i5mV7ixUyD61vTeJFYDktb7jQqMeNf4DW+ac4IqK/qy6p6MXTsufj9cicFW3d3/zTRSm
	 8aOU+2rLSkWHCwsLQs6CCAVHcQ1GWZK61gU5DxSy1rR6GkhXjrkHDAWWvG9moq/YuIzDL
	 3HslTwxvhPzhfBmbJILr9ohRDCA6JPGdVZ2myz+fK7WhtnTllC+qHMan8efR9UiloGWos
	 zkeGa6uddWequw7rpLlJR1QyWlQG9IxevpFYadayjqcek3OUE/jeONttsO5Bw5HiYdule
	 8kQ4LFpbyBR+azv041et4YNeekAf+KdT0oi5u/hSzkw9R/yEwcU7XHLSjHH8iclgxzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056518;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=mmyfdKwRuqAnEdw9I2JJeXJmb2prELekKznNh/t/3tU=;
	b=RcOauZlAoI5XeZbqd3KLA1oxQSseb8LDllJLNji1FnSzG2zPA5/yy5/ikj8ZREJU3H4J
	 o435EaLY0CZlcUw1A0MESObhBs+1eHggTZ7gu1UUc4RmgLY0FJDmPGMPJwOo2e5tutk6V
	 sswm58rGCcVS+94acuhSDJkqtay35Ew1M3aDR3kMFGqP1set+WkMUQnOWecLyPAVuCP6D
	 7bwk5zB+JuTMFwYk3PY+COy+8L2+jzKnRRhVaZ5TgiuoFBOj5Raqub5ig63WHypF9d7qU
	 R42oVL0N3xBIvaakINAJflEgyoSJzuZP360lEb4+UFuzghIOdmDKXqGCqqp/0Wnt02g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tue9Z+qK;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E56606A32A;
	Thu, 19 Nov 2026 02:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E56606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tue9Z+qK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795056492; bh=mmyfdKwRuqAnEdw9I2JJeXJmb2prELekKznNh/t/3tU=;
	h=From:To:Cc:Subject:Date;
	b=tue9Z+qK/e2CuLaNwxjzlyFsbCNPL892E7KEIBz7H/2wub93SRBMdGJnNC199mST2
	 DGkcnbs1rM5qY/DXJDdlQJjqiObXsXZ/l+5weA8epe/8i5RtRnQ9yUQpqjCi8aqhvJ
	 0hbx8lN1XkH0yOrrlOw7lgTjlTapk6R+Bu1ShFO4=
Received: from [192.168.2.135] ([113.90.236.90])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056489t32ne62k5
Message-ID: <tencent_87F1AA0F0CABDAEF48428FA7BB5F24D48D07@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLPa7Wxj2eTVh6+f0UMcaCNPhIjoPkP1sY+OZySyn2Wy6KPxJiXl
	 kyHIueNJunWnQuBcEK3VcmeKMcAdTX+FLqBmpVxgfdcdeji6b9qg1wj10IX4yuuSbzltv9Unq+32
	 cNktcQ2CXmghjd4VZ4vnwLgInOaqwJ/F4PLG41uEmT61EdDcYQvJgPHDLoMjTwUQZAIvtCRx9/lZ
	 xeQOPYY6EbTJWND/UlcOssG3gIpQc1CrcSy+cwrYSKOuWkfZzrXNU3FZUAu2IIQpb/LaH11x25PX
	 wu83SSGrPGqzamRJuFRxAGXUx1rLHCrpCQjyRCftPzo586i0CN9H8boDErWY37bUed8EwtlchFtC
	 CWlVECR/A7fBOEsAg5FGt69WepH4W8MHpyuNT+HI2Z1uqJLJ/8DT8zvLW9dw1m2FBCOp2je/SFu4
	 Z9Fi1kgQEm0efnttmMZ2tp5Ep2S6Rok0BMA/UGejgwvGAPqsoIAdy5tEhQbj1p0626DfX1oA5hLI
	 Wu2Pz5stOwkmz+myzIKZgAZf5FykH8zzfadm7OdkR51hOfvVriJD2qThw+lyl/7pzInZQVdTGgFD
	 vucNuY14ujDJZYMTdQ/4qBiop+iuEtcNuMKCeFzt3Xlx9QMirO6n0s8z0iD0s5XyUtc7UJGhIdkl
	 QeR+/qQ2PSfusSTL8UpPCXHq3R7lYwgXpB1j/EwdV+6Un13Uzxno9DLffVDLS9pdjpDHr5HvDypc
	 HmRQ5F82QEDswz6j21mnRnmVHfo6Pgq73vAJ7TvNjAemdqqUXYxrMXgrUMZ0lQ+CBra/ub0N+nRk
	 QwiszOvvCO/2eKxf/wG4WCU/Z7Q0l4xnuJfoFUl4It8a0ADFuQ6EMLPm9fJ4MRKwR5H0A2vH92LN
	 4oa5TWauqWRZfRWChW5LsJEJYuEIe4vsUPfl1e4p7326cijUwppd1+VAWyK1VP9391JFHgSOjGen
	 Pv+W613eKNT3rghZxTdPa+pg3zQ4g5QtgLXxEvtfG2ppAHwsrAU9IyqYc6Lqa2JLehsuzaG+2TK5
	 uu0mE2ln41pXzFAY6WkUPPF1FUqEqGak3NOR31oURcRs4XjwhbgEiAzpljJTj9TfSa+8PIBg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] backlight: add VIEWE I2C backlight driver
Date: Thu, 19 Nov 2026 10:48:12 +0800
X-OQ-MSGID: <179505649217.50956.4465368185898814151@qq.com>
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

Add a simple I2C backlight class driver for the VIEWE panel MCU at
address 0x45, register 0x86.

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/video/backlight/Kconfig        |  7 ++
 drivers/video/backlight/Makefile       |  1 +
 drivers/video/backlight/viewe_bl_i2c.c | 91 ++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
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
index 0000000..3be1759
--- /dev/null
+++ b/drivers/video/backlight/viewe_bl_i2c.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * I2C backlight for VIEWE DSI panels (MCU @0x45, register 0x86, 0..255).
+ */
+
+#include <linux/backlight.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define VIEWE_BL_REG		0x86
+#define VIEWE_BL_MAX		255
+#define VIEWE_BL_DEFAULT	200
+
+struct viewe_bl {
+	struct i2c_client *client;
+	struct backlight_device *bd;
+};
+
+static int viewe_bl_update_status(struct backlight_device *bd)
+{
+	struct viewe_bl *bl = bl_get_data(bd);
+	u8 buf[2] = { VIEWE_BL_REG, (u8)backlight_get_brightness(bd) };
+	struct i2c_msg msg = {
+		.addr = bl->client->addr,
+		.flags = 0,
+		.len = sizeof(buf),
+		.buf = buf,
+	};
+	int ret;
+
+	ret = i2c_transfer(bl->client->adapter, &msg, 1);
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
+	struct viewe_bl *bl;
+
+	bl = devm_kzalloc(&client->dev, sizeof(*bl), GFP_KERNEL);
+	if (!bl)
+		return -ENOMEM;
+
+	bl->client = client;
+	i2c_set_clientdata(client, bl);
+
+	bl->bd = devm_backlight_device_register(&client->dev, "viewe_bl",
+						&client->dev, bl, &viewe_bl_ops,
+						&props);
+	if (IS_ERR(bl->bd))
+		return PTR_ERR(bl->bd);
+
+	return 0;
+}
+
+static const struct of_device_id viewe_bl_of_match[] = {
+	{ .compatible = "viewe,i2c-backlight" },
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
+MODULE_DESCRIPTION("VIEWE I2C backlight");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

