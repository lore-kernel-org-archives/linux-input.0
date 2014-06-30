From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/2] input: wacom: Support up to 2048 pressure levels with ISDv4
Date: Mon, 30 Jun 2014 14:46:45 -0700
Message-ID: <1404164806-5141-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34124 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346AbaF3Vqw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2014 17:46:52 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so8919134pdi.13
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2014 14:46:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 977d05c..61a45a5 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1093,7 +1093,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
 		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
 		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
-		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x03) << 8) | data[6]);
+		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x07) << 8) | data[6]);
 		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
 		input_report_key(input, wacom->tool[0], prox);
 		return 1;
-- 
2.0.0

