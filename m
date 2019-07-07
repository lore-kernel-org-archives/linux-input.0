From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keyboard: gpio-keys-polled: use input name
 from pdata if available
Date: Sat, 6 Jul 2019 23:14:10 -0700
Message-ID: <20190707061410.GA174189@dtor-ws>
References: <1561648031-15887-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561648031-15887-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Enrico,

On Thu, Jun 27, 2019 at 05:07:10PM +0200, Enrico Weigelt, metux IT consult wrote:
> Instead of hardcoding the input name to the driver name
> ('gpio-keys-polled'), allow the passing a name via platform data
> ('name' field was already present), but default to old behaviour
> in case of NULL.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
> index 1eafe6b..c168493 100644
> --- a/drivers/input/keyboard/gpio_keys_polled.c
> +++ b/drivers/input/keyboard/gpio_keys_polled.c
> @@ -269,7 +269,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
>  
>  	input = poll_dev->input;
>  
> -	input->name = pdev->name;
> +	input->name = (pdata->name ? pdata->name : pdev->name);
>  	input->phys = DRV_NAME"/input0";
>  
>  	input->id.bustype = BUS_HOST;

I also added fetching name from "label" device property ad applied,
thank you.

-- 
Dmitry
