From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] hid: sony: Update the DualShock 4 touchpad resolution
Date: Wed, 24 Sep 2014 09:38:19 -0400
Message-ID: <1411565899-4358-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:44028 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750817AbaIXNiz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 09:38:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

The DualShock 4 touchpad has been measured to have a resolution of
44.86 dots/mm which equates to 1920x942.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5baa311..bc4269e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1107,10 +1107,10 @@ static void sony_input_configured(struct hid_device *hdev,
 
 	/*
 	 * The Dualshock 4 touchpad supports 2 touches and has a
-	 * resolution of 1920x940.
+	 * resolution of 1920x942 (44.86 dots/mm).
 	 */
 	if (sc->quirks & DUALSHOCK4_CONTROLLER) {
-		if (sony_register_touchpad(hidinput, 2, 1920, 940) != 0)
+		if (sony_register_touchpad(hidinput, 2, 1920, 942) != 0)
 			hid_err(sc->hdev,
 				"Unable to initialize multi-touch slots\n");
 	}
-- 
2.1.0

