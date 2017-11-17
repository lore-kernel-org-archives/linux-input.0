From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elants_i2c - do not clobber interrupt trigger on x86
Date: Thu, 16 Nov 2017 17:24:39 -0800
Message-ID: <20171117012439.bfnczk2mqwsf4iua@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:46981 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbdKQBYn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Nov 2017 20:24:43 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Johnny Chuang <johnny.chuang@emc.com.tw>, linux-kernel@vger.kernel.org

This is similar to commit a4b0a58bb142 ("Input: elan_i2c - do not
clobber interrupt trigger on x86")

On x86 we historically used falling edge interrupts in the driver
because that's how first Chrome devices were configured. They also
did not use ACPI to enumerate I2C devices (because back then there
was no kernel support for that), so trigger was hard-coded in the
driver. However the controller behavior is much more reliable if
we use level triggers, and that is how we configured ARM devices,
and how want to configure newer x86 devices as well. All newer
x86 boxes have their I2C devices enumerated in ACPI.

Let's see if platform code (ACPI, DT) described interrupt and
specified particular trigger type, and if so, let's use it instead
of always clobbering trigger with IRQF_TRIGGER_FALLING. We will
still use this trigger type as a fallback if platform code left
interrupt trigger unconfigured.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index e102d7764bc2..1cc3e6b135e7 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1261,10 +1261,13 @@ static int elants_i2c_probe(struct i2c_client *client,
 	}
 
 	/*
-	 * Systems using device tree should set up interrupt via DTS,
-	 * the rest will use the default falling edge interrupts.
+	 * Platform code (ACPI, DTS) should normally set up interrupt
+	 * for us, but in case it did not let's fall back to using falling
+	 * edge to be compatible with older Chromebooks.
 	 */
-	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+	irqflags = irq_get_trigger_type(client->irq);
+	if (!irqflags)
+		irqflags = IRQF_TRIGGER_FALLING;
` 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, elants_i2c_irq,
-- 
2.15.0.448.gf294e3d99a-goog


-- 
Dmitry
