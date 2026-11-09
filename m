Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244665;
	b=DikZF1qQ6dEdyz+mIFShhEw6+gx7qvGsiQq44f1K3IvZmxu7AH0BVimj/Z2AUM9NJNWv
	 L0nih3NQM29phy/LxY2xltYilxxlnvjfqW0TiTfWgmMOVYuUss2tnzXrG7qbnp/YMF5RP
	 Jy1Sfjb4uByNSsL8BrZ21I13vV+4DB+WJ6Nh0Muihsggh4xXekeP0tR7xanYS5kX5T1YY
	 0yfIhudK7f+avhKIxIcMEebytp7V+5D1CHFS845CqcQpqZa5xo96uyTevnHiyAo4eSamm
	 xWGdcvpZulOPduMfIsedvV+ggW7uA93dRjuhR1sjf3PGhBEZbYAVuW2ESv8RtBQ9PWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VpkKwusKtJBANquo4lbFioELUlzINrsE7kXdl44nTh8=;
	b=0RWidhS6Xtl6/p+gJlO2YNCF3RPWQx0yRcTb2Is48Jdw113/chqzqmQxjm39CU2LE1XI
	 +AGk6uh+gg/uwYeq2LfHITodQ0opuKaVf00ct9Plf++eCnVI7/PR70dag7e7q368HpWgm
	 bs6Dm4hlP6odr8cjK/E2plcHtUKLXl+ZMWfCAdW3gccMecPNZNdrvJnt07B4iE9KBIe+Z
	 Eohz18+OQJtFBK02x0j6A9C4iFpRgN8IVIlGpFX5H5Wp/jyktAneOD0q+MdYpD84udzR3
	 yKdCPF6kGsxXGWHJlmuC6VZa6UQc2Cly4T2mBHlOQmw4Hjervu80VvKWXP4mOFgkKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="L/pbNBGe";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30B606EE86
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 17:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D30B606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L/pbNBGe
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4ceaee6770so154061566b.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244663; x=1794849463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpkKwusKtJBANquo4lbFioELUlzINrsE7kXdl44nTh8=;
        b=L/pbNBGerbF1p/HgwxQnEkKE+VjZuWVshnguhdysfY8AzFjkzUWcvp4WfCduaU5b7o
         A7KSV2EI2caCJw1rA7f1H2sx1XOg2Allnf2dG8SqjTzHU1Vnk6Pi5LYsMpkD9V7XQSAS
         Tl1F0mmoQ7MKHE823o/eS+a/ZF0BjN6qJjD7nm/wjHqLXV7vyQfCE/gsrfmQloz1frb5
         wX/2rNpWp/9pVt3zYEk9mpXYW0VihE6cgDvuNiMy9bBwa/eXN74B4YzCNJ77QQEXkeJP
         cvoZlbH+6E/kk7Do/blYpf90Nt97RFrTKgngGkSlGFBvOWEVuDtJ654JYP3lQFnkpPKH
         SO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244663; x=1794849463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpkKwusKtJBANquo4lbFioELUlzINrsE7kXdl44nTh8=;
        b=zJOsq6TrMecuMOFlx8+BunhCv53ppNdD0ZXeaGftDQhK9ISVa1XqGCJmxr8R9YosOQ
         7rRdRqYOiXTAMIVzQII0sHPCWGJEIDHIcS6sn4kuvFOEpupLs6nJ3OlsqKRa1X5ufa93
         4mgQWHJVAnMO05Wo3G+ciMnVkM8E0YkXGUH9qEFsdTw+X+iM4be56s1uGxhWIQEJk7+u
         C2pvPPFy2+Hia8gpqd5gqZqFpKVNL+jTOlUTCraO1m61pCOyAnjyfcWDYnuNNgppO/ta
         +hbojfeDEo/pF2FNAUBd2jemA45FDdyWFxqKikHCcJlqjgFD3PGmq8TpHqAWHOPnC6u4
         ADwA==
X-Forwarded-Encrypted: i=1; AL+hErEQwyN+qGFpD6+NNUOjdmz4vBlKkd9PF4UQ0T7T7PJHfncO69PLVYUSZkt0gc58HWY7X2MocAZG4OvCwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z//65mb19WN09XsSW6KViuJPwCpBKRAjSY68kwaEu/e39Q+mq3n
	sjUCb1hRffNaz5dLLUduUKLhUEHgglt3KB3LNbJkog9VHy3mXDpsOUQF
