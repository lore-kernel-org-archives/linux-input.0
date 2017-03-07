From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 10/12] HID: sony: Print error on failure to active DS3 / Navigation controllers
Date: Tue,  7 Mar 2017 15:45:09 -0800
Message-ID: <20170307234511.30380-11-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34641 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933282AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f171.google.com with SMTP id v190so6660599pfb.1
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:25 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

This patch adds printing when we failed to activate DS3 / Nagivation
controllers and checks the return value for these failures earlier
in sony_input_configured. This paves the way for other configuration
logic for these devices, which we don't want to call if for example
the activation failed.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 16f37d6..b82d05c 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2468,7 +2468,13 @@ static int sony_input_configured(struct hid_device *hdev,
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 		sc->defer_initialization = 1;
+
 		ret = sixaxis_set_operational_usb(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to set controller into operational mode\n");
+			goto err_stop;
+		}
+
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
 			(sc->quirks & NAVIGATION_CONTROLLER_BT)) {
@@ -2477,7 +2483,13 @@ static int sony_input_configured(struct hid_device *hdev,
 		 * when connected via Bluetooth.
 		 */
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
+
 		ret = sixaxis_set_operational_bt(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to set controller into operational mode\n");
+			goto err_stop;
+		}
+
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		ret = dualshock4_get_calibration_data(sc);
-- 
2.9.3

