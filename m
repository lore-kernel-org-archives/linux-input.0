Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17833ADB5
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583139; cv=none; b=g7YiMae6wVQzdri8uYkgC6lBVnvjhmXN4CKy/p7bXPoisDaLLY8LGPAKpcrVvYoVC0swoplxU4Hlt5JIuecI2rHU1hVZv9CG7HZWzGgh/tuVF9PcQl6yZYxN9zreiDEyFmXM7LpQg/dYMKF8KJN3nEbQV0HeX/KOHJPXQI+HU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583139; c=relaxed/simple;
	bh=kz54Xr99bnvh5yKdiFBwHJ1raRWU84y9yRTsI+sR1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nbW2rO/uEaoP2Ust32AS26qNCh3DkzS/69jAUxyuGF/aZUzoSts6AYqBgTzEz6fTbJ6oh31rOef8+SRnmkJGHIiXWaX7V3FfKHqcFlnl7jU2eyEGBANaNPh8rhw8Fy2873PhefFTvrinMzSLRbXoWGB+XicP41DaU+ifnOwBGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq6ZSLKH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq6ZSLKH"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so4607444a91.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583136; x=1776187936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRoUmz6KKTbfkM8mGP/d9c/Wsuh9EY8D7iT/JLKlbBs=;
        b=Yq6ZSLKHHgU+mkDWmdDH0pwdcebdiBGyPGRjBbDh6ZgNi5j7Y2y5fWkFSiTnI9F+gA
         FZZvylcxLttzuMrRatdGfkt0HV2xjgA1Noi9Rf5zNlpu8AUZ7fcnWW8OowVu9FwZyop7
         liVhGW2LXhBA1yKt0JwLZXVLRV8ISN39RSLvu9heVKtfF3mFkrs56QyQBwt7mi9OwgMm
         VsxRNyExld8pOJQp7EKD25KIWRok2F8vRTRxO8PnFFUj3x+a3CRK+PFyI216tSkQeDcx
         xKiFvebPkt/latYYRQv7W7NmbAMpbk3yB0yK4YbiVuC/Fm6QTs6FK+s9btB6BLKODkQ6
         9cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583136; x=1776187936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRoUmz6KKTbfkM8mGP/d9c/Wsuh9EY8D7iT/JLKlbBs=;
        b=qiLZlwi7cCQKAE9RjKcJ8QOoqY86JKFk2gesYooJ2t8eKmiGrwFpQ5Gt3pt2jwu0Ak
         PQ9moXJmU0y/cUDMzCLhiN+EgtIEuPwI8rsHNxpwyPWjIuyCmeAjFku/d7fEmQisfFgv
         9xAiYhRCCigI7+e4BXNj9VBDjKpk2g5GUDrdaGrzHwGo1GARAsXjsfXD12J7nYne8nTT
         2zJ01fk2rCh9OB6GmCNdhmICez02jPACMoH7nY0vVlaajFuqNVdxzHJVnehABR7tiAlk
         a78TMSJzY7XtmJhFwW3Dokw1SzWtyUzxnT2subk9zrxhBbCxNQc/vTdyAhwCkr2ZWtis
         IBNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB/AcWX2SGbF4WFrcwgqEjoMPDR3R1FAoi1bbLsPrjy9RkqD7bveb5mnC2oPCmCI14Ab61n6od3aku3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5W98jndfrcKOspAAQLrWAw4GFO50Ha6tp9nJzsaTCJRHqoTjE
	nO0MEgeKH8upusFG60MxieaWZ72p7X+sHN2exKMrnRReLBTyXsYGzApc8BTi+VfdQgmbCA==
