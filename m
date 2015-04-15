From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] HID: wacom: move unit and unitExpo initialization to wacom_calculate_res
Date: Wed, 15 Apr 2015 16:54:14 -0700
Message-ID: <1429142054-16871-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36736 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755719AbbDOXyS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 19:54:18 -0400
Received: by pabsx10 with SMTP id sx10so67976462pab.3
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2015 16:54:17 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

That is where they belong...

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_sys.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index ca30eab..855f3b3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1365,6 +1365,12 @@ static void wacom_set_default_phy(struct wacom_features *features)
 
 static void wacom_calculate_res(struct wacom_features *features)
 {
+	/* set unit to "100th of a mm" for devices not reported by HID */
+	if (!features->unit) {
+		features->unit = 0x11;
+		features->unitExpo = -3;
+	}
+
 	features->x_resolution = wacom_calc_hid_res(features->x_max,
 						    features->x_phy,
 						    features->unit,
@@ -1505,16 +1511,8 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom_retrieve_hid_descriptor(hdev, features);
 
 	wacom_setup_device_quirks(wacom);
-
-	/* set unit to "100th of a mm" for devices not reported by HID */
-	if (!features->unit) {
-		features->unit = 0x11;
-		features->unitExpo = -3;
-	}
 	wacom_calculate_res(features);
-
 	wacom_update_name(wacom);
-
 	error = wacom_add_shared_data(hdev);
 	if (error)
 		goto fail_shared_data;
-- 
1.9.1

