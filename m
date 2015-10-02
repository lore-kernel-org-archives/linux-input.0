From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 06/18] Input: zforce - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:17 +0200
Message-ID: <1443793229-22363-7-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jingoo Han <jg1.han@samsung.com>, Dirk Behme <dirk.behme@de.bosch.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Heiko Stuebner <heiko.stuebner@bq.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

The invoked function already returns zero on success or a negative
errno code so there is no need to open code the logic in the caller.

This also fixes the following make coccicheck warning:

end returns can be simplified and declaration on line 602 can be dropped

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/zforce_ts.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 781d0f83050a..9bbadaaf6bc3 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -599,13 +599,8 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 static int zforce_input_open(struct input_dev *dev)
 {
 	struct zforce_ts *ts = input_get_drvdata(dev);
-	int ret;
 
-	ret = zforce_start(ts);
-	if (ret)
-		return ret;
-
-	return 0;
+	return zforce_start(ts);
 }
 
 static void zforce_input_close(struct input_dev *dev)
-- 
2.4.3
