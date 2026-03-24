Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C130AAA9
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316334; cv=none; b=e2lkNez6l+HGlwQIRDHoKGIwGSGgbxLUEC+Vs6OZSzfRSHvo2B7r/zhLJCLHmeP7nK6e8pxnNyDW0P78dPONF7VdKys7FL12HybufduVGO8JEzdQjbyyT0LhsWIadjHXToo0cqSoHQCdwhIVek60h8BkLcFgeGv1AFJsIOxnszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316334; c=relaxed/simple;
	bh=aO58map7MrL43NnKddrvuhuVBw1toClw63XP3wkk6yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+x16zyCjNRsTBCxNFRz8BVctF8uXd1RlwSFzX91SPzh6ju4vZsDsPAfA+hdgcuVsjrFi4I9Eh7wdhAEhnVsYzKA9FlafO5ufKBMeNW7eqEyaqlgbm0fNJZSpbkPyEeMW6PdqmE9I97lC8Y0P46E5C0DWeZECQsT3uDZW8RngGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeE59je3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeE59je3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab46931cf1so48335635ad.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316332; x=1774921132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sMcB8vCZ+ft7voGK1GkvjNRLPcoujwUB0WOFLw7EZM=;
        b=CeE59je3VsLvGnSsleky5buKqJrdGlsZO/B3m3Y088AvE3atdj0iTTR6RKeMMEM45+
         f8m6vXFGq5kvqNYK6tjeOs3e9piQaVvzYrFBWgrhD6pCpzAR3OyicI3W2ZrmWp39ne9s
         W64cyuiDPpBC1wCxp7EisCuds/+zcvt/c/V0c02S8d08tmWojXXQaibPo2+ew43B5OFX
         04Wt4BGr4YGLVZvRW3fpYhgKHXl4KeLd8IzRy1Wh40u5dyhTJimI2UmhhutT5JCGEAV5
         h0utdtOFwREjumC0Bsbfs5TOoXtHkxvEejaU8Ry6syDFbkQE4eiO0s4CvC+vosFmoCgB
         7Nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316332; x=1774921132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sMcB8vCZ+ft7voGK1GkvjNRLPcoujwUB0WOFLw7EZM=;
        b=NdNT1gjpLzgCO3KQGRfvQ2aMeYM1BU9pgxDGPog9/lqzytT1uM2qxrUBIf0Y4kVE5a
         MTp6D2ZqiuH5TZSQrmq/uLVxH0UpiJ6+F6epZ4YZgZlMO8GfJD18JpJjsDcCpZpdPPbQ
         AlIvGM1TM0DnhE5lDPxfG3gE8Frjw3ioQaxHx+VwTYlAuQjEPXSxP8jBOW1KFjV8jZcJ
         qSEdi29BgoszwXEpwLYK/ZljldV5sQc/RmWv5yAXS/VsDEaz3AZ9C3nQRdTBhRvSN/kx
         RdKR+99M9qF1Nd1Ps+TwH5eQw4InGcBAT2w5AdbKEffMJdP7hVfYCE5FUoBQ40xDpH8j
         PeSg==
X-Forwarded-Encrypted: i=1; AJvYcCXJsXj8RD5DU1oKkllETIMna4WhLjukE0sdrIN7q3gHMIzehfRQK39zBJhJ8GWtRbYRnWPW4OxBTN1Fvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziVq4Zvs+tT7FW27Nedv3OQbDeDeZm3+nIkpW60ynmolVmcZTO
	Wh3xFjHueZVPeK4U6MGxUod5wrjnf8DBxy9ksP4sepc3UXIE/0U2w0P3Cgvt060BXcJqmg==
X-Gm-Gg: ATEYQzyxMCthiNApwBJnQhy1ceuSckfqap+GCLoS0JkebbX2uO+yekRPZLYwUpYEUJ8
	9qV1fgq6MGK4LZ9ME3il/19PMGr9/0xfMluzSIyBaVEWKZTq+j0Y+E6yZkSkcdGr4zgy7j/GF8V
	knYvnyFtYTxZtw1mNT+oH4vcKeDpGzNPV37hx9QDTdcLtDlOSCNzymhoqQLQ/pWFhJv0jqtd0sd
	o3X6itA/kGCHQedCN+frx2xNKZBDlmECInQTSLfhIRvHpf7CBavtc+kMEi6mbte8CVVFcA7SIBk
	wtAR31M9OclQBAof1oqo898CVGnvQWRBTZbyIV+lqcb0+lCSLJEV/gVQElomyardk7XOeR2y7YA
	kpjxyKbXRt5fM/ydIVeGMc085bFy+lWPMJEFEwt5AtDkSFKmL+D7BvAaCCyTsdTM6AtJXcLcn5F
	ayWHCHCoH3vJS/QyqIOBY2ccOkhWCyVcZEAA==
X-Received: by 2002:a17:903:388d:b0:2b0:51be:f9d7 with SMTP id d9443c01a7336-2b0a4e05583mr13848315ad.18.1774316331697;
        Mon, 23 Mar 2026 18:38:51 -0700 (PDT)
