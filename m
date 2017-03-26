From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] drivers/rtc/rtc-pl031.c: Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:52 +0800
Message-ID: <1490539314-9681-4-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC4IFTUFXEFBBYVG37DAKGQE6FFS3CA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Convert driver to use devm_*() APIs so rely on driver model core layer
to manage resources. This eliminates error path boilerplate and makes
code neat.

Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/rtc/rtc-pl031.c | 59 +++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index e1687e1..1699a17 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -304,15 +304,8 @@ static int pl031_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 
 static int pl031_remove(struct amba_device *adev)
 {
-	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);
-
 	dev_pm_clear_wake_irq(&adev->dev);
 	device_init_wakeup(&adev->dev, false);
-	free_irq(adev->irq[0], ldata);
-	rtc_device_unregister(ldata->rtc);
-	iounmap(ldata->base);
-	kfree(ldata);
-	amba_release_regions(adev);
 
 	return 0;
 }
@@ -325,23 +318,15 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	struct rtc_class_ops *ops = &vendor->ops;
 	unsigned long time, data;
 
-	ret = amba_request_regions(adev, NULL);
-	if (ret)
-		goto err_req;
+	ldata = devm_kzalloc(&adev->dev, sizeof(*ldata), GFP_KERNEL);
+	if (!ldata)
+		return -ENOMEM;
 
-	ldata = kzalloc(sizeof(struct pl031_local), GFP_KERNEL);
-	if (!ldata) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	ldata->vendor = vendor;
 
-	ldata->base = ioremap(adev->res.start, resource_size(&adev->res));
-
-	if (!ldata->base) {
-		ret = -ENOMEM;
-		goto out_no_remap;
-	}
+	ldata->base = devm_ioremap_resource(&adev->dev, &adev->res);
+	if (IS_ERR(ldata->base))
+		return PTR_ERR(ldata->base);
 
 	amba_set_drvdata(adev, ldata);
 
@@ -374,32 +359,18 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	device_init_wakeup(&adev->dev, true);
-	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
-					THIS_MODULE);
-	if (IS_ERR(ldata->rtc)) {
-		ret = PTR_ERR(ldata->rtc);
-		goto out_no_rtc;
-	}
+	ldata->rtc = devm_rtc_device_register(&adev->dev, "pl031", ops,
+					      THIS_MODULE);
+	if (IS_ERR(ldata->rtc))
+		return PTR_ERR(ldata->rtc);
+
+	ret = devm_request_irq(&adev->dev, adev->irq[0], pl031_interrupt,
+			       vendor->irqflags, "rtc-pl031", ldata);
+	if (ret)
+		return ret;
 
-	if (request_irq(adev->irq[0], pl031_interrupt,
-			vendor->irqflags, "rtc-pl031", ldata)) {
-		ret = -EIO;
-		goto out_no_irq;
-	}
 	dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	return 0;
-
-out_no_irq:
-	rtc_device_unregister(ldata->rtc);
-out_no_rtc:
-	iounmap(ldata->base);
-out_no_remap:
-	kfree(ldata);
-out:
-	amba_release_regions(adev);
-err_req:
-
-	return ret;
 }
 
 /* Operations for the original ARM version */
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
