Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217483;
	b=QgJH/qrNnhoT6sYHlc4pbMyoZie4Uw+NifYk4Jz92+rkOnZEFlOV2H2tYxQoCgAKO/aT
	 tHUYQAIvnVyrbqAFqIHdrJJT1GWHcf4xecDM7iW14r/aEazwMON+LOkA541tsXY2BY46v
	 rPtzeNQ7Z7NHng9Mvrl0svfJx3FbyA2vHg5YfFIx1oLSdIazbXX3WOnSpYmEiu9G3ElQo
	 XMXtq90dJasIV0fYhyGrfy9cQi7vIn310QxhcrXoPfIaJi1h0MDa0onmmtg2L9Xtw3/RE
	 lk/rw0POc8so/xsv5g4NUYlwWCUkXHmcljloAuci+YK4ZGFUY0Tv2P8m5+TmWF8a1lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=W8ajPa61qLbRbu2px572/0QmwG9CerOEFMibBPl4Dkg=;
	b=DIWqeKkljZp8EY+WClHAnImCkpMqBQDKrfH8OkDJPNClLLUL5x7yUdjOaCcX/TdFYfPq
	 aElIedye5rum+BKwVN8GZk65bCR9N1+UdCPwScQUNjam1q9qZsot1i9jdqDzy/SJpHCug
	 Gm84YLGX13gFJ1TO93rOtvRnleIdhc9ew1ehuUvrEl6RkgOLN/9EVz4extv8V/+GFc4RX
	 0PiOpz+95ps+GQ6XxMK9C/hnviDLpPyQrr7cy17kgpRJuUrFBMvA5Qkq6RNggQUntdV14
	 KH3tWroXKVbzjvNC2eh4lUcKVO6tlSAxmwAzB9K1PPinXXIsP9Si8le4nB4m7I0yykQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uFFOqLjY;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F564606D810
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 09:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F564606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uFFOqLjY
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c411e139259so61443266b.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 01:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217481; x=1794822281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8ajPa61qLbRbu2px572/0QmwG9CerOEFMibBPl4Dkg=;
        b=uFFOqLjYbxtxCdGUrDysJLaT4598O5TrWxQMOBgKxYgAxlnLoAr+qyOieQ6xWhuZZu
         Pvcmo8biv0U7+AU8vLHPbaRW3pOT2nSC+MGYEEJDDsFNJheGojve2UDbofH00Dk/Isjt
         5CvyLLUwqX+/W/vLCMl7+2GMpZAHX0gvNzh6NVZi0K0GXQDG9mT4mCvh4oCzCJ6A+m4K
         sO3JDCyBpx2TXizrTv/mCfIKlsQTbxO/zq1XTXHJGbiFU3p4HPStcGzOVxLS3BqE3AMP
         NFUeW1MUPNewyGpiyRAJFiroT9sQeV+KloWr07DT8v3ECcxpCiwXZGvJ3YK6F2WoEwH5
         2TjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217481; x=1794822281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8ajPa61qLbRbu2px572/0QmwG9CerOEFMibBPl4Dkg=;
        b=ksxeZeRL+2Jl1QqYAG7nM1Sesp4yHOVZt0LEe1dCOukW5Q6aEnDmGdFlfvaDiNn7St
         hSHFcZhFQA7xR5CqCZ9n/zUegS78THGorD6jIwq7Zz+YxrtfSQpL/2Ib7ZjDznJDQ3Sy
         t2Mig7GFzaXXUAeiUQiV8lErc6Q08kgdYSnJam21z1niZ96L9s+Cpjy3z3DUjZRAUfL/
         ooqjXjyvKq8sjpXRG6sAfuEHNXz4eoAAVUYVNRWhAMAp4DJ9vuYoLANEeLLIghcMv42k
         p0JVRS3bznSLrf3vAoGfp17flb5Dp6Ua8HTvSsr170UV056odZ4JyhHo59j4t4ftvRzG
         F06g==
X-Forwarded-Encrypted: i=1; AL+hErGcjU5nL6lbwUvFZLVCjEwWApX2+QiiUfl5u4sIgAAUxOJdhRkLPfLxW55nsCD+EXqvISga6d2ISg1/eA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vw2gKrWDOK5ohBl0cC49iIov8PRjA8VlAqrstYV2lMp2zV25z
	hNX2XOUYx49/sbLmTpTqbtKvbYSuTiFHeF4WZBAuUpstK7FPyZJeJnR3
