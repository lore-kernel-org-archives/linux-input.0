From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCH 1/3] psmouse: Remove hardcoded touchpad size from the focaltech driver.
Date: Sat, 14 Feb 2015 20:01:40 +0100
Message-ID: <1423940502-12353-2-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:40867 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbbBNTCU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2015 14:02:20 -0500
Received: by mail-qg0-f50.google.com with SMTP id e89so18058551qgf.9
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2015 11:02:19 -0800 (PST)
In-Reply-To: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>

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

