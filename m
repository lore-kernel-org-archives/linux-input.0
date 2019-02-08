From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: gpio-keys-polled: use input name from
 pdata if available
Date: Thu, 7 Feb 2019 23:35:54 -0800
Message-ID: <20190208073554.GB31622@dtor-ws>
References: <1549559131-7423-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549559131-7423-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Enrico,

On Thu, Feb 07, 2019 at 06:05:31PM +0100, Enrico Weigelt, metux IT consult wrote:
> Instead of hardcoding the input name to the driver name ('gpio-keys-polled'),
> allow the passing a name via platform data ('name' field was already present),
> but default to old behaviour in case of NULL.

I thought the world is moving away from platform data and towards
OF/ACPI systems. What device are you targeting with this change?

I would want to convert gpio-keys[-polled] to generic device properties
and away form platform data...

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index edc7262..3312186 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  
>  	input = poll_dev->input;
>  
> -	input->name = pdev->name;
> +	input->name = (pdata->name ? pdata->name : pdev->name);
>  	input->phys = DRV_NAME"/input0";
>  
>  	input->id.bustype = BUS_HOST;
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
