Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575408;
	b=EHWi2NfRmNblEggmfw/RVCZZdqpHVlgwCYPGZjWAtKfMNs7P3yPRBw8Na2PEveC57+7B
	 d8PYFpblu2CI6j5LitPgtrrwMeqrPUQZpXtNcQY5DNkmqOgcsArsx5qnM6VGW8UHlZFUK
	 T+MDGeSBt3DN+iJQUnNYvBHMFCkouXVYMhrNf0/WXlbaosxg6NNDRpan5GtxFGJD7v9BV
	 Sx05XJ25c8skVAeBunLhJ3IBM2/Au++spCIrIkGhNYwjJZLHQkZrbcTM171efrVwqhWBp
	 mDYb40r7xLtWuicoLyGGMJEkvBDWpRtDQbv1NGVC7YPxgknUyfb7nia86HjexmsfQnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575408;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+X+7O/JfBFYIxFx/cIvBKt1sUhYrCLyDkiKymQQM4Zk=;
	b=unQF25tH9ZCUyLz7szErmTX5618RYA3pN5ksq5kTsN/SHcSwAEXxLpBcAevZr9KDtyE7
	 wzlW+wntFof1A258m94JNme8gcix7e/9in9QRd462txKZfypcKvxk2gP0D+5vK4ZwGnSU
	 on3UOWuZQVvtxJNBXiO3FMwCELrGQ2LSEBLEptSmM8EApalHpdN70mxQAGFIoriWNWDwf
	 SoA2+wnyRalReA4+mVwbHap8rd7thxMkI2D7b94Hvt0/VQikfmcn2lf9+JcUDi/D5BpKE
	 gQz/fyKJ5RFs9nbYTKQnERcNDuVrl8dOFmKiJMyg/XaJnPf1GPee0txYLsD1HZJuWBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RbDFVO7t;
	arc=none smtp.remote-ip=43.163.128.43
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAB606A327;
	Wed, 25 Nov 2026 02:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EAB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RbDFVO7t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795575405; bh=+X+7O/JfBFYIxFx/cIvBKt1sUhYrCLyDkiKymQQM4Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RbDFVO7tWxwncK6Hpmqm2M7Yd8Zazp81Ar395EowibmlshRGp8WI4yrFdJTCn6o+z
	 AiTckfiBIZFHS0FKonJCyZHrU5Aunh+q2il5YwaMHi/mgnEKOldsct0rvRBl88Saa+
	 mEMOi0XxKnpjML1j0kTT5WZBVJvA4IZwQBqbk+l0=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575404tl7hsayi2
Message-ID: <tencent_1B16BF5F08239F427EE3510DC7973FF6AC09@qq.com>
X-QQ-XMAILINFO: NrBotaKjWOUd0p8FYOPg5FMxGeXZIiRC1yTjAVFfvF0FMpsGmgVGN7QP+8uv8G
	 Hx/1F7FHdyf5mddJxU1QaoCs1TggK6Wvm6k/TMvvGoeYMY351fwRFpRYZVDo1XKx2r+hAb0llZWQ
	 MYsPhmiWLH4OXhwr39TnW39F9QtwnI5JXBPtRZ+lshA7zpJRPnSHaZ+mLnNC+O8JjmJ+Urr+dnbo
	 uRz9JvAztvYrQdZ+PDQxTPtRgNxQntKTQEYfxBkOvcwB4I8UNWg4GKxTE10UTF0grV8dvWGjRkZm
	 Mb+rp7GG9sacnlfIeo1YqScJtOOKA8pF6RKgrykspzf8A9kpX0qk8Tg7Ctnf4hYvB1wVq6tH6HDk
	 vbkFzEUuyLYP0k9DmpCuPODKH1MgwXWaQjYe2ALzdWxp3GwJXcd3xtoxlioqtCyoHlwls6Zikeh/
	 HaLgM6dZ51h7fXkepQigkBzhkd9kkfue0Qa+2NBxaQuInwNqyL09Q/v+hEnR01RkQJACHpsMujUD
	 /ftXbFZomwWr881Y1sk//1nZxNQay+FME8DRHctgVehneoBUzpf/8K+KricqLWjEeuPATtMBZwbo
	 swkkN4X7Gb2ozanR7An/iD+A4W1x8i7abi5VkJhFXZE15FiU5UrehMf/jiYwioW+MaSccKIALJyC
	 x405HiMjzMS0rj9aFPf4+Fe0I3KeME8g8gIwUgBUzHmCykQxnXfcQhimm/bx2iNAGvztnVpXCvS7
	 n8VOx1jzuYMm7GiMhRZs2JyrgkK39Nd/Avq4qJ5plMLP+sz7h6PUFbyDEUWeXZkj5UBS+Ft/SrQc
	 XMZSjI2Suj92b4cYwoybynFe8U80GeS0ZQdNKQWM6W+ef0vP93BOotreivWph+64wjL7Q3SoCO9I
	 sSNVYtWAKOdQVBcF3JMcIK2EgLXMPD3MRTaKBoTbCf/zRaG4LjRc+U1T1K2XN//6iEmJEbnIcFdp
	 EJPf85wUTD2tHTVgxj01NiAKReti70d7VeuB1ffviGJq9mrs10kkRCkGBCeWllho3rGRfJow5sLQ
	 TDsDbbqanE2dfFulqN5hI7VY5recRIxUOrfKeUMZibree4ijtuW2nsy6kkChnOhX8HRv/kZqqNDy
	 WW1nD/djbkcDxBvZEjWA8Wn5qcftq5uKWkTpkmfXFljUPXTqX2W90U6mrWR8hsvEgzCNwn4zzbWg
	 9MRQVCUD8O6Mf8bA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v5 5/6] Input: add Jadard JD9365TX in-cell touchscreen driver
