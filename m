From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH 13/13] Input: input - Fix typo in comment.
Date: Mon, 18 May 2015 22:44:46 +0530
Message-ID: <1431969286-3500-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc357f1..f315784 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2262,7 +2262,7 @@ EXPORT_SYMBOL(input_unregister_handler);
  *
  * Iterate over @bus's list of devices, and call @fn for each, passing
  * it @data and stop when @fn returns a non-zero value. The function is
- * using RCU to traverse the list and therefore may be usind in atonic
+ * using RCU to traverse the list and therefore may be using in atomic
  * contexts. The @fn callback is invoked from RCU critical section and
  * thus must not sleep.
  */
-- 
1.7.9.5
