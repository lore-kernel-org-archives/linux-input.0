From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCHv2 4/4] psmouse: Disable "palm detection" in the focaltech driver.
Date: Fri, 27 Feb 2015 00:20:08 +0100
Message-ID: <1424992808-29891-5-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>
List-Id: linux-input@vger.kernel.org

Apparently, the threshold for large contact area seems to be rather low on
some devices, causing the touchpad to frequently freeze during normal
usage. Because we do now know how we are supposed to use the value in
question, this commit just drops the related code completely.

Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
---
 drivers/input/mouse/focaltech.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index d96a847..e1d084a 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -185,16 +185,6 @@ static void focaltech_process_abs_packet(struct psmouse *psmouse,
 
 	state->pressed = (packet[0] >> 4) & 1;
 
-	/*
-	 * packet[5] contains some kind of tool size in the most
-	 * significant nibble. 0xff is a special value (latching) that
-	 * signals a large contact area.
-	 */
-	if (packet[5] == 0xff) {
-		state->fingers[finger].valid = false;
-		return;
-	}
-
 	state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
 	state->fingers[finger].y = (packet[3] << 8) | packet[4];
 	state->fingers[finger].valid = true;
-- 
2.1.0
