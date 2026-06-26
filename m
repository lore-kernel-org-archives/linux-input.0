Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533B3C0A04
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510201; cv=none; b=JBc6EmxAbfDfTzuT1fGbjbs3PDLViU1tsZdK6efS+c2XvXJDerYUvSaVaqYMSAm/BArNRbmAAOlj2b1GzttwGXrlnwqNqZKFosszwoMXqClyLRvst8+npAHyqCoPZVyFH2/My8pjBlM2MS1ZA/0G+nlbkPF1nxyR1D1Q1XsY+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510201; c=relaxed/simple;
	bh=evqQo3/dPwr8yXOflJyr71GXr6VBmsqzw8Vrj/PrKvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHbf7CCXXYEuPk510t4bFYO78RLPIBeGf6PB52Z2iHENuSnkltzZyPy/k1izuHtw/th1VvV9RDhrJjnvbt0ELUX98TPV7inz1g1vwOyHjKp6vWeEHiXOL6NWeDUjxSX6/FsVOXZ+fOF6hiDzYuE1sE2Am80s2gusf88pffkdXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=aqu/HRAU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="aqu/HRAU"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6980ae819f4so2753283a12.0
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1782510198; x=1783114998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO9VkXX0pS5+fEgVbf5vk8CknzA91xW+amEwRbRlupw=;
        b=aqu/HRAU51KWdb0u2MY9PQSnb4lPq3HFc3mW7mIDrbsQdINNwnkXDCc2IMAh/Pjeg3
         TsG61I8jk3epdfFMVldq8AeqUuuYxD5GV7r80qC/AyZ/5lNpIec/rQ5BkF0OiQX8mFRd
         GO6Z+VDkKLitJGBsoHNhPvTYRDFu49YZrIRX5UlMGpWCj/b0OTkl7tUk9kgQMatYf4yF
         wBd3j0gTTo4wbQYMfPI1eAgXfBzge4Y1D78qMl/I5QqN+SNKz4gK0kDZRnCcNoIXk8XQ
         2nT70xEvvB3bn8GWPVLMvgvZfOXPxUYcyO9Q4fziLSgDQPouLxlwsIoiFpDpsUkam+0h
         W7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510198; x=1783114998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gO9VkXX0pS5+fEgVbf5vk8CknzA91xW+amEwRbRlupw=;
        b=krhmluynfbFpfUcqssizbmY1JHoq1O1e6T3nPR87PqKQO4xtOvQVoFxhltqisCaRme
         kwJ6xl2HiiKDMoNjVO8ozQPwStfKBVCItRiJOFBAeDn+qcRdAdTnTiiG+7+PxI253388
         SRnAahl8C3zaG1aqyQyrljMjR8ucU/S31nP1q/V8hJHOIOiRF1ZC26klbeIk/c3gSEvN
         /M6h4IGxHWayUR2pA35iV0Ajrc3CR/fvCy+hZVKtOtYrX2nGGov6rHNDijK5ywtu0DHi
         HjRwdp5icvIE84807LgwysXfsTCi71HfbYk3x7jfryMNUYy+EP/OFl+3dUOWt+A0DuH7
         t9VA==
X-Gm-Message-State: AOJu0Yz/SpDOTOEK5LkskR50BZlfVyRzogQnZJLKo6n6q4tjgMe7y+ex
	S+k2ucOv7iPkPKqKtKfulc4R+sZpP0Zfd5DH88A6KSv1++3/fl4mf7Kbky8ZzjU2hA==
