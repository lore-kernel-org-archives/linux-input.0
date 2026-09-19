Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC983D4125
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789809835; cv=none; b=RX/oRxwSO7BYfowNVlCT+tK/tH9qfN7CwuOG0ZEqaA9tZFGO6WI6v6m+P5HrMuVrP8zvJkLgx/YHCyKVmK/rflGDfNIoKxMK3ab6iX4LC1nbjQjKhaYnyZ6fkXjVKU/eXteOApN9LKcfzwHZm0sUsiIVV08QMp106a5BTwLBjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789809835; c=relaxed/simple;
	bh=H/mJhJsVcFc8lpOfpOOaJdfN6b/ZoqHxwc76hZ6dokU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jbVt69dDzqtgEaMqIevOv6jMv5vPLHJqP4Yi7M/TEnq0rCjNh1omqphLMSN0Y0HGKCztTuX07ecRLKoiwNtPNtFGF9NV/7nxEL0phyDJEj6X2J/0cK0Q2JldAiYcAMSxACO4secOz4mncx7vWwlm8esWfdlFLY62uoC5rsX5x28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deUwCOtC; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deUwCOtC"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d77so1746470e87.0
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789809831; x=1790414631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJnXXZVTZjTht/KjX4MUJpvRsMYI1lqm1sfzJGwyzbs=;
        b=deUwCOtCo1M5RUbj2MHKO4V4va9sVyzS8413v+jvJoHU2SUoFzt4kH675Y7xMXJQBc
         20TqetBgCnnbsHn9cGyhdwm+HMUx8a9lnCGw8P47847na7jqDe/HRtLjgbB9rbLnJlXf
         r2XoifhbysNNgvmJpWZe9rLnUiya7o2RMlAfbDzRN0boGESKiq/Ehq2t3qdye/ZeNO/X
         8xSWkakGd+ECaijXqLNn1liVKmBcjbqvyRbRlSdHsDHdqnqAe9LW9OCq04TKbaRdGbsS
         61oYXYvfh6p5ISICEm5YE6HloJqXjYGPgXt0MSTxk8tR3Lv3P8cUAHjxbhLTIZ+MHNVn
         ObRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789809831; x=1790414631;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJnXXZVTZjTht/KjX4MUJpvRsMYI1lqm1sfzJGwyzbs=;
        b=a1UWI1JFoPtoyNOiP0zp18+eIGmWb90ZnLDXyCyI8YZCACnEGn7N2VSVrecH4KgCv5
         fpv7Ep6vExkfaMIF1G1N3yyw4uhvSektfB97XQStxEq74I3YgvsQucZZs2h3W2Mcwdok
         sj8bvl3Sc6ycOg0syNUe9jIMokDpP2yvgWd1iKsFEUt7Za6W9n0ygdoYGCghf3NPpKjh
         TABbRkARBrYekiPAhqOoJ8io0f2+b87F4AC+99RI/1FcnPflXPGTFQ0ee55ScSmIFbLc
         M64F+APUST3Scp9IJ19eK+SVjqTOIXX0IyKeylUKQyajKvTwMSnW6lS98iR1xeZRq6Tb
         FVjg==
X-Forwarded-Encrypted: i=1; AKwUvBw5rL2jtQqFjEDvd/Mq5OmgJBPEVYrSZiGJqa+AgrR7rXWYAe4UPo4Fz8TWn2VOvpMxPJ6Bac/vWCrZYA==@vger.kernel.org
X-Gm-Message-State: AFuF++lJOkeIaWA8BZgCl8Ex1x/IMp0HAQy+e8s2WwmdInTf7HHFM0ns
	TVG93oNWP2ehuoouYYKp++UQT2C7CUJcmSTaadtj6MHf1pi/AJw2T+9G
X-Gm-Gg: AYBFou3qbE8lD/AbgOh9dp1FECkabrgn2DjNFJ5/yy5vEEcEt2QFgvgSdHAvFPpHwVx
	xpLHQVmbdV5MVDY6AljW8jUJgI5ojEXMThR48B4z9wqsPp8AfbTcmV+jkcmC2K7et7Mn22XVYIQ
	qZANalMyaY1lzaAoGbHVfPyxqSS02NlfJJtnl33dlH3cksO33NeaOAqcWU0IW4YaMIDhrh+zcK6
	jtD3zCVQxyp7miDXYeXmTQsvFsnLvXNI2+vJq2aC/PEspdYmiQHKlQGeI5uIc6RqCT6uEwFxxf/
	QEJv5lvmMZH460o98HLOgHy/GP7LG2HPVGEWX6Xqd3pwznoggm/1foNyJ5nViZgdyGVGgwUGu7c
	bBMmCrpWi9TSnEr9oaz6ewR1pPwyjXRBBo2duPibmjuXb8C1wUkY0Wbuji3bzxAIErxiTz3RV0Q
	LOdkxDNa+Mok+20FKbXvPoQCc3qyu6I3i4PDl9BmQcXF07LNR2Bul7tlPowlD/MRGNqeu2UEvl5
	lkB/UUVYMLxmyE=
