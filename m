From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] Input: synaptics-rmi4: Get IRQ flags from the IRQ subsystem
Date: Fri,  5 Feb 2016 13:36:37 +0100
Message-ID: <1454675797-10065-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33944 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcBEMg7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2016 07:36:59 -0500
Received: by mail-lb0-f173.google.com with SMTP id cw1so48707497lbb.1
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2016 04:36:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Christopher Heiny <cheiny@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Linus Walleij <linus.walleij@linaro.org>

I don't understand what the irq_flags in the platform data is
there for other than being default 0. The trigger type is
specified by device tree or ACPI or similar so before forcing
it to LEVEL_LOW, ask the descriptor what flags it already have.

Without this my RMI4 touchscreen fails like this:
input: Synaptics TM1217 as /devices/rmi4-00/input/input2
genirq: Setting trigger mode 8 for irq 163 failed
	(nmk_gpio_irq_set_type+0x0/0x138)
rmi4_i2c 3-004b: Failed to register interrupt 163
rmi4_i2c: probe of 3-004b failed with error -22

And that is because my GPIO controller does not support level
IRQs, only edges. And that is also what is specified in the
device tree: interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
but it is not falling through to the driver because of this
hardcoding.

This patch makes the driver respect the flags from the
IRQ subsystem and only shoehorn it into LEVEL_LOW if none
is specified.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This goes on top of the v3 patchset and was necessary
for my testing.

Feel free to apply this on top of the RMI4 patches OR
squash it into the series, I don't care as long as the
result works for me.
---
 drivers/input/rmi4/rmi_i2c.c | 3 ++-
 drivers/input/rmi4/rmi_spi.c | 2 +-
 include/linux/rmi.h          | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index 75020f246158..c21e6c133069 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/rmi.h>
 #include <linux/of.h>
+#include <linux/irq.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -188,7 +189,7 @@ static irqreturn_t rmi_i2c_irq(int irq, void *dev_id)
 static int rmi_i2c_init_irq(struct i2c_client *client)
 {
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
-	int irq_flags = rmi_i2c->xport.pdata.irq_flags;
+	int irq_flags = irqd_get_trigger_type(irq_get_irq_data(rmi_i2c->irq));
 	int ret;
 
 	if (!irq_flags)
diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 5be321cf906d..e87978d2cbbb 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -342,7 +342,7 @@ static irqreturn_t rmi_spi_irq(int irq, void *dev_id)
 static int rmi_spi_init_irq(struct spi_device *spi)
 {
 	struct rmi_spi_xport *rmi_spi = spi_get_drvdata(spi);
-	int irq_flags = rmi_spi->xport.pdata.irq_flags;
+	int irq_flags = irqd_get_trigger_type(irq_get_irq_data(rmi_i2c->irq));
 	int ret;
 
 	if (!irq_flags)
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 7b9d15f1db06..e0aca1476001 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -201,15 +201,11 @@ struct rmi_device_platform_data_spi {
 /**
  * struct rmi_device_platform_data - system specific configuration info.
  *
- * @irq_flags - this is used to specify intrerrupt type flags.
- *
  * @reset_delay_ms - after issuing a reset command to the touch sensor, the
  * driver waits a few milliseconds to give the firmware a chance to
  * to re-initialize.  You can override the default wait period here.
  */
 struct rmi_device_platform_data {
-	int irq_flags;
-
 	int reset_delay_ms;
 
 	struct rmi_device_platform_data_spi spi_data;
-- 
2.4.3

