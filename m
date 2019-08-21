From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] (submitted) input: misc: soc_button_array: use
 platform_device_register_resndata()
Date: Tue, 20 Aug 2019 20:20:15 -0700
Message-ID: <20190821032015.GR121898@dtor-ws>
References: <1566303944-15321-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566303944-15321-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Enrico,

On Tue, Aug 20, 2019 at 02:25:44PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> The registration of gpio-keys device can be written much shorter
> by using the platform_device_register_resndata() helper.
> 
> v2:
>     * pass &pdev->dev to platform_device_register_resndata()
>     * fixed errval on failed platform_device_register_resndata()
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/input/misc/soc_button_array.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5e59f8e5..27550f9 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -110,25 +110,24 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index)
>  	gpio_keys_pdata->nbuttons = n_buttons;
>  	gpio_keys_pdata->rep = autorepeat;
>  
> -	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
> -	if (!pd) {
> -		error = -ENOMEM;
> +	pd = platform_device_register_resndata(
> +		&pdev->dev,
> +		"gpio-keys",
> +		PLATFORM_DEVID_AUTO,
> +		NULL,
> +		0,
> +		gpio_keys_pdata,
> +		sizeof(*gpio_keys_pdata));
> +
> +	error = PTR_ERR_OR_ZERO(pd);
> +
> +	if (IS_ERR(pd)) {

I changed this and the PTR_ERR() to simply "error" and applied.

> +		dev_err(&pdev->dev, "failed registering gpio-keys: %ld\n", PTR_ERR(pd));
>  		goto err_free_mem;
>  	}
>  
> -	error = platform_device_add_data(pd, gpio_keys_pdata,
> -					 sizeof(*gpio_keys_pdata));
> -	if (error)
> -		goto err_free_pdev;
> -
> -	error = platform_device_add(pd);
> -	if (error)
> -		goto err_free_pdev;
> -
>  	return pd;
>  
> -err_free_pdev:
> -	platform_device_put(pd);
>  err_free_mem:
>  	devm_kfree(&pdev->dev, gpio_keys_pdata);
>  	return ERR_PTR(error);
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
