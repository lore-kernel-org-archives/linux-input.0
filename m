From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Fri, 27 Feb 2009 21:28:03 +0200
Message-ID: <1235762883-20870-2-git-send-email-me@felipebalbi.com>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37304 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbZB0T2Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 14:28:16 -0500
In-Reply-To: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Samuel Ortiz <sameo@openedhand.com>, David Brownell <dbrownell@users.sourceforge.net>

From: Felipe Balbi <felipe.balbi@nokia.com>

Make that twl4030-pwrbutton.c driver probe with current
child creation api for twl4030.

Cc: Samuel Ortiz <sameo@openedhand.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
This part is better off going via mfd.

 drivers/mfd/twl4030-core.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 68826f1..c86bc3b 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -101,6 +101,12 @@
 #define twl_has_usb()	false
 #endif
 
+#if defined(CONFIG_INPUT_TWL4030_PWRBUTTON) \
+	|| defined(CONFIG_INPUT_TWL4030_PWBUTTON_MODULE)
+#define twl_has_pwrbutton()	true
+#else
+#define twl_has_pwrbutton()	false
+#endif
 
 /* Triton Core internal information (BEGIN) */
 
@@ -526,6 +532,13 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		usb_transceiver = child;
 	}
 
+	if (twl_has_pwrbutton()) {
+		child = add_child(1, "twl4030_pwrbutton",
+				NULL, 0, true, pdata->irq_base + 8 + 0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
 	if (twl_has_regulator()) {
 		/*
 		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1);
-- 
1.6.2.rc0.61.g5cd12

