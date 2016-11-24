From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: Change msleep to usleep_range for small msecs
Date: Thu, 24 Nov 2016 21:33:03 +0530
Message-ID: <1480003383-1716-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33457 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965932AbcKXPxy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Nov 2016 10:53:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/misc/bma150.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 2124390..1fa8537 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -207,7 +207,7 @@ static int bma150_set_mode(struct bma150_data *bma150, u8 mode)
 		return error;
 
 	if (mode == BMA150_MODE_NORMAL)
-		msleep(2);
+		usleep_range(2000, 2100);
 
 	bma150->mode = mode;
 	return 0;
@@ -222,7 +222,7 @@ static int bma150_soft_reset(struct bma150_data *bma150)
 	if (error)
 		return error;
 
-	msleep(2);
+	usleep_range(2000, 2100);
 	return 0;
 }
 
-- 
2.6.2

