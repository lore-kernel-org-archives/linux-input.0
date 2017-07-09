From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 2/2] skip all blobs that are not touches
Date: Sun,  9 Jul 2017 20:54:51 +0200
Message-ID: <1499626491-22592-2-git-send-email-floe@butterbrot.org>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:37777 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752467AbdGITEF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 9 Jul 2017 15:04:05 -0400
In-Reply-To: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

The SUR40 labels all reported blobs as touch, token, or generic blob.
Previously, all blobs were reported as touch regardless of type, causing
lots of false positives. Present patch fixes this.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 12bdee9..fbd4010 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -309,6 +309,8 @@ static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
 	int slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
 	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
 		return;
+	if (blob->type != SUR40_TOUCH)
+		return;
 
 	input_mt_slot(input, slotnum);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
-- 
2.7.4

