From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] HID: asus: Fix special function keys on T200TA
Date: Fri,  5 Jan 2018 12:09:19 +0100
Message-ID: <20180105110919.30399-2-hdegoede@redhat.com>
References: <20180105110919.30399-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeAELJZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jan 2018 06:09:25 -0500
In-Reply-To: <20180105110919.30399-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Just like on the T100TA the T200TA HID descriptors for the 0xff32
Asus vendor usage page need a small fixup. But on the T200TA the HID
descriptors are larger because they have descrriptors for one more
(unused) HID report appended.

Extend the T100TA descriptor fixup to also check for the T200TA's
descriptors size.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 07525bc99b6a..88b9703318e4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -715,9 +715,10 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
 		rdesc[55] = 0xdd;
 	}
-	/* For the T100TA keyboard dock */
+	/* For the T100TA/T200TA keyboard dock */
 	if (drvdata->quirks & QUIRK_T100_KEYBOARD &&
-		 *rsize == 76 && rdesc[73] == 0x81 && rdesc[74] == 0x01) {
+		 (*rsize == 76 || *rsize == 101) &&
+		 rdesc[73] == 0x81 && rdesc[74] == 0x01) {
 		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
 		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
 	}
-- 
2.14.3

