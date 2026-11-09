Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244667;
	b=Znf0Ql2sLheEACRBXK83oXtursAmkg1ZmWqkysJHESgZazC+S4YJJLm136fiQsxkAvzV
	 0/j6JpJp0XJUOVLhyBhvAEykYqLin13I8AXSJ6rGj0180JK9yk1nCcF8rJUu/OgxKHWY3
	 eytH1IfQxQe7TenQ/behGHjv6G1ZP8PLAMuoGSn10VAZuKdqljl31GMSnFPspumriSoBO
	 kOpwoG4CA3YhNp8TPQZHmUo0Qx981Z185exL8zy5/HRxii3LEsK0TTTRZhjs9JnbqOVnh
	 Diy1ILpW7UmEbSScQKRQuAF2y8NQeyX2leT0eRqeepmozeZ6pVAUbuOiWe31/qBMxAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Guw5DNgTB/i1FyuD8Sp0b940WtsYJcsWIyxWRJFxD5g=;
	b=BKq0+vR9IRTuZ8QbtBR5PoAzVRGegZez8tuFo3zatFEO07jPJCaK/SABshsa3Omi0Fyl
	 ws/j4+1+tqoSm6zQKsnNpWW3MENeBZh/u3SQpa2cQIy4CIRb/ZV3jpk+S36O8zD91O8DW
	 41U5bbubsT9YxuaBDXefVdvSYAB3cGoDrh4SCvxIRe1GHdIjX2ingI8Ce2JmmGclfHnBV
	 Amyj2j4esdSW4w2Y2iLLKVVAmy5wja0MGlqy3edjqBXU6q/Xir1EN9qp0tRQQRc4O2bY0
	 kC6ZsxhKB/DP1ImauWvNh3rBReqhnu0AzsT3hclw8sD9TQzBttcqSLxx2PAcF1TyR2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QswF4CIG;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB2606EE95
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 17:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01EB2606EE95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QswF4CIG
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso165251866b.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244665; x=1794849465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Guw5DNgTB/i1FyuD8Sp0b940WtsYJcsWIyxWRJFxD5g=;
        b=QswF4CIG5+QmUqMYaul3cbUSimiFAKHAgno/LgQHt2ASCvCAQg1U0rE/+3KKllA/Of
         1xeIfz4waCMnuas0n8hdOhSrZEYyCbFSBO2jzM4gipPmOv5l30uyMq0fxCdzKh9KrOK3
         wJPeHt08Xb4KvnVWF20O4BcbA46tl+oPRAFt38Tmo0ydc/WI8Kpik1B2sEMRby6TC6le
         BV91eHp7eCVWa+C7WeJDes84c+szD5Q42j8SWAMIOyNe8ZcoEhHVvcSypszQqpe72K4V
         3/9lbgZEzH03gzGyvoKkCu1bRQJECT5j0iYtcRmCFTJlxDNtC0tB6UN57TJiu76aGkwJ
         nrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244665; x=1794849465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Guw5DNgTB/i1FyuD8Sp0b940WtsYJcsWIyxWRJFxD5g=;
        b=qYLjZ7b5lspb5bKYoTRq7XsyaWGMM32P81TwMZVbFajYwu42f3oKcX3Yxu6WQNjO4/
         STvHX8++c7mkpm8gh/FmtU0MP5HURvdFvkl5RMlc429Y+5I9FjcnVb5RO22VZbvDTuUx
         7pRulb7hLGr7HtqbuIOSd9qeAjH7mJnQ490k2Ze/zzg/hzBBTyUEAKgFmuPli7ZSiwM+
         TXMWxxS/B4JHpWGtLgA/6+bJkGicpNgIFX+14cKGB+fsHp7useBed8Urt6xUihgeYBdk
         SjyaGXwLGpy7OXFX0+suEOUTm3slnZfSBoNuFDAkwomI2/2bnyYbIHYQN+iZ3Caqnl4X
         RB7w==
X-Forwarded-Encrypted: i=1; AL+hErHD62T/k6N2BsGUF0xI6ZDfrYYq0BakK1HrXK68XK0fpWHhfkE/tHf/exeYX+xJ9ZVNPZamwm24Lvb0yw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ftQZ7wjsNmthzKes4W9F4F/plXCSyROlD2Umos1rf2BnX0e/8
	Ge9sEFKLrJhHkoHvtZrh51v461kmPmqfPKPu4zbjrH2ilQEp7Si+3fIX1RMRN6x7
