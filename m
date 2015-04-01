From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] alps: Report alps v2 Dualpoint Stick events via the right evdev node
Date: Wed,  1 Apr 2015 17:44:06 +0200
Message-ID: <1427903046-26692-3-git-send-email-hdegoede@redhat.com>
References: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59951 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbbDAPoQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Apr 2015 11:44:16 -0400
In-Reply-To: <1427903046-26692-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On V2 devices the DualPoint Stick reports bare packets, these should be
reported via the "AlpsPS/2 ALPS DualPoint Stick" dev2 evdev node, which also
has the INPUT_PROP_POINTING_STICK propbit set.

Note that since there is no way to distuingish these packets from an external
ps/2 mouse (in sofar as these laptops have an external ps/2 port) this means
that we will be reporting ps/2 mouse events via this evdev node too, as we've
been doing in kernel 3.19 and older.

This has been tested on a Dell Latitude D620 and a Dell Latitude E6400,
which both have a V2 touchpad + a DualPoint Stick which reports bare packets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f2c5545..80b6eca 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1161,7 +1161,12 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 	struct alps_data *priv = psmouse->private;
 	struct input_dev *dev;
 
-	if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+	/* Figure out which device to use to report the bare packet */
+	if (priv->proto_version == ALPS_PROTO_V2 &&
+	    (priv->flags & ALPS_DUALPOINT)) {
+		/* On V2 devices the DualPoint Stick reports bare packets */
+		dev = priv->dev2;
+	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
 			psmouse_queue_work(psmouse, &priv->dev3_register_work,
-- 
2.3.4

