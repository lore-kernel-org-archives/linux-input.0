Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF953B8105
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095198; cv=none; b=JU1rzas7vjk0fn9mWm0hOMMjj6WmFARkaDYyoDuw6aSAHbc9SP9pndwysponI7bOReqHKhLhvEZLmxEmMqMmtPcsfZHIV8Z1L5myC53V7vgqATifvPC43N3Jcmr4guGucYr9zMjpuuRpZIGQ9P6GuJS+G+6jdIMV6vHaVkBfgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095198; c=relaxed/simple;
	bh=m6dZVzLShvxQsGHK3VxIE9Sjt7/sw19+HhSeN0dQKKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=girICKxPF5EE4QKzR6PdQCmSid8YrBT1lzO6xudoN5BdfduvHhbeZQiuwb1cG/CXMvz57+RQPz6D1vgEDmnVhzkakAIlMS35Ucx9JKlczkCZVGqiweMVIPjI3vMgUMxoeIZlmXmtGPEiSQBn2ILObfPozzKuHpxbFHOYNM33Mk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+I60aRk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+I60aRk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ed27fe974so1619657b3.2
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784095196; x=1784699996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxpyTgMMN9g4VKGoiVHYmeZxsbeCKWj9b8FRsbqnMK4=;
        b=H+I60aRkhcdHThvVeSHfY6KHN4GKHLmvXX5ZqwzV/+jy7KZSlO9+cq7RotfnCqKrsY
         gp7zvthAfA5WYUThI6yFN2VGoNst9JSfWi7+xhKpmZqc9jZ2efzGIEt8H0kNnRFfAy0B
         8TPUkXOCiHrBPwyx8jquEXOICa2XEcAzAv2kWe3AHdMfRT3d1r7Fdd2OvC5d2EaK/hEe
         Fl7lKtlejPjAt/96WdSwbVq3ElAEFDOkDI7b4cmiGG9TmeZNOaTfVZHof1sIN/kStvCT
         RYB6H2A+TeWX/r8VikZN+NtISy47dfZnuEJbYJ9PeuK80aAiTKSJEupC3c9KIRgH2+cl
         TMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095196; x=1784699996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxpyTgMMN9g4VKGoiVHYmeZxsbeCKWj9b8FRsbqnMK4=;
        b=iaOD4cSBR76ZobuCsPPV2T4aU96inng7fQcfxaLmvpCJ4JF0bSoEPnAtKn15bbixX4
         6DlpLjI2+4wZIh2n7F6/Ikp2y0h0KeodksloO7y4iwnYlXBmpVP/1C4PR5gjI5GAGD/o
         4AVEUu1fQ0rRySPiTIu+WS4zCOZT+619087WDuEvMjx2P6QxH2+jiZWZjxLux78Uav+N
         xUCCIkdL1a1zxVBAMAU2lXmw6HyoBdUiLc7D0qXq0shf4QjxmLZXJLTO02JlQ2LX4ip2
         j6fNKdRCnmr56CpH2XJ2MpRBxvKfA2EQ/VWMXvSEIMPySEyh/qSs29o3OeqbUAlanDeQ
         SQ7g==
X-Gm-Message-State: AOJu0YyypAemv/a6udcAuMLx9dmyAGCH5tCoyLoY3VKA33j2mSKKT8Gu
	ihy5LqyNsZqyNZowfSw8abSG/Q2czEkMO7iJhOzRu1qVHcxg3bIG+R6y
X-Gm-Gg: AfdE7cnfEYkqClloixAM69wYIWYXqbhwhTXw3anBgtzUMq7djx6wbU6mh0eC5muMSNS
	9zsSUOGpB4fLGsVdSdqkxfrCZmtrZZNBjVAC25UztIfNWYuSqG+yIJdsJUZERAeZvK2dmnHYhKA
	sU5dkev3YCGGg3t+p5Zoi2+2x9alSm37IC3PvLr+N3hq3AQidELwmtPD6moa5c3BvEPO5OWKJ2F
	5VyGih88wvO9aCZyNDM+u9nTgrD6XPubc9Xa6JuNNFcQ41jIeZ3VCXJWhcZW0svIKko+zNT3ldc
	caD0qmvfH9DKHgJtYE9guz+VZVbsDbaKmbbOIMK9EH6DhC8HmVRBzP8Go50GOMdle4RpPTNgf01
	oGWpJ9JbbQiBGRJfvs4Ed4iXICP+irJSxD+sBT52vE7bT9EoacLabqrK/zIgl8R2gGem5U1Jo5R
	jkuesXbKV2kVttefhRF6QZQEFgHHN1
