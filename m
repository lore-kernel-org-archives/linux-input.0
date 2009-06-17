From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] Restoring usages used by the pen.
Date: Tue, 16 Jun 2009 22:39:13 -0400
Message-ID: <4A385751.8000904@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:37339 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbZFQCjW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2009 22:39:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Restoring usages used by the pen.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 75ed9d2..aeab973 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -62,11 +62,15 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,

 	case HID_UP_DIGITIZER:
 		switch (usage->hid) {
+
+		/* these are actually used by the pen */
+		case HID_DG_INVERT: /* high when the eraser button is pressed */
+		case HID_DG_ERASER: /* high when the tip and eraser are both pressed */
+		case HID_DG_BARRELSWITCH:  /* doubtful */
+			return 0;
+
 		/* we do not want to map these for now */
-		case HID_DG_INVERT: /* value is always 0 */
-		case HID_DG_ERASER: /* value is always 0 */
 		case HID_DG_CONTACTID: /* value is useless */
-		case HID_DG_BARRELSWITCH:  /* doubtful */
 		case HID_DG_INPUTMODE:
 		case HID_DG_DEVICEINDEX:
 		case HID_DG_CONTACTCOUNT:
@@ -233,6 +237,7 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)

 	if (ret)
 		kfree (nd);
+
 	return ret;
 }

-- 
1.6.3.1


