From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCHv6 2/3] Input: twl4030-pwrbutton: use dev_err for errors
Date: Fri, 25 Oct 2013 23:05:03 +0300
Message-ID: <20131025200503.GE17447@blackmetal.musicnaut.iki.fi>
References: <1382626126-12565-1-git-send-email-sre@debian.org>
 <1382626126-12565-3-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382626126-12565-3-git-send-email-sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, Oct 24, 2013 at 04:48:45PM +0200, Sebastian Reichel wrote:
> Use dev_err() to output errors instead of dev_dbg().
> 
> Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>

Reviewed-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>

> ---
>  drivers/input/misc/twl4030-pwrbutton.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index a3a0fe3..48639ff 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -74,13 +74,13 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
>  			"twl4030_pwrbutton", pwr);
>  	if (err < 0) {
> -		dev_dbg(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
> +		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
>  		goto free_input_dev;
>  	}
>  
>  	err = input_register_device(pwr);
>  	if (err) {
> -		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
> +		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
>  		goto free_irq;
>  	}
>  
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
