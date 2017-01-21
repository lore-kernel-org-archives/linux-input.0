From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/13] Input: rmi4 - Use local variables consistently
Date: Sat, 21 Jan 2017 10:45:59 -0800
Message-ID: <1485024365-3368-8-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50223 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbdAUSsH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:48:07 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

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
 drivers/input/rmi4/rmi_bus.c    | 4 ++--
 drivers/input/rmi4/rmi_driver.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 1c40d94ca506..f754e09ac7a7 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -261,10 +261,10 @@ int __rmi_register_function_handler(struct rmi_function_handler *handler,
 	driver->probe = rmi_function_probe;
 	driver->remove = rmi_function_remove;
 
-	error = driver_register(&handler->driver);
+	error = driver_register(driver);
 	if (error) {
 		pr_err("driver_register() failed for %s, error: %d\n",
-			handler->driver.name, error);
+			driver->name, error);
 		return error;
 	}
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 11447ab1055c..47e75021ee79 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -836,7 +836,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 			       void *ctx, const struct pdt_entry *pdt)
 {
 	struct device *dev = &rmi_dev->dev;
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	int *current_irq_count = ctx;
 	struct rmi_function *fn;
 	int i;
@@ -1040,7 +1040,7 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 	}
 
 	if (data->bootloader_mode)
-		dev_warn(&rmi_dev->dev, "Device in bootloader mode.\n");
+		dev_warn(dev, "Device in bootloader mode.\n");
 
 	data->irq_count = irq_count;
 	data->num_of_irq_regs = (data->irq_count + 7) / 8;
-- 
2.7.4

