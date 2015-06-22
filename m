From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: axp20x-pek: Fix reporting button
 state as inverted
Date: Mon, 22 Jun 2015 14:30:51 -0700
Message-ID: <20150622213051.GD2350@dtor-ws>
References: <1434278541-21355-1-git-send-email-hdegoede@redhat.com>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBD75UGWAKGQEDWD6LDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434278541-21355-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Jun 14, 2015 at 12:42:21PM +0200, Hans de Goede wrote:
> Currently we are reporting the button state as inverted on all boards with
> an axp209 pmic, tested on a ba10-tvbox, bananapi, bananapro, cubietruck and
> utoo-p66 tablet.
> 
> The axp209 datasheet clearly states that the power button must be connected
> between the PWRON key and ground. Which means that on a press we will get
> a falling edge (dbf) irq not a rising one, and likewise on release we will
> get a rising edge (dbr) irq, not a falling one.
> 
> This commit swaps the check for the 2 irqs fixing the inverted reporting of
> the power button state.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Carlo, Chen-Yu, could you please give this patch a spin and let us know
if it works on your boards?

Thanks!

> ---
>  drivers/input/misc/axp20x-pek.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index f1c8447..10e140a 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -167,9 +167,13 @@ static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
>  	struct input_dev *idev = pwr;
>  	struct axp20x_pek *axp20x_pek = input_get_drvdata(idev);
>  
> -	if (irq == axp20x_pek->irq_dbr)
> +	/*
> +	 * The power-button is connected to ground so a falling edge (dbf)
> +	 * means it is pressed.
> +	 */
> +	if (irq == axp20x_pek->irq_dbf)
>  		input_report_key(idev, KEY_POWER, true);
> -	else if (irq == axp20x_pek->irq_dbf)
> +	else if (irq == axp20x_pek->irq_dbr)
>  		input_report_key(idev, KEY_POWER, false);
>  
>  	input_sync(idev);
> -- 
> 2.4.3
> 

-- 
Dmitry
