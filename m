Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881D41D131
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954818; cv=none; b=CV6Yr1ctTCFYSut+ZMm7082CJ4rhuQjLqNTmRjOMf7E+9oneVN6ccZ8dZDTH9oCqXFSzcPw7F4xHreJeD22lKlYLr9HRya9sH9+oP+B8MIKHd3ou/g3Wty0dOItsOPVJNklSYd7wq+yaCUtJJHlHzMkfdIRCcqBmo4F5Sia1Hoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954818; c=relaxed/simple;
	bh=MQqoQaB1FyoyMJ+K6yDem6WMrchPow1EhO4d1DLyKj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shPIgwg1c6L56kR1L8BNng88SqkGRqNhhWJ4mqon0XzpNyXDLsZexNBVxag5ssEuCUv4Z1dJienZNO/tdFQi3VNQ4ctl1lcRgBrMPm9Rbkfi7jSnOhc709uXasmd9vVWbOel8Ao9pxL16d79hsBui1I10cz15vcwJgZ2AYqvmvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aznMqGAa; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aznMqGAa"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35b2c599f43so4166958eec.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954816; x=1792559616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JDi1ZUpchAKrAeynCZ008rcYzeK/yq/xfHew59IB4Z8=;
        b=aznMqGAabPfsZK8qdbwxW614EkmctvdX4zNWe1xKXsU5mpn8aBpnNi3k2ggtJ2w36U
         OV9fkrbXv1E2ltrpbJlmHJ6lPX09Y5c2mIMFn56NVEIGKDaOeo3BbSs5ipkeXSkyFxm1
         10djiTOzIVJiFBJp6FYrBTJC2zCJ1I+C/aNnzIpPmriDXyZe2QjTEx/T2fXu3VV904e0
         R4HAyy3FE76AVNY/EAzVWck3ft8emOxtHR3HTesH/mdLVRAvnzK6qpk//GD+3jemT0VN
         P06b8ogTrBJQWwIcG4f1iYegL0w7zi3NaEyfWYR/ZrrzntZl6XUTDTrnSuQtf0mRXNQH
         vrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954816; x=1792559616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JDi1ZUpchAKrAeynCZ008rcYzeK/yq/xfHew59IB4Z8=;
        b=ObCtM0v1smPvErImO92GjEmKTKoGs7t7FN8EQRLpiRqbziKkrvQF82Vd0yFExbGM1l
         7ByvRyq76tjkFiNQRurjRNbIAZ8yrzQPbfQKfDzEU3f7kgX6wcKm+lZlzoepTzDEfczb
         E1xXND3nLCmGR0eyBHh1KF9i8fpSYb1nlF/EsLI29O7xD4QLggjHVEIDsD9GuvxzQvSo
         EiGFOhxRjocqyafSkVdxVLCrM2Gc3OA9e/i0qIwW8FAzz9CDMZNuOiJdMcxY+BMHieKe
         pn6u0AOJr+dZSZmMpuEjxip/Al4LZ0Z/mjnGX97hKp1SX5ChWFOk1b4oGDyhJU9TrZF1
         EPDw==
X-Forwarded-Encrypted: i=1; AKwUvByLeot7xtRP9z5Mhjs2MUGJPBxrDHsPv9oGnf3ODy7GEo6Xwy2gxSIJt5xKlTaRi9WDbMpLWVVepcR9Tg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSYYflufWFLJ8byoQwYuQlESEIayVhACs2GQut8x32vaqXLFIb
	rj8UslW9B60/E9/nX6Hdwap0V+FGQE+cgE/KSlU6yQHksT93EIZE6Qyd
X-Gm-Gg: AYBFou1zs3VNMST9mu3290ytVdo+4vov8OktqIIbq0zG54SrSRsttqk5sFI/NMSuaFq
	ptA5h0/CiR/JytDoUtmuTJFYdm4J4A8YqIt1Ik5A004jqJNjdBbaedXqTI9LSFptxintu+xScKS
	ATPguB5SMP9g6c5SMlYbjbguYdqmw3oR758ENYwKcwnOW4wo1ayr1rvsVU0kfUN5NUmW+Lbshoi
	k4K6HOCAbUCsJajodja1WEo9R8yMSXCC40CdICxLail2x8FVk/6pzPZkpHASxlWi97tZODuV0lS
	Ivw7MJ5aH+gW0uF1vRbXH8tw4a0b95TZYlmlLSE8q8z361Hpa9OGlL8vquuiPOnXAaO2ukZMJ3u
	L7TX1EhaawpBOzguHzEdqf6S27oyZZX5Y41ePYGyqmCn/PS9alGwPISEpJPdXST0mVXUnUc22b8
	X+S3ZcJUNJmtXTBgxtGSJaCq32Pd3b8Gf1WpkmRrOOue0mTRRG5Nz4mkPz2qurmX8W8wmGAmgbB
	28sIv7UoeZeyumfmFjfWkV8PqhY6EU4QAqEW+8XQp6x0elSAs8OIMdjinPC0bE=
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3537db99e8amr27762456eec.0.1791954816356;
        Tue, 13 Oct 2026 22:13:36 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm51629125eec.21.2026.10.13.22.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:35 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] HID: Use hidraw_instance() in drivers
Date: Tue, 13 Oct 2026 22:13:23 -0700
Message-ID: <20261014051326.3784498-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
References: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index f9bcaeb66385..1d2657edab27 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -587,6 +587,7 @@ config HID_LCPOWER
 
 config HID_LED
 	tristate "Simple RGB LED support"
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	help
 	Support for simple RGB LED devices. Currently supported are:
@@ -1252,6 +1253,7 @@ config HID_TOPRE
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
+	depends on HIDRAW
 	depends on LEDS_CLASS
 	select HID_LED
 	help
@@ -1285,6 +1287,7 @@ config HID_UDRAW_PS3
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
2.56.0.385.gd3acb90ef8-goog
