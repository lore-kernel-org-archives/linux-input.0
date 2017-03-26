From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/5] drivers/rtc/rtc-pl030.c: Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:51 +0800
Message-ID: <1490539314-9681-3-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC4IFTUFXEFBBXFG37DAKGQEEA5WEYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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
 drivers/rtc/rtc-pl030.c | 49 ++++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a9..372b1fd 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -102,49 +102,30 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	struct pl030_rtc *rtc;
 	int ret;
 
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		goto err_req;
-
 	rtc = devm_kzalloc(&dev->dev, sizeof(*rtc), GFP_KERNEL);
-	if (!rtc) {
-		ret = -ENOMEM;
-		goto err_rtc;
-	}
+	if (!rtc)
+		return -ENOMEM;
 
-	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!rtc->base) {
-		ret = -ENOMEM;
-		goto err_rtc;
-	}
+	rtc->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(rtc->base))
+		return PTR_ERR(rtc->base);
 
 	__raw_writel(0, rtc->base + RTC_CR);
 	__raw_writel(0, rtc->base + RTC_EOI);
 
 	amba_set_drvdata(dev, rtc);
 
-	ret = request_irq(dev->irq[0], pl030_interrupt, 0,
-			  "rtc-pl030", rtc);
+	ret = devm_request_irq(&dev->dev, dev->irq[0], pl030_interrupt, 0,
+			       "rtc-pl030", rtc);
 	if (ret)
-		goto err_irq;
+		return ret;
 
-	rtc->rtc = rtc_device_register("pl030", &dev->dev, &pl030_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
-		goto err_reg;
-	}
+	rtc->rtc = devm_rtc_device_register(&dev->dev, "pl030", &pl030_ops,
+					    THIS_MODULE);
+	if (IS_ERR(rtc->rtc))
+		return PTR_ERR(rtc->rtc);
 
 	return 0;
-
- err_reg:
-	free_irq(dev->irq[0], rtc);
- err_irq:
-	iounmap(rtc->base);
- err_rtc:
-	amba_release_regions(dev);
- err_req:
-	return ret;
 }
 
 static int pl030_remove(struct amba_device *dev)
@@ -152,12 +133,6 @@ static int pl030_remove(struct amba_device *dev)
 	struct pl030_rtc *rtc = amba_get_drvdata(dev);
 
 	writel(0, rtc->base + RTC_CR);
-
-	free_irq(dev->irq[0], rtc);
-	rtc_device_unregister(rtc->rtc);
-	iounmap(rtc->base);
-	amba_release_regions(dev);
-
 	return 0;
 }
 
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
