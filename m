From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3] Input: wacom - set stylus_in_proximity when pen is in range
Date: Tue, 27 May 2014 16:17:44 -0700
Message-ID: <1401232664-9699-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34555 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaE0XRe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2014 19:17:34 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so9901461pad.41
        for <linux-input@vger.kernel.org>; Tue, 27 May 2014 16:17:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <killertofu@gmail.com>
Tested-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 24c0733..c98e51c 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -484,6 +484,8 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		input_report_key(input, BTN_TOUCH, 0);
 		input_report_abs(input, ABS_PRESSURE, 0);
 		input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
+		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
+			wacom->shared->stylus_in_proximity = true;
 	}
 
 	/* Exit report */
-- 
1.9.1

