From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 1/4] HID: sony: Use the SIXAXIS_CONTROLLER constant when possible
Date: Tue, 24 Jun 2014 13:28:40 +0200
Message-ID: <1403609323-27283-2-git-send-email-ao2@ao2.it>
References: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:52968 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbaFXMMJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 08:12:09 -0400
In-Reply-To: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Instead of checking for SIXAXIS_CONTROLLER_USB and SIXAXIS_CONTROLLER_BT
separately, a check on SIXAXIS_CONTROLLER can be used when setting
connect_mask.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2259eaa..a77269b 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1830,9 +1830,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	if (sc->quirks & VAIO_RDESC_CONSTANT)
 		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
-	else if (sc->quirks & SIXAXIS_CONTROLLER_USB)
-		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
-	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
+	else if (sc->quirks & SIXAXIS_CONTROLLER)
 		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
 
 	ret = hid_hw_start(hdev, connect_mask);
-- 
2.0.0

