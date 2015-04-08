From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.0 REGRESSION FIX] alps: Fix left touchpad button getting stuck when using it with trackpoint
Date: Wed,  8 Apr 2015 17:38:52 +0200
Message-ID: <1428507532-25533-2-git-send-email-hdegoede@redhat.com>
References: <1428507532-25533-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbbDHPjB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 11:39:01 -0400
In-Reply-To: <1428507532-25533-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

When the left touchpad button gets pressed, and then the trackpoint is moved,
and then the button is released, the following happens:

1) touchpad packet is received, touchpad evdev node reports BTN_LEFT 1
2) pointingstick packet is received, the hw will report a BTN_LEFT 1 in this
   packet because when the trackstick is active it communicates the combined
   touchpad + pointingstick buttons in the trackstick packet, since
   alps_report_bare_ps2_packet passes NULL (*) for the dev2 parameter to
   alps_report_buttons the combining is not detected and the pointingstick
   evdev node will also report BTN_LEFT 1
3) on release of the button a pointingstick packet with BTN_LEFT 0 is received,
   and the pointingstick evdev node will report BTN_LEFT 0

Note how because of the passing as NULL for dev2 the touchpad evdev node
will never send BTN_LEFT 0 in this scenario leading to a stuck mouse button.

This is a regression in 4.0 introduced by commit 04aae283ba6a8
("Input: ALPS - do not mix trackstick and external PS/2 mouse data")

This commit fixes this by passing in the touchpad evdev as dev2 parameter
when calling alps_report_buttons for the pointingstick on alps v2 devices,
so that alps_report_buttons correctly detect that we're already reporting the
button as pressed via the touchpad evdev node, and will also send the release
event there.

Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 80b6eca..6962c26 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1159,13 +1159,14 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 					bool report_buttons)
 {
 	struct alps_data *priv = psmouse->private;
-	struct input_dev *dev;
+	struct input_dev *dev, *dev2 = NULL;
 
 	/* Figure out which device to use to report the bare packet */
 	if (priv->proto_version == ALPS_PROTO_V2 &&
 	    (priv->flags & ALPS_DUALPOINT)) {
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
+		dev2 = psmouse->dev;
 	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
@@ -1177,7 +1178,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 	}
 
 	if (report_buttons)
-		alps_report_buttons(dev, NULL,
+		alps_report_buttons(dev, dev2,
 				packet[0] & 1, packet[0] & 2, packet[0] & 4);
 
 	input_report_rel(dev, REL_X,
-- 
2.3.4

