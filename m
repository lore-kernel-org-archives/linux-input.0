From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] soc_button_array: fix the issue that button device
 can't be enumerated since 3.16-rc1
Date: Mon, 22 Sep 2014 09:44:32 +0800
Message-ID: <1411350272.1280.51.camel@rzhang1-toshiba>
References: <1404309504.8366.93.camel@rzhang1-toshiba>
	 <1404309713.8366.94.camel@rzhang1-toshiba>
	 <2556427.cdnVoQoSXY@vostro.rjw.lan>
	 <20140709165732.GD10364@core.coreip.homeip.net>
	 <1406702719.10148.3.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6388 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbaIVBp3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Sep 2014 21:45:29 -0400
In-Reply-To: <1406702719.10148.3.camel@rzhang1-toshiba>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, yao.jin@intel.com, linux-input <linux-input@vger.kernel.org>

Hi, Dmitry,

On Wed, 2014-07-30 at 14:45 +0800, Zhang Rui wrote:
> Hi, Dmitry,
> 
> On Wed, 2014-07-09 at 09:57 -0700, Dmitry Torokhov wrote:
> > On Tue, Jul 08, 2014 at 10:50:04PM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, July 02, 2014 10:01:53 PM Zhang Rui wrote:
> > > > From c2ee1886ba230d9d93d2ea2f350b1dc1a2d5ead5 Mon Sep 17 00:00:00 2001
> > > > From: Jin Yao <yao.jin@linux.intel.com>
> > > > Date: Thu, 26 Jun 2014 10:26:44 +0800
> > > > Subject: [PATCH] soc_button_array: fix the issue that button device can't be
> > > >  enumerated since 3.16-rc1
> > > 
> > > Hi Rui,
> > > 
> > > For 3.16 I'm afraid we need to add the missing device ID to the PNP list.
> > > It is too late to do the conversion at this point IMO and we can do it later.
> > 
> > But for 3.17 this patch is the right way of doing things, right?
> 
> This is the patch we should use for 3.17.
> Compared with the previous version, I just removed the soc_button_array id
> from acpi pnp id list, which was added in 3.16-rc5, as an urgent fix.
> 
> Please review.
> 
Can you please take a look at this patch?

thanks,
rui
> From f09ff78ba75a9de0f6df333be6238a5b1bf36464 Mon Sep 17 00:00:00 2001
> From: Jin Yao <yao.jin@linux.intel.com>
> Date: Thu, 26 Jun 2014 10:26:44 +0800
> Subject: [PATCH] convert soc_button_array driver to platform bus
> 
> ACPI device enumeration mechanism changed a lot since 3.16-rc1.
> ACPI device objects with _HID will be enumerated to platform bus by default.
> For the existing PNP drivers that probe the PNPACPI devices, the device ids
> are listed explicitly in drivers/acpi/acpi_pnp.c.
> But ACPI folks will continue their effort on shrinking this id list by
> converting the PNP drivers to platform drivers, for the devices that don't
> belong to PNP bus in nature.
> 
> convert soc_button_array driver from PNP bus to platform bus in this patch.
> 
> Signed-off-by: Jin Yao <yao.jin@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/acpi_pnp.c               |  2 --
>  drivers/input/misc/soc_button_array.c | 60 ++++++++++++++++++-----------------
>  2 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 4ddb0dc..6703c1f 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -14,8 +14,6 @@
>  #include <linux/module.h>
>  
>  static const struct acpi_device_id acpi_pnp_device_ids[] = {
> -	/* soc_button_array */
> -	{"PNP0C40"},
>  	/* pata_isapnp */
>  	{"PNP0600"},		/* Generic ESDI/IDE/ATA compatible hard disk controller */
>  	/* floppy */
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5a6334b..16ca162 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -18,7 +18,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/platform_device.h>
> -#include <linux/pnp.h>
> +#include <linux/acpi.h>
>  
>  /*
>   * Definition of buttons on the tablet. The ACPI index of each button
> @@ -67,7 +67,7 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
>  }
>  
>  static struct platform_device *
> -soc_button_device_create(struct pnp_dev *pdev,
> +soc_button_device_create(struct platform_device *pdev,
>  			 const struct soc_button_info *button_info,
>  			 bool autorepeat)
>  {
> @@ -135,30 +135,40 @@ soc_button_device_create(struct pnp_dev *pdev,
>  	return ERR_PTR(error);
>  }
>  
> -static void soc_button_remove(struct pnp_dev *pdev)
> +static int soc_button_remove(struct platform_device *pdev)
>  {
> -	struct soc_button_data *priv = pnp_get_drvdata(pdev);
> +	struct soc_button_data *priv = platform_get_drvdata(pdev);
> +
>  	int i;
>  
>  	for (i = 0; i < BUTTON_TYPES; i++)
>  		if (priv->children[i])
>  			platform_device_unregister(priv->children[i]);
> +
> +	return 0;
>  }
>  
> -static int soc_button_pnp_probe(struct pnp_dev *pdev,
> -				const struct pnp_device_id *id)
> +static int soc_button_probe(struct platform_device *pdev)
>  {
> -	const struct soc_button_info *button_info = (void *)id->driver_data;
> +	struct device *dev = &pdev->dev;
> +	const struct acpi_device_id *id;
> +	struct soc_button_info *button_info;
>  	struct soc_button_data *priv;
>  	struct platform_device *pd;
>  	int i;
>  	int error;
>  
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	button_info = (struct soc_button_info *)id->driver_data;
> +
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	pnp_set_drvdata(pdev, priv);
> +	platform_set_drvdata(pdev, priv);
>  
>  	for (i = 0; i < BUTTON_TYPES; i++) {
>  		pd = soc_button_device_create(pdev, button_info, i == 0);
> @@ -189,30 +199,22 @@ static struct soc_button_info soc_button_PNP0C40[] = {
>  	{ }
>  };
>  
> -static const struct pnp_device_id soc_button_pnp_match[] = {
> -	{ .id = "PNP0C40", .driver_data = (long)soc_button_PNP0C40 },
> -	{ .id = "" }
> +static const struct acpi_device_id soc_button_acpi_match[] = {
> +	{ "PNP0C40", (unsigned long)soc_button_PNP0C40 },
> +	{ }
>  };
> -MODULE_DEVICE_TABLE(pnp, soc_button_pnp_match);
>  
> -static struct pnp_driver soc_button_pnp_driver = {
> -	.name		= KBUILD_MODNAME,
> -	.id_table	= soc_button_pnp_match,
> -	.probe          = soc_button_pnp_probe,
> +MODULE_DEVICE_TABLE(acpi, soc_button_acpi_match);
> +
> +static struct platform_driver soc_button_driver = {
> +	.probe          = soc_button_probe,
>  	.remove		= soc_button_remove,
> +	.driver		= {
> +		.name = KBUILD_MODNAME,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(soc_button_acpi_match),
> +	},
>  };
> -
> -static int __init soc_button_init(void)
> -{
> -	return pnp_register_driver(&soc_button_pnp_driver);
> -}
> -
> -static void __exit soc_button_exit(void)
> -{
> -	pnp_unregister_driver(&soc_button_pnp_driver);
> -}
> -
> -module_init(soc_button_init);
> -module_exit(soc_button_exit);
> +module_platform_driver(soc_button_driver);
>  
>  MODULE_LICENSE("GPL");