Date: Wed, 25 Nov 2026 10:56:37 +0800
X-OQ-MSGID: <20261125025638.1171-6-3066883572@qq.com>
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

Add a polling I2C driver for the JD9365TX in-cell touch controller.
Typical module FPCs expose I2C only, so the driver polls coordinate
SRAM after opening the controller backdoor.

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/input/touchscreen/Kconfig           |  12 +
 drivers/input/touchscreen/Makefile          |   1 +
 drivers/input/touchscreen/jadard_jd9365tx.c | 352 ++++++++++++++++++++
 3 files changed, 365 insertions(+)
 create mode 100644 drivers/input/touchscreen/jadard_jd9365tx.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index e2ee722..da425c8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -540,6 +540,18 @@ config TOUCHSCREEN_IPROC
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm_iproc_tsc.
 
+config TOUCHSCREEN_JADARD_JD9365TX
+	tristate "Jadard JD9365TX in-cell touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have a Jadard JD9365TX in-cell touchscreen.
+	  The driver polls over I2C when no interrupt line is wired.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called jadard_jd9365tx.
+
 config TOUCHSCREEN_S6SY761
 	tristate "Samsung S6SY761 Touchscreen driver"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 58094f2..5846f4d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_TOUCHSCREEN_IMAGIS)	+= imagis.o
 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+= imx6ul_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
 obj-$(CONFIG_TOUCHSCREEN_IPROC)		+= bcm_iproc_tsc.o
+obj-$(CONFIG_TOUCHSCREEN_JADARD_JD9365TX) += jadard_jd9365tx.o
 obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+= max11801_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MXS_LRADC)     += mxs-lradc-ts.o
