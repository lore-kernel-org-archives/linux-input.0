From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: multitouch: force retrieving of Win8 signature blob
Date: Mon,  7 Mar 2016 11:02:38 +0100
Message-ID: <1457344958-9987-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56875 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbcCGKCm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Mar 2016 05:02:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The Synaptics 0x11e5 over I2C found in the Asus T100-CHI requires to
fetch the signature blob to actually start sending events.

With this patch, we should be close enough to the Windows driver which
checks the content of the blob at plugin to validate or not the
touchscreen.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=113481
regression introduced by 6d4f5440 ("HID: multitouch: Fetch feature
reports on demand for Win8 devices") which has been backported to stable.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Jiri,

Let's hope this will be the final patch for Win8 touch devices. I do not
think we need much more tests from broader devices as this is really what
we use to do before 6d4f5440, and this is also what the Windows driver does.

Crossing fingers.

Cheers,
Benjamin

 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6adb788..c2cb46d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -396,6 +396,11 @@ static void mt_feature_mapping(struct hid_device *hdev,
 			td->is_buttonpad = true;
 
 		break;
+	case 0xff0000c5:
+		/* Retrieve the Win8 blob once to enable some devices */
+		if (usage->usage_index == 0)
+			mt_get_feature(hdev, field->report);
+		break;
 	}
 }
 
-- 
2.5.0

