From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 1/7] HID: dragonrise: fix a typo in descriptors comments s/Joystik/Joystick/
Date: Thu, 28 Jan 2016 18:23:41 +0100
Message-ID: <1454001827-26732-2-git-send-email-ao2@ao2.it>
References: <1454001827-26732-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:27598 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946090AbcA1R3k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 12:29:40 -0500
In-Reply-To: <1454001827-26732-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Frank Praznik <frank.praznik@gmail.com>, Antonio Ospite <ao2@ao2.it>

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-dr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index 1d78ba3..8fd4bf7 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -151,7 +151,7 @@ static inline int drff_init(struct hid_device *hid)
  * descriptor. In any case, it's a wonder it works on Windows.
  *
  *  Usage Page (Desktop),             ; Generic desktop controls (01h)
- *  Usage (Joystik),                  ; Joystik (04h, application collection)
+ *  Usage (Joystick),                 ; Joystick (04h, application collection)
  *  Collection (Application),
  *    Collection (Logical),
  *      Report Size (8),
@@ -207,7 +207,7 @@ static inline int drff_init(struct hid_device *hid)
 /* Fixed report descriptor for PID 0x011 joystick */
 static __u8 pid0011_rdesc_fixed[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),           */
-	0x09, 0x04,         /*  Usage (Joystik),                */
+	0x09, 0x04,         /*  Usage (Joystick),               */
 	0xA1, 0x01,         /*  Collection (Application),       */
 	0xA1, 0x02,         /*      Collection (Logical),       */
 	0x14,               /*          Logical Minimum (0),    */
-- 
2.7.0

