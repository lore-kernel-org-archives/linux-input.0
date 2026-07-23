Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B245D18D
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820212; cv=none; b=LB3ue14T0ac4cEYZmDfRl7kX1BMmOlIeGutboxAuts4d5tQIlsCbT2wF67IumDAXWSVe3TLjN8T+KCJJAdK6so/5vURUPG9PlXPdjrCcXtHV/RIbX2kdZatuLf1Q68kRrNYir2Qeqczb6F6jVzvZwMkusGc54gPdYK8gfLe3f7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820212; c=relaxed/simple;
	bh=IxfGdOD8c+bs/ofS0nPioWhzBnW302ku2so1VQ4QdXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW4UmJuWq8mJzeOrqDUsGNqBqKcyQN21qD/yQXa7im0/nd+UT++H8mKuf/VGa1l5rZq9sfjb0hZ2YdJj5iZ9usjP7klQGE+CNWCUid7kTEC4hMbqoUck/dhoSA7iHo2Rpz54Mv4uCVGllenqxnOebrGiZelNPOdbhJRkAygJatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=EIov3dK6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="EIov3dK6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c197eaaab00so140521766b.0
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1784820206; x=1785425006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Imh04o9mc49Waklr40dCWoXoSYRmEDG+6s9mmv06zbw=;
        b=EIov3dK6bac9lVV8Md9LULCBrJcH/c3MqTIfTVYGxkhVauxDZFcF799H3mAR+dweOF
         oQH7d6o+yd0qZYIbxMwRUNhvVLENOnznVNJzPaXcMWp+8JyO1wZMH1nKE5FQ4faMrl4d
         gYtnD84ogt+KbXJge2sODgzGlBkGU8T2pVPiUup4PEksX2F5dn3T80f06aqgtnhXf6zJ
         f7SJ4MePAQkAM3vuPeUQhPEHkz73NtOgS1f16eyJC7CmkV8HVgNvnQOwtjnP4gDD/Fse
         IIGTWbJaVEFLcfiw2jd5OQRy/UY8pApkoETMtCADx3PVvMVaYwzTX41H5eMWZ5ghZbSm
         hJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820206; x=1785425006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Imh04o9mc49Waklr40dCWoXoSYRmEDG+6s9mmv06zbw=;
        b=ARhPd5Xcb1XK8exY+Pl9tcxu/440OwoTSsvNNQGByY/kZEPG1/5S3Ro8Hwcx7OrJ8b
         UH6l19eBRf8Xzp53nrWw72x13ZxbIv0AsGLvIIsSSP9CQhelijrVD6gxTQRnFmscAtA+
         69tLk75vP15VPIr/Cg27EsNeE5MF9bFVi8/kLTozi/MH2NXF5775w8IxzCiWrV4caJr1
         rdvl2KPDuq+VdCZ2Y9Kqmc3LQwc/TWKEIVjJIZaXfBjZ5mHmFDOknrcddyePLEebEr40
         UscsBnJhHwMT8nPrEZ5Jb7S75oDh1BvWgY725OYzqNlJMvmymuY9ZVGb/ylli2RBsrTF
         iTLA==
X-Gm-Message-State: AOJu0YxXnd4gRu8W8ZQn82qUuidx0AY71rvsE5bS4IEZkpfOBMcXo9kq
	70P9wHkCk25eFMp7C5r1w4tpUiVONWAnj7Gu173WMczLGl08/lxlAzVw34+VGVyoOg==
X-Gm-Gg: AR+sD10TZgvSXHPMysu4uwqnWd5rqPLdSMzI9cYwfCJGSkCw4fGIRTz+711TqDhJIhU
	gUdGJzlSJ9xrPEOofK2OUKZCayQlFx/GXMMHbrniVX87X0UnvkXeYQ5y/bHu8Zd3r/9MXh9wk7G
	7wAVhzgjMKeBfcEdXe50IbTy6OIy5xUZM7oAaBSKjNSftjXnQZSEAmrKThpRzTKlanyAq5jUDUi
	AOXFy6KIT7sX2V1zYy1DNlCbeIU4cSv9jRPJCNRyUs5IV28Fhps1qyQDCQOPjkgJzuHnpcqutjW
	f6JeAQD5+ab+hkF5CBRZZEk+iXo9XeV6melOhSbtd33hf6etE+hCdFTDaVirinIgLZpwRKQeHbv
	3f3dn0EXb60bBiyYAq4Q35Szoj+/rRzPnH1zU0FZigbBUai0jlqJG7LB/+0FhLsxqDFyTIpBEmZ
	+CwbFXrPGoY39RD/e4NX67APGtf4evDZI/YnRfs+RVrgPC0NJ2oiaBTopLtqI+4tTX8HhH/Mz1W
	wIfyG5lk2TxmQFXZeW6T8PrkJ7JXX5q77Opyzay/g==
