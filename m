From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Handle failing HID_DG_CONTACTMAX requests
Date: Fri,  8 May 2015 14:25:02 -0700
Message-ID: <1431120302-13691-2-git-send-email-killertofu@gmail.com>
References: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34418 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbEHV0E (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 17:26:04 -0400
Received: by pacyx8 with SMTP id yx8so59518693pac.1
        for <linux-input@vger.kernel.org>; Fri, 08 May 2015 14:26:04 -0700 (PDT)
In-Reply-To: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, jono <lejono@gmail.com>, Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Hardware may not respond to a request for the HID_DG_CONTACTMAX feature and
we should be tolerant of such a failure. This is especially true when using
hid-replay where the hardware doesn't exist, but also for devices attached
to a flaky bus. This patch increases the number of allowable retries to
match other calls to 'wacom_get_report' and also provides a fallback which
forces 'touch_max = 16' (enough for any Wacom device seen so far).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 3cd74d9..c9a7e30 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -125,9 +125,17 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 				break;
 			data[0] = field->report->id;
 			ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
-						data, 2, 0);
-			if (ret == 2)
+						data, 2, WAC_CMD_RETRIES);
+			if (ret == 2) {
 				features->touch_max = data[1];
+			}
+			else {
+				features->touch_max = 16;
+				dev_warn(&hdev->dev, "wacom_feature_mapping: "
+					 "could not get HID_DG_CONTACTMAX, "
+					 "defaulting to %d\n",
+					  features->touch_max);
+			}
 			kfree(data);
 		}
 		break;
-- 
2.4.0

