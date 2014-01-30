From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 4/4] Input: wacom: Handle 1024 pressure levels in wacom_tpc_pen
Date: Thu, 30 Jan 2014 10:48:48 -0800
Message-ID: <1391107728-1306-4-git-send-email-killertofu@gmail.com>
References: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39363 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaA3Ssr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 13:48:47 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so3334673pdj.40
        for <linux-input@vger.kernel.org>; Thu, 30 Jan 2014 10:48:47 -0800 (PST)
In-Reply-To: <1391107728-1306-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, pinglinux@gmail.com, skomra@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Some tablet PC sensors (e.g. the 0xEC found in the Thinkpad
Yoga) report more than 256 pressure levels and will experience
wraparound unless the full range is read.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9ff5613..ae1437b 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1087,7 +1087,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
 		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
 		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
-		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x01) << 8) | data[6]);
+		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x03) << 8) | data[6]);
 		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
 		input_report_key(input, wacom->tool[0], prox);
 		return 1;
-- 
1.8.5.3

