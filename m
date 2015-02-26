From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCHv2 1/4] psmouse: Remove hardcoded touchpad size from the focaltech driver.
Date: Fri, 27 Feb 2015 00:20:05 +0100
Message-ID: <1424992808-29891-2-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>
List-Id: linux-input@vger.kernel.org

The size has in most cases already been fetched from the touchpad, the
hardcoded values should have been removed.

Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
---
 drivers/input/mouse/focaltech.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index fca38ba..5d8cf98 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -67,9 +67,6 @@ static void focaltech_reset(struct psmouse *psmouse)
 
 #define FOC_MAX_FINGERS 5
 
-#define FOC_MAX_X 2431
-#define FOC_MAX_Y 1663
-
 /*
  * Current state of a single finger on the touchpad.
  */
@@ -131,7 +128,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
 		if (active) {
 			input_report_abs(dev, ABS_MT_POSITION_X, finger->x);
 			input_report_abs(dev, ABS_MT_POSITION_Y,
-					 FOC_MAX_Y - finger->y);
+					 priv->y_max - finger->y);
 		}
 	}
 	input_mt_report_pointer_emulation(dev, true);
-- 
2.1.0
