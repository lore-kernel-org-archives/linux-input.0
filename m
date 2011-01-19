From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: ad7979 - Convert SPI to dev_pm_ops
Date: Wed, 19 Jan 2011 09:40:38 -0800
Message-ID: <20110119174038.GA29107@core.coreip.homeip.net>
References: <1295441139-14706-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1295441139-14706-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47798 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1ASRkr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Jan 2011 12:40:47 -0500
Received: by vws16 with SMTP id 16so480055vws.19
        for <linux-input@vger.kernel.org>; Wed, 19 Jan 2011 09:40:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295441139-14706-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

Hi Mark,

On Wed, Jan 19, 2011 at 12:45:38PM +0000, Mark Brown wrote:
> +
> +static SIMPLE_DEV_PM_OPS(ad7879_spi_pm, ad7879_spi_suspend, ad7879_spi_resume);
>  #endif
>  

I was looking at SIMPLE_DEV_PM_OPS definition and it turns into noop if
CONFIG_PM_SLEEP is not set (for systems with runtime PM only, for
example). This will lead to "unused function" compiler warnings (and I
think I have seen such reports for randconfig compiles off linux-next).

Do you think we coudl augment your patch thusly:

diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 0b135a6..ddf732f 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -21,7 +21,7 @@
 #define AD7879_WRITECMD(reg) (AD7879_CMD(reg))
 #define AD7879_READCMD(reg)  (AD7879_CMD(reg) | AD7879_CMD_READ)
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int ad7879_spi_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -41,9 +41,9 @@ static int ad7879_spi_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(ad7879_spi_pm, ad7879_spi_suspend, ad7879_spi_resume);
-#endif
 
 /*
  * ad7879_read/write are only used for initial setup and for sysfs controls.
@@ -175,9 +175,7 @@ static struct spi_driver ad7879_spi_driver = {
 		.name	= "ad7879",
 		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm	= &ad7879_spi_pm,
-#endif
 	},
 	.probe		= ad7879_spi_probe,
 	.remove		= __devexit_p(ad7879_spi_remove),

Thanks,
Dmitry

-- 
Dmitry