X-Gm-Gg: AYBFou2bYTbWMpB3c2miWoGlldxCsCbo/D7aqPJYFcYAtbEfZBmj4QNAwwwmUEtoaE/
	x5tVfdAzWW+D6Lro8TeqfdjRuZNNCIOM68VfCnqknNeCy9g0nginiYRFKObsJHziNuaeuRsZ5JV
	PuPIPOK30l8XqYS+FKN8F1R5X1TQtZlj0FQxNNl6+B4xGBhL42OvMrc8Oybhs+aSo80BmneIW2m
	zUx5OZZ2BXNgbX4CLigtQKwuZuWHsBGWLCOXZUR6uTzdDUcF/PQ/SV+D6d8jn0FEzWwZVrt7cqj
	2ME6Oj4ArU0171lBKyfGyBVNtfZ3h2MeE+qms7kky5DCSvDmfW1eTJRaXdK1frhoPhNb7erjFd7
	Sbm4m2o56Fp3ee/78y7k1JmAPFfuc1h3b6sYl0DP5qW13wQPn7StpAIH4V2CwAiYzA0vD6zfA9j
	htpnqUciAXeJlAJrjqTKlKEspzR2d0zEjsrszfiyKWBo5WoNOnBhE49yeU79AYFpt93lMjKAryB
	s6h1ggmAeaCWRxZZcMbT2/DdTI55Bgw3WvAWJmyl/bJHzGNhwfwGwmjWx7DPXAEbceZZNG4GSYn
	juIg4HSrp9UL4xb6GT3s7EiEiGln3Y/yziOAgP0vBK6PRV9z+8vNxgfd
X-Received: by 2002:a17:907:160e:b0:c3e:4f41:e2a6 with SMTP id a640c23a62f3a-c4d6d161e93mr224560466b.6.1794217480921;
        Mon, 09 Nov 2026 01:44:40 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:6e3a:d704:53e2:f00e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4753aasm137786866b.45.2026.11.09.01.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:44:40 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] HID: lg-g15: report Super-key-lock state on G15 v2's keyboard interface
Date: Mon,  9 Nov 2026 10:44:25 +0100
Message-ID: <20261109094426.1432465-4-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109094426.1432465-1-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
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

The G15 v2 exposes a second USB HID interface (046D:C226) previously
left to hid-generic, which reports the Super-key-lock ("Game Mode")
state on report 3. Bind it as LG_G15_V2_KBD: keep default hid-input
behavior for normal typing, and additionally decode report 3 to expose
the lock state as a read-only g15::game_mode LED.

Tested on Logitech G15v2.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Assisted-by: Claude:claude-sonnet-5
---
 drivers/hid/hid-ids.h    |   1 +
 drivers/hid/hid-lg-g15.c | 192 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 189 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa6516d..44ebf2a0accc 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -950,6 +950,7 @@
 #define USB_DEVICE_ID_LOGITECH_G13		0xc21c
 #define USB_DEVICE_ID_LOGITECH_G15_LCD		0xc222
 #define USB_DEVICE_ID_LOGITECH_G11		0xc225
+#define USB_DEVICE_ID_LOGITECH_G15_V2_KBD	0xc226
 #define USB_DEVICE_ID_LOGITECH_G15_V2_LCD	0xc227
 #define USB_DEVICE_ID_LOGITECH_G510		0xc22d
 #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 35d183787383..592c9747738e 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -63,7 +63,8 @@
 enum lg_g15_model {
 	LG_G13,
 	LG_G15,
-	LG_G15_V2,
+	LG_G15_V2,	/* 046D:C227, GamePanel LCD iface */
+	LG_G15_V2_KBD,	/* 046D:C226, keyboard/consumer-ctrl iface, not the LCD */
 	LG_G510,
 	LG_G510_USB_AUDIO,
 	LG_Z10,
@@ -134,6 +135,17 @@ struct lg_g15_data {
 	bool lcd_contrast_set;		/* LCD contrast written at least once */
 };
 
+/*
+ * State for the G15 v2's separate keyboard + consumer-control USB device
+ * (046D:C226). Unlike lg_g15_data above, this is not the GamePanel LCD
+ * interface: it carries normal typing (left to generic hid-input) plus one
+ * extra report we care about, so it only needs a small amount of state.
+ */
+struct lg_g15_kbd_data {
+	struct led_classdev led;	/* g15::game_mode, read-only */
+	bool super_lock;		/* Cached HW state of the Super/Windows-key lock */
+};
+
 /********* G13 LED functions ***********/
 /*
  * G13 retains no state across power cycles, and always powers up with the backlight on,
@@ -717,6 +729,8 @@ static int lg_g15_get_initial_led_brightness(struct lg_g15_data *g15)
 		 * the LCD and touch keys part of the speakers.
 		 */
 		return 0;
+	case LG_G15_V2_KBD:
+		break; /* Never reached, this model has no lg_g15_data */
 	}
 	return -EINVAL; /* Never reached */
 }