X-Received: by 2002:a05:690c:2604:b0:80e:5236:b944 with SMTP id 00721157ae682-81e9000f56bmr117831387b3.10.1784095195674;
        Tue, 14 Jul 2026 22:59:55 -0700 (PDT)
Received: from arsenalgear ([2a02:6ea0:c10d:6070::12])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1ee7b3sm162032127b3.36.2026.07.14.22.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:59:54 -0700 (PDT)
From: Uddhav Swami <uddhavswami@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Uddhav Swami <uddhavswami@gmail.com>
Subject: [PATCH v3] HID: add driver for Gigabyte Aero vendor-specific brightness keys
Date: Wed, 15 Jul 2026 01:59:51 -0400
Message-ID: <20260715055951.15144-1-uddhavswami@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715004457.100650-1-uddhavswami@gmail.com>
References: <20260715004457.100650-1-uddhavswami@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Gigabyte Aero 15 XB keyboard (Chu Yuen Enterprise Co., Ltd,
USB ID 1044:7a3f) sends brightness up/down keypresses as vendor-defined
HID reports (Usage Page 0xFF02, Report ID 4) rather than standard HID
Consumer Control usages, causing KEY_BRIGHTNESSUP and KEY_BRIGHTNESSDOWN
to never reach the input subsystem.

Add a minimal HID driver that intercepts Report ID 4 and maps values
0x7D and 0x7E to KEY_BRIGHTNESSDOWN and KEY_BRIGHTNESSUP respectively.

Tested on: Gigabyte Aero 15 XB (USB ID 1044:7a3f)

Signed-off-by: Uddhav Swami <uddhavswami@gmail.com>
---
v3:
  - Restrict registration of brightness key capabilities to only the
    hid_input containing GIGABYTE_AERO_REPORT_ID, avoiding the registration
    of redundant/dummy input devices for other collections (reported by
    Sashiko).
  - Scan the hi->reports list to find the report, as hi->report is NULL
    unless HID_QUIRK_MULTI_INPUT is set.
  - Rename the error return variable in gigabyte_aero_probe() from 'ret' to
    'error' to follow input subsystem conventions.

v2:
  - Check HID_CLAIMED_INPUT after hid_hw_start() to avoid potential
    use-after-free if input_register_device() fails during probe.
    Reported by Sashiko.

 drivers/hid/Kconfig        |  10 +++
 drivers/hid/Makefile       |   1 +
 drivers/hid/hid-gigabyte.c | 144 +++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h      |   5 +-
 4 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-gigabyte.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 03f36899e458..fa74e67e35c8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -406,6 +406,16 @@ config HID_GFRM
 	help
 	Support for Google Fiber TV Box remote controls
 
+config HID_GIGABYTE_AERO
+	tristate "Gigabyte Aero laptop vendor-specific keys"
+	depends on USB_HID
+	help
+	  Support for vendor-specific keyboard keys on Gigabyte Aero
+	  laptops
+
+	  Currently the following device is known to be supported:
+	   - Gigabyte Aero 15 XB
+
 config HID_GLORIOUS
 	tristate "Glorious PC Gaming Race mice"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3dd0c56..ef3a14b04126 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
 obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
+obj-$(CONFIG_HID_GIGABYTE_AERO)	+= hid-gigabyte.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
 obj-$(CONFIG_HID_VIVALDI_COMMON) += hid-vivaldi-common.o
 obj-$(CONFIG_HID_GOODIX_SPI)	+= hid-goodix-spi.o
