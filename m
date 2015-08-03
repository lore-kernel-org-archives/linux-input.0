From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 8/9] Input: atmel_mxt_ts - initialise input slots with INPUT_MT_DIRECT
Date: Mon,  3 Aug 2015 16:23:16 +0100
Message-ID: <1438615397-17112-9-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:52307 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754248AbbHCPct (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:49 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

This indicates the device coordinates should be directly mapped to screen.
This is valid since scaling/flipping/rotation should be done by configuring
the MXT device.

It also flags to Android using INPUT_PROP_DIRECT that the device should be
treated as a touch screen by default, and removes the necessity for a
default IDC file.

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ff48d45..2aa44dc 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1858,6 +1858,8 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	if (pdata->t19_num_keys) {
 		mxt_set_up_as_touchpad(input_dev, data);
 		mt_flags |= INPUT_MT_POINTER;
+	} else {
+		mt_flags |= INPUT_MT_DIRECT;
 	}
 
 	/* For multi touch */
-- 
2.4.6

