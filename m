From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] alps: Non interleaved V2 dualpoint has separate stick button bits
Date: Wed,  8 Apr 2015 18:04:52 +0200
Message-ID: <1428509092-25794-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45983 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbbDHQE4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Apr 2015 12:04:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Non interleaved V2 dualpoint touchpad / stick combos have separate stick
button bits in the touchpad packets, if we do not check these then the
trackpoint buttons will not work when using the touchpad, and when pressed
when the user starts using the touchpad will report a release event even
though the button is still pressed.

This commit fixes this by checking the separate bits, note that we simply
combine the buttons, since the hardware does the same when using the touchpad
buttons with the trackpoint, so we do not have enough information to properly
separate them.

Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 6962c26..58987b5 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -243,6 +243,14 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 		return;
 	}
 
+	/* Non interleaved V2 dualpoint has separate stick button bits */
+	if (priv->proto_version == ALPS_PROTO_V2 &&
+	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
+		left |= packet[0] & 1;
+		right |= packet[0] & 2;
+		middle |= packet[0] & 4;
+	}
+
 	alps_report_buttons(dev, dev2, left, right, middle);
 
 	/* Convert hardware tap to a reasonable Z value */
-- 
2.3.4

