From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: sony: do not bail out when the sixaxis refuses the output report
Date: Fri,  8 Jan 2016 17:58:49 +0100
Message-ID: <1452272329-8744-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52808 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932220AbcAHQ6z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jan 2016 11:58:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Max Fedotov <thesourcehim@gmail.com>, linux-kernel@vger.kernel.org

When setting the operational mode, some third party (Speedlink Strike-FX)
gamepads refuse the output report. Failing here means we refuse to
initialize the gamepad while this should be harmless.

The weird part is that the initial commit that added this: a7de9b8
("HID: sony: Enable Gasia third-party PS3 controllers") mentions this
very same controller as one requiring this output report.
Anyway, it's broken for one user at least, so let's change it.
We will report an error, but at least the controller should work.

And no, these devices present themselves as legacy Sony controllers
(VID:PID of 054C:0268, as in the official ones) so there are no ways
of discriminating them from the official ones.

https://bugzilla.redhat.com/show_bug.cgi?id=1255325

Reported-and-tested-by: Max Fedotov <thesourcehim@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-sony.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9b8db0e..b2d2fae 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1420,8 +1420,10 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	}
 
 	ret = hid_hw_output_report(hdev, buf, 1);
-	if (ret < 0)
-		hid_err(hdev, "can't set operational mode: step 3\n");
+	if (ret < 0) {
+		hid_info(hdev, "can't set operational mode: step 3, ignoring\n");
+		ret = 0;
+	}
 
 out:
 	kfree(buf);
-- 
2.5.0