diff --git a/drivers/hid/hid-gigabyte.c b/drivers/hid/hid-gigabyte.c
new file mode 100644
index 000000000000..5a66d270ea8e
--- /dev/null
+++ b/drivers/hid/hid-gigabyte.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for Gigabyte Aero laptop vendor-specific brightness keys.
+ *
+ *  The keyboard sends brightness up/down presses as a vendor-defined usage page
+ *  report instead of standard HID Consumer Control usages.
+ *
+ *  This driver intercepts them and emits the correct KEY_BRIGHTNESSUP /
+ *  KEY_BRIGHTNESSDOWN events.
+ *
+ *  Currently supported devices are:
+ *	Gigabyte Aero 15 XB
+ *
+ *  Copyright (c) 2026 Uddhav Swami <uddhavswami@gmail.com>
+ *
+ *  This module based on hid-asus by
+ *  Copyright (c) 2016 Yusuke Fujimaki <usk.fujimaki@gmail.com>
+ *  Copyright (c) 2016 Brendan McGrath <redmcg@redmandi.dyndns.org>
+ *  Copyright (c) 2016 Victor Vlasenko <victor.vlasenko@sysgears.com>
+ *  Copyright (c) 2016 Frederik Wenigwieser <frederik.wenigwieser@gmail.com>
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/input.h>
+
+#include "hid-ids.h"
+
+MODULE_AUTHOR("Uddhav Swami <uddhavswami@gmail.com>");
+MODULE_DESCRIPTION("HID driver for Gigabyte Aero");
+
+#define GIGABYTE_AERO_REPORT_ID 0x04
+#define GIGABYTE_AERO_BRIGHTNESS_DOWN 0x7D
+#define GIGABYTE_AERO_BRIGHTNESS_UP 0x7E
+
+struct gigabyte_drvdata {
+	struct input_dev *input;
+};
+
+static int gigabyte_aero_raw_event(struct hid_device *hdev,
+				   struct hid_report *report, u8 *data,
+				   int size)
+{
+	struct gigabyte_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata->input)
+		return 0;
+
+	if (report->id != GIGABYTE_AERO_REPORT_ID || size < 4)
+		return 0;
+
+	switch (data[3]) {
+	case GIGABYTE_AERO_BRIGHTNESS_DOWN:
+		input_report_key(drvdata->input, KEY_BRIGHTNESSDOWN, 1);
+		input_sync(drvdata->input);
+		input_report_key(drvdata->input, KEY_BRIGHTNESSDOWN, 0);
+		input_sync(drvdata->input);
+		return 1;
+	case GIGABYTE_AERO_BRIGHTNESS_UP:
+		input_report_key(drvdata->input, KEY_BRIGHTNESSUP, 1);
+		input_sync(drvdata->input);
+		input_report_key(drvdata->input, KEY_BRIGHTNESSUP, 0);
+		input_sync(drvdata->input);
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int gigabyte_aero_input_configured(struct hid_device *hdev,
+					  struct hid_input *hi)
+{
+	struct gigabyte_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct hid_report *report;
+	bool has_report = false;
+
+	list_for_each_entry(report, &hi->reports, hidinput_list) {
+		if (report->id == GIGABYTE_AERO_REPORT_ID) {
+			has_report = true;
+			break;
+		}
+	}
+
+	if (!has_report)
+		return 0;
+
+	input_set_capability(hi->input, EV_KEY, KEY_BRIGHTNESSUP);
+	input_set_capability(hi->input, EV_KEY, KEY_BRIGHTNESSDOWN);
+
+	drvdata->input = hi->input;
+
+	return 0;
+}
+
+static int gigabyte_aero_probe(struct hid_device *hdev,
+			       const struct hid_device_id *id)
+{
+	struct gigabyte_drvdata *drvdata;
+	int error;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, drvdata);
+
+	error = hid_parse(hdev);
+	if (error) {
+		hid_err(hdev, "gigabyte_aero: parse failed: %d\n", error);
+		return error;
+	}
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (error) {
+		hid_err(hdev, "gigabyte_aero: hw start failed: %d\n", error);
+		return error;
+	}
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
+		hid_err(hdev, "gigabyte_aero: no input device claimed\n");
+		hid_hw_stop(hdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id gigabyte_aero_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHU_YUEN,
+			 USB_DEVICE_ID_CHU_YUEN_AERO_KBD) },
+	{}
+};
+MODULE_DEVICE_TABLE(hid, gigabyte_aero_devices);
+
+static struct hid_driver gigabyte_aero_driver = {
+	.name = "hid_gigabyte_aero",
+	.id_table = gigabyte_aero_devices,
+	.probe = gigabyte_aero_probe,
+	.raw_event = gigabyte_aero_raw_event,
+	.input_configured = gigabyte_aero_input_configured,
+};
+module_hid_driver(gigabyte_aero_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b70f719b3b07..e33cdf33929b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -330,6 +330,9 @@
 #define USB_VENDOR_ID_CHUNGHWAT		0x2247
 #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001
 
+#define USB_VENDOR_ID_CHU_YUEN			0x1044
+#define USB_DEVICE_ID_CHU_YUEN_AERO_KBD		0x7a3f
+
 #define USB_VENDOR_ID_CIDC		0x1677
 
 #define I2C_VENDOR_ID_CIRQUE           0x0488
@@ -1319,7 +1322,6 @@
 #define USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE       0x0368
 #define USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE       0x0369
 
-
 #define USB_VENDOR_ID_SONY			0x054c
 #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
 #define USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE	0x0374
@@ -1610,7 +1612,6 @@
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D65	0x4d65
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
 
-
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
 #define USB_DEVICE_ID_RI_KA_WEBMAIL	0x1320	/* Webmail Notifier */
 
-- 
2.55.0
