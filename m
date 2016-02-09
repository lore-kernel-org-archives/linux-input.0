From: Antonio Ospite <ao2@ao2.it>
Subject: [RESEND PATCH 3/6] HID: sony: fix a typo in descriptors comments s/Joystik/Joystick/
Date: Tue,  9 Feb 2016 13:55:05 +0100
Message-ID: <1455022508-20041-4-git-send-email-ao2@ao2.it>
References: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:21810 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648AbcBIMzj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 07:55:39 -0500
In-Reply-To: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Antonio Ospite <ao2@ao2.it>

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Acked-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ff01647..3877101 100644
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