X-Received: by 2002:a05:6512:acd:b0:5b7:6590:a8e0 with SMTP id 2adb3069b0e04-5b8c1956420mr1704625e87.57.1789809831226;
        Sat, 19 Sep 2026 02:23:51 -0700 (PDT)
Received: from [221.89.0.0] ([104.28.232.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c7937ae5sm431591e87.23.2026.09.19.02.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 02:23:50 -0700 (PDT)
Message-ID: <816a300c-1f63-4d4a-a0f9-8eef5bd7e748@gmail.com>
Date: Sat, 19 Sep 2026 12:23:49 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
From: Ruzal <daminovruzal7@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com> <aquWNXpJuQr8HLBU@beelink>
 <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com> <aqwUYWPz_nORoFr6@beelink>
 <33a7c239-ede5-4091-ba72-ff429d97013c@gmail.com>
Content-Language: en-US
In-Reply-To: <33a7c239-ede5-4091-ba72-ff429d97013c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 9:01 PM, Ruzal wrote:
> Both descriptor-level approaches confirm what you suspected: modifying the
> descriptor still leaves the application collection instantiated as an empty/
> broken input node, which trips up libinput and blocks the compositor event
> loop for ~15 seconds.

Hi Benjamin,

Quick update on the stall and a tested quirk fix:

The userspace stall happens because unrecognized vendor pages hit
`unknown:` in hid-input.c:1420 (`map_abs(ABS_MISC)`). This sets EV_ABS,
causing hidinput_has_been_populated() to return true and register an
anomalous node with only ABS_MISC, which trips up libinput.

Instead of touching the descriptor, we can handle this via hid-multitouch:
- Add MT_QUIRK_IGNORE_VENDOR_TELEMETRY to drop HID_UP_HPVENDOR2 in mt_input_mapping().
- Add MT_CLS_GOODIX (mirroring MT_CLS_WIN_8 quirks).
- Bind with HID_GROUP_MULTITOUCH_WIN_8 in mt_devices[] (preserving INPUT_PER_APP).

This drops the phantom input node while leaving raw reports on /dev/hidraw intact.

I built the module and tested loading it: /proc/bus/input/devices no longer
creates the UNKNOWN node, and /dev/hidraw0 remains available.

Diff:

---
 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-multitouch.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3aca5aa9176..d0850a98c9f8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -567,6 +567,7 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
 #define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01E0	0x01e0
 #define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
 #define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
 #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 451c7324e6a0..2e973a3b652b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -79,6 +79,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_APPLE_TOUCHBAR		BIT(23)
 #define MT_QUIRK_YOGABOOK9I		BIT(24)
 #define MT_QUIRK_KEEP_LATENCY_ON_CLOSE	BIT(25)
+#define MT_QUIRK_IGNORE_VENDOR_TELEMETRY	BIT(26)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -235,6 +236,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_APPLE_TOUCHBAR			0x0114
 #define MT_CLS_YOGABOOK9I			0x0115
 #define MT_CLS_EGALAX_P80H84			0x0116
+#define MT_CLS_GOODIX				0x0117
 #define MT_CLS_SIS				0x0457
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -457,6 +459,15 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
 	},
+	{ .name = MT_CLS_GOODIX,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS |
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_IGNORE_VENDOR_TELEMETRY,
+		.export_all_inputs = true },
 	{ }
 };
 
@@ -1524,6 +1535,17 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return 1;
 	}
 
+	/*
+	 * Goodix FreeTouch devices emit a periodic heartbeat on vendor
+	 * page 0xFF01 which hid-input would otherwise map to
+	 * KEY_MICMUTE / KEY_BRIGHTNESS*, creating a phantom keyboard.
+	 * Drop it here so no input node is exported; the report remains
+	 * available through hidraw.
+	 */
+	if ((application->quirks & MT_QUIRK_IGNORE_VENDOR_TELEMETRY) &&
+	    (usage->hid & HID_USAGE_PAGE) == HID_UP_HPVENDOR2)
+		return -1;
+
 	if (rdata->is_mt_collection)
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
@@ -2457,6 +2479,11 @@ static const struct hid_device_id mt_devices[] = {
 	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
 		     I2C_DEVICE_ID_GOODIX_01E9) },
 
+	/* Goodix GXTP7863 device with FreeTouch heartbeat on page 0xFF01 */
+	{ .driver_data = MT_CLS_GOODIX,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8, I2C_VENDOR_ID_GOODIX,
+		     I2C_DEVICE_ID_GOODIX_01E0) },
+
 	/* GoodTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH,

If this approach looks good to you, I can formally submit it as [PATCH v5].

Cheers,
Ruzal
