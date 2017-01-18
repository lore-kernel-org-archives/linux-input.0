From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 14/33] Input: gpio_decoder - Drop unnecessary call to platform_set_drvdata and other changes
Date: Wed, 18 Jan 2017 09:46:35 -0800
Message-ID: <1484761614-12225-15-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-input@vger.kernel.org

There is no call to platform_get_drvdata() or dev_get_drvdata().
Drop the unnecessary call to platform_set_drvdata().

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop platform_set_drvdata()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/gpio_decoder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/gpio_decoder.c b/drivers/input/misc/gpio_decoder.c
index ca7e0bacb2d8..1dca526e6f1a 100644
--- a/drivers/input/misc/gpio_decoder.c
+++ b/drivers/input/misc/gpio_decoder.c
@@ -110,7 +110,6 @@ static int gpio_decoder_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to register polled  device\n");
 		return err;
 	}
-	platform_set_drvdata(pdev, decoder);
 
 	return 0;
 }
-- 
2.7.4
