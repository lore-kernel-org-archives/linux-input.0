From: anshul.g@samsung.com
Subject: [PATCH] Input:Optimize events_per_packet count calculation
Date: Wed, 10 Dec 2014 17:18:43 +0530
Message-ID: <1418212123-4549-1-git-send-email-anshul.g@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58933 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaLJLtF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Dec 2014 06:49:05 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGD004AO7HREX00@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 10 Dec 2014 20:49:03 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <anshul.g@samsung.com>

This patch avoids unnecessary operations while estimating events per
packet for an input device when event type is not set.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/input.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 29ca0bb..8172296 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1973,18 +1973,22 @@ static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
 
 	events = mt_slots + 1; /* count SYN_MT_REPORT and SYN_REPORT */
 
-	for (i = 0; i < ABS_CNT; i++) {
-		if (test_bit(i, dev->absbit)) {
-			if (input_is_mt_axis(i))
-				events += mt_slots;
-			else
-				events++;
+	if (test_bit(EV_ABS, dev->evbit)) {
+		for (i = 0; i < ABS_CNT; i++) {
+			if (test_bit(i, dev->absbit)) {
+				if (input_is_mt_axis(i))
+					events += mt_slots;
+				else
+					events++;
+			}
 		}
 	}
 
-	for (i = 0; i < REL_CNT; i++)
-		if (test_bit(i, dev->relbit))
-			events++;
+	if (test_bit(EV_REL, dev->evbit)) {
+		for (i = 0; i < REL_CNT; i++)
+			if (test_bit(i, dev->relbit))
+				events++;
+	}
 
 	/* Make room for KEY and MSC events */
 	events += 7;
-- 
1.7.9.5

