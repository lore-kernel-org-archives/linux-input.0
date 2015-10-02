From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 18/18] Input: tps6507x-ts - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:29 +0200
Message-ID: <1443793229-22363-19-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

drivers/input/touchscreen/tps6507x-ts.c:57:5-8: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/input/touchscreen/tps6507x-ts.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 4ffd829d1990..a340bfccdfb6 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -50,14 +50,7 @@ struct tps6507x_ts {
 
 static int tps6507x_read_u8(struct tps6507x_ts *tsc, u8 reg, u8 *data)
 {
-	int err;
-
-	err = tsc->mfd->read_dev(tsc->mfd, reg, 1, data);
-
-	if (err)
-		return err;
-
-	return 0;
+	return tsc->mfd->read_dev(tsc->mfd, reg, 1, data);
 }
 
 static int tps6507x_write_u8(struct tps6507x_ts *tsc, u8 reg, u8 data)
-- 
2.4.3
