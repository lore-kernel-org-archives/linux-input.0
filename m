From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: sur40 - suppress false uninitialized variable warning
Date: Tue, 26 Nov 2013 11:08:19 -0800
Message-ID: <20131126190815.GA23739@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:46551 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab3KZTIX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 14:08:23 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so8650789pbc.15
        for <linux-input@vger.kernel.org>; Tue, 26 Nov 2013 11:08:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org

We will never use packet_id before initializing it as we start with
"need_blobs == -1" and will set packet_id there.

Also use le32_to_cpu when fetching header->packet_id.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index cfd1b7e..f1cb051 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -251,7 +251,7 @@ static void sur40_poll(struct input_polled_dev *polldev)
 	struct sur40_state *sur40 = polldev->private;
 	struct input_dev *input = polldev->input;
 	int result, bulk_read, need_blobs, packet_blobs, i;
-	u32 packet_id;
+	u32 uninitialized_var(packet_id);
 
 	struct sur40_header *header = &sur40->bulk_in_buffer->header;
 	struct sur40_blob *inblob = &sur40->bulk_in_buffer->blobs[0];
@@ -286,7 +286,7 @@ static void sur40_poll(struct input_polled_dev *polldev)
 		if (need_blobs == -1) {
 			need_blobs = le16_to_cpu(header->count);
 			dev_dbg(sur40->dev, "need %d blobs\n", need_blobs);
-			packet_id = header->packet_id;
+			packet_id = le32_to_cpu(header->packet_id);
 		}
 
 		/*
-- 
1.8.3.1


-- 
Dmitry