X-Gm-Gg: AeBDievAWThFqQl4gcgPi+/YeEZjyuCEhOv1fHfeBNL6tI9cCeT9RKxec1+LiV1JR+X
	RzdecdKFgkHpdm16MK1XZ9K76HDPIbq0hQOHD46eawsPJbuwu4/pDSq7aHWqrIFVMAhvLLXCmnO
	sIrRWjlXk/Vtgn2Ir7ZHIbCim+ETK13iuZfnYJaPOzydIgTwLBbdf09w0v/5M3169TZ4B84rjdb
	1rizxq0Bl9wwRNnJIUmZn+9baJuZ9a4bPW2ai3ltmTpOSQ8HOH4AQf5l1lPR3IqxpRcxcsql0Ka
	lbfdb1iwXzRTrK1luIJRAa+6XJbD9IdqB7EpW+KEmbIKSzLBLFCGhOtCEeaRGuC/4PfUXMiDAFE
	qKoiDif/6hBQwLciA/9e373ULVsCBFJrN/Pa4h+XnUNchOjTt2VCCxEBM9FBu2xlery6k9Zbwph
	wYJppN3DmJDY6Xnzz8iNM/yQA8YqSsmuc6hw==
X-Received: by 2002:a17:90b:1b4f:b0:35d:93ff:284f with SMTP id 98e67ed59e1d1-35de691ad7dmr17772435a91.15.1775583136107;
        Tue, 07 Apr 2026 10:32:16 -0700 (PDT)
Received: from ITX.tail9b489a.ts.net ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd369f414sm17434069a91.15.2026.04.07.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:32:15 -0700 (PDT)
From: Zhouwang Huang <honjow311@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	honjow <honjow311@gmail.com>
Cc: denis.benato@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH] HID: core: add short report quirk and use it for GPD Win (2f24:0137)
Date: Wed,  8 Apr 2026 01:32:11 +0800
Message-ID: <20260407173212.86942-1-honjow311@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win
handheld (2f24:0137)") used report_fixup to shrink Report Count from
63 to 11 so that short reports from firmware <= 1.09 would not be
rejected by hid_report_raw_event().

However, firmware 1.10 fixed the report length and now sends the full
63 bytes.  Because report_fixup already shrank the descriptor,
usbhid allocates a 12-byte URB buffer — far too small for the 64-byte
transfer — causing continuous -EOVERFLOW on every interrupt-in URB.
The HID report descriptor and bcdDevice are identical across firmware
versions, so report_fixup cannot conditionally apply.

