Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B226ED46
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076308; cv=none; b=RwA5I+QHSMD43QgZ6/yicNkuJm/QWGTgdUB5gCwvC8i/vzF/dL9k22BNFjQ0lQszUrZV0e3gb4KWdySkL7pxdEx0RgGrqlWpQhBJglTcZslj3ARntcgeqbKxMr+kRVAyk5yV4CqYUPYIhPeRdp5OdwfpozDMT7mFvQ8/6cIsEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076308; c=relaxed/simple;
	bh=RRwWHtshglt5yqGVok9CNhqryTp72L8dsZ7LKV0Q7I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVeDsV+AMBvoBMc0GdcqexKoLalpigs+CUryMUtOlhw3zG2GJ5ozWhorgqkl6BFhC33o9CeAU2gRoTP/eWZdiN/HMHY9dUPunxNmkQLrw6z4KIeY9X67422LxA+y0nNqbgZHcHhF1HUO9DcJZKK0szmT+j41PfyBOcjYe3GFg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyZUyt1M; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyZUyt1M"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6626b5ace23so220301d50.0
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784076302; x=1784681102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kL8qks2Ku4X0rwAYB/xcPiZozEFepjNhKVT+TPeilco=;
        b=XyZUyt1MA/D+d1AcEuUhsUXILtO7g7zvwL5pdJjbxwPtbE++4FYhM76+Q/qwvvJGg4
         Y1VsU7ngnTK5Dgejix/asww5cEZ8z2jUPaWILMCIkDO9m+uoEBembmOxTLpj46PF7zoe
         37pi30gl4burwoQvypBkrvUE4Cn2Eeb+mAn3o1K7fiAwTdOe7z6C3jJhO/BVDOGgIFBE
         Oqq6xXxT9PUG0FTmMGjFS9d38BtvNodWVIShlaOL5Tr8A2nTz1GxVFUo6xmR5SfXNzW1
         PImUmM9OtN7cJ8jlkqjeYs+PMuQ+PoNXrP2B9ocnEZLUmhipdYKxSi8Tc2+wjNCfiSAl
         /1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784076302; x=1784681102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kL8qks2Ku4X0rwAYB/xcPiZozEFepjNhKVT+TPeilco=;
        b=aWzvEAhpoBi9fO8zJw+Tz7jgxD2/IuJyJr9bir51mxB5PLbsXz2kYNjs4Hu5zGJXy/
         hAN9xOz5AdZKN+Nln/3qx89dOFwMrgNYtHhdVVG9MoQSuVlB1BC5POsx3G03Pl42Tvym
         549GkHujJz5wUFqhIp6a8khgu/Rzo0ee1AK/sGj2kRlMiMFC1aEE8IFDqYfXELZF4m9S
         IhPdGzjVi3Kt11S1JJZ3beYikbUuZPQVxx8s1ONqk5pP7AUHG4qCKC1ojkh7XgN1gu7G
         f7YB6hh/C4rkZzv1qJ7R+a4kVfMc+eSW6kBdyJzKXWMpyZ6Awdo+SFS2otLxlbrk9sRN
         m/aQ==
X-Gm-Message-State: AOJu0YzvOyn8BoBB0e0+TSyBkumhzxsvOUyzBD9dL084BMA78CurRH86
	IewGogV4/jDwBexMNqA24FQjQR8DaVr6Z7+Q0mAm5tumT2j5ncXxoU29
X-Gm-Gg: AfdE7clEGeVyTXkzvP7fv9L3l/BmeZPceNtUOJ4UUEH5/DGaBDHZ+y2oGL+rqFcD8oW
	ZFBtVpLcRWRAsIg3sLiheOnONdYnPZRx81sicB0awO45HOFPu6G8RBpjrn9PXDvcZ6DtzGuG2TP
	OJ/bXXSQJ3R2fOr7JUR17qYnAD8GMiOAYerPe4e0KuqvAJOuUprIPylOd9Kb4duCvZLsjDRbHmH
	ezym6GbVoyzZ/grrdHYCAg2Yp2uE84g0QJw97VjusetM6x+S40EgBLQ4+1yVSrO0KV3x6cqpUiv
	zghV3/51Skaf8cyHXLlDAWbqw81cRU0Rgylxu7P3uE8Xe32j1XhgLPoZ2z29aM72X2lIiJ51TOE
	FSu/4CL27Oz/PXT71Fqis6MS2GeNdlf4IcN5noRTll6GpN2iXY/w4TR7E2mNlKH24OSZmi+gxN6
	GwZzazmBRk+SmktR3S/Tdds0d/if3Y
X-Received: by 2002:a05:690e:1918:b0:664:b3c0:653e with SMTP id 956f58d0204a3-667d98ec083mr9639668d50.29.1784076302151;
        Tue, 14 Jul 2026 17:45:02 -0700 (PDT)
Received: from arsenalgear ([2a02:6ea0:c10d:6070::20])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a5b4adsm17753074d50.18.2026.07.14.17.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:45:01 -0700 (PDT)
From: Uddhav Swami <uddhavswami@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Uddhav Swami <uddhavswami@gmail.com>
Subject: [PATCH] HID: add driver for Gigabyte Aero vendor-specific brightness keys
Date: Tue, 14 Jul 2026 20:44:57 -0400
Message-ID: <20260715004457.100650-1-uddhavswami@gmail.com>
X-Mailer: git-send-email 2.55.0
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
 drivers/hid/Kconfig        |  10 +++
 drivers/hid/Makefile       |   1 +
 drivers/hid/hid-gigabyte.c | 127 +++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h      |   5 +-
 4 files changed, 141 insertions(+), 2 deletions(-)
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
index 000000000000..1c242734aed3
--- /dev/null
+++ b/drivers/hid/hid-gigabyte.c
@@ -0,0 +1,127 @@
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
+	struct input_dev *input = hi->input;
+
+	input_set_capability(input, EV_KEY, KEY_BRIGHTNESSUP);
+	input_set_capability(input, EV_KEY, KEY_BRIGHTNESSDOWN);
+
+	drvdata->input = input;
+
+	return 0;
+}
+
+static int gigabyte_aero_probe(struct hid_device *hdev,
+			       const struct hid_device_id *id)
+{
+	struct gigabyte_drvdata *drvdata;
+	int ret;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, drvdata);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "gigabyte_aero: parse failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "gigabyte_aero: hw start failed: %d\n", ret);
+		return ret;
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

