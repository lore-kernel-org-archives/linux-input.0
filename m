From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 3/4] HID: sony: Fix spacing in the device definitions.
Date: Thu, 16 Jan 2014 21:43:03 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401162136270.15779@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:64868 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaAQCnE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 21:43:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Fix cosmetic spacing in the device definitions.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony
 
 drivers/hid/hid-sony.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e623131..a7c8167 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -33,11 +33,11 @@
 
 #include "hid-ids.h"
 
-#define VAIO_RDESC_CONSTANT     BIT(0)
-#define SIXAXIS_CONTROLLER_USB  BIT(1)
-#define SIXAXIS_CONTROLLER_BT   BIT(2)
-#define BUZZ_CONTROLLER         BIT(3)
-#define PS3REMOTE		BIT(4)
+#define VAIO_RDESC_CONSTANT       BIT(0)
+#define SIXAXIS_CONTROLLER_USB    BIT(1)
+#define SIXAXIS_CONTROLLER_BT     BIT(2)
+#define BUZZ_CONTROLLER           BIT(3)
+#define PS3REMOTE                 BIT(4)
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
-- 
1.8.3.2

