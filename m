Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F238C2D1
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572874; cv=none; b=W38h5DGFOV8DYwa4prh0szn7ARZM4992uevxPLUFJMZCgvwqH+Fj5/mkrnayxnEelClkQPf5CfZdBkfel/UaIyRtRgmoWa2PvnRP7bcesO8wtFdik+XousI36OBmJCSHROVnDo4ofE5lccY2tlOa8ATew1oPGSwKwHOx9/APl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572874; c=relaxed/simple;
	bh=OZZ0uXY7w70rIzw6rjXwFH+HHlSGepNSdY6J4Kmc6Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZseCGizKx85ecHon7hbGZ2uArZfcDjUwGppAxc5dbtrrOLaBkdc3zFrfx08eRyVue1Yo99U5tf4oqWvF7zjcVo3SmAO1KRKLfQjE1jG9e+WYHtwwH7//t+QTcGDlMvS+ikxmAuhKJLxVi9AwySbmSiwtFW+S4yW/Ebtxy3BQ2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGx1aH+0; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGx1aH+0"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so73553eec.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791572872; x=1792177672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lFPnL7OfTMUeQK3pRClGzPFCMP7OICjteJSXPNsOl40=;
        b=PGx1aH+0KGmb+WsL7RzqApB91ScEevGd1VZ9T16WFE9xkotZmHXM3xzU4Y6Spc9iut
         gl0LIhQcRqaknDr6ZoZDD+itQ4TM2/YmFWzrGRXxG5ZjlelvZPVYQCfld1geDN8ANtJ9
         yFoOtj1NhRO3MRQqOfBS7SnpW4shbs9QOQa+9Cg0FpON5f0oyNRaY08wc0Hlpe7hISBH
         wgD0KrbiLYl6DEY/nBhPGxyDeG0f1g++PzQnL2/8iu0Iqt4Ip8CN4Yodl6S0yi6owB4+
         MGZflKdtbnUrEWDjYrq70PYm9xqzsCDUnLBhmwt8j7U1TyQzqa5A9W4caNPJIkIfhpX1
         8D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791572872; x=1792177672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFPnL7OfTMUeQK3pRClGzPFCMP7OICjteJSXPNsOl40=;
        b=jSpynGGFoEPXFdw6wx33oS4C+4IbdzFe/f7HBwoFjwoA851DAAmnjCMtFM+iB0OdS/
         t1sM4dSvsz5xyLwoHl+43Ia5BNT3m6Ha+11o3BXx4qBD/K2rvOXMUkWBI7v4cPmLkEFc
         9iIifvr4NOLNdqp7s61EP+gL7vNAIyiLAcZ+fzuAgMI/PbfMdxXEu+u7VJs9nDeEngxX
         cHdHQG1QFu6/sBY1UL8UBrpkGhUEtWISUvdV5/GI/TMHHDg3k6mmywAyyZkl3f6uWJzY
         bG8ZMtT0xvUAQuJ88TWD78V9yZ5j4EwwviB7ZPnqTMwVuHj4aG9K6b11jk79pjp6R+kt
         40VQ==
X-Gm-Message-State: AFq9FYLEsRBR8CRj+pZgM9bk8Du+XTakcluQVQ/Me+m65AWpbIsJSoYG
	/lAxtAr7IpuJgBIwlbP7Xj/TRRJj66diKVgnSoPNVwLAlJ063ros/ubbT9Pj8afv
