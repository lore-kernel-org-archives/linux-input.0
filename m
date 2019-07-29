From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: soc_button_array: use
 platform_device_register_resndata()
Date: Mon, 29 Jul 2019 19:23:13 +0200
Message-ID: <20190729172313.GA755@penguin>
References: <1564410372-18506-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1564410372-18506-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 29, 2019 at 04:26:12PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> The registration of gpio-keys device can be written much shorter
> by using the platform_device_register_resndata() helper.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/input/misc/soc_button_array.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5e59f8e5..f5e148b 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -110,25 +110,21 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
>  	gpio_keys_pdata->nbuttons = n_buttons;
>  	gpio_keys_pdata->rep = autorepeat;
>  
> -	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
> -	if (!pd) {
> -		error = -ENOMEM;
> +	pd = platform_device_register_resndata(NULL,

I wonder if we should pass &pdev->dev instead of NULL here to form
proper device hierarchy, now that we have this option.

> +		"gpio-keys",
> +		PLATFORM_DEVID_AUTO,
> +		NULL,
> +		0,
> +		gpio_keys_pdata,
> +		sizeof(*gpio_keys_pdata));
> +
> +	if (IS_ERR(pd)) {
> +		dev_err(&pdev->dev, "failed registering gpio-keys: %ld\n", PTR_ERR(pd));
>  		goto err_free_mem;

Since you did not assign 'error' value here this goto will result in the
function returning 0 even if platform_device_register_resndata() failed.
I'd doing:

	pd = platform_device_register_resndata(NULL, ...);
	error = PTR_ERR_OR_ZERO(pd);
	if (error) {
		dev_err(...);
		goto err_free_mem;
	}

Thanks.

-- 
Dmitry
