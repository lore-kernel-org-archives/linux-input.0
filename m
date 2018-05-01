From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] Input: atmel_mxt_ts - add missing compatible strings to
 OF device table
Date: Tue, 1 May 2018 13:57:13 -0700
Message-ID: <20180501205713.GA130399@dtor-ws>
References: <20180410095340.24074-1-javierm@redhat.com>
 <20180501184853.GB52077@dtor-ws>
 <CAL_JsqJ-UTGrPm2tiS1yVFweWB_LH2JSBpOpMtogTYFi7pCsGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ-UTGrPm2tiS1yVFweWB_LH2JSBpOpMtogTYFi7pCsGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-input@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

From: Javier Martinez Canillas <javierm@redhat.com>

Commit af503716ac14 ("i2c: core: report OF style module alias for devices
registered via OF") fixed how the I2C core reports the module alias when
devices are registered via OF.

But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
OF device ID table, so if a Device Tree is using a different one, autoload
won't be working for the module (the matching works because the I2C device
ID table is used as a fallback).

So add compatible strings for each of the entries in the I2C device table.

Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
[dtor: document which compatibles are deprecated and should not be used]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/atmel,maxtouch.txt   |    7 +++++++
 drivers/input/touchscreen/atmel_mxt_ts.c           |    5 +++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index 23e3abc3fdef0..c88919480d373 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -4,6 +4,13 @@ Required properties:
 - compatible:
     atmel,maxtouch
 
+    The following compatibles have been used in various products but are
+    deprecated:
+	atmel,qt602240_ts
+	atmel,atmel_mxt_ts
+	atmel,atmel_mxt_tp
+	atmel,mXT224
+
 - reg: The I2C address of the device
 
 - interrupts: The sink for the touchpad's IRQ output
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 5f41c1860f403..779dbfcc0eded 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3297,6 +3297,11 @@ static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
 
 static const struct of_device_id mxt_of_match[] = {
 	{ .compatible = "atmel,maxtouch", },
+	/* Compatibles listed below are deprecated */
+	{ .compatible = "atmel,qt602240_ts", },
+	{ .compatible = "atmel,atmel_mxt_ts", },
+	{ .compatible = "atmel,atmel_mxt_tp", },
+	{ .compatible = "atmel,mXT224", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mxt_of_match);
