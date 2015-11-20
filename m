From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/7] touchscreen: pixcir_i2c: Add support
 for wake and enable gpios
Date: Fri, 20 Nov 2015 09:27:25 -0800
Message-ID: <20151120172725.GA26895@dtor-ws>
References: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
 <1448018233-27824-5-git-send-email-hdegoede@redhat.com>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBAFQXWZAKGQEYPDTSPQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448018233-27824-5-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 20, 2015 at 12:17:10PM +0100, Hans de Goede wrote:
> From: Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>
> 
> On some devices the wake and enable pins of the pixcir touchscreen
> controller are connected to gpios and these must be controlled by the
> driver for the device to operate properly.
> 
> Signed-off-by: Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2 (Hans de Goede):
> -Split the changes for dealing with inverted / swapped axis out into a
>  separate patch
> -Remove a bunch of dev_info calls to make the driver less chatty
> -Use devm_gpiod_get_optional as these new gpios are optional
> -Only msleep after setting enable high if we have an enable pin
> ---
>  .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  2 +
>  drivers/input/touchscreen/pixcir_i2c_ts.c          | 46 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> index 8eb240a..72ca5ec 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> @@ -10,6 +10,8 @@ Required properties:
>  
>  Optional properties:
>  - reset-gpio: GPIO connected to the RESET line of the chip
> +- enable-gpios: GPIO connected to the ENABLE line of the chip
> +- wake-gpios: GPIO connected to the WAKE line of the chip
>  
>  Example:
>  
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 211408c..b75ef65 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -38,6 +38,8 @@ struct pixcir_i2c_ts_data {
>  	struct input_dev *input;
>  	struct gpio_desc *gpio_attb;
>  	struct gpio_desc *gpio_reset;
> +	struct gpio_desc *gpio_enable;
> +	struct gpio_desc *gpio_wake;
>  	const struct pixcir_i2c_chip_data *chip;
>  	int max_fingers;	/* Max fingers supported in this instance */
>  	bool running;
> @@ -208,6 +210,11 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
>  	struct device *dev = &ts->client->dev;
>  	int ret;
>  
> +	if (mode == PIXCIR_POWER_ACTIVE || mode == PIXCIR_POWER_IDLE) {
> +		if (!IS_ERR_OR_NULL(ts->gpio_wake))
> +			gpiod_set_value_cansleep(ts->gpio_wake, 1);

I believe you error out in case when IS_ERR(ts->gpio_wake) is true, so I
wonder if we should simply use

		if (ts->gpio_wake)
			gpiod_set_value_cansleep(ts->gpio_wake, 1);

here and elsewhere.

No need to resubmit, just let me know.

Thanks.

-- 
Dmitry
