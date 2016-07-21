From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v2] HID: sony: disable descriptor fixup for FutureMax Dance Mat
Date: Thu, 21 Jul 2016 19:54:48 +0300
Message-ID: <20160721165448.14275-1-mikko.perttunen@kapsi.fi>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:47645 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926AbcGUQzS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2016 12:55:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: ao2@ao2.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

From: Mikko Perttunen <mperttunen@nvidia.com>

The FutureMax Dance Mat claims to be a SixAxis controller
but breaks if descriptor fixups are applied. Detect the
device using its USB product string and disable fixups
when it is detected.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2: don't use usb device properties

 drivers/hid/hid-sony.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 310436a..29a1aa9 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -51,6 +51,7 @@
 #define NAVIGATION_CONTROLLER_USB BIT(9)
 #define NAVIGATION_CONTROLLER_BT  BIT(10)
 #define SINO_LITE_CONTROLLER      BIT(11)
+#define FUTUREMAX_DANCE_MAT       BIT(12)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -1125,7 +1126,7 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	if (sc->quirks & SINO_LITE_CONTROLLER)
+	if (sc->quirks & (SINO_LITE_CONTROLLER | FUTUREMAX_DANCE_MAT))
 		return rdesc;
 
 	/*
@@ -2289,6 +2290,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct sony_sc *sc;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 
+	if (!strcmp(hdev->name, "FutureMax Dance Mat"))
+		quirks |= FUTUREMAX_DANCE_MAT;
+
 	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
 	if (sc == NULL) {
 		hid_err(hdev, "can't alloc sony descriptor\n");
-- 
2.9.0

