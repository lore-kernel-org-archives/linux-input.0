From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] input: wacom - missed the last bit of expresskey for DTU-1031
Date: Fri, 11 Apr 2014 12:32:22 -0700
Message-ID: <1397244742-20012-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:53936 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbaDKTcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2014 15:32:11 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so5649124pdi.21
        for <linux-input@vger.kernel.org>; Fri, 11 Apr 2014 12:32:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 05f371d..3d094c9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1838,7 +1838,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 	case DTU:
 		if (features->type == DTUS) {
 			input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
-			for (i = 0; i < 3; i++)
+			for (i = 0; i < 4; i++)
 				__set_bit(BTN_0 + i, input_dev->keybit);
 		}
 		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
-- 
1.8.3.2

