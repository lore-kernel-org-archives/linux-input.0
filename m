From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: mouse: navpoint - Change msleep to usleep_range for small msecs
Date: Mon, 28 Nov 2016 22:58:05 +0530
Message-ID: <1480354085-1885-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33719 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754278AbcK1RSh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 12:18:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lost.distance@yahoo.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/mouse/navpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index d6e8f58..2ede00b 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -166,7 +166,7 @@ static void navpoint_up(struct navpoint *navpoint)
 	for (timeout = 100; timeout != 0; --timeout) {
 		if (!(pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS))
 			break;
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 
 	if (timeout == 0)
-- 
2.6.2

