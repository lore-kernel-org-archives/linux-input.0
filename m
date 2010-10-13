From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RFC, PATCH 2/2] HID: hid-sony, use HID_QUIRK_FORCE_OUT_CONTROL_EP for Sixaxis
Date: Wed, 13 Oct 2010 22:57:38 +0200
Message-ID: <1287003458-3791-3-git-send-email-ospite@studenti.unina.it>
References: <4CA9DD89.2010106@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:37128 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab0JMU6d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:58:33 -0400
In-Reply-To: <4CA9DD89.2010106@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Alan Ott <alan@signal11.us>, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?UTF-8?q?Mikko=20Virkkil=C3=A4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

Force output reports to be sent on the control endpoint for
SIXAXIS_CONTROLLER_USB, this allows to finally send output reports to
the controller via hidraw, which is needed in order to set leds without
libusb.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/hid/hid-sony.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d61f268..7b0c70a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -110,8 +110,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	if (sc->quirks & SIXAXIS_CONTROLLER_USB)
+	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		ret = sixaxis_set_operational_usb(hdev);
+		hdev->quirks |= HID_QUIRK_FORCE_OUT_CONTROL_EP;
+	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
 	else
-- 
1.7.1

