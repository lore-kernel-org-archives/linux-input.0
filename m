From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: keyboard: lm8323 - Change msleep to usleep_range for small msecs
Date: Mon, 28 Nov 2016 22:40:09 +0530
Message-ID: <1480353009-1483-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.stone@nokia.com, timo.o.karjalainen@nokia.com, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>
List-Id: linux-input@vger.kernel.org

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/keyboard/lm8323.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 21bea52..14679e9 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -689,7 +689,7 @@ static int lm8323_probe(struct i2c_client *client,
 			break;
 		}
 
-		msleep(1);
+		usleep_range(1000, 1100);
 	}
 
 	lm8323_configure(lm);
-- 
2.6.2
