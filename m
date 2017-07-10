From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH v2 2/3] silence unnecessary noisy debug output
Date: Mon, 10 Jul 2017 17:42:25 +0200
Message-ID: <1499701346-12110-2-git-send-email-floe@butterbrot.org>
References: <1499701346-12110-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:42414 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753646AbdGJPmn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 11:42:43 -0400
In-Reply-To: <1499701346-12110-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, peter.hutterer@who-t.net
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

This information is unneccessary, even as debug output.
Leave commented out as documentation of the packet ID quirk.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 259aef5..953d2ff 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -374,10 +374,13 @@ static void sur40_poll(struct input_polled_dev *polldev)
 		/*
 		 * Sanity check. when video data is also being retrieved, the
 		 * packet ID will usually increase in the middle of a series
-		 * instead of at the end.
-		 */
-		if (packet_id != le32_to_cpu(header->packet_id))
+		 * instead of at the end. However, the data is still consistent,
+		 * so the packet ID is probably just valid for the first packet
+		 * in a series.
+
+		if (packet_id != header->packet_id)
 			dev_dbg(sur40->dev, "packet ID mismatch\n");
+		 */
 
 		packet_blobs = result / sizeof(struct sur40_blob);
 		dev_dbg(sur40->dev, "received %d blobs\n", packet_blobs);
-- 
2.7.4

