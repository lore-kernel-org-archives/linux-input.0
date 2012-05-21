From: chris@cnpbagwell.com
Subject: [PATCH 2/2] input: wacom - Bamboo One 1024 pressure fix
Date: Sun, 20 May 2012 20:43:32 -0500
Message-ID: <1337564612-15301-2-git-send-email-chris@cnpbagwell.com>
References: <1337564612-15301-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50505 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab2EUBnl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 21:43:41 -0400
Received: by obbtb18 with SMTP id tb18so7412531obb.19
        for <linux-input@vger.kernel.org>; Sun, 20 May 2012 18:43:40 -0700 (PDT)
In-Reply-To: <1337564612-15301-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Bamboo One's with ID of 0x6a and 0x6b were added with correct
indication of 1024 pressure levels but the Graphire packet routine
was only looking at 9 bits.  Increased to 10 bits.

This bug caused these devices to roll over to zero pressure at half
way mark.

The other devices using this routine only support 256 or 512 range
and look to fix unused bits at zero.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Reported-by: Tushant Mirchandani <tushantin@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 004bc1b..869e057 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -248,7 +248,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
 		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
 		if (wacom->tool[0] != BTN_TOOL_MOUSE) {
-			input_report_abs(input, ABS_PRESSURE, data[6] | ((data[7] & 0x01) << 8));
+			input_report_abs(input, ABS_PRESSURE, data[6] | ((data[7] & 0x03) << 8));
 			input_report_key(input, BTN_TOUCH, data[1] & 0x01);
 			input_report_key(input, BTN_STYLUS, data[1] & 0x02);
 			input_report_key(input, BTN_STYLUS2, data[1] & 0x04);
-- 
1.7.10.1