X-Gm-Gg: AYBFou1syluvmvufCjHR2Mhf6HHp4H4SDdsTrQvqdIrmacjrGhGFoyypdqd9cYHqER5
	S1jpbeiO474clmUYZlLfva2b3JIwU2p8+KfGMqyN/TGHKn61wfX6oby+lQ3AYbIabJaYc8eRKpu
	rikCSs9Rp/REP8cUtu/TqzdZhXz3WSevGwE4wBAWBlN4rK70MdiLwvmMrQb/XZXDPrHLdwJ1MtY
	GUGAv14PhiwdvIQX9s27K1e1+pWR40YmBNG/byvQBjAqeIhWsQvlJ67RXlEZUZVXZWx11pPZf1Y
	O4kjL5xBigxQvenC8vcJfwyBFmHCKZETtFP0ewz1q1XbpiTxtuSNwAsefBrHQZdWpWVCFEH5A+R
	pYuHCrpjfFDmSmrfg74GrAfb8xXkRBh4ejJZ9t3wq1fkO59cpNAnNcH9Seo1xdcoAEDcZuCccOp
	cQnzuTf1pM5eFZMPNiazpYd/5AlnvwcPcgjIJIDc9fygj+oQFcQsrXn4WqP2av2pmrWamDb7Oj+
	NEcCUS3LILUOAWu73IOFOz7p63zx1ovp7oglTgrituK4W3aBUcVANjr8zzTxQdA5lfru5lk
X-Received: by 2002:a05:7300:6ca1:b0:356:4c53:7928 with SMTP id 5a478bee46e88-3564c5379edmr2258323eec.35.1791572871720;
        Fri, 09 Oct 2026 12:07:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8725:99de:769c:1fe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm10191598eec.0.2026.10.09.12.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:07:50 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH 1/3] Input: wacom_w8001 - fix teardown order and device lifetime
Date: Fri,  9 Oct 2026 12:07:42 -0700
Message-ID: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In w8001_disconnect(), serio_close() was called before unregistering
the input devices. When input_unregister_device() calls w8001_close()
to shut down the hardware, w8001_command() fails because the serio
port is already closed, preventing W8001_CMD_STOP from reaching the
controller.

Additionally, w8001_connect() pre-allocated both pen_dev and touch_dev
upfront before serio_open() so w8001_interrupt() could dereference
them unconditionally, and then freed unused input devices mid-probe
without synchronizing with w8001_interrupt() when pen or touch was
absent. That created a race and use-after-free hazard with
w8001_interrupt(), as well as a double-free on the fail4 error path.

Fix these issues by guarding event reporting in w8001_interrupt()
against NULL device pointers, allocating and registering input devices
on demand after querying capabilities, synchronizing device pointer
publication and teardown with serio_pause_rx, and unregistering input
devices before closing the serio port in both disconnect and probe
error unwind paths.