X-Received: by 2002:a17:906:9fce:b0:c12:83da:7eeb with SMTP id a640c23a62f3a-c1c50993672mr182744766b.19.1784820205559;
        Thu, 23 Jul 2026 08:23:25 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebb385sm250749666b.52.2026.07.23.08.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:23:25 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v3 1/3] Input: ilitek_ts: add stylus input support
Date: Thu, 23 Jul 2026 17:22:42 +0200
Message-ID: <20260723152244.11252-2-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723152244.11252-1-kristian@mide.dk>
References: <20260709182602.7308-1-kristian@mide.dk>
 <20260723152244.11252-1-kristian@mide.dk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a separate stylus input device for report ID 0x0c packets,
with pressure, hover, and side-button support.

The pen device is created lazily on first pen report so
touchscreen-only hardware does not expose stylus capabilities up
front.

The packet format is reverse engineered from a tested CHUWI
Hi10 Max. Pressure is reported from buf[6..7] shifted right by
one, matching the observed 1024 pressure levels on the tested
device.

Pen coordinates are reported through touchscreen_report_pos()
so the same axis inversion and swapping properties used by the
touch path apply to the stylus as well.

The pen device lifetime is managed explicitly so the IRQ is
removed before the lazy pen input device is unregistered during
driver teardown.

Use input_set_capability() for the pen key capabilities.

Signed-off-by: Kristian Mide <kristian@mide.dk>
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 137 +++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 3de0fbf8d..86975fa9a 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -37,6 +37,18 @@
 #define ILITEK_TP_CMD_GET_IC_MODE			0xC0
 
 #define ILITEK_TP_I2C_REPORT_ID				0x48
+/* Reverse engineered stylus report on a tested CHUWI Hi10 Max device. */
+#define ILITEK_PEN_I2C_REPORT_ID			0x0C
+#define ILITEK_PEN_PRESSURE_MAX			1023
+#define ILITEK_PEN_DISTANCE_MAX			2
+/* Userspace expects tablet axis resolution; with INPUT_PROP_DIRECT this is */
+/* mostly descriptive and does not materially affect event coordinates. */
+#define ILITEK_PEN_RESOLUTION			68
+
+#define ILITEK_PEN_FLAG_TOUCH			0x01
+#define ILITEK_PEN_FLAG_STYLUS2			0x02
+#define ILITEK_PEN_FLAG_STYLUS			0x08
+#define ILITEK_PEN_FLAG_PROX			0x10
 
 #define REPORT_COUNT_ADDRESS				61
 #define ILITEK_SUPPORT_MAX_POINT			40
