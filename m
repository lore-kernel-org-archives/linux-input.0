From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH v2] Input :Optimize input_dev_release_keys function
Date: Thu, 25 Jun 2015 10:53:37 -0700
Message-ID: <1435254817-41989-1-git-send-email-aksgarg1989@gmail.com>
References: <aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33353 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbFYRyO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 13:54:14 -0400
Received: by padev16 with SMTP id ev16so53809532pad.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2015 10:54:13 -0700 (PDT)
In-Reply-To: <aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

input_dev_release_keys : Use for_each_set_bit instead
of testing every bit upto KEY_MAX as it is more clean
and more optimized.

input_estimate_events_per_packet : Use bitmap_weight
to get set bits count for EV_REL type instead of using
loop and also use for_each_set_bit for EV_ABS event for
more optimized code.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/input/input.c |   28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index e0b7b8e..9459f8b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -682,12 +682,9 @@ static void input_dev_release_keys(struct input_dev *dev)
 	int code;
 
 	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
-		for (code = 0; code <= KEY_MAX; code++) {
-			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
-			    __test_and_clear_bit(code, dev->key)) {
-				input_pass_event(dev, EV_KEY, code, 0);
-			}
-		}
+		for_each_set_bit(code, dev->keybit, KEY_MAX)
+			input_pass_event(dev, EV_KEY, code, 0);
+		memset(dev->key, 0, sizeof(dev->key));
 		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
 	}
 }
@@ -1986,21 +1983,16 @@ static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
 	events = mt_slots + 1; /* count SYN_MT_REPORT and SYN_REPORT */
 
 	if (test_bit(EV_ABS, dev->evbit)) {
-		for (i = 0; i < ABS_CNT; i++) {
-			if (test_bit(i, dev->absbit)) {
-				if (input_is_mt_axis(i))
-					events += mt_slots;
-				else
-					events++;
-			}
+		for_each_set_bit(i, dev->absbit, ABS_CNT) {
+			if (input_is_mt_axis(i))
+				events += mt_slots;
+			else
+				events++;
 		}
 	}
 
-	if (test_bit(EV_REL, dev->evbit)) {
-		for (i = 0; i < REL_CNT; i++)
-			if (test_bit(i, dev->relbit))
-				events++;
-	}
+	if (test_bit(EV_REL, dev->evbit))
+		events += bitmap_weight(dev->relbit, REL_CNT);
 
 	/* Make room for KEY and MSC events */
 	events += 7;
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

