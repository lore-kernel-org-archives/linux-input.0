From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 09/18] Input: jornada720_ts - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:20 +0200
Message-ID: <1443793229-22363-10-git-send-email-javier@osg.samsung.com>
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

drivers/input/touchscreen/jornada720_ts.c:137:1-6: WARNING: end returns can be simplified

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/jornada720_ts.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index ea3b6a5b83e6..177a1e92da03 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -134,11 +134,7 @@ static int jornada720_ts_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = input_register_device(jornada_ts->dev);
-	if (error)
-		return error;
-
-	return 0;
+	return input_register_device(jornada_ts->dev);
 }
 
 /* work with hotplug and coldplug */
-- 
2.4.3
