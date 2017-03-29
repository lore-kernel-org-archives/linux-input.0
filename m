From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH] HID: wacom: Don't add ghost interface as shared data
Date: Wed, 29 Mar 2017 10:35:39 -0700
Message-ID: <1490808939-22398-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34526 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbdC2Rg5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 13:36:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, killertofu@gmail.com
Cc: linux-kernel@vger.kernel.org, Aaron Armstrong Skomra <skomra@gmail.com>, "stable # 4 . 9" <stable@vger.kernel.org>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

A previous commit (below) adds a check for already probed interfaces to
Wacom's matching heuristic. Unfortunately this causes the Bamboo Pen
(CTL-460) to match itself to its 'ghost' touch interface. After
subsequent changes to the driver this match to the ghost causes the
kernel to crash. This patch avoids calling wacom_add_shared_data()
for the BAMBOO_PEN's ghost touch interface.

Fixes: 41372d5d40e7 ("HID: wacom: Augment 'oVid' and 'oPid' with heuristics for HID_GENERIC")
Cc: stable <stable@vger.kernel.org>     # 4.9
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_sys.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 5e7a5648e708..0c535d0f3b95 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2017,6 +2017,14 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	wacom_update_name(wacom, wireless ? " (WL)" : "");
 
+	/* pen only Bamboo neither support touch nor pad */
+	if ((features->type == BAMBOO_PEN) &&
+	    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
+	    (features->device_type & WACOM_DEVICETYPE_PAD))) {
+		error = -ENODEV;
+		goto fail;
+	}
+
 	error = wacom_add_shared_data(hdev);
 	if (error)
 		goto fail;
@@ -2064,14 +2072,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	/* pen only Bamboo neither support touch nor pad */
-	if ((features->type == BAMBOO_PEN) &&
-	    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
-	    (features->device_type & WACOM_DEVICETYPE_PAD))) {
-		error = -ENODEV;
-		goto fail_quirks;
-	}
-
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
 		error = hid_hw_open(hdev);
 
-- 
2.7.4