X-Gm-Gg: AYBFou0GXV7EmKYIcLf+T5/L79sCRvnTDOnLEtNibhtqDjoxln7qWdyFXTZPnw9QZCX
	msP4SkfdfB2POLMXehdksW+ie3kKEurrs4bqIfV1bB+HkkYk1/6vBB+iwDO/FeXY5MTnRkamM/V
	qaM5lzZf8sJiDbuHoAg0r/Rgd9l9WELnWRbj1SsMDCncJBR2RbMD5sjLyp0S1CGj40LmCZBE5oF
	45gGBhRHqs7qlJrfxDdGRmNNT8JS8WIDzNhjSHsX2RhjtcOY1DEWxm/rhdHcad3kJnHE4C0uMOr
	0PLFPN7RdcQv3cy9x1GCx1r70EkYnyoTn0yHTC4cbjygIPZ5DyQy2kDmPIxQrV97dSIKVvpoNgP
	q6w9GEai7XrMor/GHzHSjOBHp8mrctMOBZQ2cmXZVMBBchJvskFlzdxazMyvmQOEJ9+PCIlyxoP
	W0tO6IXQHwTVpN24eH9D3oj1F/N0kdbvP4tmQ1snzjxPa8YlGGq65FklW5+X3zIzqNZlsSHboPu
	riJ7hcUsiWul2BYGYLnGSqf+A5cTqmrhNOy0VurmeiZRRb2r4AaGLPvG7PrKEVQIM2qEaxU+n9t
	3fho/nnSHeP+Np73UL2EfwNM8AbfOINm4iMLnxCVAkh8vvfP7peNkFat
X-Received: by 2002:a17:907:9481:b0:c26:2eee:ffc7 with SMTP id a640c23a62f3a-c5049655396mr83466b.35.1794244665001;
        Mon, 09 Nov 2026 09:17:45 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:9811:d134:cbdf:c22b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4af091sm191633866b.50.2026.11.09.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:17:44 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: lg-g15: report Super-key-lock state on G15 v2's keyboard interface
Date: Mon,  9 Nov 2026 18:17:27 +0100
Message-ID: <20261109171727.2812614-3-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109171727.2812614-1-torsteine+linux@gmail.com>
References: <20261109171727.2812614-1-torsteine+linux@gmail.com>
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
 drivers/hid/hid-lg-g15.c | 230 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 227 insertions(+), 4 deletions(-)

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
index 3827c66ca3a9..998023ad272d 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <dt-bindings/leds/common.h>
@@ -45,7 +46,8 @@
 enum lg_g15_model {
 	LG_G13,
 	LG_G15,
-	LG_G15_V2,
+	LG_G15_V2,	/* 046D:C227, GamePanel LCD iface */
+	LG_G15_V2_KBD,	/* 046D:C226, keyboard/consumer-ctrl iface, not the LCD */
 	LG_G510,
 	LG_G510_USB_AUDIO,
 	LG_Z10,
@@ -104,6 +106,19 @@ struct lg_g15_data {
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
+	spinlock_t lock;		/* Protects super_lock and events */
+	bool super_lock;		/* Cached HW state of the Super/Windows-key lock */
+	unsigned int events;		/* Report 3 input reports seen so far */
+};
+
 /********* G13 LED functions ***********/
 /*
  * G13 retains no state across power cycles, and always powers up with the backlight on,
@@ -699,6 +714,8 @@ static int lg_g15_get_initial_led_brightness(struct lg_g15_data *g15)
 		 * the LCD and touch keys part of the speakers.
 		 */
 		return 0;
+	case LG_G15_V2_KBD:
+		break; /* Never reached, this model has no lg_g15_data */
 	}
 	return -EINVAL; /* Never reached */
 }
