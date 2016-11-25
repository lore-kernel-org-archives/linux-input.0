From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input - soc_button_array: use gpio_is_valid()
Date: Fri, 25 Nov 2016 11:38:37 -0800
Message-ID: <20161125193837.GB15266@dtor-ws>
References: <1480091802-14482-1-git-send-email-benjamin.tissoires@redhat.com>
 <1480091802-14482-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480091802-14482-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 25, 2016 at 05:36:41PM +0100, Benjamin Tissoires wrote:
> gpio_keys will later use gpio_is_valid(). To match the actual
> behavior, we should use it here too.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
> no changes in v3
> 
> Changes in v2:
> - fixed gpio_is_valid(gpio) -> !gpio_is_valid(gpio)
> ---
>  drivers/input/misc/soc_button_array.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index c14b827..bbd433c 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -17,6 +17,7 @@
>  #include <linux/acpi.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio_keys.h>
> +#include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  
>  /*
> @@ -92,7 +93,7 @@ soc_button_device_create(struct platform_device *pdev,
>  			continue;
>  
>  		gpio = soc_button_lookup_gpio(&pdev->dev, info->acpi_index);
> -		if (gpio < 0)
> +		if (!gpio_is_valid(gpio))
>  			continue;
>  
>  		gpio_keys[n_buttons].type = info->event_type;
> -- 
> 2.7.4
> 

-- 
Dmitry
