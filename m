From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/13] Input: misc - Use local variables consistently
Date: Sat, 21 Jan 2017 10:45:57 -0800
Message-ID: <1485024365-3368-6-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49623 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdAUSrT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:47:19 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Dan Murphy <dmurphy@ti.com>, Jingkui Wang <jkwang@google.com>, John Stultz <john.stultz@linaro.org>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

If a function declares a variable to access a structure element,
use it conssistently.

The conversion was done automatically with coccinelle using
the following semantic patch.

// Catch function parameters.
// Handle those first to trigger reformatting.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
identifier fn;
expression list es;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
- fn(&svar->elem, es)
+ fn(d, es)
...> }

// Now address non-functions and multiple transformations in function
// parameters.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
(
- &svar->elem
+ d
|
- svar->elem.i
+ d->i
)
...> }

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/misc/drv260x.c          | 2 +-
 drivers/input/misc/gpio_tilt_polled.c | 2 +-
 drivers/input/misc/hisi_powerkey.c    | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 0a2b865b1000..fb089d36c0d6 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -538,7 +538,7 @@ static int drv260x_probe(struct i2c_client *client,
 
 	haptics->input_dev = devm_input_allocate_device(dev);
 	if (!haptics->input_dev) {
-		dev_err(&client->dev, "Failed to allocate input device\n");
+		dev_err(dev, "Failed to allocate input device\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index f103b99d1852..6e217a45e39a 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -138,7 +138,7 @@ static int gpio_tilt_polled_probe(struct platform_device *pdev)
 
 	input->name = pdev->name;
 	input->phys = DRV_NAME"/input0";
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 
 	input->id.bustype = BUS_HOST;
 	input->id.vendor = 0x0001;
diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_powerkey.c
index 675539c529ce..c4c42124a059 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -75,9 +75,9 @@ static int hi65xx_powerkey_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	int irq, i, error;
 
-	input = devm_input_allocate_device(&pdev->dev);
+	input = devm_input_allocate_device(dev);
 	if (!input) {
-		dev_err(&pdev->dev, "failed to allocate input device\n");
+		dev_err(dev, "failed to allocate input device\n");
 		return -ENOMEM;
 	}
 
@@ -111,12 +111,11 @@ static int hi65xx_powerkey_probe(struct platform_device *pdev)
 
 	error = input_register_device(input);
 	if (error) {
-		dev_err(&pdev->dev, "failed to register input device: %d\n",
-			error);
+		dev_err(dev, "failed to register input device: %d\n", error);
 		return error;
 	}
 
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(dev, 1);
 
 	return 0;
 }
-- 
2.7.4

