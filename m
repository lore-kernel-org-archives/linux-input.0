From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] Input: edt-ft5x06 - Add support for regulator
Date: Fri, 8 Dec 2017 17:16:29 -0800
Message-ID: <20171209011629.4nkcjxj2l2j7zyph@dtor-ws>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-5-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171208215419.30396-5-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Mylène,

On Fri, Dec 08, 2017 at 10:54:18PM +0100, Mylène Josserand wrote:
> Add the support of regulator to use them as VCC source.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index c53a3d7239e7..44b0e04a8f35 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -39,6 +39,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  #include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define WORK_REGISTER_THRESHOLD		0x00
>  #define WORK_REGISTER_REPORT_RATE	0x08
> @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
>  	struct touchscreen_properties prop;
>  	u16 num_x;
>  	u16 num_y;
> +	struct regulator *supply;
>  
>  	struct gpio_desc *reset_gpio;
>  	struct gpio_desc *wake_gpio;
> @@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	tsdata->max_support_points = chip_data->max_support_points;
>  
> +	tsdata->supply = devm_regulator_get_optional(&client->dev, "power");

I'd prefer if we used devm_regulator_get() instead. On a
fully-constrained systems a missing regulator will be substituted with a
dummy one that you can then use in regulator_enable() and
regulator_disable(). The _optional regulator API is reserved for cases
where some of chip functionality is optional and you can engage it by
powering up parts of the chip. The reset is not such case: it is always
present, but may not be exposed to the OS to control.

I think the preference is to call the supply by the name is a datasheet,
something like "vcc" or "vdd", etc.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
