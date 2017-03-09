From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Input: soc_button_array: Use NULL for GPIO connection ID
Date: Thu, 09 Mar 2017 16:11:15 +0200
Message-ID: <1489068675.20145.171.camel@linux.intel.com>
References: <20170309135957.15161-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39526 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754559AbdCIOLS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 09:11:18 -0500
In-Reply-To: <20170309135957.15161-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 2017-03-09 at 14:59 +0100, Hans de Goede wrote:
> The gpiolib-acpi code is becoming more strict and connection-IDs
> may only be used with devices which have a _DSD with matching IDs
> in there. Since the soc_button_array ACPI binding is pure index
> based pass in NULL as connection-ID to avoid the more strict cheks
> resulting in gpiod_count and gpiod_get_index not returning any gpios.
> 

Fine by me:

FWIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/misc/soc_button_array.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c
> b/drivers/input/misc/soc_button_array.c
> index eb1ba4e..b8769f6 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -48,7 +48,7 @@ static int soc_button_lookup_gpio(struct device
> *dev, int acpi_index)
>  	struct gpio_desc *desc;
>  	int gpio;
>  
> -	desc = gpiod_get_index(dev, KBUILD_MODNAME, acpi_index,
> GPIOD_ASIS);
> +	desc = gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
>  	if (IS_ERR(desc))
>  		return PTR_ERR(desc);
>  
> @@ -167,7 +167,7 @@ static int soc_button_probe(struct platform_device
> *pdev)
>  
>  	button_info = (struct soc_button_info *)id->driver_data;
>  
> -	if (gpiod_count(dev, KBUILD_MODNAME) <= 0) {
> +	if (gpiod_count(dev, NULL) <= 0) {
>  		dev_dbg(dev, "no GPIO attached, ignoring...\n");
>  		return -ENODEV;
>  	}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
