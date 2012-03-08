From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] input: wacom: Use touch size for ABS_MT_TOUCH_MAJOR
Date: Wed,  7 Mar 2012 17:39:06 -0800
Message-ID: <1331170746-12636-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62324 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab2CHBjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Mar 2012 20:39:15 -0500
Received: by iagz16 with SMTP id z16so9441015iag.19
        for <linux-input@vger.kernel.org>; Wed, 07 Mar 2012 17:39:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

3rd-gen Bamboo devices report both "amplitude" and "size" data
in their touch packets. This patch changes the source for
ABS_MT_TOUCH_MAJOR to be the latter rather than the former.
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index d0b0fc4..5daf11d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -916,7 +916,7 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 	if (touch) {
 		int x = (data[2] << 4) | (data[4] >> 4);
 		int y = (data[3] << 4) | (data[4] & 0x0f);
-		int w = data[6];
+		int w = data[5];
 
 		input_report_abs(input, ABS_MT_POSITION_X, x);
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
-- 
1.7.9.1

