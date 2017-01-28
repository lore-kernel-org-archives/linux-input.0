From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: joydev - use clamp() macro
Date: Sat, 28 Jan 2017 11:19:18 -0800
Message-ID: <20170128191918.GA38093@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34184 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdA1T1J (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 28 Jan 2017 14:27:09 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Raphael Assenat <raph@raphnet.net>, linux-kernel@vger.kernel.org

We have a nice macro ensuring that the value is within certain range, let's
use it instead of open-coding.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joydev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index db5e290e897e..065e67bf56dd 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -87,7 +87,7 @@ static int joydev_correct(int value, struct js_corr *corr)
 		return 0;
 	}
 
-	return value < -32767 ? -32767 : (value > 32767 ? 32767 : value);
+	return clamp(value, -32767, 32767);
 }
 
 static void joydev_pass_event(struct joydev_client *client,
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
