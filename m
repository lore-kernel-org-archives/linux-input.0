From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 04/18] Input: kxtj9 - remove unneeded retval variable
Date: Fri,  2 Oct 2015 15:40:15 +0200
Message-ID: <1443793229-22363-5-git-send-email-javier@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jingoo Han <jg1.han@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The retval variable isn't needed since isn't used in the
function. Remove the variable and just return 0 instead.

This also fixes the following make coccicheck warning:

drivers/input/misc/kxtj9.c:638:5-11: Unneeded variable: "retval". Return "0" on line 646

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/input/misc/kxtj9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index e058d711256a..efaffcc57e36 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -635,7 +635,6 @@ static int __maybe_unused kxtj9_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct kxtj9_data *tj9 = i2c_get_clientdata(client);
 	struct input_dev *input_dev = tj9->input_dev;
-	int retval = 0;
 
 	mutex_lock(&input_dev->mutex);
 
@@ -643,7 +642,7 @@ static int __maybe_unused kxtj9_resume(struct device *dev)
 		kxtj9_enable(tj9);
 
 	mutex_unlock(&input_dev->mutex);
-	return retval;
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(kxtj9_pm_ops, kxtj9_suspend, kxtj9_resume);
-- 
2.4.3
