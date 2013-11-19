From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 2/5] HID: sony: Use BIT(x) macro to define quirks constants
Date: Tue, 19 Nov 2013 20:26:29 +0100
Message-ID: <1384889192-18488-3-git-send-email-sven@narfation.org>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42237 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967Ab3KST0n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 14:26:43 -0500
In-Reply-To: <1384889192-18488-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 28b847a..0677292 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -33,11 +33,11 @@
 
 #include "hid-ids.h"
 
-#define VAIO_RDESC_CONSTANT     (1 << 0)
-#define SIXAXIS_CONTROLLER_USB  (1 << 1)
-#define SIXAXIS_CONTROLLER_BT   (1 << 2)
-#define BUZZ_CONTROLLER         (1 << 3)
-#define PS3REMOTE		(1 << 4)
+#define VAIO_RDESC_CONSTANT     BIT(0)
+#define SIXAXIS_CONTROLLER_USB  BIT(1)
+#define SIXAXIS_CONTROLLER_BT   BIT(2)
+#define BUZZ_CONTROLLER         BIT(3)
+#define PS3REMOTE		BIT(4)
 
 static const u8 sixaxis_rdesc_fixup[] = {
 	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
-- 
1.8.4.3

