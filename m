From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: psmouse - clean up Cypress probe
Date: Thu, 3 Dec 2015 15:56:48 -0800
Message-ID: <20151203235648.GA29409@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36826 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbLCX4w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2015 18:56:52 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org

When Cypress protocol support is disabled cypress_init() is a stub that
always returns -ENOSYS, so there is not point in testing for
CONFIG_MOUSE_PS2_CYPRESS after we decided that we are dealing with a
Cypress device. Also, we should only be calling cypress_detect() when
set_properties argument is "true", like with other protocols.

There is a slight change in behavior to make follow-up patches more
uniform: when we detect Cypress but its initialization fails, instead of
immediately returning PSMOUSE_PS2 protocol we now continue trying
IntelliMouse [Explorer]. Given that Cypress devices only have issue with
Sentelic probes probing Imtellimouse should be safe.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index c2bd866..978ba0b 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -836,19 +836,15 @@ static int psmouse_extensions(struct psmouse *psmouse,
 	 * Trackpads.
 	 */
 	if (max_proto > PSMOUSE_IMEX &&
-			cypress_detect(psmouse, set_properties) == 0) {
-		if (IS_ENABLED(CONFIG_MOUSE_PS2_CYPRESS)) {
-			if (cypress_init(psmouse) == 0)
-				return PSMOUSE_CYPRESS;
-
-			/*
-			 * Finger Sensing Pad probe upsets some modules of
-			 * Cypress Trackpad, must avoid Finger Sensing Pad
-			 * probe if Cypress Trackpad device detected.
-			 */
-			return PSMOUSE_PS2;
-		}
+	    psmouse_do_detect(cypress_detect, psmouse, set_properties) == 0) {
+		if (!set_properties || cypress_init(psmouse) == 0)
+			return PSMOUSE_CYPRESS;
 
+		/*
+		 * Finger Sensing Pad probe upsets some modules of
+		 * Cypress Trackpad, must avoid Finger Sensing Pad
+		 * probe if Cypress Trackpad device detected.
+		 */
 		max_proto = PSMOUSE_IMEX;
 	}
 
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
