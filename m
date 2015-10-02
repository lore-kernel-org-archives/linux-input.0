From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 11/18] Input: da9034-ts - simplify function return logic
Date: Fri,  2 Oct 2015 15:40:22 +0200
Message-ID: <1443793229-22363-12-git-send-email-javier@osg.samsung.com>
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

end returns can be simplified and declaration on line 304 can be dropped

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/touchscreen/da9034-ts.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/da9034-ts.c b/drivers/input/touchscreen/da9034-ts.c
index 8264822dc4b9..f10887851674 100644
--- a/drivers/input/touchscreen/da9034-ts.c
+++ b/drivers/input/touchscreen/da9034-ts.c
@@ -301,7 +301,6 @@ static int da9034_touch_probe(struct platform_device *pdev)
 	struct da9034_touch_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct da9034_touch *touch;
 	struct input_dev *input_dev;
-	int error;
 
 	touch = devm_kzalloc(&pdev->dev, sizeof(struct da9034_touch),
 			     GFP_KERNEL);
@@ -347,11 +346,7 @@ static int da9034_touch_probe(struct platform_device *pdev)
 	touch->input_dev = input_dev;
 	input_set_drvdata(input_dev, touch);
 
-	error = input_register_device(input_dev);
-	if (error)
-		return error;
-
-	return 0;
+	return input_register_device(input_dev);
 }
 
 static struct platform_driver da9034_touch_driver = {
-- 
2.4.3
