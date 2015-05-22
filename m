From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] touchscreen: stmpe-ts: enable module autoload
Date: Fri, 22 May 2015 13:17:25 -0700
Message-ID: <20150522201725.GI40101@dtor-ws>
References: <555E4BF8.80401@web.de>
 <20150521230612.GA39517@dtor-ws>
 <555EBFF3.1010602@gmail.com>
 <20150522182922.GF40101@dtor-ws>
 <555F7D1E.7020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33844 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913AbbEVUR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 16:17:29 -0400
Received: by igbhj9 with SMTP id hj9so192812igb.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 13:17:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555F7D1E.7020701@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, May 22, 2015 at 09:01:50PM +0200, Heiner Kallweit wrote:
> Am 22.05.2015 um 20:29 schrieb Dmitry Torokhov:
> > On Fri, May 22, 2015 at 07:34:43AM +0200, Heiner Kallweit wrote:
> >> Am 22.05.2015 um 01:06 schrieb Dmitry Torokhov:
> >>> Hi Heiner,
> >>>
> >>> On Thu, May 21, 2015 at 11:19:52PM +0200, Heiner Kallweit wrote:
> >>>> Even with poper DT config the module didn't autoload.
> >>>> That's fixed by this additional alias.
> >>>>
> >>>> Tested successfully with a STMPE610-based Adafruit PITFT Plus 3.5"
> >>>> on RPI2 under Arch Linux ARM (kernel 3.18.13).
> >>>>
> >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>> ---
> >>>>  drivers/input/touchscreen/stmpe-ts.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> >>>> index e4c3125..1940e3c 100644
> >>>> --- a/drivers/input/touchscreen/stmpe-ts.c
> >>>> +++ b/drivers/input/touchscreen/stmpe-ts.c
> >>>> @@ -393,4 +393,5 @@ module_platform_driver(stmpe_ts_driver);
> >>>>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
> >>>>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
> >>>>  MODULE_LICENSE("GPL");
> >>>> +MODULE_ALIAS("spi:" STMPE_TS_NAME);
> >>>>  MODULE_ALIAS("platform:" STMPE_TS_NAME);
> >>>
> >>> Bit this is not an SPI driver, it is a platform driver for a MFD cell.
> >>> Why does adding SPI alias help?
> >>>
> >>> Thanks.
> >>>
> >> The STMPE610 in my case is used on a small touchscreen for the Raspberry Pi
> >> and touchscreen controller as well as display controller are connected via
> >> SPI + a few GPIOs to the RPI.
> >>
> >> The display controller is supported by the fbtft driver and the drivers
> >> for the respective display controllers have similar aliases.
> >> see e.g. drivers/staging/fbtft/fb_hx8353d.c
> >>
> >> MODULE_ALIAS("spi:hx8353d");
> >> MODULE_ALIAS("platform:hx8353d");
> > 
> > I understand why both platform and spi aliases are needed for
> > fb_hx8353d: FBTFT_REGISTER_DRIVER macro does register 2 separate
> > drivers, one SPI and another platform, and so needs both aliases. You
> > still have not explained why we need SPI alias for stmpe-ts which is MFD
> > cell represented by a platform device/driver no matter what bus is used
> > to connect stmpe itself, I2C or SPI.
> > 
> > What is the modalias on the stmpe-ts device in sysfs?
> > 
> > Thanks.
> > 
> These are the stmpe-related entries under /sys/devices:
> 
> ./soc/3f204000.spi/spi_master/spi0/spi0.1/stmpe-gpio
> ./soc/3f204000.spi/spi_master/spi0/spi0.1/stmpe-ts
> 
> stmpe-ts/modalias is:
> of:Nstmpe_touchscreenT<NULL>Cst,stmpe-ts

OK, that explains it. Does the patch below help?

Thanks.

-- 
Dmitry

Input: stmpe-ts - fix automatic module loading

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

When STMPE is instantiated via device tree individual MFD cells rae formed
with OF modaliases, not platform modaliases, and so we need to add OF
device table to the driver if we want it to load automatically:

of:Nstmpe_touchscreenT<NULL>Cst,stmpe-ts

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index e4c3125..e4977c6 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -383,13 +383,21 @@ static int stmpe_ts_remove(struct platform_device *pdev)
 
 static struct platform_driver stmpe_ts_driver = {
 	.driver = {
-		   .name = STMPE_TS_NAME,
-		   },
+		.name = STMPE_TS_NAME,
+	},
 	.probe = stmpe_input_probe,
 	.remove = stmpe_ts_remove,
 };
 module_platform_driver(stmpe_ts_driver);
 
+#ifdef CONFIG_OF
+static const struct of_device_id stmpe_ts_ids[] = {
+	{ .compatible = "st,stmpe-ts", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, stmpe_ts_ids);
+#endif
+
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
 MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
 MODULE_LICENSE("GPL");
