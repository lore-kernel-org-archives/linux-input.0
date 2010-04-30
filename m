From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] hid/hid-sony: fix sony_set_operational_bt
Date: Fri, 30 Apr 2010 21:53:59 +0200
Message-ID: <1272657239-29436-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out19.alice.it ([85.33.2.19]:4099 "EHLO
	smtp-out19.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab0D3Ty1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Apr 2010 15:54:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, cbe-oss-dev@lists.ozlabs.org, linux-bluetooth@vger.kernel.org, hadess@hadess.net

Don't send the report type as part of the data, this prevents the
controller from going into the operational state at all.

This is completely equivalent to what the code originally meant to accomplish:
as per in net/bluetooth/hidp/core.c::hidp_output_raw_report(), by using
HID_FEATURE_REPORT here, what will be actually sent is
(HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE) which is exactly 0x53.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

As this change makes sony_set_operational_bt work while it was non working
before, it might be good to have it in 2.6.34.

Thanks,
   Antonio Ospite
   http://ao2.it

 drivers/hid/hid-sony.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 7502a4b..402d557 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -76,7 +76,7 @@ static int sony_set_operational_usb(struct hid_device *hdev)
 
 static int sony_set_operational_bt(struct hid_device *hdev)
 {
-	unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
+	unsigned char buf[] = { 0xf4,  0x42, 0x03, 0x00, 0x00 };
 	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
 }
 
-- 
1.7.1

