From: Scott Moreau <oreaus@gmail.com>
Subject: [PATCH v3] HID: sony: Fix up nyko core controller
Date: Wed, 10 Jan 2018 11:46:13 -0700
Message-ID: <1515609973-21447-1-git-send-email-oreaus@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41084 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeAJSql (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Jan 2018 13:46:41 -0500
Received: by mail-io0-f193.google.com with SMTP id f6so492021ioh.8
        for <linux-input@vger.kernel.org>; Wed, 10 Jan 2018 10:46:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Scott Moreau <oreaus@gmail.com>

This fixes missing d-pad axis broken since e19a267b99. The axis mapping for
the nyko controller has the d-pad as axis 0x39 instead of d-pad as buttons.
This is handled by the default hid mapping so we return 0 in sony_mapping.
This controller also has no accelerometer so avoid initializing it with
a condition in sony_input_configured() to setup these controllers.

Signed-off-by: Scott Moreau <oreaus@gmail.com>
---

Changed in v3:

- Added signoff

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

