From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/3] HID: wacom - Cleanup input_capabilities for Graphire 4 and Bamboo Fun
Date: Tue, 18 Nov 2014 13:28:37 -0800
Message-ID: <1416346117-11307-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:63853 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbaKRV2p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 16:28:45 -0500
Received: by mail-pd0-f179.google.com with SMTP id g10so23988644pdj.24
        for <linux-input@vger.kernel.org>; Tue, 18 Nov 2014 13:28:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

Graphire 4 only has two tablet buttons; Bamboo Fun touch ring is only
for PAD.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by:  Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 372d890..792569c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2047,9 +2047,6 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	switch (features->type) {
 	case WACOM_MO:
-		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
-		/* fall through */
-
 	case WACOM_G4:
 		/* fall through */
 
@@ -2303,9 +2300,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 	case WACOM_G4:
 		__set_bit(BTN_BACK, input_dev->keybit);
-		__set_bit(BTN_LEFT, input_dev->keybit);
 		__set_bit(BTN_FORWARD, input_dev->keybit);
-		__set_bit(BTN_RIGHT, input_dev->keybit);
 		input_set_capability(input_dev, EV_REL, REL_WHEEL);
 		break;
 
-- 
1.9.1

