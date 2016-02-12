From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: fix hid_ignore_special_drivers module parameter
Date: Fri, 12 Feb 2016 17:10:37 +0100
Message-ID: <1455293437-12088-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbcBLQKl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 11:10:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

hid_ignore_special_drivers works fine until hid_scan_report
autodetects and reassign devices (for hid-multitouch,
hid-microsoft and hid-rmi).

Simplify the handling of the parameter: if it is there, use
hid-generic, no matter what, and if not, scan the device or
rely on the hid_have_special_driver table.

This was detected while trying to disable hid-multitouch on
a Surface Pro cover which prevented to use the keyboard.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC: stable@vger.kernel.org
---

Hi Jiri,

not sure if we should keep or not the stable@ tag. The issue was there for a
long time, and nobody complained. It's up to you.

Cheers,
Benjamin

 drivers/hid/hid-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e637e4f..fe8be16 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2661,9 +2661,10 @@ int hid_add_device(struct hid_device *hdev)
 	/*
 	 * Scan generic devices for group information
 	 */
-	if (hid_ignore_special_drivers ||
-	    (!hdev->group &&
-	     !hid_match_id(hdev, hid_have_special_driver))) {
+	if (hid_ignore_special_drivers) {
+		hdev->group = HID_GROUP_GENERIC;
+	} else if (!hdev->group &&
+		   !hid_match_id(hdev, hid_have_special_driver)) {
 		ret = hid_scan_report(hdev);
 		if (ret)
 			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
-- 
2.5.0

