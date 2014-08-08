From: Nick Dyer <nick.dyer-8YpZQSjhsQH10XsdtD+oqA@public.gmane.org>
Subject: Re: [PATCH v2 1/1] Input: atmel_mxt_ts - Get IRQ edge/level flags
 on DT booting
Date: Fri, 08 Aug 2014 15:07:33 +0100
Message-ID: <53E4D9A5.908@itdev.co.uk>
References: <1407397492-17475-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407397492-17475-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Yufeng Shen <miletus-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/08/14 08:44, Javier Martinez Canillas wrote:
> The Atmel maXTouch driver assumed that the IRQ type flags will
> always be passed using platform data but this is not true when
> booting using Device Trees. In these setups the interrupt type
> was ignored by the driver when requesting an IRQ.
> 
> This means that it will fail if a machine specified other type
> than IRQ_TYPE_NONE. The right approach is to get the IRQ flags
> that was parsed by OF from the "interrupt" Device Tree propery.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

I'm happy for this to go in if Dmitry will accept it. It does seem to be a
quirk of some platforms that it is necessary, but it's only one line.

Thanks for spending so much time debugging this.

Signed-off-by: Nick Dyer <nick.dyer-8YpZQSjhsQH10XsdtD+oqA@public.gmane.org>

> ---
> 
> This patch was first sent as a part of a two part series along
> with [PATCH 2/2] Input: atmel_mxt_ts - Add keycodes array example.
> 
> But there are no dependencies between these two patches so there
> is no need to resend that one with no changes for v2.
> 
> Changes since v1:
>  - Assign flags to pdata->irqflags in mxt_parse_dt() instead of probe().
>    Suggested by Tomasz Figa.
> 
>  drivers/input/touchscreen/atmel_mxt_ts.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 03b8571..5c8cbd3 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -22,6 +22,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c/atmel_mxt_ts.h>
>  #include <linux/input/mt.h>
> +#include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> @@ -2093,6 +2094,8 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
>  	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
>  
> +	pdata->irqflags = irq_get_trigger_type(client->irq);
> +
>  	if (of_find_property(client->dev.of_node, "linux,gpio-keymap",
>  			     &proplen)) {
>  		pdata->t19_num_keys = proplen / sizeof(u32);
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
