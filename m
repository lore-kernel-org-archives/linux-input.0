From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH v2 3/3] skip all blobs that are not touches
Date: Mon, 10 Jul 2017 17:42:26 +0200
Message-ID: <1499701346-12110-3-git-send-email-floe@butterbrot.org>
References: <1499701346-12110-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:42419 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753646AbdGJPmp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 11:42:45 -0400
In-Reply-To: <1499701346-12110-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, peter.hutterer@who-t.net
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

The SUR40 labels all reported blobs as touch, token, or generic blob.
Previously, all blobs were reported as touch regardless of type, causing
lots of false positives. Present patch fixes this.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 953d2ff..7e6e0a1 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -296,20 +296,24 @@ static void sur40_close(struct input_polled_dev *polldev)
 static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
 {
 	int wide, major, minor;
+	int bb_size_x, bb_size_y, pos_x, pos_y, ctr_x, ctr_y, slotnum;
 
-	int bb_size_x = le16_to_cpu(blob->bb_size_x);
-	int bb_size_y = le16_to_cpu(blob->bb_size_y);
-
-	int pos_x = le16_to_cpu(blob->pos_x);
-	int pos_y = le16_to_cpu(blob->pos_y);
-
-	int ctr_x = le16_to_cpu(blob->ctr_x);
-	int ctr_y = le16_to_cpu(blob->ctr_y);
+	if (blob->type != SUR40_TOUCH)
+		return;
 
-	int slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
+	slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
 	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
 		return;
 
+	bb_size_x = le16_to_cpu(blob->bb_size_x);
+	bb_size_y = le16_to_cpu(blob->bb_size_y);
+
+	pos_x = le16_to_cpu(blob->pos_x);
+	pos_y = le16_to_cpu(blob->pos_y);
+
+	ctr_x = le16_to_cpu(blob->ctr_x);
+	ctr_y = le16_to_cpu(blob->ctr_y);
+
 	input_mt_slot(input, slotnum);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
 	wide = (bb_size_x > bb_size_y);
-- 
2.7.4

