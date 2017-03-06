From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Correct Intuos Pro 2 resolution
Date: Mon,  6 Mar 2017 10:54:57 -0800
Message-ID: <1488826498-8578-2-git-send-email-skomra@gmail.com>
References: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32941 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754219AbdCFTDq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Mar 2017 14:03:46 -0500
Received: by mail-pf0-f195.google.com with SMTP id v190so7549828pfb.0
        for <linux-input@vger.kernel.org>; Mon, 06 Mar 2017 11:03:33 -0800 (PST)
In-Reply-To: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, Ping.Cheng@wacom.com, killertofu@gmail.com, benjamin.tissoires@redhat.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>

The features struct for the second gen Intuos Pro
uses the wrong constant for the resolution. This fix
is for commit 4922cd2.

Signed-off-by: Aaron Armstrong Skomra <skomra@gmail.com>
---
 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4aa3de9..3d86446 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4197,10 +4197,10 @@ static const struct wacom_features wacom_features_0x343 =
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x360 =
 	{ "Wacom Intuos Pro M", 44800, 29600, 8191, 63,
-	  INTUOSP2_BT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 9, .touch_max = 10 };
+	  INTUOSP2_BT, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 10 };
 static const struct wacom_features wacom_features_0x361 =
 	{ "Wacom Intuos Pro L", 62200, 43200, 8191, 63,
-	  INTUOSP2_BT, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 9, .touch_max = 10 };
+	  INTUOSP2_BT, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 10 };
 
 static const struct wacom_features wacom_features_HID_ANY_ID =
 	{ "Wacom HID", .type = HID_GENERIC, .oVid = HID_ANY_ID, .oPid = HID_ANY_ID };
-- 
2.7.4