@@ -50,6 +62,7 @@ struct ilitek_ts_data {
 	struct i2c_client		*client;
 	struct gpio_desc		*reset_gpio;
 	struct input_dev		*input_dev;
+	struct input_dev		*pen_input_dev;
 	struct touchscreen_properties	prop;
 
 	const struct ilitek_protocol_map *ptl_cb_func;
@@ -89,6 +102,9 @@ enum ilitek_cmds {
 	MAX_CMD_CNT
 };
 
+static int ilitek_pen_input_dev_init(struct device *dev,
+				      struct ilitek_ts_data *ts);
+
 /* ILITEK I2C R/W APIs */
 static int ilitek_i2c_write_and_read(struct ilitek_ts_data *ts,
 				     u8 *cmd, int write_len, int delay,
@@ -146,6 +162,54 @@ static void ilitek_touch_down(struct ilitek_ts_data *ts, unsigned int id,
 	touchscreen_report_pos(input, &ts->prop, x, y, true);
 }
 
+/*
+ * buf[1] carries prox/touch/side-button state and buf[6..7] carries
+ * pressure. A right shift by one matches the observed 1024 pressure levels.
+ */
+static int ilitek_process_pen_report(struct ilitek_ts_data *ts, u8 *buf)
+{
+	struct device *dev = &ts->client->dev;
+	struct input_dev *input = ts->pen_input_dev;
+	unsigned int x, y, z, distance;
+	bool prox, touch, stylus, stylus2;
+	int error;
+
+	if (!input) {
+		error = ilitek_pen_input_dev_init(dev, ts);
+		if (error) {
+			dev_err_ratelimited(dev,
+					    "failed to register pen input device: %d\n",
+					    error);
+			return 0;
+		}
+		input = ts->pen_input_dev;
+	}
+
+	x = get_unaligned_le16(buf + 2);
+	y = get_unaligned_le16(buf + 4);
+	z = get_unaligned_le16(buf + 6) >> 1;
+	prox = !!(buf[1] & ILITEK_PEN_FLAG_PROX);
+	touch = !!(buf[1] & ILITEK_PEN_FLAG_TOUCH);
+	stylus = !!(buf[1] & ILITEK_PEN_FLAG_STYLUS);
+	stylus2 = !!(buf[1] & ILITEK_PEN_FLAG_STYLUS2);
+	distance = prox ? (touch ? 0 : 1) : ILITEK_PEN_DISTANCE_MAX;
+	if (!touch)
+		z = 0;
+	else if (z > ILITEK_PEN_PRESSURE_MAX)
+		z = ILITEK_PEN_PRESSURE_MAX;
+
+	input_report_key(input, BTN_TOOL_PEN, prox || touch);
+	input_report_key(input, BTN_TOUCH, touch);
+	input_report_key(input, BTN_STYLUS, stylus);
+	input_report_key(input, BTN_STYLUS2, stylus2);
+	touchscreen_report_pos(input, &ts->prop, x, y, false);
+	input_report_abs(input, ABS_PRESSURE, z);
+	input_report_abs(input, ABS_DISTANCE, distance);
+	input_sync(input);
+
+	return 0;
+}
+
 static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 {
 	int error = 0;
@@ -164,6 +228,9 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		return error;
 	}
 
+	if (buf[0] == ILITEK_PEN_I2C_REPORT_ID)
+		return ilitek_process_pen_report(ts, buf);
+
 	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
 		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
 		return -EINVAL;
@@ -459,6 +526,58 @@ static int ilitek_read_tp_info(struct ilitek_ts_data *ts, bool boot)
 	return 0;
 }
 
+static int ilitek_pen_input_dev_init(struct device *dev, struct ilitek_ts_data *ts)
+{
+	struct input_dev *pen_input;
+	int error;
+
+	if (ts->pen_input_dev)
+		return 0;
+
+	/* No explicit pen capability probe is known; create on first pen report. */
+
+	pen_input = input_allocate_device();
+	if (!pen_input)
+		return -ENOMEM;
+
+	ts->pen_input_dev = pen_input;
+	pen_input->dev.parent = dev;
+	pen_input->name = "ilitek_ts_pen";
+	pen_input->id.bustype = BUS_I2C;
+
+	__set_bit(INPUT_PROP_DIRECT, pen_input->propbit);
+	input_set_capability(pen_input, EV_KEY, BTN_TOUCH);
+	input_set_capability(pen_input, EV_KEY, BTN_TOOL_PEN);
+	input_set_capability(pen_input, EV_KEY, BTN_STYLUS);
+	input_set_capability(pen_input, EV_KEY, BTN_STYLUS2);
+
+	input_set_abs_params(pen_input, ABS_X,
+			     input_abs_get_min(ts->input_dev, ABS_MT_POSITION_X),
+			     input_abs_get_max(ts->input_dev, ABS_MT_POSITION_X),
+			     0, 0);
+	input_set_abs_params(pen_input, ABS_Y,
+			     input_abs_get_min(ts->input_dev, ABS_MT_POSITION_Y),
+			     input_abs_get_max(ts->input_dev, ABS_MT_POSITION_Y),
+			     0, 0);
+	input_set_abs_params(pen_input, ABS_PRESSURE, 0,
+			     ILITEK_PEN_PRESSURE_MAX, 0, 0);
+	input_set_abs_params(pen_input, ABS_DISTANCE, 0,
+			     ILITEK_PEN_DISTANCE_MAX, 0, 0);
+	input_abs_set_res(pen_input, ABS_X, ILITEK_PEN_RESOLUTION);
+	input_abs_set_res(pen_input, ABS_Y, ILITEK_PEN_RESOLUTION);
+
+	error = input_register_device(pen_input);
+	if (error)
+		goto err_free_pen_input;
+
+	return 0;
+
+err_free_pen_input:
+	ts->pen_input_dev = NULL;
+	input_free_device(pen_input);
+	return error;
+}
+
 static int ilitek_input_dev_init(struct device *dev, struct ilitek_ts_data *ts)
 {
 	int error;
@@ -589,9 +708,8 @@ static int ilitek_ts_i2c_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_request_threaded_irq(dev, ts->client->irq,
-					  NULL, ilitek_i2c_isr, IRQF_ONESHOT,
-					  "ilitek_touch_irq", ts);
+	error = request_threaded_irq(ts->client->irq, NULL, ilitek_i2c_isr,
+				     IRQF_ONESHOT, "ilitek_touch_irq", ts);
 	if (error) {
 		dev_err(dev, "request threaded irq failed: %d\n", error);
 		return error;
@@ -600,6 +718,18 @@ static int ilitek_ts_i2c_probe(struct i2c_client *client)
 	return 0;
 }
 
+static void ilitek_ts_i2c_remove(struct i2c_client *client)
+{
+	struct ilitek_ts_data *ts = i2c_get_clientdata(client);
+
+	free_irq(client->irq, ts);
+
+	if (ts->pen_input_dev) {
+		input_unregister_device(ts->pen_input_dev);
+		ts->pen_input_dev = NULL;
+	}
+}
+
 static int ilitek_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -677,6 +807,7 @@ static struct i2c_driver ilitek_ts_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(ilitekts_acpi_id),
 	},
 	.probe = ilitek_ts_i2c_probe,
+	.remove = ilitek_ts_i2c_remove,
 	.id_table = ilitek_ts_i2c_id,
 };
 module_i2c_driver(ilitek_ts_i2c_driver);
-- 
2.54.0

