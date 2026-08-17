Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2683A9628
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952007; cv=none; b=bZP27WJrWO7yhhBrrHCt+IYgHnCoFGf4vV2irWBeLs/RnoTQdSgoEWIHbQMEExcRcMZNRZAhkh5zNEEPLRbNFbSHVhgoptCQq8G/wv7RqDtzGDf01ks9AJ782v34SGJPsxkNl2CUrkdxmEyKNLYKxwV/6lkga9+W4sui2qKC5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952007; c=relaxed/simple;
	bh=jl33vFpnY9fPrrbbaNA6bbnkAR/1c8RUySDAdABwS4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJuhRmnOfK3lXJvH+uCCEtqMVUhfL/Cog6UrAV6oJ8Kwrk0K9JC4M4kJ1kceFeiB/M6cEB7ru7uaBx98MBwiopmfDcFlenW12FzQeIzXwpJP7kKjeXNJRtsgn96LBAUziKWRuhwrsmTb/caHXe3MJrQ9k4VBGaYoY+GaF8sgFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5DtP1fh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5DtP1fh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2244668a12.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786952005; x=1787556805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVAAa0Dt4F7KI70K/neRMqTnPTSe3vM2XIsc8a2kCM0=;
        b=F5DtP1fhTvhjvrSJz60U3iGWtAwjpy6Ll/qnRFUeapEndK90KeaitTSdwqP5qeneB4
         3IS0R+7XhX0lgRZbXbljsWGW3Yf10/wW60BXTUBssU7jmqqtKM0pTpeW3pejiTZKdmTL
         3saBUlzrNzy8RkDju18JdTC6IX8hHsMQGCiS7xvg2q3BqBwkc0eW+b7XD78I7NsnDgTU
         0HhyEnFjISuD4Znxlm68gSCSuyoQ1znhMHeSa2b2/nejhm2yvMhKAxqDRzUC7Ysx8PMu
         z1QuWnwy8cvtklX/TBvfCpzXvNxpY1ShubJAAh1+ESpyaziCfPgEM7CFzTu1pD4apC2a
         MTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786952005; x=1787556805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVAAa0Dt4F7KI70K/neRMqTnPTSe3vM2XIsc8a2kCM0=;
        b=mu9fDPqt6/1ma5h32mJtL4gBh5kgXoht20fZR2jzpk1hLoUwHamvvHJU6zxNeqbeWp
         mi3DY6NE+YhI/kjocw1+k/4ZxfBZFmzyISSCOKse/CtWPQQODGvzR6+MbBp8jD6G7F9c
         mHkd6dcaFg3C6Igbm2shTv/ddr49byBrATiCy7TEQkogu3F9z3Pn723o/4cD3m2kOi4F
         RS0+rvrjyGCvUgB+tsE95sUxmGCYu6Q1qHuXVDFIyS3YefekZwzibZTU6PKVm34zxXZV
         FGqi1ohu9QXWcgcLG413dKR+IXFviolcPvrGcnm2q41bhJEZ0ERU3xoknOxH6wH/ich0
         a80A==
X-Gm-Message-State: AOJu0YyNQpxYf5tyGkvcFFX2mW0LAaIxvKGTs9ddPIKzeIPKMy3cmHp2
	npEY3JP8ka/DCaJFjgIYFkbU4gInN5u9PyOgqwFYJVzIpQkQRexnjGnE4w0EJtDvSR8=
X-Gm-Gg: AR+sD10C7DSUhGNgTX8rnHLfPP54fzT1xo+dzv6TYgfyS5UeuoQauSYPRpcM0jOxsU2
	7bB2VQyAC670YPX+5uc9REHgRuCxkJowVzwfVPrFoNpRo/caNk7CyJjA2O6rAkIqMxl2jNv3UBl
	/Ti/3VpbStCtNwu7GETqxCDRYSgOSIQ5cZJzKAthuonuqg+kkwGhoUIzOE4JDb/ZOUqUiQ88+Ga
	3hkSGWXZGAz8kn+i7DRpxdjL0BBLnjjA2qem47NA40p/0L1j/AoooivdBTXGhiSEpQQ+HM8l39k
	asCdtc776k10iL4KuToCyU9WdM3zY8toqcQFaGAPZt/SwLs76VrfXLw76/+9cIB8zQMbgsnVtla
	Q8GNZVM2kPw8ss4S8+CUxH5qv1hxnntHR+Uc3BrIb1i0MtUeUseLXyBFTX5VV0+L1DdGzdVyWDs
	NByqYZDfNcljxALrZVpTXp4dtrqi7P1EdpEg4adEUtUZBLP1HtDGxwwV8OfiKg9MYEoba4WxW0z
	bn9ponxXQoPl7yWkIUIjEk1llH6cEpitkF5
X-Received: by 2002:a05:6a21:3281:b0:3bf:5539:f93 with SMTP id adf61e73a8af0-3cc71eb2994mr22559290637.38.1786952004903;
        Mon, 17 Aug 2026 00:33:24 -0700 (PDT)
