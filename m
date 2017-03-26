From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/5] Input: ambakmi - Convert to use devm_*()
Date: Sun, 26 Mar 2017 22:41:50 +0800
Message-ID: <1490539314-9681-2-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBC4IFTUFXEFBBV5G37DAKGQEPDJIM5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

This patch also fixes the memory leakage for 'kmi->io' when remove
module.

Signed-off-by: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/input/serio/ambakmi.c | 44 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index c6606ca..d4814be 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -112,19 +112,11 @@ static int amba_kmi_probe(struct amba_device *dev,
 {
 	struct amba_kmi_port *kmi;
 	struct serio *io;
-	int ret;
-
-	ret = amba_request_regions(dev, NULL);
-	if (ret)
-		return ret;
-
-	kmi = kzalloc(sizeof(struct amba_kmi_port), GFP_KERNEL);
-	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!kmi || !io) {
-		ret = -ENOMEM;
-		goto out;
-	}
 
+	kmi = devm_kzalloc(&dev->dev, sizeof(*kmi), GFP_KERNEL);
+	io  = devm_kzalloc(&dev->dev, sizeof(*io), GFP_KERNEL);
+	if (!kmi || !io)
+		return -ENOMEM;
 
 	io->id.type	= SERIO_8042;
 	io->write	= amba_kmi_write;
@@ -136,31 +128,19 @@ static int amba_kmi_probe(struct amba_device *dev,
 	io->dev.parent	= &dev->dev;
 
 	kmi->io		= io;
-	kmi->base	= ioremap(dev->res.start, resource_size(&dev->res));
-	if (!kmi->base) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	kmi->base	= devm_ioremap_resource(&dev->dev, &dev->res);
+	if (IS_ERR(kmi->base))
+		return PTR_ERR(kmi->base);
 
-	kmi->clk = clk_get(&dev->dev, "KMIREFCLK");
-	if (IS_ERR(kmi->clk)) {
-		ret = PTR_ERR(kmi->clk);
-		goto unmap;
-	}
+	kmi->clk = devm_clk_get(&dev->dev, "KMIREFCLK");
+	if (IS_ERR(kmi->clk))
+		return PTR_ERR(kmi->clk);
 
 	kmi->irq = dev->irq[0];
 	amba_set_drvdata(dev, kmi);
 
 	serio_register_port(kmi->io);
 	return 0;
-
- unmap:
-	iounmap(kmi->base);
- out:
-	kfree(kmi);
-	kfree(io);
-	amba_release_regions(dev);
-	return ret;
 }
 
 static int amba_kmi_remove(struct amba_device *dev)
@@ -168,10 +148,6 @@ static int amba_kmi_remove(struct amba_device *dev)
 	struct amba_kmi_port *kmi = amba_get_drvdata(dev);
 
 	serio_unregister_port(kmi->io);
-	clk_put(kmi->clk);
-	iounmap(kmi->base);
-	kfree(kmi);
-	amba_release_regions(dev);
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
