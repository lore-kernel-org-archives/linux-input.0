Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB14DD6CB
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621604; cv=none; b=uVx8dIg2f7JO6LpYkaCdXcg5tJwQGs5n2cO53x0Ppued43CErYjAcVkHhWHMkFGV38m6MWgdT9im04CGsVjTtKXpFRsZ52KKuRCXMbqyO42ETM3iA0R1F7iDFIdsg4Ijgqq6rj7UOa7FRR+Qbqp5clb5WzHO8TSyPWpqguJvcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621604; c=relaxed/simple;
	bh=Lqaji5ph0czeuCeP3y9/bFSkMdWLs2ccp9kNJZt5LgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghACBHlEuFQVm8rRCpXKCS+IF/f1SAIBBBv3Mw3RB+cFwFWyTFQV/Pcn5e+xlqhrwtt5bqRX2jTr4QseqwQa4ordYQ239m+4YtCQL50LLvBv1kjm+Jvv86Csyack1ziJjwqKF9uJUqN4cUiRUi2xllgK4p3CxYbocsEHt4ZKXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=E4vsL43e; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="E4vsL43e"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso164650a12.2
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1783621600; x=1784226400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KL7Xx6G+0pkMQ9dY+CzbGjxkPtIIITSgsRBX8uxIyc=;
        b=E4vsL43eJFcUoZxL31PYdD5r8BYAc44pChuO/ixAWzwG7KiWMIXgcyL2jzueCviZO2
         CVW2nQTV0PMgmyAtCaHJfTPQ1R5keaYRDKm95YmIvbP+FSs94RwLskLTx2Ygcfio6xeE
         hxBWQMdG2lIZTAKONZZwyiIij0EggVrm8MXRVlEWdjKEG0ulQ8f5p5RCQsqdED/I37/R
         bE6YNHrrbeoL+XPMuDPgl5lwS+BRe+Sjuxe9TMnUUbvgUPViTgJ1FU8+FBW24mFd7tyi
         jJ8K1k1She20NlXL6VGvpqHJIatr2XOhIlQSuqQG5uEv21kkt/rnxHYkHJnLdgBKs6BQ
         zaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621600; x=1784226400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2KL7Xx6G+0pkMQ9dY+CzbGjxkPtIIITSgsRBX8uxIyc=;
        b=sPz3lQQDH/2favJPdKBQgZnqpJyu9C9wDDn08PeSxbAKacjwKRgqY64KTfoDlU+wk0
         Ye2Pm40k/P+xa/DczurtE3EfNN79NKZiTVQlVhnutGhuMMxs1qCNOng/WiFRNiIMV9g7
         s/Zoe4aeBBW89s1Nek98CBSoe5TzMjLxvhReBXOHwpVPQvR9mvhmwnWfo3EHb1VG5e13
         Pi5B5yq192lLj4rWzHaiYz+dKuSVdoLrYuSgfK7QEXhgMvOFVBPeKS+e9GzRebJUqZ1q
         yNJth5XyMtkJg9l6aC+0A+TqMP8q4aICtvWsjo4gk+rMB77m88R1SuaAs89K77XYYeSj
         Saag==
X-Gm-Message-State: AOJu0YwWiRpI2Frf48Va+yCSzfkR3BfvazHziIPM4JN3kISoXJAwSfH2
	ClHqRQIqNZ1W1qJx/jUkxOa2qLhpTU8zrT67HL7GVSA4zL1CC/0hewXeERVxv7XEWvGF6JI8Fmy
	gzlApjA==
X-Gm-Gg: AfdE7ckCoSKutewgZZksVA1X5PccuZ0jNQQdj3MEjDDFAvw2tBoK1svcMiWoiufSV9Q
	iVoDDCohewXTdsNeW2OEc6tj/Eq6VVSndmL6+UUyLgouKbxVOriiPiXoqrsbJIlMPFRzWjq9G9Q
	53ialyDHI7lWZW0p9TJe9vh77ZI8gFohrg27VxFcZFvdjGoIWdv3MLvNUOrJdw9UNptCsdsL+wK
	EqIAeqrFLKzpKtuqNkbCRU7re/2zl2PoE7xJv7cLBDmNhhnvJUyST32YjBvIZANoQiHIJvKLQ9K
	Dv4cxtokcR74NuR3I3ESSQqaE5cIqW4XA2YHkpUs0xDJNNsLi2PcyBgZuE52sLMF6S/9yedWaQ0
	I1SSSs+esTQv3yYlypJvVF+pkaDYn0Tgq0yOkCBC/PyNv2s+Y2jAiOcuDGFdSjSbTookSJnFyvD
	oXtnj67aeWDoGM7JXBj8HOdQvuBgWO9csLEN/lUlAOXxkB5nXb/Dlb2yapW5AwT8FkiTg/18vR1
	/H3A1NQuUzqVaR8LbrzaXQBSbkiAcmRbXDDPz7FCvT1sN+k6YtPu8w+Brw+NpQ=
X-Received: by 2002:a05:6402:4583:b0:69a:9355:d1d6 with SMTP id 4fb4d7f45d1cf-69ab44d55bemr3425081a12.42.1783621599553;
        Thu, 09 Jul 2026 11:26:39 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19dbee72sm9934268a12.30.2026.07.09.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:26:38 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v2 1/3] Input: ilitek_ts: add stylus input support
Date: Thu,  9 Jul 2026 20:26:00 +0200
Message-ID: <20260709182602.7308-2-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709182602.7308-1-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260709182602.7308-1-kristian@mide.dk>
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
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 139 +++++++++++++++++++++-
 1 file changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 3de0fbf8d..54e39721f 100644
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
@@ -459,6 +526,60 @@ static int ilitek_read_tp_info(struct ilitek_ts_data *ts, bool boot)
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
+	__set_bit(EV_KEY, pen_input->evbit);
+	__set_bit(EV_ABS, pen_input->evbit);
+	__set_bit(BTN_TOUCH, pen_input->keybit);
+	__set_bit(BTN_TOOL_PEN, pen_input->keybit);
+	__set_bit(BTN_STYLUS, pen_input->keybit);
+	__set_bit(BTN_STYLUS2, pen_input->keybit);
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
@@ -589,9 +710,8 @@ static int ilitek_ts_i2c_probe(struct i2c_client *client)
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
@@ -600,6 +720,18 @@ static int ilitek_ts_i2c_probe(struct i2c_client *client)
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
@@ -677,6 +809,7 @@ static struct i2c_driver ilitek_ts_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(ilitekts_acpi_id),
 	},
 	.probe = ilitek_ts_i2c_probe,
+	.remove = ilitek_ts_i2c_remove,
 	.id_table = ilitek_ts_i2c_id,
 };
 module_i2c_driver(ilitek_ts_i2c_driver);
-- 
2.54.0

