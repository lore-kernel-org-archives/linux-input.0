From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance Mat
Date: Sun, 17 Jul 2016 20:25:33 +0300
Message-ID: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:46136 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbcGQR1H (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jul 2016 13:27:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

From: Mikko Perttunen <mperttunen@nvidia.com>

The FutureMax Dance Mat claims to be a SixAxis controller
but breaks if descriptor fixups are applied. Detect the
device using its USB product string and disable fixups
when it is detected.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/hid/hid-sony.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 310436a..4c976f7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -36,6 +36,9 @@
 #include <linux/list.h>
 #include <linux/idr.h>
 #include <linux/input/mt.h>
+#include <linux/usb.h>
+
+#include "usbhid/usbhid.h"
 
 #include "hid-ids.h"
 
@@ -51,6 +54,7 @@
 #define NAVIGATION_CONTROLLER_USB BIT(9)
 #define NAVIGATION_CONTROLLER_BT  BIT(10)
 #define SINO_LITE_CONTROLLER      BIT(11)
+#define FUTUREMAX_DANCE_MAT       BIT(12)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -1125,7 +1129,7 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	if (sc->quirks & SINO_LITE_CONTROLLER)
+	if (sc->quirks & (SINO_LITE_CONTROLLER | FUTUREMAX_DANCE_MAT))
 		return rdesc;
 
 	/*
@@ -2288,6 +2292,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	unsigned long quirks = id->driver_data;
 	struct sony_sc *sc;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
+	struct usb_device *usb_dev;
+
+	if (quirks & SIXAXIS_CONTROLLER_USB) {
+		usb_dev = hid_to_usb_dev(hdev);
+		if (usb_dev && usb_dev->product &&
+		    !strcmp(usb_dev->product, "FutureMax Dance Mat")) {
+			quirks |= FUTUREMAX_DANCE_MAT;
+		}
+	}
 
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
 	if (sc == NULL) {
-- 
2.8.2

