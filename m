From: Scott Moreau <oreaus@gmail.com>
Subject: [PATCH] HID: sony: Fix up nyko core controller
Date: Tue, 12 Dec 2017 17:54:04 -0700
Message-ID: <1513126444-7675-1-git-send-email-oreaus@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:40616 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbdLMAyQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Dec 2017 19:54:16 -0500
Received: by mail-io0-f194.google.com with SMTP id v186so1045213iod.7
        for <linux-input@vger.kernel.org>; Tue, 12 Dec 2017 16:54:16 -0800 (PST)
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
 drivers/hid/hid-sony.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b9dc3ac..1be0a35 100644
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
 
@@ -2566,6 +2569,10 @@ static int sony_input_configured(struct hid_device *hdev,
 		}
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
+	} else if (sc->quirks & SINO_LITE_CONTROLLER) {
+		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
+
+		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
-- 
2.7.4