X-Gm-Gg: AYBFou1gDd5gFSxxLyg+nRJMyxN2YSsVEtp8/8A5RI+9Z2l5gJxe9Ajth23tPF80oUO
	NnYqPci7hshmRCvH+Rldxjhq8u3uL0mOrTMBzD3v/K2UFgMClkGq6oo8XbmNrtjSG2i5tpYkEKq
	Y5Lrq8oELdmR7Uhge9B8FeRT/g0FYFJU8+JScYiNuEMrOJABklc2WtFqX3nGQWxdLOcXhlDnjPa
	ka/xw2Udl9L/DQTavKTzqBIjGkRdX6OlDgsJShHuHcmrQZGoID2DrjmbGBpEIlxUz6b3l3jXXgd
	PJmp2kPqJbr1tf6N4q0ASMAnxImi1EHsgLADsIY8C9DD2ODsSzouZmfb5byajnRvO+o9NK0Lgko
	ZW7RL+tbfQbnRbjPi4IUDgUb6u+KCp9I7DQczvTAgDF3iukJ7pDMkC4Bbn8KZCE5hAKvkTXI1QC
	2Jj8069i1INCqjSUgpaLblEhZu8YxqjA40/gOb3hpjAIGMbE3cuweV08gpu47stHDHueEHoKGGA
	fym5rKnwep6jM3isU9gF0dK3kG5dzevVnEvWLs8Oci5RCDpRSFPzBY3CVZydMrB/yXLqwMaIOWI
	gbbrOOwtHlqJ02CdUkaRFl1duGxDuaYdpb7S0V55iSc8ZUGltPMutKVP
X-Received: by 2002:a17:906:c112:b0:c36:a4b4:b1ed with SMTP id a640c23a62f3a-c50494f2e27mr3990266b.11.1794244662538;
        Mon, 09 Nov 2026 09:17:42 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:9811:d134:cbdf:c22b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4af091sm191633866b.50.2026.11.09.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:17:42 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: lg-g15: add LCD contrast LED
Date: Mon,  9 Nov 2026 18:17:26 +0100
Message-ID: <20261109171727.2812614-2-torsteine+linux@gmail.com>
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

Wire values ({2, 32, 129, value}) match libg15's setLCDContrast()
byte-for-byte.

Tested on Logitech G15v2.

