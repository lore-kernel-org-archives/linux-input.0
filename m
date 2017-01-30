From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: don't apply generic settings to old devices
Date: Mon, 30 Jan 2017 15:40:49 -0800
Message-ID: <1485819649-8057-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35999 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbdA3Xsu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Jan 2017 18:48:50 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so24651597pfo.3
        for <linux-input@vger.kernel.org>; Mon, 30 Jan 2017 15:48:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

Non-generic devices have numbered_buttons set for both pen and
touch interfaces by default. The actual number of buttons on the
interface is normally manually decided later, which is different
from what those HID generic devices are processed, where number
of buttons are directly retrieved from HID descriptors.

This patch adds the missed HID_GENERIC check and moves the statement
to wacom_setup_pad_input_capabilities since it's not a quirk anymore.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0884dc9..6477fcd 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2777,8 +2777,6 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	struct wacom_features *features = &wacom->wacom_wac.features;
 
 	/* The pen and pad share the same interface on most devices */
-	if (features->numbered_buttons > 0)
-		features->device_type |= WACOM_DEVICETYPE_PAD;
 	if (features->type == GRAPHIRE_BT || features->type == WACOM_G4 ||
 	    features->type == DTUS ||
 	    (features->type >= INTUOS3S && features->type <= WACOM_MO)) {
@@ -3288,6 +3286,9 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 {
 	struct wacom_features *features = &wacom_wac->features;
 
+	if ((features->type == HID_GENERIC) && features->numbered_buttons > 0)
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+
 	if (!(features->device_type & WACOM_DEVICETYPE_PAD))
 		return -ENODEV;
 
-- 
2.7.4