X-Gm-Gg: AfdE7cmtqCYdVVVIqBGJYMEtPCOEbUdBeC+JSCRPAPb/7+MzEsUuavm0DUkGQ/KE3UD
	5+xQRJnhYi6U60qDaMFmuDI1jHd+IN7VjFJSULvA16OO6d34ICgtJMHLXtAjtru9k2nEIshyuEc
	TARUGwBbBG7Z8m4pP2MJ88VVSe5fFN58iHf7LRGv2s0TfLPcD/SqBQhtBi9uIKiiQEeXPykyFOW
	Kp+4PA9rfZeBD77m7naQvO02X+kgJZYqDdETpSy2j3UOG/1offmXkRXHmQmaHwNCvuVFhwOkvSZ
	OtfsG82NYzCe5Sk1m0LP0fEfqsVVC16J4OzxBByCJPuHbcnqvXUMNVR6q4XzLPBwsOyKHTp6/SX
	Cf97otjydxNYSpI9K98xFrw/XbAeObHbZs0kU4woFI/79npJRCpOUWBkphWCJBCCGHIt8qVQDUK
	/iPONRS54Dgcic/fAVjyw65p0SMGA/ApyWJFNRkc+JNSSKaPxKzhvxdkFapJ96KAMoOfqp4oJOX
	wo6KnUa4jG74v3dCskJvRUmHw==
X-Received: by 2002:a05:6402:13d3:b0:698:5d0:2a61 with SMTP id 4fb4d7f45d1cf-69810163478mr2988181a12.0.1782510198008;
        Fri, 26 Jun 2026 14:43:18 -0700 (PDT)
Received: from localhost.localdomain (78-31-252-186.static.kviknet.net. [78.31.252.186])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aece6dsm3385821a12.12.2026.06.26.14.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:43:17 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH 1/2] Input: ilitek_ts: add stylus input support
Date: Fri, 26 Jun 2026 23:42:47 +0200
Message-ID: <20260626214248.5563-2-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626214248.5563-1-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
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
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 130 ++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 3de0fbf8d..f0721af02 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -18,6 +18,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/errno.h>
 #include <linux/acpi.h>
+#include <linux/device/devres.h>
 #include <linux/input/touchscreen.h>
 #include <linux/unaligned.h>
 
@@ -37,6 +38,18 @@
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
@@ -50,6 +63,7 @@ struct ilitek_ts_data {
 	struct i2c_client		*client;
 	struct gpio_desc		*reset_gpio;
 	struct input_dev		*input_dev;
+	struct input_dev		*pen_input_dev;
 	struct touchscreen_properties	prop;
 
 	const struct ilitek_protocol_map *ptl_cb_func;
@@ -89,6 +103,9 @@ enum ilitek_cmds {
 	MAX_CMD_CNT
 };
 
+static int ilitek_pen_input_dev_init(struct device *dev,
+				      struct ilitek_ts_data *ts);
+
 /* ILITEK I2C R/W APIs */
 static int ilitek_i2c_write_and_read(struct ilitek_ts_data *ts,
 				     u8 *cmd, int write_len, int delay,
@@ -146,6 +163,62 @@ static void ilitek_touch_down(struct ilitek_ts_data *ts, unsigned int id,
 	touchscreen_report_pos(input, &ts->prop, x, y, true);
 }
 
+static void ilitek_unregister_pen_input(void *data)
+{
+	struct ilitek_ts_data *ts = data;
+
+	input_unregister_device(ts->pen_input_dev);
+	ts->pen_input_dev = NULL;
+}
+
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
@@ -164,6 +237,9 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		return error;
 	}
 
+	if (buf[0] == ILITEK_PEN_I2C_REPORT_ID)
+		return ilitek_process_pen_report(ts, buf);
+
 	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
 		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
 		return -EINVAL;
@@ -459,6 +535,60 @@ static int ilitek_read_tp_info(struct ilitek_ts_data *ts, bool boot)
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
+			     ts->screen_min_x, ts->screen_max_x, 0, 0);
+	input_set_abs_params(pen_input, ABS_Y,
+			     ts->screen_min_y, ts->screen_max_y, 0, 0);
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
+	error = devm_add_action_or_reset(dev, ilitek_unregister_pen_input, ts);
+	if (error)
+		return error;
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
-- 
2.54.0

