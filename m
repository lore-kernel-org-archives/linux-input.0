From: Jaikumar Ganesh <jaikumarg@android.com>
Subject: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching modes
Date: Wed, 17 Aug 2011 12:59:42 -0700
Message-ID: <1313611182-19924-1-git-send-email-jaikumarg@android.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:16990 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab1HQUAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 16:00:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Jaikumar Ganesh <jaikumarg@android.com>

From: Jiri Kosina <jkosina@suse.cz>

23746a introduced this commit but was reverted in c3a492.
The trackpad uses report Ids which are not present in the
report descriptor. These reports ids are not documented
anywhere. There are devices in the market (Apple magic tracpkad,
BT version 2.0 is one such device) with the same device id,
which fail when we use 0xd7 as the report id. So we need the EIO
change of 23746a as a failsafe to work with these devices.

Original Author: Jiri Kosina <jkosina@suse.cz>

Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
---
 drivers/hid/hid-magicmouse.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 0ec91c1..a5eda4c 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -501,9 +501,17 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 	report->size = 6;
 
+	/*
+	 * The device reponds with 'invalid report id' when feature
+	 * report switching it into multitouch mode is sent to it.
+	 *
+	 * This results in -EIO from the _raw low-level transport callback,
+	 * but there seems to be no other way of switching the mode.
+	 * Thus the super-ugly hacky success check below.
+	 */
 	ret = hdev->hid_output_raw_report(hdev, feature, sizeof(feature),
 			HID_FEATURE_REPORT);
-	if (ret != sizeof(feature)) {
+	if (ret != -EIO) {
 		hid_err(hdev, "unable to request touch data (%d)\n", ret);
 		goto err_stop_hw;
 	}
-- 
1.7.3.1

