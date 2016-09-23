From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH] Fix a issue that Alps Touchpad cursor does not work
Date: Fri, 23 Sep 2016 14:32:55 +0900
Message-ID: <1474608775-10839-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kai.heng.feng@canonical.com, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

fix Touchpad cursor does not work after touching Touchpad 
by 3 or more fingers.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 048befd..610df92 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -190,16 +190,16 @@ static int alps_raw_event(struct hid_device *hdev,
 			if (z != 0) {
 				input_mt_report_slot_state(hdata->input,
 					MT_TOOL_FINGER, 1);
+				input_report_abs(hdata->input,
+					ABS_MT_POSITION_X, x);
+				input_report_abs(hdata->input,
+					ABS_MT_POSITION_Y, y);
+				input_report_abs(hdata->input,
+					ABS_MT_PRESSURE, z);
 			} else {
 				input_mt_report_slot_state(hdata->input,
 					MT_TOOL_FINGER, 0);
-				break;
 			}
-
-			input_report_abs(hdata->input, ABS_MT_POSITION_X, x);
-			input_report_abs(hdata->input, ABS_MT_POSITION_Y, y);
-			input_report_abs(hdata->input, ABS_MT_PRESSURE, z);
-
 		}
 
 		input_mt_sync_frame(hdata->input);
-- 
2.7.4
