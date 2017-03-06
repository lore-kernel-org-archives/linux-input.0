From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 2/2] HID: wacom: don't manually release resources for the EKR
Date: Mon,  6 Mar 2017 10:54:58 -0800
Message-ID: <1488826498-8578-3-git-send-email-skomra@gmail.com>
References: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34494 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbdCFTEQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Mar 2017 14:04:16 -0500
Received: by mail-pg0-f65.google.com with SMTP id b5so3696201pgg.1
        for <linux-input@vger.kernel.org>; Mon, 06 Mar 2017 11:04:15 -0800 (PST)
In-Reply-To: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, Ping.Cheng@wacom.com, killertofu@gmail.com, benjamin.tissoires@redhat.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>

Commit 5b779fc introduces the manual release of resources
in wacom_remove() as an addition to the driver's use of devm.
The EKR resources can only be released through
wacom_remote_destroy_one() so we skip the manual release
for it.

Signed-off-by: Aaron Armstrong Skomra <skomra@gmail.com>
---
 drivers/hid/wacom_sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index be8f7e2..994bddc 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2579,7 +2579,9 @@ static void wacom_remove(struct hid_device *hdev)
 
 	/* make sure we don't trigger the LEDs */
 	wacom_led_groups_release(wacom);
-	wacom_release_resources(wacom);
+
+	if (wacom->wacom_wac.features.type != REMOTE)
+		wacom_release_resources(wacom);
 
 	hid_set_drvdata(hdev, NULL);
 }
-- 
2.7.4