Received: from arsenalgear ([2405:201:5003:b0e5:de9f:6316:18ae:75ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c490ee9sm3831395eec.25.2026.08.17.00.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 00:33:24 -0700 (PDT)
From: Uddhav Swami <uddhavswami@gmail.com>
To: linux-input@vger.kernel.org
Cc: Uddhav Swami <uddhavswami@gmail.com>,
	jikos@kernel.org,
	bentiss@kernel.org
Subject: [PATCH v4] HID: chuyuen: add driver for vendor-specific brightness keys
Date: Mon, 17 Aug 2026 00:33:19 -0700
Message-ID: <20260817073319.33200-1-uddhavswami@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715055951.15144-1-uddhavswami@gmail.com>
References: <20260715055951.15144-1-uddhavswami@gmail.com>
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
v4:
- Rename driver from hid-gigabyte to hid-chuyuen (and Kconfig symbol
  HID_GIGABYTE_AERO to HID_CHUYUEN, module name to hid_chuyuen) to
  follow the hid-<vendor> naming convention, since Chu Yuen Enterprise
  is the actual USB vendor, not Gigabyte. (Jiri)
v3:
- Fix a NULL pointer dereference: hi->report can be NULL for some
  hid_input instances. Iterate hi->reports via list_for_each_entry()
  on hidinput_list to find report ID 0x04 before setting capabilities.
- Rename local variable ret to error in probe for clarity.
v2:
- Fix a use-after-free: check HID_CLAIMED_INPUT after hid_hw_start()
  to catch a failed input_register_device().

 drivers/hid/Kconfig       |  10 +++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-chuyuen.c | 145 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h     |   3 +
 4 files changed, 159 insertions(+)
 create mode 100644 drivers/hid/hid-chuyuen.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 03f36899e458..6647434d5adf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -243,6 +243,16 @@ config HID_CHICONY
 	help
 	Support for Chicony Tactical pad and special keys on Chicony keyboards.
 
+config HID_CHUYUEN
+	tristate "Chu Yuen Aero laptop vendor-specific keys"
+	depends on USB_HID
+	help
+	  Support for vendor-specific keyboard keys on Chu Yuen keyboards
+	  found in Gigabyte Aero laptops.
+
+	  Currently the following device is known to be supported:
+	   - Gigabyte Aero 15 XB
+
 config HID_CORSAIR
 	tristate "Corsair devices"
 	depends on USB_HID && LEDS_CLASS
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3dd0c56..7f7503261b4f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
 obj-$(CONFIG_HID_BIGBEN_FF)	+= hid-bigbenff.o
 obj-$(CONFIG_HID_CHERRY)	+= hid-cherry.o
 obj-$(CONFIG_HID_CHICONY)	+= hid-chicony.o
+obj-$(CONFIG_HID_CHUYUEN)	+= hid-chuyuen.o
 obj-$(CONFIG_HID_CMEDIA)	+= hid-cmedia.o
 obj-$(CONFIG_HID_CORSAIR)	+= hid-corsair.o hid-corsair-void.o
 obj-$(CONFIG_HID_COUGAR)	+= hid-cougar.o
diff --git a/drivers/hid/hid-chuyuen.c b/drivers/hid/hid-chuyuen.c
new file mode 100644
index 000000000000..9bc0ab509083
--- /dev/null
+++ b/drivers/hid/hid-chuyuen.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for Chu Yuen Enterprise keyboards, as found on Gigabyte
+ *  Aero laptops, with vendor-specific brightness keys.
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
+MODULE_DESCRIPTION("HID driver for Chu Yuen Aero keyboards");
+
+#define CHUYUEN_AERO_REPORT_ID 0x04
+#define CHUYUEN_AERO_BRIGHTNESS_DOWN 0x7D
+#define CHUYUEN_AERO_BRIGHTNESS_UP 0x7E
+
+struct chuyuen_drvdata {
+	struct input_dev *input;
+};
+
+static int chuyuen_aero_raw_event(struct hid_device *hdev,
+				   struct hid_report *report, u8 *data,
+				   int size)
+{
+	struct chuyuen_drvdata *drvdata = hid_get_drvdata(hdev);
+
+	if (!drvdata->input)
+		return 0;
+
+	if (report->id != CHUYUEN_AERO_REPORT_ID || size < 4)
+		return 0;
+
+	switch (data[3]) {
+	case CHUYUEN_AERO_BRIGHTNESS_DOWN:
+		input_report_key(drvdata->input, KEY_BRIGHTNESSDOWN, 1);
+		input_sync(drvdata->input);
+		input_report_key(drvdata->input, KEY_BRIGHTNESSDOWN, 0);
+		input_sync(drvdata->input);
+		return 1;
+	case CHUYUEN_AERO_BRIGHTNESS_UP:
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
+static int chuyuen_aero_input_configured(struct hid_device *hdev,
+					  struct hid_input *hi)
+{
+	struct chuyuen_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct hid_report *report;
+	bool has_report = false;
+
+	list_for_each_entry(report, &hi->reports, hidinput_list) {
+		if (report->id == CHUYUEN_AERO_REPORT_ID) {
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
+static int chuyuen_aero_probe(struct hid_device *hdev,
+			       const struct hid_device_id *id)
+{
+	struct chuyuen_drvdata *drvdata;
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
+		hid_err(hdev, "chuyuen_aero: parse failed: %d\n", error);
+		return error;
+	}
+
+	error = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (error) {
+		hid_err(hdev, "chuyuen_aero: hw start failed: %d\n", error);
+		return error;
+	}
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
+		hid_err(hdev, "chuyuen_aero: no input device claimed\n");
+		hid_hw_stop(hdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id chuyuen_aero_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CHU_YUEN,
+			 USB_DEVICE_ID_CHU_YUEN_AERO_KBD) },
+	{}
+};
+MODULE_DEVICE_TABLE(hid, chuyuen_aero_devices);
+
+static struct hid_driver chuyuen_aero_driver = {
+	.name = "hid_chuyuen",
+	.id_table = chuyuen_aero_devices,
+	.probe = chuyuen_aero_probe,
+	.raw_event = chuyuen_aero_raw_event,
+	.input_configured = chuyuen_aero_input_configured,
+};
+module_hid_driver(chuyuen_aero_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b70f719b3b07..b6bca8d8d94d 100644
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
-- 
2.55.0