@@ -981,11 +995,138 @@ static int lg_g510_leds_event(struct lg_g15_data *g15, u8 *data)
 	return 0;
 }
 
+/********* G15 v2 keyboard interface functions *********/
+
+/* Report 3, byte 1 bit 0: Super/Windows key lock state ("Game Mode") */
+#define LG_G15_V2_KBD_GAME_MODE_REPORT	0x03
+
+/*
+ * The G15 v2's keyboard device uses struct lg_g15_kbd_data as drvdata, not
+ * struct lg_g15_data. This is the one check used by every entry point to
+ * tell the two apart.
+ */
+static bool lg_g15_is_v2_kbd(struct hid_device *hdev)
+{
+	return hdev->vendor == USB_VENDOR_ID_LOGITECH &&
+	       hdev->product == USB_DEVICE_ID_LOGITECH_G15_V2_KBD;
+}
+
+static enum led_brightness lg_g15_v2_kbd_super_lock_get(struct led_classdev *led_cdev)
+{
+	struct lg_g15_kbd_data *kbd = container_of(led_cdev, struct lg_g15_kbd_data, led);
+
+	return kbd->super_lock;
+}
+
+static void lg_g15_v2_kbd_set_super_lock(struct lg_g15_kbd_data *kbd, bool super_lock)
+{
+	if (super_lock == kbd->super_lock)
+		return;
+
+	kbd->super_lock = super_lock;
+	led_classdev_notify_brightness_hw_changed(&kbd->led, super_lock);
+}
+
+/* Fetches the current lock state, which may already be on at probe/resume. */
+static void lg_g15_v2_kbd_read_super_lock(struct hid_device *hdev,
+					  struct lg_g15_kbd_data *kbd)
+{
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(2, GFP_KERNEL); /* DMA-able, not on the stack */
+	if (!buf)
+		return;
+
+	ret = hid_hw_raw_request(hdev, LG_G15_V2_KBD_GAME_MODE_REPORT, buf, 2,
+				 HID_INPUT_REPORT, HID_REQ_GET_REPORT);
+	if (ret == 2 && buf[0] == LG_G15_V2_KBD_GAME_MODE_REPORT)
+		lg_g15_v2_kbd_set_super_lock(kbd, buf[1] & 0x01);
+	else
+		hid_dbg(hdev, "Error reading Super-key-lock state: %d\n", ret);
+
+	kfree(buf);
+}
+
+/* Decodes report 3 and mirrors the Super-key-lock bit into the game_mode LED. */
+static int lg_g15_v2_kbd_raw_event(struct hid_device *hdev, u8 *data, int size)
+{
+	struct lg_g15_kbd_data *kbd = hid_get_drvdata(hdev);
+
+	if (!kbd || data[0] != LG_G15_V2_KBD_GAME_MODE_REPORT || size != 2)
+		return 0; /* Not our report, or the non-consumer-control interface */
+
+	lg_g15_v2_kbd_set_super_lock(kbd, data[1] & 0x01);
+
+	return 0;
+}
+
+/*
+ * The G15 v2's keyboard USB device exposes two HID interfaces of its own
+ * (boot keyboard + consumer control); both match this same USB product ID,
+ * so this probe runs once per interface. Only the consumer-control one
+ * carries report 3, so the LED is only registered there; the other gets
+ * plain generic hid-input and nothing else, same as if hid-generic had
+ * bound it.
+ */
+static int lg_g15_v2_kbd_probe(struct hid_device *hdev)
+{
+	struct hid_report_enum *rep_enum;
+	struct hid_report *rep;
+	bool has_game_mode_report = false;
+	struct lg_g15_kbd_data *kbd;
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		if (rep->id == LG_G15_V2_KBD_GAME_MODE_REPORT)
+			has_game_mode_report = true; /* This is the consumer-control interface */
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT); /* Plain generic keyboard input */
+	if (ret)
+		return ret;
+
+	if (!has_game_mode_report)
+		return 0; /* Boot-keyboard interface, nothing more to do */
+
+	kbd = devm_kzalloc(&hdev->dev, sizeof(*kbd), GFP_KERNEL);
+	if (!kbd)
+		return 0; /* Non-fatal, keyboard input still works without the LED */
+
+	kbd->led.name = "g15::game_mode";
+	kbd->led.max_brightness = 1;
+	kbd->led.brightness_get = lg_g15_v2_kbd_super_lock_get;
+	kbd->led.flags = LED_BRIGHT_HW_CHANGED; /* Enables the hw_changed notify below */
+
+	ret = devm_led_classdev_register(&hdev->dev, &kbd->led);
+	if (ret)
+		return 0; /* Non-fatal, keyboard input still works without the LED */
+
+	/*
+	 * Only set drvdata once the LED is registered: raw_event may run as
+	 * soon as hid_hw_start() returns, and notifying a brightness change
+	 * on an unregistered LED triggers a WARN.
+	 */
+	hid_set_drvdata(hdev, kbd);
+	lg_g15_v2_kbd_read_super_lock(hdev, kbd);
+
+	return 0;
+}
+
 static int lg_g15_raw_event(struct hid_device *hdev, struct hid_report *report,
 			    u8 *data, int size)
 {
-	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_data *g15;
+
+	if (lg_g15_is_v2_kbd(hdev)) /* Separate kbd/consumer-ctrl dev */
+		return lg_g15_v2_kbd_raw_event(hdev, data, size);
 
+	g15 = hid_get_drvdata(hdev);
 	if (!g15)
 		return 0;
 
@@ -1015,6 +1156,8 @@ static int lg_g15_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (data[0] == LG_G510_INPUT_KBD_BACKLIGHT && size == 2)
 			return lg_g510_leds_event(g15, data);
 		break;
+	case LG_G15_V2_KBD:
+		break; /* Never reached, handled via lg_g15_is_v2_kbd() above */
 	}
 
 	return 0;
