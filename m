From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 12/12] HID: sony: Perform duplicate device check earlier on
Date: Tue,  7 Mar 2017 15:45:11 -0800
Message-ID: <20170307234511.30380-13-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35816 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933287AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pg0-f51.google.com with SMTP id b129so6022935pgc.2
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:27 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Game controllers can be connected twice through USB and BT. Only
one connection is allowed. Currently we perform a check for duplicate
controllers halfway through device initialization. To prevent
'transient' devices, we should do this check as early as we can.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f8c4835..c92f590 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2477,6 +2477,10 @@ static int sony_input_configured(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	ret = append_dev_id = sony_check_add(sc);
+	if (ret < 0)
+		goto err_stop;
+
 	ret = sony_allocate_output_report(sc);
 	if (ret < 0) {
 		hid_err(hdev, "failed to allocate the output report buffer\n");
@@ -2613,10 +2617,6 @@ static int sony_input_configured(struct hid_device *hdev,
 	if (ret < 0)
 		goto err_stop;
 
-	ret = append_dev_id = sony_check_add(sc);
-	if (ret < 0)
-		goto err_stop;
-
 	if (sc->quirks & SONY_LED_SUPPORT) {
 		ret = sony_leds_init(sc);
 		if (ret < 0)
-- 
2.9.3

