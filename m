From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4] input - wacom: TPC2FG doesn't store touch id for slots
Date: Mon, 25 Jun 2012 14:36:58 -0700
Message-ID: <1340660218-27475-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59790 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab2FYVcx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 17:32:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so7102210pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 14:32:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 4453864..6533f44 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1547,10 +1547,8 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
-	case TABLETPC2FG:
 	case MTSCREEN:
 		if (features->device_type == BTN_TOOL_FINGER) {
-
 			wacom_wac->slots = kmalloc(features->touch_max *
 							sizeof(int),
 						   GFP_KERNEL);
@@ -1559,7 +1557,11 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 			for (i = 0; i < features->touch_max; i++)
 				wacom_wac->slots[i] = -1;
+		}
+		/* fall through */
 
+	case TABLETPC2FG:
+		if (features->device_type == BTN_TOOL_FINGER) {
 			input_mt_init_slots(input_dev, features->touch_max);
 			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
 					0, MT_TOOL_MAX, 0, 0);
-- 
1.7.7.6