@@ -1417,6 +1560,9 @@ static int lg_g15_register_led(struct lg_g15_data *g15, int i, const char *name)
 			ret = devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cdev);
 		}
 		break;
+	case LG_G15_V2_KBD:
+		ret = -EINVAL; /* Never reached, this model has no lg_g15_data LEDs */
+		break;
 	}
 
 	return ret;
@@ -1492,6 +1638,12 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct hid_report *rep;
 	int ret, i, gkeys = 0;
 
+	if (lg_g15_is_v2_kbd(hdev)) /* Not the GamePanel LCD interface */
+		return lg_g15_v2_kbd_probe(hdev);
+
+	if (id->driver_data == LG_G15_V2_KBD) /* e.g. a mismatching new_id */
+		return -ENODEV;
+
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
 	ret = hid_parse(hdev);
@@ -1574,6 +1726,8 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case LG_Z10:
 		connect_mask = HID_CONNECT_HIDRAW;
 		break;
+	case LG_G15_V2_KBD:
+		break; /* Never reached, rejected above */
 	}
 
 	ret = hid_hw_start(hdev, connect_mask);
@@ -1732,6 +1886,16 @@ static const struct hid_device_id lg_g15_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_G15_V2_LCD),
 		.driver_data = LG_G15_V2 },
+	/*
+	 * The G15 v2's keyboard + consumer-control USB device (a separate
+	 * device from the GamePanel LCD one above, on the keyboard's builtin
+	 * hub). Normal typing is handled by generic hid-input; we only bind
+	 * this to also expose the Super/Windows-key-lock ("Game Mode") state,
+	 * see lg_g15_v2_kbd_probe().
+	 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_G15_V2_KBD),
+		.driver_data = LG_G15_V2_KBD },
 	/* G510 without a headset plugged in */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_G510),
@@ -1750,7 +1914,18 @@ MODULE_DEVICE_TABLE(hid, lg_g15_devices);
 
 static void lg_g15_remove(struct hid_device *hdev)
 {
-	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_data *g15;
+
+	/*
+	 * The G15 v2's keyboard device uses struct lg_g15_kbd_data, not
+	 * lg_g15_data below; it has nothing to clean up beyond hid_hw_stop().
+	 */
+	if (lg_g15_is_v2_kbd(hdev)) {
+		hid_hw_stop(hdev);
+		return;
+	}
+
+	g15 = hid_get_drvdata(hdev);
 
 	/*
 	 * g15->work is only initialized for the models that schedule it
@@ -1772,9 +1947,18 @@ static void lg_g15_remove(struct hid_device *hdev)
  */
 static int lg_g15_resume(struct hid_device *hdev)
 {
-	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_data *g15;
 	struct lg_g15_led *contrast;
 
+	if (lg_g15_is_v2_kbd(hdev)) {
+		struct lg_g15_kbd_data *kbd = hid_get_drvdata(hdev);
+
+		if (kbd)
+			lg_g15_v2_kbd_read_super_lock(hdev, kbd);
+		return 0;
+	}
+
+	g15 = hid_get_drvdata(hdev);
 	if (!g15)
 		return 0;
 
-- 
2.53.0

