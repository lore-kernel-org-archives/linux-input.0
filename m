From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 8/9] HID: uclogic: Override constant descriptors
Date: Tue, 13 Sep 2016 17:08:42 +0300
Message-ID: <20160913140843.25567-9-spbnick@gmail.com>
References: <20160913140843.25567-1-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35582 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756644AbcIMOJO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:09:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id c131so3169284wmh.2
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:09:14 -0700 (PDT)
In-Reply-To: <20160913140843.25567-1-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Nikolai Kondrashov <spbnick@gmail.com>

Make uclogic_report_fixup override constant descriptors with generated
descriptors, so models reusing product ID, but working with generated
descriptor get correct one.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-uclogic.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 72778b3..64abd8d 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -632,6 +632,12 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	__u8 iface_num = iface->cur_altsetting->desc.bInterfaceNumber;
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
+	if (drvdata->rdesc != NULL) {
+		rdesc = drvdata->rdesc;
+		*rsize = drvdata->rsize;
+		return rdesc;
+	}
+
 	switch (hdev->product) {
 	case USB_DEVICE_ID_UCLOGIC_TABLET_PF1209:
 		if (*rsize == PF1209_RDESC_ORIG_SIZE) {
@@ -701,11 +707,6 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			break;
 		}
 		break;
-	default:
-		if (drvdata->rdesc != NULL) {
-			rdesc = drvdata->rdesc;
-			*rsize = drvdata->rsize;
-		}
 	}
 
 	return rdesc;
-- 
2.9.3

