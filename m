From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCHv2 2/4] psmouse: Ensure that the focaltech driver reports consistent coordinates.
Date: Fri, 27 Feb 2015 00:20:06 +0100
Message-ID: <1424992808-29891-3-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:42541 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbbBZXUX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 18:20:23 -0500
In-Reply-To: <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>

We don't know whether x_max or y_max really hold the maximum possible
coordinates, and we don't know for sure whether we correctly interpret the
coordinates sent by the touchpad, so we clamp the reported values to
prevent confusion in userspace code.

Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
---
 drivers/input/mouse/focaltech.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 5d8cf98..0cfc646 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -126,9 +126,17 @@ static void focaltech_report_state(struct psmouse *psmouse)
 		input_mt_slot(dev, i);
 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
 		if (active) {
-			input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
+			int clamped_x, clamped_y;
+			/*
+			 * The touchpad might report invalid data, so we clamp
+			 * the resulting values so that we do not confuse
+			 * userspace.
+			 */
+			clamped_x = clamp((int)finger->x, 0, (int)priv->x_max);
+			clamped_y = clamp((int)finger->y, 0, (int)priv->y_max);
+			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
 			input_report_abs(dev, ABS_MT_POSITION_Y,
-					 priv->y_max - finger->y);
+					 priv->y_max - clamped_y);
 		}
 	}
 	input_mt_report_pointer_emulation(dev, true);
-- 
2.1.0

