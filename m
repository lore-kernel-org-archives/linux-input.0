From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/7] alps: Do not use input-mt finger tracking for semi-mt devices
Date: Fri, 24 Apr 2015 16:48:54 +0200
Message-ID: <1429886936-24587-6-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901AbbDXOtH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:07 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

With the recent process_bitmap() changes all semi-mt devices always report
the first finger down in slot 0, so stop using input-mt finger tracking
for these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 604dea3..11fda20 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -532,7 +532,11 @@ static void alps_report_semi_mt_data(struct psmouse *psmouse, int fingers)
 		priv->second_touch = -1;
 	}
 
-	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 2);
+	if (fingers >= 1)
+		alps_set_slot(dev, 0, f->mt[0].x, f->mt[0].y);
+	if (fingers >= 2)
+		alps_set_slot(dev, 1, f->mt[1].x, f->mt[1].y);
+	input_mt_sync_frame(dev);
 
 	input_mt_report_finger_count(dev, fingers);
 
@@ -2835,7 +2839,7 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
 
 	input_mt_init_slots(dev1, MAX_TOUCHES,
 			    INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
-				INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
+				INPUT_MT_SEMI_MT);
 }
 
 static void alps_set_abs_params_v7(struct alps_data *priv,
-- 
2.3.5

