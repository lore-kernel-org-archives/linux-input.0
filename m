From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: rotary_encoder - mark PM methods as __maybe_unused
Date: Mon, 18 Jan 2016 09:41:39 -0800
Message-ID: <1453138902-11657-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of guarding PM methods with #ifdef let's mark them as
__maybe_unused as it allows for better compile coverage.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/rotary_encoder.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 7828bd1..b9a86ca 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -381,8 +381,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rotary_encoder_suspend(struct device *dev)
+static int __maybe_unused rotary_encoder_suspend(struct device *dev)
 {
 	struct rotary_encoder *encoder = dev_get_drvdata(dev);
 
@@ -394,7 +393,7 @@ static int rotary_encoder_suspend(struct device *dev)
 	return 0;
 }
 
-static int rotary_encoder_resume(struct device *dev)
+static int __maybe_unused rotary_encoder_resume(struct device *dev)
 {
 	struct rotary_encoder *encoder = dev_get_drvdata(dev);
 
@@ -405,10 +404,9 @@ static int rotary_encoder_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(rotary_encoder_pm_ops,
-		 rotary_encoder_suspend, rotary_encoder_resume);
+			 rotary_encoder_suspend, rotary_encoder_resume);
 
 static struct platform_driver rotary_encoder_driver = {
 	.probe		= rotary_encoder_probe,
-- 
2.6.0.rc2.230.g3dd15c0
