From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: arizona-haptic - convert to use managed input
 devices
Date: Mon, 6 Jul 2015 14:40:05 -0700
Message-ID: <20150706214005.GA32140@dtor-ws>
References: <20150706173841.GA31110@dtor-ws>
 <10887748.SfjriXAezU@jclayton-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34673 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbbGFVkJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 17:40:09 -0400
Content-Disposition: inline
In-Reply-To: <10887748.SfjriXAezU@jclayton-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org

On Mon, Jul 06, 2015 at 12:33:06PM -0700, Joshua Clayton wrote:
> Hi,
> It seems to me that swapping error for ret buries the functional changes in 
> the patch...
> would it be better to split them into a second  cleanup patch?

Fair enough, although I am not sure if I ever get to the renaming again
;)

Thanks.

-- 
Dmitry


Input: arizona-haptic - convert to use managed input devices

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Using managed input device (via devm_input_allocate_device) simplifies
error handling and driver removal paths and also silences CID# 712569.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/arizona-haptics.c |   26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 4dbbed7..4bf6785 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -170,8 +170,8 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 
 	INIT_WORK(&haptics->work, arizona_haptics_work);
 
-	haptics->input_dev = input_allocate_device();
-	if (haptics->input_dev == NULL) {
+	haptics->input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!haptics->input_dev) {
 		dev_err(arizona->dev, "Failed to allocate input device\n");
 		return -ENOMEM;
 	}
@@ -188,41 +188,23 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(arizona->dev, "input_ff_create_memless() failed: %d\n",
 			ret);
-		goto err_ialloc;
+		return ret;
 	}
 
 	ret = input_register_device(haptics->input_dev);
 	if (ret < 0) {
 		dev_err(arizona->dev, "couldn't register input device: %d\n",
 			ret);
-		goto err_iff;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, haptics);
 
 	return 0;
-
-err_iff:
-	if (haptics->input_dev)
-		input_ff_destroy(haptics->input_dev);
-err_ialloc:
-	input_free_device(haptics->input_dev);
-
-	return ret;
-}
-
-static int arizona_haptics_remove(struct platform_device *pdev)
-{
-	struct arizona_haptics *haptics = platform_get_drvdata(pdev);
-
-	input_unregister_device(haptics->input_dev);
-
-	return 0;
 }
 
 static struct platform_driver arizona_haptics_driver = {
 	.probe		= arizona_haptics_probe,
-	.remove		= arizona_haptics_remove,
 	.driver		= {
 		.name	= "arizona-haptics",
 	},
