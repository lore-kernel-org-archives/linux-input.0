From: cpaul@redhat.com
Subject: [PATCH 1/1] Input - alps: Fix button reporting on the V2 Alps protocol
Date: Wed, 29 Jul 2015 16:45:26 -0400
Message-ID: <1438202726-5100-2-git-send-email-cpaul@redhat.com>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <1438202726-5100-1-git-send-email-cpaul@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG2U6E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 16:58:04 -0400
In-Reply-To: <1438202726-5100-1-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>

From: Stephen Chandler Paul <cpaul@redhat.com>

The data concerning which buttons on the touchpad are held down or not
are in the fourth packet we receive from the mouse, not the first.

Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
---
 drivers/input/mouse/alps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 113d6f1..e2f9b25 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -254,9 +254,9 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 	/* Non interleaved V2 dualpoint has separate stick button bits */
 	if (priv->proto_version == ALPS_PROTO_V2 &&
 	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
-		left |= packet[0] & 1;
-		right |= packet[0] & 2;
-		middle |= packet[0] & 4;
+		left |= packet[3] & 1;
+		right |= packet[3] & 2;
+		middle |= packet[3] & 4;
 	}
 
 	alps_report_buttons(dev, dev2, left, right, middle);
-- 
2.4.3

