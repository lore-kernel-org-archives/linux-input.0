From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/7] alps: Change alps_decode_rushmore to do all decoding itself
Date: Fri, 24 Apr 2015 16:48:50 +0200
Message-ID: <1429886936-24587-2-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40580 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144AbbDXOtC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:02 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Change alps_decode_rushmore to do all decoding itself, rather then relying
on alps_decode_pinnacle and then overriding some fields + or-ing in some
bits.

This is a preparation patch for modifying the decode functions to properly
differentiate between position and bitmap packets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index e6708f6..e2ae6ca 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -605,13 +605,25 @@ static int alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
 static int alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 				 struct psmouse *psmouse)
 {
-	alps_decode_pinnacle(f, p, psmouse);
-
-	/* Rushmore's packet decode has a bit difference with Pinnacle's */
+	f->first_mp = !!(p[4] & 0x40);
 	f->is_mp = !!(p[5] & 0x40);
+
 	f->fingers = max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
-	f->x_map |= (p[5] & 0x10) << 11;
-	f->y_map |= (p[5] & 0x20) << 6;
+	f->x_map = ((p[5] & 0x10) << 11) |
+		   ((p[4] & 0x7e) << 8) |
+		   ((p[1] & 0x7f) << 2) |
+		   ((p[0] & 0x30) >> 4);
+	f->y_map = ((p[5] & 0x20) << 6) |
+		   ((p[3] & 0x70) << 4) |
+		   ((p[2] & 0x7f) << 1) |
+		   (p[4] & 0x01);
+
+	f->st.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
+	       ((p[0] & 0x30) >> 4);
+	f->st.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
+	f->pressure = p[5] & 0x7f;
+
+	alps_decode_buttons_v3(f, p);
 
 	return 0;
 }
-- 
2.3.5

