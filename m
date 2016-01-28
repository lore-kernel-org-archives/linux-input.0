From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 3/7] HID: sony: fix a typo in descriptors comments s/Joystik/Joystick/
Date: Thu, 28 Jan 2016 18:23:43 +0100
Message-ID: <1454001827-26732-4-git-send-email-ao2@ao2.it>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:27591 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946092AbcA1R3l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 12:29:41 -0500
In-Reply-To: <1454001827-26732-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Frank Praznik <frank.praznik@gmail.com>, Antonio Ospite <ao2@ao2.it>

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 173af01..8dcea69 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -252,7 +252,7 @@ static __u8 motion_rdesc[] = {
 /* PS/3 Navigation controller */
 static __u8 navigation_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x04,         /*  Usage (Joystik),                    */
+	0x09, 0x04,         /*  Usage (Joystick),                   */
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0xA1, 0x02,         /*      Collection (Logical),           */
 	0x85, 0x01,         /*          Report ID (1),              */
-- 
2.7.0

