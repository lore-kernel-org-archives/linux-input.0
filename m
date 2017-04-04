From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: touchscreen: sur40: fix bad endianness handling in sur40_poll
Date: Tue,  4 Apr 2017 15:06:17 +0200
Message-ID: <1491311177-16974-1-git-send-email-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:56992 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752518AbdDDNGd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Apr 2017 09:06:33 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 6460020F0F
        for <linux-input@vger.kernel.org>; Tue,  4 Apr 2017 15:06:31 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: hverkuil@xs4all.nl, mchehab@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

sparse says:

  sur40.c:372:40: warning: restricted __le32 degrades to integer

the header's data is __le32 so we need to convert it before comparing.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/touchscreen/sur40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 4c0eeca..128e5bd 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -369,7 +369,7 @@ static void sur40_poll(struct input_polled_dev *polldev)
 		 * packet ID will usually increase in the middle of a series
 		 * instead of at the end.
 		 */
-		if (packet_id != header->packet_id)
+		if (packet_id != le32_to_cpu(header->packet_id))
 			dev_dbg(sur40->dev, "packet ID mismatch\n");
 
 		packet_blobs = result / sizeof(struct sur40_blob);
-- 
2.1.4