Fixes: 66fd9385ee9c ("Input: wacom_w8001 - simplify w8001_remove")
Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen devices into two devices")
Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 341 +++++++++++++-----------
 1 file changed, 186 insertions(+), 155 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index d8d1cdc3f09e..1c48e2775214 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -302,7 +302,8 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 
 		if (w8001->pktlen == w8001->idx) {
 			w8001->idx = 0;
-			if (w8001->type != BTN_TOOL_PEN &&
+			if (w8001->touch_dev &&
+			    w8001->type != BTN_TOOL_PEN &&
 			    w8001->type != BTN_TOOL_RUBBER) {
 				parse_single_touch(w8001->data, &coord);
 				report_single_touch(w8001, &coord);
@@ -321,8 +322,10 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 			break;
 
 		w8001->idx = 0;
-		parse_pen_data(w8001->data, &coord);
-		report_pen_events(w8001, &coord);
+		if (w8001->pen_dev) {
+			parse_pen_data(w8001->data, &coord);
+			report_pen_events(w8001, &coord);
+		}
 		break;
 
 	/* control packet */
@@ -340,7 +343,8 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 	/* 2 finger touch packet */
 	case W8001_PKTLEN_TOUCH2FG - 1:
 		w8001->idx = 0;
-		parse_multi_touch(w8001);
+		if (w8001->touch_dev)
+			parse_multi_touch(w8001);
 		break;
 
 	default:
@@ -349,7 +353,9 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 		 * sends invalid data packets that are larger than
 		 * W8001_PKTLEN_TPCPEN. Let's start over again.
 		 */
-		if (!w8001->touch_dev && w8001->idx > W8001_PKTLEN_TPCPEN - 1)
+		if (!w8001->touch_dev &&
+		    (w8001->data[0] & W8001_TAB_MASK) != W8001_TAB_BYTE &&
+		    w8001->idx > W8001_PKTLEN_TPCPEN - 1)
 			w8001->idx = 0;
 	}
 
@@ -404,19 +410,6 @@ static void w8001_close(struct input_dev *dev)
 		w8001_command(w8001, W8001_CMD_STOP, false);
 }
 
-static int w8001_detect(struct w8001 *w8001)
-{
-	int error;
-
-	error = w8001_command(w8001, W8001_CMD_STOP, false);
-	if (error)
-		return error;
-
-	msleep(250);	/* wait 250ms before querying the device */
-
-	return 0;
-}
-
 static void w8001_append_suffix(char *dest, const char *suffix, size_t dest_sz)
 {
 	size_t used = strnlen(dest, dest_sz);
@@ -424,88 +417,54 @@ static void w8001_append_suffix(char *dest, const char *suffix, size_t dest_sz)
 	strscpy(dest + used, suffix, dest_sz - used);
 }
 
-static int w8001_setup_pen(struct w8001 *w8001, char *basename,
-			   size_t basename_sz)
+static bool w8001_detect_pen(struct w8001 *w8001,
+			     char *basename, size_t basename_sz,
+			     struct w8001_coord *coord)
 {
-	struct input_dev *dev = w8001->pen_dev;
-	struct w8001_coord coord;
 	int error;
 
-	/* penabled? */
 	error = w8001_command(w8001, W8001_CMD_QUERY, true);
 	if (error)
-		return error;
-
-	__set_bit(EV_KEY, dev->evbit);
-	__set_bit(EV_ABS, dev->evbit);
-	__set_bit(BTN_TOUCH, dev->keybit);
-	__set_bit(BTN_TOOL_PEN, dev->keybit);
-	__set_bit(BTN_TOOL_RUBBER, dev->keybit);
-	__set_bit(BTN_STYLUS, dev->keybit);
-	__set_bit(BTN_STYLUS2, dev->keybit);
-	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
-
-	parse_pen_data(w8001->response, &coord);
-	w8001->max_pen_x = coord.x;
-	w8001->max_pen_y = coord.y;
-
-	input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
-	input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
-	input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
-	input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
-	input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
-	if (coord.tilt_x && coord.tilt_y) {
-		input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
-		input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
-	}
+		return false;
 
+	parse_pen_data(w8001->response, coord);
+	w8001->max_pen_x = coord->x;
+	w8001->max_pen_y = coord->y;
 	w8001->id = 0x90;
 	w8001_append_suffix(basename, " Penabled", basename_sz);
 
-	return 0;
+	return true;
 }
 
-static int w8001_setup_touch(struct w8001 *w8001, char *basename,
-			     size_t basename_sz)
+static bool w8001_detect_touch(struct w8001 *w8001,
+			       char *basename, size_t basename_sz,
+			       struct w8001_touch_query *touch)
 {
-	struct input_dev *dev = w8001->touch_dev;
-	struct w8001_touch_query touch;
 	int error;
 
-
-	/* Touch enabled? */
 	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
 	if (error)
-		return error;
+		return false;
+
 	/*
 	 * Some non-touch devices may reply to the touch query. But their
 	 * second byte is empty, which indicates touch is not supported.
 	 */
 	if (!w8001->response[1])
-		return -ENXIO;
+		return false;
 
-	__set_bit(EV_KEY, dev->evbit);
-	__set_bit(EV_ABS, dev->evbit);
-	__set_bit(BTN_TOUCH, dev->keybit);
-	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
-
-	parse_touchquery(w8001->response, &touch);
-	w8001->max_touch_x = touch.x;
-	w8001->max_touch_y = touch.y;
+	parse_touchquery(w8001->response, touch);
+	w8001->max_touch_x = touch->x;
+	w8001->max_touch_y = touch->y;
 
 	if (w8001->max_pen_x && w8001->max_pen_y) {
 		/* if pen is supported scale to pen maximum */
-		touch.x = w8001->max_pen_x;
-		touch.y = w8001->max_pen_y;
-		touch.panel_res = W8001_PEN_RESOLUTION;
+		touch->x = w8001->max_pen_x;
+		touch->y = w8001->max_pen_y;
+		touch->panel_res = W8001_PEN_RESOLUTION;
 	}
 
-	input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
-	input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
-	input_abs_set_res(dev, ABS_X, touch.panel_res);
-	input_abs_set_res(dev, ABS_Y, touch.panel_res);
-
-	switch (touch.sensor_id) {
+	switch (touch->sensor_id) {
 	case 0:
 	case 2:
 		w8001->pktlen = W8001_PKTLEN_TOUCH93;
@@ -523,24 +482,6 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 
 	case 5:
 		w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
-
-		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
-		error = input_mt_init_slots(dev, 2, 0);
-		if (error) {
-			dev_err(&w8001->serio->dev,
-				"failed to initialize MT slots: %d\n", error);
-			return error;
-		}
-
-		input_set_abs_params(dev, ABS_MT_POSITION_X,
-					0, touch.x, 0, 0);
-		input_set_abs_params(dev, ABS_MT_POSITION_Y,
-					0, touch.y, 0, 0);
-		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
-					0, MT_TOOL_MAX, 0, 0);
-		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
-		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
-
 		w8001_append_suffix(basename, " 2FG", basename_sz);
 		if (w8001->max_pen_x && w8001->max_pen_y)
 			w8001->id = 0xE3;
@@ -550,13 +491,19 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 	}
 
 	w8001_append_suffix(basename, " Touchscreen", basename_sz);
-
-	return 0;
+	return true;
 }
 
-static void w8001_set_devdata(struct input_dev *dev, struct w8001 *w8001,
-			      struct serio *serio)
+static struct input_dev *w8001_allocate_device(struct w8001 *w8001,
+					       const char *name)
 {
+	struct input_dev *dev;
+
+	dev = input_allocate_device();
+	if (!dev)
+		return NULL;
+
+	dev->name = name;
 	dev->phys = w8001->phys;
 	dev->id.bustype = BUS_RS232;
 	dev->id.product = w8001->id;
@@ -565,28 +512,139 @@ static void w8001_set_devdata(struct input_dev *dev, struct w8001 *w8001,
 	dev->open = w8001_open;
 	dev->close = w8001_close;
 
-	dev->dev.parent = &serio->dev;
+	dev->dev.parent = &w8001->serio->dev;
+
+	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
+	input_set_capability(dev, EV_KEY, BTN_TOUCH);
 
 	input_set_drvdata(dev, w8001);
+
+	return dev;
+}
+
+static int w8001_setup_pen(struct w8001 *w8001, const char *basename,
+			   const struct w8001_coord *coord)
+{
+	struct input_dev *dev;
+	int error;
+
+	snprintf(w8001->pen_name, sizeof(w8001->pen_name), "%s Pen", basename);
+
+	dev = w8001_allocate_device(w8001, w8001->pen_name);
+	if (!dev)
+		return -ENOMEM;
+
+	__set_bit(BTN_TOOL_PEN, dev->keybit);
+	__set_bit(BTN_TOOL_RUBBER, dev->keybit);
+	__set_bit(BTN_STYLUS, dev->keybit);
+	__set_bit(BTN_STYLUS2, dev->keybit);
+
+	input_set_abs_params(dev, ABS_X, 0, coord->x, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, coord->y, 0, 0);
+	input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
+	input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
+	input_set_abs_params(dev, ABS_PRESSURE, 0, coord->pen_pressure, 0, 0);
+	if (coord->tilt_x && coord->tilt_y) {
+		input_set_abs_params(dev, ABS_TILT_X, 0, coord->tilt_x, 0, 0);
+		input_set_abs_params(dev, ABS_TILT_Y, 0, coord->tilt_y, 0, 0);
+	}
+
+	scoped_guard(serio_pause_rx, w8001->serio)
+		w8001->pen_dev = dev;
+
+	error = input_register_device(dev);
+	if (error)
+		goto err_unpublish_dev;
+
+	return 0;
+
+err_unpublish_dev:
+	scoped_guard(serio_pause_rx, w8001->serio)
+		w8001->pen_dev = NULL;
+	input_free_device(dev);
+	return error;
+}
+
+static int w8001_setup_touch(struct w8001 *w8001, const char *basename,
+			     const struct w8001_touch_query *touch)
+{
+	struct input_dev *dev;
+	int error;
+
+	snprintf(w8001->touch_name, sizeof(w8001->touch_name), "%s Finger", basename);
+
+	dev = w8001_allocate_device(w8001, w8001->touch_name);
+	if (!dev)
+		return -ENOMEM;
+
+	input_set_abs_params(dev, ABS_X, 0, touch->x, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, touch->y, 0, 0);
+	input_abs_set_res(dev, ABS_X, touch->panel_res);
+	input_abs_set_res(dev, ABS_Y, touch->panel_res);
+
+	if (touch->sensor_id == 5) {
+		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
+		error = input_mt_init_slots(dev, 2, 0);
+		if (error) {
+			dev_err(&w8001->serio->dev,
+				"failed to initialize MT slots: %d\n", error);
+			goto err_free_dev;
+		}
+
+		input_set_abs_params(dev, ABS_MT_POSITION_X, 0, touch->x, 0, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, touch->y, 0, 0);
+		input_set_abs_params(dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
+		input_abs_set_res(dev, ABS_MT_POSITION_X, touch->panel_res);
+		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch->panel_res);
+	}
+
+	scoped_guard(serio_pause_rx, w8001->serio)
+		w8001->touch_dev = dev;
+
+	error = input_register_device(dev);
+	if (error)
+		goto err_unpublish_dev;
+
+	return 0;
+
+err_unpublish_dev:
+	scoped_guard(serio_pause_rx, w8001->serio)
+		w8001->touch_dev = NULL;
+err_free_dev:
+	input_free_device(dev);
+	return error;
 }
 
 /*
  * w8001_disconnect() is the opposite of w8001_connect()
  */
 
+static void w8001_unregister_devices(struct w8001 *w8001)
+{
+	struct input_dev *pen_dev = NULL;
+	struct input_dev *touch_dev = NULL;
+
+	scoped_guard(serio_pause_rx, w8001->serio) {
+		swap(pen_dev, w8001->pen_dev);
+		swap(touch_dev, w8001->touch_dev);
+	}
+
+	if (pen_dev)
+		input_unregister_device(pen_dev);
+	if (touch_dev)
+		input_unregister_device(touch_dev);
+}
+
 static void w8001_disconnect(struct serio *serio)
 {
 	struct w8001 *w8001 = serio_get_drvdata(serio);
 
+	w8001_unregister_devices(w8001);
+
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 
-	if (w8001->pen_dev)
-		input_unregister_device(w8001->pen_dev);
-	if (w8001->touch_dev)
-		input_unregister_device(w8001->touch_dev);
 	kfree(w8001);
-
-	serio_set_drvdata(serio, NULL);
 }
 
 /*
@@ -598,22 +656,17 @@ static void w8001_disconnect(struct serio *serio)
 static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct w8001 *w8001;
-	struct input_dev *input_dev_pen;
-	struct input_dev *input_dev_touch;
+	struct w8001_coord coord;
+	struct w8001_touch_query touch;
 	char basename[64] = "Wacom Serial";
-	int err, err_pen, err_touch;
+	bool has_pen, has_touch;
+	int err;
 
 	w8001 = kzalloc_obj(*w8001);
-	input_dev_pen = input_allocate_device();
-	input_dev_touch = input_allocate_device();
-	if (!w8001 || !input_dev_pen || !input_dev_touch) {
-		err = -ENOMEM;
-		goto fail1;
-	}
+	if (!w8001)
+		return -ENOMEM;
 
 	w8001->serio = serio;
-	w8001->pen_dev = input_dev_pen;
-	w8001->touch_dev = input_dev_touch;
 	mutex_init(&w8001->mutex);
 	init_completion(&w8001->cmd_done);
 	snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->phys);
@@ -621,66 +674,44 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	serio_set_drvdata(serio, w8001);
 	err = serio_open(serio, drv);
 	if (err)
-		goto fail2;
+		goto err_free_w8001;
 
-	err = w8001_detect(w8001);
+	err = w8001_command(w8001, W8001_CMD_STOP, false);
 	if (err)
-		goto fail3;
+		goto err_close_serio;
+
+	msleep(250);	/* wait 250ms before querying the device */
 
-	/* For backwards-compatibility we compose the basename based on
+	/*
+	 * For backwards-compatibility we compose the basename based on
 	 * capabilities and then just append the tool type
 	 */
-	err_pen = w8001_setup_pen(w8001, basename, sizeof(basename));
-	err_touch = w8001_setup_touch(w8001, basename, sizeof(basename));
-	if (err_pen && err_touch) {
+	has_pen = w8001_detect_pen(w8001, basename, sizeof(basename), &coord);
+	has_touch = w8001_detect_touch(w8001, basename, sizeof(basename), &touch);
+	if (!has_pen && !has_touch) {
 		err = -ENXIO;
-		goto fail3;
+		goto err_close_serio;
 	}
 
-	if (!err_pen) {
-		snprintf(w8001->pen_name, sizeof(w8001->pen_name),
-			 "%s Pen", basename);
-		input_dev_pen->name = w8001->pen_name;
-
-		w8001_set_devdata(input_dev_pen, w8001, serio);
-
-		err = input_register_device(w8001->pen_dev);
+	if (has_pen) {
+		err = w8001_setup_pen(w8001, basename, &coord);
 		if (err)
-			goto fail3;
-	} else {
-		input_free_device(input_dev_pen);
-		input_dev_pen = NULL;
-		w8001->pen_dev = NULL;
+			goto err_close_serio;
 	}
 
-	if (!err_touch) {
-		snprintf(w8001->touch_name, sizeof(w8001->touch_name),
-			 "%s Finger", basename);
-		input_dev_touch->name = w8001->touch_name;
-
-		w8001_set_devdata(input_dev_touch, w8001, serio);
-
-		err = input_register_device(w8001->touch_dev);
+	if (has_touch) {
+		err = w8001_setup_touch(w8001, basename, &touch);
 		if (err)
-			goto fail4;
-	} else {
-		input_free_device(input_dev_touch);
-		input_dev_touch = NULL;
-		w8001->touch_dev = NULL;
+			goto err_close_serio;
 	}
 
 	return 0;
 
-fail4:
-	if (w8001->pen_dev)
-		input_unregister_device(w8001->pen_dev);
-fail3:
+err_close_serio:
+	w8001_unregister_devices(w8001);
 	serio_close(serio);
-fail2:
+err_free_w8001:
 	serio_set_drvdata(serio, NULL);
-fail1:
-	input_free_device(input_dev_pen);
-	input_free_device(input_dev_touch);
 	kfree(w8001);
 	return err;
 }
-- 
2.56.0.385.gd3acb90ef8-goog

