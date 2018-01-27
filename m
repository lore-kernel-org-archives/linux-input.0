From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: gpio_keys: Delete an error message for a failed memory
 allocation in two functions
Date: Sat, 27 Jan 2018 14:55:00 +0100
Message-ID: <6a34d439-6465-db9b-e8de-3f3b5b1ca257@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Joseph Lo <josephl@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Stephen Lu <lumotuwe@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 14:42:19 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/gpio_keys.c        | 4 +---
 drivers/input/keyboard/gpio_keys_polled.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..d12fccf923d2 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -757,10 +757,8 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	size = sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data);
 	ddata = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (!ddata) {
-		dev_err(dev, "failed to allocate state\n");
+	if (!ddata)
 		return -ENOMEM;
-	}
 
 	ddata->keymap = devm_kcalloc(dev,
 				     pdata->nbuttons, sizeof(ddata->keymap[0]),
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262103b9..c79b1a75d036 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -253,10 +253,8 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	size = sizeof(struct gpio_keys_polled_dev) +
 			pdata->nbuttons * sizeof(struct gpio_keys_button_data);
 	bdev = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (!bdev) {
-		dev_err(dev, "no memory for private data\n");
+	if (!bdev)
 		return -ENOMEM;
-	}
 
 	poll_dev = devm_input_allocate_polled_device(dev);
 	if (!poll_dev) {
-- 
2.16.1