Received: from localhost.localdomain ([212.107.28.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836556desm164963475ad.47.2026.03.23.18.38.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Mar 2026 18:38:51 -0700 (PDT)
From: honjow <honjow311@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: denis.benato@linux.dev,
	honjow311@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH] HID: gpd: fix report descriptor on GPD Win handheld (2f24:0137)
Date: Tue, 24 Mar 2026 09:38:45 +0800
Message-ID: <20260324013847.68024-1-honjow311@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OEM USB HID interface found on GPD Win handhelds (VID 2f24, registered
to ShenZhen HuiJiaZhi / GameSir, PID 0137) declares 63-byte Input and
Feature reports for Report ID 1, but the firmware only transfers 11 data
bytes per interrupt.

Since commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()"), the HID core rejects undersized reports instead of zero-
padding them. This breaks the device entirely on kernels >= v7.0-rc5.

Fix it by patching the report descriptor in report_fixup(), reducing
Report Count from 63 to 11 for both Input and Feature.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221271
Signed-off-by: honjow <honjow311@gmail.com>
---
 drivers/hid/Kconfig   | 10 +++++++++
 drivers/hid/Makefile  |  1 +
 drivers/hid/hid-gpd.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h |  3 +++
 4 files changed, 66 insertions(+)
 create mode 100644 drivers/hid/hid-gpd.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 10c12d8e65579..20c60f5aca4c5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -419,6 +419,16 @@ config HID_GLORIOUS
 	  Support for Glorious PC Gaming Race mice such as
 	  the Glorious Model O, O- and D.
 
+config HID_GPD
+	tristate "GPD Win handheld OEM HID support"
+	depends on USB_HID
+	help
+	  Report descriptor fix for the OEM USB HID interface (GameSir
+	  2f24:0137) found on GPD Win handhelds. The firmware declares 63-byte
+	  reports but only sends 11 bytes, which the HID core rejects.
+
+	  Say Y or M here if you use a GPD Win handheld with this interface.
+
 config HID_HOLTEK
 	tristate "Holtek HID devices"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 07dfdb6a49c59..03ef72ec4499f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_HID_ELO)		+= hid-elo.o
 obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
+obj-$(CONFIG_HID_GPD)		+= hid-gpd.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
 obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
diff --git a/drivers/hid/hid-gpd.c b/drivers/hid/hid-gpd.c
new file mode 100644
index 0000000000000..5b4d203e24995
--- /dev/null
+++ b/drivers/hid/hid-gpd.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID report descriptor fixup for GPD Win handhelds.
+ *
+ *  The OEM HID interface (VID 2f24 / GameSir, PID 0137) declares Report ID 1
+ *  with Report Count 63 (8-bit fields) for both Input and Feature, but the
+ *  firmware only sends 11 bytes of payload after the report ID.
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define RDESC_LEN		38
+#define RPT_COUNT_INPUT_OFF	21
+#define RPT_COUNT_FEATURE_OFF	34
+
+static const __u8 *gpd_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				    unsigned int *rsize)
+{
+	if (*rsize != RDESC_LEN)
+		return rdesc;
+
+	if (rdesc[RPT_COUNT_INPUT_OFF - 1] == 0x95 &&
+	    rdesc[RPT_COUNT_INPUT_OFF] == 0x3f &&
+	    rdesc[RPT_COUNT_FEATURE_OFF - 1] == 0x95 &&
+	    rdesc[RPT_COUNT_FEATURE_OFF] == 0x3f) {
+		hid_info(hdev, "fixing report counts (63 -> 11 bytes)\n");
+		rdesc[RPT_COUNT_INPUT_OFF] = 11;
+		rdesc[RPT_COUNT_FEATURE_OFF] = 11;
+	}
+
+	return rdesc;
+}
+
+static const struct hid_device_id gpd_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMESIR, USB_DEVICE_ID_GAMESIR_0137) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, gpd_devices);
+
+static struct hid_driver gpd_driver = {
+	.name = "gpd",
+	.id_table = gpd_devices,
+	.report_fixup = gpd_report_fixup,
+};
+
+module_hid_driver(gpd_driver);
+
+MODULE_DESCRIPTION("HID report descriptor fix for GPD Win handheld (GameSir 2f24:0137)");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 933b7943bdb50..d0a6c19baa660 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -533,6 +533,9 @@
 #define USB_VENDOR_ID_FRUCTEL	0x25B6
 #define USB_DEVICE_ID_GAMETEL_MT_MODE	0x0002
 
+#define USB_VENDOR_ID_GAMESIR		0x2f24
+#define USB_DEVICE_ID_GAMESIR_0137	0x0137
+
 #define USB_VENDOR_ID_GAMEVICE	0x27F8
 #define USB_DEVICE_ID_GAMEVICE_GV186	0x0BBE
 #define USB_DEVICE_ID_GAMEVICE_KISHI	0x0BBF
-- 
2.51.2