Replace the report_fixup driver with a new per-device quirk
HID_QUIRK_ALLOW_SHORT_REPORTS.  When set, hid_report_raw_event()
zero-pads short reports instead of rejecting them — the same behaviour
the core had before commit 0a3fe972a7cb ("HID: core: Mitigate
potential OOB by removing bogus memset()").  The descriptor is left
unmodified so the URB buffer matches the declared report size and works
with any firmware version.

Remove hid-gpd.c, its Kconfig entry and Makefile line; the device is
now handled by hid-generic with the quirk applied from hid-quirks.c.

Fixes: 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win handheld (2f24:0137)")
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
---
 drivers/hid/Kconfig      | 10 --------
 drivers/hid/Makefile     |  1 -
 drivers/hid/hid-core.c   | 11 +++++----
 drivers/hid/hid-gpd.c    | 52 ----------------------------------------
 drivers/hid/hid-quirks.c |  2 ++
 include/linux/hid.h      |  2 ++
 6 files changed, 11 insertions(+), 67 deletions(-)
 delete mode 100644 drivers/hid/hid-gpd.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2159d0fb7020..c1d9f7c6a5f2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -419,16 +419,6 @@ config HID_GLORIOUS
 	  Support for Glorious PC Gaming Race mice such as
 	  the Glorious Model O, O- and D.
 
-config HID_GPD
-	tristate "GPD Win handheld OEM HID support"
-	depends on USB_HID
-	help
-	  Report descriptor fix for the OEM USB HID interface (GameSir
-	  2f24:0137) found on GPD Win handhelds. The firmware declares 63-byte
-	  reports but only sends 11 bytes, which the HID core rejects.
-
-	  Say Y or M here if you use a GPD Win handheld with this interface.
-
 config HID_HOLTEK
 	tristate "Holtek HID devices"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index f69cd6015465..e01838239ae6 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
 obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
-obj-$(CONFIG_HID_GPD)		+= hid-gpd.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
 obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f5587b786f87..52e86f927a38 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2057,10 +2057,13 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
-				     report->id, rsize, csize);
-		ret = -EINVAL;
-		goto out;
+		if (!(hid->quirks & HID_QUIRK_ALLOW_SHORT_REPORTS)) {
+			hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
+					     report->id, rsize, csize);
+			ret = -EINVAL;
+			goto out;
+		}
+		memset(cdata + csize, 0, rsize - csize);
 	}
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
diff --git a/drivers/hid/hid-gpd.c b/drivers/hid/hid-gpd.c
deleted file mode 100644
index 5b4d203e2499..000000000000
--- a/drivers/hid/hid-gpd.c
+++ /dev/null
@@ -1,52 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  HID report descriptor fixup for GPD Win handhelds.
- *
- *  The OEM HID interface (VID 2f24 / GameSir, PID 0137) declares Report ID 1
- *  with Report Count 63 (8-bit fields) for both Input and Feature, but the
- *  firmware only sends 11 bytes of payload after the report ID.
- */
-
-#include <linux/hid.h>
-#include <linux/module.h>
-
-#include "hid-ids.h"
-
-#define RDESC_LEN		38
-#define RPT_COUNT_INPUT_OFF	21
-#define RPT_COUNT_FEATURE_OFF	34
-
-static const __u8 *gpd_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-				    unsigned int *rsize)
-{
-	if (*rsize != RDESC_LEN)
-		return rdesc;
-
-	if (rdesc[RPT_COUNT_INPUT_OFF - 1] == 0x95 &&
-	    rdesc[RPT_COUNT_INPUT_OFF] == 0x3f &&
-	    rdesc[RPT_COUNT_FEATURE_OFF - 1] == 0x95 &&
-	    rdesc[RPT_COUNT_FEATURE_OFF] == 0x3f) {
-		hid_info(hdev, "fixing report counts (63 -> 11 bytes)\n");
-		rdesc[RPT_COUNT_INPUT_OFF] = 11;
-		rdesc[RPT_COUNT_FEATURE_OFF] = 11;
-	}
-
-	return rdesc;
-}
-
-static const struct hid_device_id gpd_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137) },
-	{ }
-};
-MODULE_DEVICE_TABLE(hid, gpd_devices);
-
-static struct hid_driver gpd_driver = {
-	.name = "gpd",
-	.id_table = gpd_devices,
-	.report_fixup = gpd_report_fixup,
-};
-
-module_hid_driver(gpd_driver);
-
-MODULE_DESCRIPTION("HID report descriptor fix for GPD Win handheld (GameSir 2f24:0137)");
-MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index f6be3ffee023..b9ae1442eba9 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -97,6 +97,8 @@ static const struct hid_device_id hid_quirks[] = {
 		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMEVICE, USB_DEVICE_ID_GAMEVICE_KISHI),
 		HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137),
+		HID_QUIRK_ALLOW_SHORT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING), HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 31324609af4d..212dd13bfcfa 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -381,6 +381,7 @@ struct hid_item {
  * | @HID_QUIRK_X_INVERT:
  * | @HID_QUIRK_Y_INVERT:
  * | @HID_QUIRK_IGNORE_MOUSE:
+ * | @HID_QUIRK_ALLOW_SHORT_REPORTS: accept shorter-than-expected reports, zero-pad
  * | @HID_QUIRK_SKIP_OUTPUT_REPORTS:
  * | @HID_QUIRK_SKIP_OUTPUT_REPORT_ID:
  * | @HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP:
@@ -408,6 +409,7 @@ struct hid_item {
 #define HID_QUIRK_X_INVERT			BIT(12)
 #define HID_QUIRK_Y_INVERT			BIT(13)
 #define HID_QUIRK_IGNORE_MOUSE			BIT(14)
+#define HID_QUIRK_ALLOW_SHORT_REPORTS		BIT(15)
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
-- 
2.53.0

