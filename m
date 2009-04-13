From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 2/3] input: workaround pen {down,up} events not reliable after
	stopping TSI
Date: Mon, 13 Apr 2009 12:09:10 +0800
Message-ID: <f17812d70904122109w4d14ab4frc66d95aad123d7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:3300 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbZDMEJM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2009 00:09:12 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2200875qwh.37
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2009 21:09:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Bin Yang <bin.yang@marvell.com>

>From 424ea166ef37e3f69883ef5aeaf14f1489e9f085 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Mon, 13 Apr 2009 11:04:51 +0800
Subject: [PATCH 2/3] input: workaround pen {down,up} events not
reliable after stopping TSI

PEN_{UP/DOWN} events are expected to be available soon after stopping TSI
auto measurement, but this is found not always true. Workaround this by
delay and simulate such an event (according to pen down status bit).

Signed-off-by: Bin Yang <bin.yang@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/touchscreen/da9034-ts.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c
b/drivers/input/touchscreen/da9034-ts.c
index eac2905..37f5df2 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -177,6 +177,15 @@ static void da9034_event_handler(struct
da9034_touch *touch, int event)
 			goto err_reset;

 		touch->state = STATE_STOP;
+
+		/* FIXME: PEN_{UP/DOWN} events are expected to be
+		 * available by stopping TSI, but this is found not
+		 * always true, delay and simulate such an event
+		 * here is more reliable
+		 */
+		mdelay(1);
+		da9034_event_handler(touch, is_pen_down(touch) ?
+				EVENT_PEN_DOWN : EVENT_PEN_UP);
 		break;

 	case STATE_STOP:
@@ -191,8 +200,6 @@ static void da9034_event_handler(struct
da9034_touch *touch, int event)
 			report_pen_up(touch);
 			touch->state = STATE_IDLE;
 		}
-
-		input_sync(touch->input_dev);
 		break;

 	case STATE_WAIT:
@@ -202,8 +209,10 @@ static void da9034_event_handler(struct
da9034_touch *touch, int event)
 		if (is_pen_down(touch)) {
 			start_tsi(touch);
 			touch->state = STATE_BUSY;
-		} else
+		} else {
+			report_pen_up(touch);
 			touch->state = STATE_IDLE;
+		}
 		break;
 	}
 	return;
@@ -228,16 +237,12 @@ static int da9034_touch_notifier(struct
notifier_block *nb,
 	struct da9034_touch *touch =
 		container_of(nb, struct da9034_touch, notifier);

-	if (event & DA9034_EVENT_PEN_DOWN) {
-		if (is_pen_down(touch))
-			da9034_event_handler(touch, EVENT_PEN_DOWN);
-		else
-			da9034_event_handler(touch, EVENT_PEN_UP);
-	}
-
 	if (event & DA9034_EVENT_TSI_READY)
 		da9034_event_handler(touch, EVENT_TSI_READY);

+	if (event & DA9034_EVENT_PEN_DOWN && touch->state == STATE_IDLE)
+		da9034_event_handler(touch, EVENT_PEN_DOWN);
+
 	return 0;
 }

-- 
1.6.0.4