diff --git a/drivers/input/touchscreen/jadard_jd9365tx.c b/drivers/input/touchscreen/jadard_jd9365tx.c
new file mode 100644
index 0000000..2d81062
--- /dev/null
+++ b/drivers/input/touchscreen/jadard_jd9365tx.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * Jadard JD9365TX in-cell touchscreen (I2C @0x68, polling).
+ * Typical DSI FPC has no interrupt line.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define JD_CHIP_ID			0x9084
+#define JD_CHIP_ID_ALT			0x9032
+#define JD_SOC_CHIP_ID2			0x40008076
+#define JD_ERAM_BASE			0x20011000
+#define JD_SECTION_READY_VAL		0xA55A
+#define JD_MAX_DSRAM_NUM		25
+#define JD_ESRAM_COORD_IDX		1
+#define JD_ESRAM_SECTION_NUM		6
+#define JD_DEFAULT_COORD_ADDR		0x20011120
+#define JD_TOUCH_DATA_SIZE		78
+#define JD_REPORT_MIN_SIZE		53
+#define JD_FINGER_DATA_SIZE		5
+#define JD_FINGER_NUM_ADDR		0
+#define JD_TOUCH_COORD_INFO_ADDR	3
+#define JD_MAX_POINTS			10
+#define JD_DEFAULT_POLL_MS		16
+
+struct jadard_tp {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	struct gpio_desc *reset;
+	u32 coord_addr;
+	u16 touch_data_size;
+	u16 max_points;
+	unsigned int poll_interval_ms;
+};
+
+static int jd_bus_write(struct i2c_client *client, const u8 *cmd, u8 cmd_len,
+			const u8 *data, u16 data_len)
+{
+	u8 buf[64];
+	struct i2c_msg msg;
+	int ret;
+
+	if (cmd_len + data_len > sizeof(buf))
+		return -EINVAL;
+
+	memcpy(buf, cmd, cmd_len);
+	if (data_len)
+		memcpy(buf + cmd_len, data, data_len);
+
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.len = cmd_len + data_len;
+	msg.buf = buf;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret == 1 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static int jd_bus_read(struct i2c_client *client, const u8 *cmd, u8 cmd_len,
+		       u8 *data, u16 data_len)
+{
+	struct i2c_msg msg[2];
+	int ret;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = cmd_len;
+	msg[0].buf = (u8 *)cmd;
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = data_len;
+	msg[1].buf = data;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	return ret == 2 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static int jd_enter_backdoor(struct i2c_client *client)
+{
+	const u8 cmd[5] = { 0xF2, 0xAA, 0xF0, 0x0F, 0x55 };
+	const u8 data = 0x68;
+
+	return jd_bus_write(client, cmd, sizeof(cmd), &data, 1);
+}
+
+static int jd_read_reg(struct i2c_client *client, u32 addr, u8 *rdata, u16 rlen)
+{
+	u8 cmd[6];
+
+	cmd[0] = 0xF3;
+	cmd[1] = (addr >> 24) & 0xFF;
+	cmd[2] = (addr >> 16) & 0xFF;
+	cmd[3] = (addr >> 8) & 0xFF;
+	cmd[4] = addr & 0xFF;
+	cmd[5] = 0x03;
+
+	return jd_bus_read(client, cmd, sizeof(cmd), rdata, rlen);
+}
+
+static int jd_get_chip_id(struct i2c_client *client, u16 *id)
+{
+	u8 rbuf[2];
+	int ret;
+
+	ret = jd_read_reg(client, JD_SOC_CHIP_ID2, rbuf, sizeof(rbuf));
+	if (ret)
+		return ret;
+
+	*id = (u16)((rbuf[1] << 8) | rbuf[0]);
+	return 0;
+}
+
+static bool jd_section_ready(struct i2c_client *client)
+{
+	u8 rbuf[2];
+	unsigned int waited = 0;
+
+	do {
+		msleep(2);
+		if (jd_read_reg(client, JD_ERAM_BASE, rbuf, sizeof(rbuf)))
+			return false;
+		waited += 2;
+		if (((rbuf[1] << 8) | rbuf[0]) == JD_SECTION_READY_VAL)
+			return true;
+	} while (waited < 100);
+
+	return false;
+}
+
+static int jd_resolve_coord_addr(struct jadard_tp *ts)
+{
+	u32 esram_num_addr = JD_ERAM_BASE + 4 + JD_MAX_DSRAM_NUM * 8;
+	u32 esram_sec_addr = esram_num_addr + 4;
+	u8 buf[JD_ESRAM_SECTION_NUM * 8];
+	u32 addr, len;
+	int ret;
+
+	ret = jd_read_reg(ts->client, esram_sec_addr, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	addr = get_unaligned_le32(&buf[JD_ESRAM_COORD_IDX * 8]);
+	len = get_unaligned_le32(&buf[JD_ESRAM_COORD_IDX * 8 + 4]);
+
+	if (len < JD_REPORT_MIN_SIZE || len > JD_TOUCH_DATA_SIZE ||
+	    addr < JD_ERAM_BASE ||
+	    addr > JD_ERAM_BASE + 0x1000 - len)
+		return -EINVAL;
+
+	ts->coord_addr = addr;
+	ts->touch_data_size = (u16)len;
+	return 0;
+}
+
+static int jd_hw_init(struct jadard_tp *ts)
+{
+	u16 chip_id = 0;
+	int ret;
+
+	ret = jd_enter_backdoor(ts->client);
+	if (ret)
+		return ret;
+
+	ret = jd_get_chip_id(ts->client, &chip_id);
+	if (ret)
+		return ret;
+
+	if (chip_id != JD_CHIP_ID && chip_id != JD_CHIP_ID_ALT)
+		return -ENODEV;
+
+	if (jd_section_ready(ts->client) && !jd_resolve_coord_addr(ts))
+		return 0;
+
+	ts->coord_addr = JD_DEFAULT_COORD_ADDR;
+	ts->touch_data_size = JD_TOUCH_DATA_SIZE;
+	return 0;
+}
+
+static void jd_report_touches(struct jadard_tp *ts, const u8 *buf)
+{
+	u8 finger_num = buf[JD_FINGER_NUM_ADDR];
+	unsigned int i;
+
+	/* Discard obviously invalid headers instead of clamping to max. */
+	if (finger_num > ts->max_points)
+		return;
+
+	for (i = 0; i < ts->max_points; i++) {
+		const u8 *c = buf + JD_TOUCH_COORD_INFO_ADDR +
+			      i * JD_FINGER_DATA_SIZE;
+		u16 x = get_unaligned_be16(c);
+		u16 y = get_unaligned_be16(c + 2);
+		u8 w = c[4];
+		bool down;
+
+		/*
+		 * Slots are fixed; inactive contacts report 0xFFFF/0xFFFF.
+		 * Do not gate on finger_num, or a lower slot lift drops a
+		 * still-active higher slot.
+		 */
+		down = x != 0xFFFF && y != 0xFFFF &&
+		       x <= ts->prop.max_x && y <= ts->prop.max_y;
+
+		input_mt_slot(ts->input, i);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, down);
+
+		if (down) {
+			touchscreen_report_pos(ts->input, &ts->prop, x, y, true);
+			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, w);
+		}
+	}
+
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
+}
+
+static void jd_poll(struct input_dev *input)
+{
+	struct jadard_tp *ts = input_get_drvdata(input);
+	u8 buf[JD_TOUCH_DATA_SIZE];
+	int ret;
+
+	ret = jd_read_reg(ts->client, ts->coord_addr, buf, ts->touch_data_size);
+	if (ret) {
+		/* Panel/power cycle drops backdoor mode; re-open it. */
+		if (jd_hw_init(ts))
+			return;
+		ret = jd_read_reg(ts->client, ts->coord_addr, buf,
+				  ts->touch_data_size);
+		if (ret)
+			return;
+	}
+
+	jd_report_touches(ts, buf);
+}
+
+static int jadard_tp_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct jadard_tp *ts;
+	struct input_dev *input;
+	static const char * const supplies[] = { "vdd", "iovcc" };
+	u32 val;
+	int error;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client = client;
+	ts->max_points = JD_MAX_POINTS;
+	ts->poll_interval_ms = JD_DEFAULT_POLL_MS;
+	ts->touch_data_size = JD_TOUCH_DATA_SIZE;
+	ts->coord_addr = JD_DEFAULT_COORD_ADDR;
+
+	error = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies),
+					       supplies);
+	if (error)
+		return error;
+
+	ts->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->reset))
+		return PTR_ERR(ts->reset);
+
+	if (ts->reset) {
+		gpiod_set_value_cansleep(ts->reset, 1);
+		msleep(10);
+		gpiod_set_value_cansleep(ts->reset, 0);
+		msleep(20);
+	}
+
+	error = jd_hw_init(ts);
+	if (error)
+		return error;
+
+	if (!device_property_read_u32(dev, "poll-interval", &val) &&
+	    val >= 8 && val <= 100)
+		ts->poll_interval_ms = val;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = "Jadard JD9365TX Touchscreen";
+	input->id.bustype = BUS_I2C;
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 719, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 1279, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(input, true, &ts->prop);
+
+	error = input_mt_init_slots(input, ts->max_points, INPUT_MT_DIRECT);
+	if (error)
+		return error;
+
+	input_set_drvdata(input, ts);
+	ts->input = input;
+	i2c_set_clientdata(client, ts);
+
+	error = input_setup_polling(input, jd_poll);
+	if (error)
+		return error;
+
+	input_set_poll_interval(input, ts->poll_interval_ms);
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct of_device_id jadard_tp_of_match[] = {
+	{ .compatible = "jadard,jd9365tx" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jadard_tp_of_match);
+
+static const struct i2c_device_id jadard_tp_id[] = {
+	{ .name = "jd9365tx" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, jadard_tp_id);
+
+static struct i2c_driver jadard_tp_driver = {
+	.driver = {
+		.name = "jadard-tp-jd9365tx",
+		.of_match_table = jadard_tp_of_match,
+	},
+	.probe = jadard_tp_probe,
+	.id_table = jadard_tp_id,
+};
+module_i2c_driver(jadard_tp_driver);
+
+MODULE_AUTHOR("Hefei <3066883572@qq.com>");
+MODULE_DESCRIPTION("Jadard JD9365TX in-cell touchscreen");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

