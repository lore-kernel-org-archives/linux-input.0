Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635249426C
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190531; cv=none; b=nWnRDO7U8Q+pxbwNhhDNQaybgZq6BdicKswxkORbh0gsysnBR2WNUzOyM0sjE3kyK+AA+kGvUgHMEL8f6CuFPqRkMns7I9MQKfyROdKyST5m/M7ebg74RLcouHPDol396sbr3iB9eHo6YpFwQs1AYZl7Y72ZFD9xjYEUbckp2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190531; c=relaxed/simple;
	bh=Gh4x85xhDRMYU4nqx32tZhihvuy8fo+fLxcKNdJqsYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkCR5qJ9Xq+Ux7HIMCysKho3xnh4UwT4+OzhOAOKw+kGD4w6Pfrvw3nKEPHJb+qS+HRBZzOnL3/UPzNI6M4s2CGCM93ziua+OZG5wyqqRMp1GVI0hJ5NKiWZ1rSEOlHUhLN0oVSuqO8qwglapGpGyN4KDvjII2U20GLMPWqWPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7+hxHBG; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7+hxHBG"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30b6dad2382so1143050eec.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792190529; x=1792795329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c9z6d9OD49AKTUfCODTcTvczn5+OsFSiJsACZgNn1w=;
        b=Z7+hxHBGsnNc/iI3P1QsWo7zNEgD5F32hQKI6+ReHcl36M6moVeoe/7Ie6ViiTxnRo
         lhxq0OI2TyTu8eLjynElZ5oIEUBepM9FP9Xry0ZwgzzzQmPxjok2QCDhbYhHhAvDY46i
         oZqIy4wKG+Lw4w00LHX9wlStxcnaHGGg/X//fkEsg73xr7Q+QbP9OqhFmpgPDgs7ZXNN
         NEqD7HLi36+4pIVU7SVszgg0XeTLOxibu3TgCGdR0txZ4iJRKMC+oND5Cxeds+eRij0h
         ZT6mJ7gX7kLSmNmQwqjZOdKkZDE3cM0WHAbOMdjGVYw7k0GLnLsKuIXLGJ7AqRQLiD0E
         w23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792190529; x=1792795329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c9z6d9OD49AKTUfCODTcTvczn5+OsFSiJsACZgNn1w=;
        b=RMONIgSu7orOIh7e3neidC8L7w5hpWDR2Nk2XO3SrjeaEvWXh18d/a1szJoG6MmPHW
         5uk7Gq99S9YkjulTqkpOjHvyle9XmvyCLH8J4YD9qybw5sNDDIJ7AjJRgOCz591JzVMt
         DHdjjASK3vIr5RSd74jRqYmvv/wdvmXuTFQNVL7rOQRkViolltQ5VMyg4bd2XxSxmYQG
         ZNCH8hJ66yeM5gHC8O7o8pj14kGErhAGaQ/dl7hlEQbb1iV33x9LskOwKJ7662OtvOb6
         1Xc5wW6FLSAo27kz8u2s6TfknzT2actbF1p8SBwwhbUP31kSEdG7pbwHemeiI6DbFvac
         hB+g==
X-Forwarded-Encrypted: i=1; AKwUvBzXifkxNZ6nmLhzqqVaeSEgf1RbpygjlA6iGocJYTgIlQA0zb3zmy5XwBJ4E2FfiBAqH5pAjBJgcPl46g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIe9U9CsYYMtGUKW6ufky46t+MZ8/tDwSi6aOuhXYFOHAOMg+Zl
	bXB2y4moyAZ2XY+BP3qzXsStRhOeiSwJQiYvcTXJrG+oUBrVAsxV1AGp
X-Gm-Gg: AYBFou3XP/OXyWIJGX7A5XU0/dPp5grjeKNI4mTJpVgQMVg/KVRbQ2Xl5BJzlIXROVK
	dm73Q1tnIytOa01IzDMtYeU/nGkJ+woeeGWtuEuH0A0P6Hw+XXOxmGimxeHM2uN4M++RQ54Nt4P
	ibjV+saHOxXfqvzQZ1a1oc3/rcnherRw0tw3xjHPQZrCw+eAJm4V3o4/v1+3XFdb/SgOXYDrSh7
	SCTtS6V8NKBqHzx+FhB93URf+BDV+uqzuz+v/E0T5qlt2/Nha2ptS+06fMydFNW46ohYFjYqw8z
	pznf9eJy4Yz4TiUIUfyWFir8fnHFkMnF1PoSw73jn06Z1rZAtoYh7NmvFiSQ/nKu9F9zQQ0vN+3
	t6Pnu3BDTqNt/maRqk8bI6Gt5NaJNNACRkS16xg7HI0YSoySqElSpm2yv/4jweIYhoYVnLRcAPA
	qBQ8NBH2+b/AY8sFHKUcL0N7Eej9SWCDtxJIf1nJPfb9Tny1lUkOeh/Vqt93UsrsshQQU4Wf0GZ
	RI0APBD9jH9LVqGpnKakS7NwxbjhLlgCxAsa+sAoEZHkNwQnE/zyVqS4PqWE/k=