Based on libg15.c.

Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Based-on-work-by: Philip Lawatsch <philip@lawatsch.at>
Based-on-work-by: Alex Ibrado <alex@ibrado.org>
Based-on-work-by: Anthony J. Mirabella <mirabeaj@gmail.com>
Based-on-work-by: Mike Lampard <mlampard@users.sourceforge.net>
Assisted-by: Claude:claude-sonnet-5
---
 drivers/hid/hid-lg-g15.c | 119 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 02ef3e2094b4..3827c66ca3a9 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -59,7 +59,16 @@ enum lg_g15_led_type {
 	LG_G15_MACRO_PRESET2,
 	LG_G15_MACRO_PRESET3,
 	LG_G15_MACRO_RECORD,
-	LG_G15_LED_MAX
+	LG_G15_LED_MAX,
+	/*
+	 * LCD contrast uses a different feature-report sub-format than the
+	 * brightness/macro fields above (see lg_g15_contrast_set()) and has
+	 * no hardware readback, so it lives outside [0, LG_G15_LED_MAX) to
+	 * avoid being swept into the G13/macro loops bounded by
+	 * LG_G15_LED_MAX. G15/G15 v2 only; registered explicitly.
+	 */
+	LG_G15_LCD_CONTRAST = LG_G15_LED_MAX,
+	LG_G15_LED_ARRAY_SIZE
 };
 
 struct g13_input_report {
@@ -89,9 +98,10 @@ struct lg_g15_data {
 	struct input_dev *input_js; /* Separate joystick device for G13. */
 	struct hid_device *hdev;
 	enum lg_g15_model model;
-	struct lg_g15_led leds[LG_G15_LED_MAX];
+	struct lg_g15_led leds[LG_G15_LED_ARRAY_SIZE];
 	bool game_mode_enabled;
 	bool backlight_disabled;	/* true == HW backlight toggled *OFF* */
+	bool lcd_contrast_set;		/* LCD contrast written at least once */
 };
 
 /********* G13 LED functions ***********/
@@ -365,6 +375,69 @@ static int lg_g15_led_set(struct led_classdev *led_cdev,
 	return ret;
 }
 
+/*
+ * LCD contrast, report 2 field 32: {2, 32, 129, value}, value in
+ * {18, 22, 26} for low/medium/high. Distinct sub-format from the
+ * brightness/macro fields (value sits in byte 3, not byte 2, and byte 2 is
+ * a fixed marker rather than the field selector) and has no GET_REPORT
+ * readback, so brightness_get just returns the last value we set.
+ */
+/* Must be called with g15->mutex held */
+static int lg_g15_contrast_write(struct lg_g15_data *g15,
+				 enum led_brightness brightness)
+{
+	static const u8 contrast_values[] = { 18, 22, 26 };
+	int ret;
+
+	/*
+	 * The LED core does not clamp to max_brightness on every path (a
+	 * delayed set passes the raw sysfs value), so clamp here.
+	 */
+	brightness = min_t(enum led_brightness, brightness,
+			   ARRAY_SIZE(contrast_values) - 1);
+
+	g15->transfer_buf[0] = LG_G15_FEATURE_REPORT;
+	g15->transfer_buf[1] = 32;
+	g15->transfer_buf[2] = 129;
+	g15->transfer_buf[3] = contrast_values[brightness];
+
+	ret = hid_hw_raw_request(g15->hdev, LG_G15_FEATURE_REPORT,
+				 g15->transfer_buf, 4,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret != 4) {
+		hid_err(g15->hdev, "Error setting LCD contrast: %d\n", ret);
+		return (ret < 0) ? ret : -EIO;
+	}
+
+	g15->leds[LG_G15_LCD_CONTRAST].brightness = brightness;
+	g15->lcd_contrast_set = true;
+	return 0;
+}
+
+static int lg_g15_contrast_set(struct led_classdev *led_cdev,
+			       enum led_brightness brightness)
+{
+	struct lg_g15_data *g15 = dev_get_drvdata(led_cdev->dev->parent);
+	int ret;
+
+	if (led_cdev->flags & LED_UNREGISTERING)
+		return 0;
+
+	mutex_lock(&g15->mutex);
+	ret = lg_g15_contrast_write(g15, brightness);
+	mutex_unlock(&g15->mutex);
+
+	return ret;
+}
+
+static enum led_brightness lg_g15_contrast_get(struct led_classdev *led_cdev)
+{
+	struct lg_g15_led *g15_led =
+		container_of(led_cdev, struct lg_g15_led, cdev);
+
+	return g15_led->brightness;
+}
+
 static void lg_g15_leds_changed_work(struct work_struct *work)
 {
 	struct lg_g15_data *g15 = container_of(work, struct lg_g15_data, work);
@@ -1017,6 +1090,13 @@ static int lg_g15_register_led(struct lg_g15_data *g15, int i, const char *name)
 		break;
 	case LG_G15:
 	case LG_G15_V2:
+		if (i == LG_G15_LCD_CONTRAST) {
+			g15->leds[i].cdev.brightness_set_blocking = lg_g15_contrast_set;
+			g15->leds[i].cdev.brightness_get = lg_g15_contrast_get;
+			g15->leds[i].cdev.max_brightness = 2;
+			ret = devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cdev);
+			break;
+		}
 		g15->leds[i].cdev.brightness_get = lg_g15_led_get;
 		fallthrough;
 	case LG_Z10:
@@ -1333,6 +1413,14 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto error_hw_stop;
 	}
 
+	/* The G11 shares the LG_G15 model but has no LCD */
+	if ((g15->model == LG_G15 && hdev->product != USB_DEVICE_ID_LOGITECH_G11) ||
+	    g15->model == LG_G15_V2) {
+		ret = lg_g15_register_led(g15, LG_G15_LCD_CONTRAST, "g15::lcd_contrast");
+		if (ret)
+			goto error_hw_stop;
+	}
+
 	return 0;
 
 error_hw_stop:
@@ -1389,12 +1477,39 @@ static void lg_g15_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+/*
+ * The LCD does not retain its contrast across a USB reset or power loss;
+ * re-apply the last value userspace set, if any.
+ */
+static int lg_g15_resume(struct hid_device *hdev)
+{
+	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
+	struct lg_g15_led *contrast;
+
+	if (!g15)
+		return 0;
+
+	contrast = &g15->leds[LG_G15_LCD_CONTRAST];
+	if (!contrast->cdev.dev)
+		return 0;
+
+	/* Under the mutex, so a concurrent contrast set cannot be undone */
+	mutex_lock(&g15->mutex);
+	if (g15->lcd_contrast_set)
+		lg_g15_contrast_write(g15, contrast->brightness);
+	mutex_unlock(&g15->mutex);
+
+	return 0;
+}
+
 static struct hid_driver lg_g15_driver = {
 	.name			= "lg-g15",
 	.id_table		= lg_g15_devices,
 	.raw_event		= lg_g15_raw_event,
 	.probe			= lg_g15_probe,
 	.remove			= lg_g15_remove,
+	.resume			= lg_g15_resume,
+	.reset_resume		= lg_g15_resume,
 };
 module_hid_driver(lg_g15_driver);
 
-- 
2.53.0

