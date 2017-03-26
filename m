From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] ALSA: AACI: Convert to use devm_ioremap_resource()
Date: Sun, 26 Mar 2017 22:41:54 +0800
Message-ID: <1490539314-9681-6-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC4IFTUFXEFBB3FG37DAKGQEOQWQKEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

Convert to use devm_ioremap_resource() in probe function, otherwise it's
missed to unremap this region if probe failed or rmmod module.

Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/arm/aaci.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..2078568 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -990,19 +990,13 @@ static int aaci_probe(struct amba_device *dev,
 	struct aaci *aaci;
 	int ret, i;
 
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		return ret;
-
 	aaci = aaci_init_card(dev);
-	if (!aaci) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!aaci)
+		return -ENOMEM;
 
-	aaci->base = ioremap(dev->res.start, resource_size(&dev->res));
-	if (!aaci->base) {
-		ret = -ENOMEM;
+	aaci->base = devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(aaci->base)) {
+		ret = PTR_ERR(aaci->base);
 		goto out;
 	}
 
@@ -1064,9 +1058,7 @@ static int aaci_probe(struct amba_device *dev,
 	}
 
  out:
-	if (aaci)
-		snd_card_free(aaci->card);
-	amba_release_regions(dev);
+	snd_card_free(aaci->card);
 	return ret;
 }
 
@@ -1079,7 +1071,6 @@ static int aaci_remove(struct amba_device *dev)
 		writel(0, aaci->base + AACI_MAINCR);
 
 		snd_card_free(card);
-		amba_release_regions(dev);
 	}
 
 	return 0;
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
