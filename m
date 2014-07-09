From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 12/14] alps: Change decode function prototype to return an int
Date: Wed,  9 Jul 2014 17:24:17 +0200
Message-ID: <1404919459-23561-13-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932597AbaGIPYo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:44 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

So that decode functions can return a failure when appropriate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 12 +++++++++---
 drivers/input/mouse/alps.h |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 93c6087..140471d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -538,7 +538,7 @@ static void alps_decode_buttons_v3(struct alps_fields *f, unsigned char *p)
 	f->ts_middle = !!(p[3] & 0x40);
 }
 
-static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
+static int alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
 				 struct psmouse *psmouse)
 {
 	f->first_mp = !!(p[4] & 0x40);
@@ -558,9 +558,11 @@ static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
 	f->pressure = p[5] & 0x7f;
 
 	alps_decode_buttons_v3(f, p);
+
+	return 0;
 }
 
-static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
+static int alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 				 struct psmouse *psmouse)
 {
 	alps_decode_pinnacle(f, p, psmouse);
@@ -570,9 +572,11 @@ static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 	f->fingers = max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
 	f->x_map |= (p[5] & 0x10) << 11;
 	f->y_map |= (p[5] & 0x20) << 6;
+
+	return 0;
 }
 
-static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
+static int alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
 				struct psmouse *psmouse)
 {
 	u64 palm_data = 0;
@@ -605,6 +609,8 @@ static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
 		f->x_map = (palm_data >> priv->y_bits) &
 			   (BIT(priv->x_bits) - 1);
 	}
+
+	return 0;
 }
 
 static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index ee841e5..17e3ae3 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -157,7 +157,7 @@ struct alps_data {
 
 	int (*hw_init)(struct psmouse *psmouse);
 	void (*process_packet)(struct psmouse *psmouse);
-	void (*decode_fields)(struct alps_fields *f, unsigned char *p,
+	int (*decode_fields)(struct alps_fields *f, unsigned char *p,
 			      struct psmouse *psmouse);
 	void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
 
-- 
2.0.0