X-Received: by 2002:a05:701b:4201:20b0:168:6ad8:e89f with SMTP id a92af1059eb24-1850c22369cmr1762385c88.3.1792190528603;
        Fri, 16 Oct 2026 15:42:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:34f0:f27d:9a5d:56e0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm8252348c88.21.2026.10.16.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:42:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 16 Oct 2026 15:41:50 -0700
Subject: [PATCH v2 3/5] HID: Use hidraw_instance() in drivers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-test-hidraw-base-v2-3-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Michael Zaidman <michael.zaidman@gmail.com>, Rishi Gupta <gupt21@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Andrej Shadura <andrew@shadura.me>, 
 Johannes Roith <johannes@gnu-linux.rocks>, linux-input@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Instead of directly dereferencing struct hidraw to inspect minor device
numbers, use hidraw_instance(). This removes the dependency of these
drivers on the internal struct hidraw layout.

For hid-cp2112, fall back to dev_name() when hidraw is not available.
For hid-led and hid-u2fzero, require CONFIG_HIDRAW and propagate errors
if hidraw is unavailable.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/Kconfig       |  3 +++
 drivers/hid/hid-cp2112.c  | 13 ++++++++-----
 drivers/hid/hid-led.c     |  8 ++++++--
 drivers/hid/hid-u2fzero.c |  8 ++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 0e3a0ccd6901..ff38b589f576 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -604,6 +604,7 @@ config HID_LCPOWER
 
 config HID_LED
 	tristate "Simple RGB LED support"
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	help
 	Support for simple RGB LED devices. Currently supported are:
@@ -1290,6 +1291,7 @@ config HID_TOPRE
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	select HID_LED
 	help
@@ -1323,6 +1325,7 @@ config HID_UDRAW_PS3
 config HID_U2FZERO
 	tristate "U2F Zero LED and RNG support"
 	depends on USB_HID
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	depends on HW_RANDOM
 	help
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..148946b04bff 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1225,7 +1225,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct gpio_irq_chip *girq;
 	struct i2c_timings timings;
 	u32 addr;
-	int ret;
+	int ret, instance;
 
 	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -1330,9 +1330,13 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->adap.algo		= &smbus_algorithm;
 	dev->adap.algo_data	= dev;
 	dev->adap.dev.parent	= &hdev->dev;
-	snprintf(dev->adap.name, sizeof(dev->adap.name),
-		 "CP2112 SMBus Bridge on hidraw%d",
-		 ((struct hidraw *)hdev->hidraw)->minor);
+	instance = hidraw_instance(hdev);
+	if (instance >= 0)
+		snprintf(dev->adap.name, sizeof(dev->adap.name),
+			 "CP2112 SMBus Bridge on hidraw%d", instance);
+	else
+		snprintf(dev->adap.name, sizeof(dev->adap.name),
+			 "CP2112 SMBus Bridge on %s", dev_name(&hdev->dev));
 	dev->hwversion = buf[2];
 	init_waitqueue_head(&dev->wait);
 
@@ -1494,4 +1498,3 @@ module_hid_driver(cp2112_driver);
 MODULE_DESCRIPTION("Silicon Labs HID USB to SMBus master bridge");
 MODULE_AUTHOR("David Barksdale <dbarksdale@uplogix.com>");
 MODULE_LICENSE("GPL");
-
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 7d82f8d426bb..63fd723d9e69 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -448,7 +448,7 @@ static int hidled_init_rgb(struct hidled_rgb *rgb, unsigned int minor)
 static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidled_device *ldev;
-	unsigned int minor;
+	int minor;
 	int ret, i;
 
 	ldev = devm_kzalloc(&hdev->dev, sizeof(*ldev), GFP_KERNEL);
@@ -488,7 +488,11 @@ static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret)
 		return ret;
 
-	minor = ((struct hidraw *) hdev->hidraw)->minor;
+	minor = hidraw_instance(hdev);
+	if (minor < 0) {
+		hid_hw_stop(hdev);
+		return minor;
+	}
 
 	for (i = 0; i < ldev->config->num_leds; i++) {
 		ldev->rgb[i].ldev = ldev;
diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 82404b6e2d25..83e223c12cd6 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -307,7 +307,7 @@ static int u2fzero_probe(struct hid_device *hdev,
 			 const struct hid_device_id *id)
 {
 	struct u2fzero_device *dev;
-	unsigned int minor;
+	int minor;
 	int ret;
 
 	if (!hid_is_usb(hdev))
@@ -347,7 +347,11 @@ static int u2fzero_probe(struct hid_device *hdev,
 
 	dev->present = true;
 
-	minor = ((struct hidraw *) hdev->hidraw)->minor;
+	minor = hidraw_instance(hdev);
+	if (minor < 0) {
+		ret = minor;
+		goto err_free_urb;
+	}
 
 	ret = u2fzero_init_led(dev, minor);
 	if (ret)

-- 
2.56.0.176.g3575e65682-goog

