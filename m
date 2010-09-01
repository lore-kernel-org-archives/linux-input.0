From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 1/7 v3] HID: magicmouse: don't allow hidinput to initialize the device
Date: Tue, 31 Aug 2010 21:56:18 -0400
Message-ID: <1283306184-28833-2-git-send-email-chase.douglas@canonical.com>
References: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Poole <mdpoole@troilus.org>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Chase Douglas <chase.douglas@ubuntu.com>

The driver listens only for raw events from the device. If we allow
the hidinput layer to initialize, we can hit NULL pointer dereferences
in the hidinput layer because disconnecting only removes the hidinput
devices from the hid device while leaving the hid fields configured.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Acked-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 319b0e5..d38b529 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -404,15 +404,20 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	/* When registering a hid device, one of hidinput, hidraw, or hiddev
+	 * subsystems must claim the device. We are bypassing hidinput due to
+	 * our raw event processing, and hidraw and hiddev may not claim the
+	 * device. We get around this by telling hid_hw_start that input has
+	 * claimed the device already, and then flipping the bit back.
+	 */
+	hdev->claimed = HID_CLAIMED_INPUT;
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDINPUT);
+	hdev->claimed &= ~HID_CLAIMED_INPUT;
 	if (ret) {
 		dev_err(&hdev->dev, "magicmouse hw start failed\n");
 		goto err_free;
 	}
 
-	/* we are handling the input ourselves */
-	hidinput_disconnect(hdev);
-
 	report = hid_register_report(hdev, HID_INPUT_REPORT, TOUCH_REPORT_ID);
 	if (!report) {
 		dev_err(&hdev->dev, "unable to register touch report\n");
-- 
1.7.1
