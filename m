From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] Input:mouse:synaptics_i2c - Fix for typo in comment in
Date: Mon, 25 May 2015 22:53:29 +0530
Message-ID: <1432574609-3272-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34701 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbbEYRXl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 13:23:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a8998ba..2c87a93 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -340,7 +340,7 @@ static bool synaptics_i2c_get_input(struct synaptics_i2c *touch)
 	s32 data;
 	s8 x_delta, y_delta;
 
-	/* Deal with spontanious resets and errors */
+	/* Deal with spontaneous resets and errors */
 	if (synaptics_i2c_check_error(touch->client))
 		return 0;
 
-- 
1.7.9.5

