From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 12/14] keyboard: snvs-pwrkey: use __maybe_unused to hide
 pm functions
Date: Wed, 2 Mar 2016 09:12:38 -0800
Message-ID: <20160302171238.GA4318@dtor-ws>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-13-git-send-email-arnd@arndb.de>
 <AMSPR04MB263BDF6CE19C8B5432ECAE588BC0@AMSPR04MB263.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33779 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbcCBRMm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 12:12:42 -0500
Content-Disposition: inline
In-Reply-To: <AMSPR04MB263BDF6CE19C8B5432ECAE588BC0@AMSPR04MB263.eurprd04.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Li <frank.li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, "b38343@freescale.com" <b38343@freescale.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Frank Li <Frank.Li@freescale.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Mar 02, 2016 at 04:04:46PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > Sent: Wednesday, March 02, 2016 9:59 AM
> > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-arm-kernel@lists.infradead.org; Arnd Bergmann <arnd@arndb.de>;
> > Shawn Guo <shawnguo@kernel.org>; b38343@freescale.com; Javier
> > Martinez Canillas <javier@osg.samsung.com>; Frank Li
> > <Frank.Li@freescale.com>; linux-input@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH 12/14] keyboard: snvs-pwrkey: use __maybe_unused to hide
> > pm functions
> > 
> > The SNVS power key driver has suspend/resume functions that are accessed
> > using SIMPLE_DEV_PM_OPS, which hide the reference when
> > CONFIG_PM_SLEEP is not set, resulting in a warning about unused functions:
> > 
> > drivers/input/keyboard/snvs_pwrkey.c:183:12: error:
> > 'imx_snvs_pwrkey_suspend' defined but not used [-Werror=unused-function]
> > drivers/input/keyboard/snvs_pwrkey.c:194:12: error:
> > 'imx_snvs_pwrkey_resume' defined but not used [-Werror=unused-function]
> > 
> > This adds __maybe_unused annotations to let the compiler know it can
> > silently drop the function definition.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

> 
> > ---
> >  drivers/input/keyboard/snvs_pwrkey.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/snvs_pwrkey.c
> > b/drivers/input/keyboard/snvs_pwrkey.c
> > index 9adf13a5864a..b0ffadeb208c 100644
> > --- a/drivers/input/keyboard/snvs_pwrkey.c
> > +++ b/drivers/input/keyboard/snvs_pwrkey.c
> > @@ -180,7 +180,7 @@ static int imx_snvs_pwrkey_probe(struct
> > platform_device *pdev)
> >  	return 0;
> >  }
> > 
> > -static int imx_snvs_pwrkey_suspend(struct device *dev)
> > +static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev); @@ -
> > 191,7 +191,7 @@ static int imx_snvs_pwrkey_suspend(struct device *dev)
> >  	return 0;
> >  }
> > 
> > -static int imx_snvs_pwrkey_resume(struct device *dev)
> > +static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> > --
> > 2.7.0
> 

-- 
Dmitry