@@ -963,11 +980,173 @@ static int lg_g510_leds_event(struct lg_g15_data *g15, u8 *data)
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
+/* Must be called with kbd->lock held */
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
+static int lg_g15_v2_kbd_get_super_lock(struct hid_device *hdev, bool *super_lock)
+{
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(2, GFP_KERNEL); /* DMA-able, not on the stack */
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(hdev, LG_G15_V2_KBD_GAME_MODE_REPORT, buf, 2,
+				 HID_INPUT_REPORT, HID_REQ_GET_REPORT);
+	if (ret == 2 && buf[0] == LG_G15_V2_KBD_GAME_MODE_REPORT) {
+		*super_lock = buf[1] & 0x01;
+		ret = 0;
+	} else {
+		hid_dbg(hdev, "Error reading Super-key-lock state: %d\n", ret);
+		ret = (ret < 0) ? ret : -EIO;
+	}
+
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * Re-reads the lock state on resume. Input reports keep arriving while the
+ * GET_REPORT is in flight; if one did, it is newer than what we read, so
+ * keep the state it set.
+ */
+static void lg_g15_v2_kbd_refresh_super_lock(struct hid_device *hdev,
+					     struct lg_g15_kbd_data *kbd)
+{
+	unsigned long flags;
+	unsigned int events;
+	bool super_lock;
+
+	spin_lock_irqsave(&kbd->lock, flags);
+	events = kbd->events;
+	spin_unlock_irqrestore(&kbd->lock, flags);
+
+	if (lg_g15_v2_kbd_get_super_lock(hdev, &super_lock))
+		return;
+
+	spin_lock_irqsave(&kbd->lock, flags);
+	if (kbd->events == events)
+		lg_g15_v2_kbd_set_super_lock(kbd, super_lock);
+	spin_unlock_irqrestore(&kbd->lock, flags);
+}
+
+/* Decodes report 3 and mirrors the Super-key-lock bit into the game_mode LED. */
+static int lg_g15_v2_kbd_raw_event(struct hid_device *hdev, u8 *data, int size)
+{
+	struct lg_g15_kbd_data *kbd = hid_get_drvdata(hdev);
+	unsigned long flags;
+
+	if (!kbd || data[0] != LG_G15_V2_KBD_GAME_MODE_REPORT || size != 2)
+		return 0; /* Not our report, or the non-consumer-control interface */
+
+	spin_lock_irqsave(&kbd->lock, flags);
+	kbd->events++;
+	lg_g15_v2_kbd_set_super_lock(kbd, data[1] & 0x01);
+	spin_unlock_irqrestore(&kbd->lock, flags);
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
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP; /* As hid-generic does */
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
+	spin_lock_init(&kbd->lock);
+
+	/* Register the LED with the current state, not a default of off */
+	lg_g15_v2_kbd_get_super_lock(hdev, &kbd->super_lock);
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
+	/* hid-core does not deliver input reports until probe() returns */
+	hid_set_drvdata(hdev, kbd);
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
 
@@ -997,6 +1176,8 @@ static int lg_g15_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (data[0] == LG_G510_INPUT_KBD_BACKLIGHT && size == 2)
 			return lg_g510_leds_event(g15, data);
 		break;
+	case LG_G15_V2_KBD:
+		break; /* Never reached, handled via lg_g15_is_v2_kbd() above */
 	}
 
 	return 0;
@@ -1135,6 +1316,9 @@ static int lg_g15_register_led(struct lg_g15_data *g15, int i, const char *name)
 			ret = devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cdev);
 		}
 		break;
+	case LG_G15_V2_KBD:
+		ret = -EINVAL; /* Never reached, this model has no lg_g15_data LEDs */
+		break;
 	}
 
 	return ret;
@@ -1210,6 +1394,12 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -1292,6 +1482,8 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case LG_Z10:
 		connect_mask = HID_CONNECT_HIDRAW;
 		break;
+	case LG_G15_V2_KBD:
+		break; /* Never reached, rejected above */
 	}
 
 	ret = hid_hw_start(hdev, connect_mask);
@@ -1446,6 +1638,16 @@ static const struct hid_device_id lg_g15_devices[] = {
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
@@ -1464,7 +1666,18 @@ MODULE_DEVICE_TABLE(hid, lg_g15_devices);
 
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
@@ -1483,9 +1696,18 @@ static void lg_g15_remove(struct hid_device *hdev)
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
+			lg_g15_v2_kbd_refresh_super_lock(hdev, kbd);
+		return 0;
+	}
+
+	g15 = hid_get_drvdata(hdev);
 	if (!g15)
 		return 0;
 
-- 
2.53.0

