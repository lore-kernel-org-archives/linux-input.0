From: Tobias Mueller <dmitry.torokhov@gmail.com>
Subject: [PATCH 09/37] Input: appletouch - add product IDs for the 4th generation MacBooks
Date: Wed, 2 Apr 2008 10:02:06 -0400
Message-ID: <f23c1d7579211c801494c7a8d6fca12905f7949f.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:35324 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759954AbYDUNTF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:05 -0400
Received: by rn-out-0910.google.com with SMTP id e11so303938rng.17
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:05 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Signed-off-by: Tobias Mueller <Tobias_Mueller@twam.info>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mouse/appletouch.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index b4423a4..8dd3942 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -62,6 +62,10 @@
 #define GEYSER4_ISO_PRODUCT_ID	0x021B
 #define GEYSER4_JIS_PRODUCT_ID	0x021C
 
+#define GEYSER4_HF_ANSI_PRODUCT_ID	0x0229
+#define GEYSER4_HF_ISO_PRODUCT_ID	0x022A
+#define GEYSER4_HF_JIS_PRODUCT_ID	0x022B
+
 #define ATP_DEVICE(prod)					\
 	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |		\
 		       USB_DEVICE_ID_MATCH_INT_CLASS |		\
@@ -93,6 +97,10 @@ static struct usb_device_id atp_table [] = {
 	{ ATP_DEVICE(GEYSER4_ISO_PRODUCT_ID) },
 	{ ATP_DEVICE(GEYSER4_JIS_PRODUCT_ID) },
 
+	{ ATP_DEVICE(GEYSER4_HF_ANSI_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER4_HF_ISO_PRODUCT_ID) },
+	{ ATP_DEVICE(GEYSER4_HF_JIS_PRODUCT_ID) },
+
 	/* Terminating entry */
 	{ }
 };
@@ -217,7 +225,10 @@ static inline int atp_is_geyser_3(struct atp *dev)
 		(productId == GEYSER3_JIS_PRODUCT_ID) ||
 		(productId == GEYSER4_ANSI_PRODUCT_ID) ||
 		(productId == GEYSER4_ISO_PRODUCT_ID) ||
-		(productId == GEYSER4_JIS_PRODUCT_ID);
+		(productId == GEYSER4_JIS_PRODUCT_ID) ||
+		(productId == GEYSER4_HF_ANSI_PRODUCT_ID) ||
+		(productId == GEYSER4_HF_ISO_PRODUCT_ID) ||
+		(productId == GEYSER4_HF_JIS_PRODUCT_ID);
 }
 
 /*
-- 
1.5.5.rc2.6.gf58d


