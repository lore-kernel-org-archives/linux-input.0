From: Scott Moreau <oreaus@gmail.com>
Subject: [PATCH] HID: sony: Fix up nyko core controller
Date: Sun, 10 Dec 2017 19:51:48 -0700
Message-ID: <1512960708-23379-1-git-send-email-oreaus@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36737 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdLKCvw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 10 Dec 2017 21:51:52 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so12526089itj.1
        for <linux-input@vger.kernel.org>; Sun, 10 Dec 2017 18:51:52 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Scott Moreau <oreaus@gmail.com>

This fixes missing d-pad axis broken since e19a267b99. The axis mapping for
the nyko controller has the d-pad as axis 0x39 instead of d-pad as buttons.
This is handled by the default hid mapping so we return 0 in sony_mapping.
This controller also has no accelerometer so avoid initializing it with
a condition in sony_input_configured() to setup these controllers.
---
 drivers/hid/hid-sony.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b9dc3ac..e703024 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1225,6 +1225,9 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & NAVIGATION_CONTROLLER)
 		return navigation_mapping(hdev, hi, field, usage, bit, max);
 
+	if (sc->quirks & SINO_LITE_CONTROLLER)
+		return 0;
+
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_mapping(hdev, hi, field, usage, bit, max);
 
@@ -2566,6 +2569,12 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
+	} else if (sc->quirks & SINO_LITE_CONTROLLER) {
+		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
+		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
+		sc->defer_initialization = 1;
+
+		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
-- 
2.7.4

