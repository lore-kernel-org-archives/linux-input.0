From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/3] HID: wacom: Manually declare ABS_{X,Y} for pointer emulation
Date: Mon, 24 Nov 2014 15:32:13 -0800
Message-ID: <1416871934-14133-3-git-send-email-killertofu@gmail.com>
References: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35421 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaKXXc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2014 18:32:28 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so10730838pdb.29
        for <linux-input@vger.kernel.org>; Mon, 24 Nov 2014 15:32:28 -0800 (PST)
In-Reply-To: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, pinglinux@gmail.com, Jason Gerecke <killertofu@gmail.com>

If a HID descriptor places HID_DG_CONTACTID before HID_DG_X and HID_DG_Y then
the ABS_X and ABS_Y will not be automatically initialized by the call to
input_mt_init_slots. Here we move the setup of those axes outside of the
'if' statement so that they're always present if the associated HID field
is.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1468f00..a55e0ed 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1382,16 +1382,14 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 
 	switch (usage->hid) {
 	case HID_GD_X:
-		if (touch_max == 1)
-			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
-		else
+		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
+		if (touch_max > 1)
 			wacom_map_usage(wacom, usage, field, EV_ABS,
 					ABS_MT_POSITION_X, 4);
 		break;
 	case HID_GD_Y:
-		if (touch_max == 1)
-			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
-		else
+		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
+		if (touch_max > 1)
 			wacom_map_usage(wacom, usage, field, EV_ABS,
 					ABS_MT_POSITION_Y, 4);
 		break;
-- 
2.1.3

