From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: edt-ft5x06 - Switch to newer gpio framework
Date: Mon, 24 Aug 2015 12:41:13 -0700
Message-ID: <20150824194113.GE22442@dtor-ws>
References: <1440184112-11061-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440184112-11061-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 21, 2015 at 02:08:32PM -0500, Franklin S Cooper Jr wrote:
> The current/old gpio framework used doesn't properly listen to
> ACTIVE_LOW and ACTIVE_HIGH flags. The newer gpio framework takes into
> account these flags when setting gpio values.
> 
> Also use gpiod_set_value_cansleep since wake and reset pins can be
> provided by bus based io expanders.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |   4 +-
>  drivers/input/touchscreen/edt-ft5x06.c             | 115 +++++++--------------
>  include/linux/input/edt-ft5x06.h                   |   4 +-
>  3 files changed, 43 insertions(+), 80 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> index 76db967..9330d4d 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> @@ -50,6 +50,6 @@ Example:
>  		pinctrl-0 = <&edt_ft5x06_pins>;
>  		interrupt-parent = <&gpio2>;
>  		interrupts = <5 0>;
> -		reset-gpios = <&gpio2 6 1>;
> -		wake-gpios = <&gpio4 9 0>;
> +		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> +		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
>  	};
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 394b1de..6b128b3 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -91,9 +91,9 @@ struct edt_ft5x06_ts_data {
>  	u16 num_x;
>  	u16 num_y;
>  
> -	int reset_pin;
> -	int irq_pin;
> -	int wake_pin;
> +	struct gpio_desc *reset_pin;
> +	struct gpio_desc *wake_pin;
> +	struct gpio_desc *irq_pin;
>  
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry *debug_dir;
> @@ -755,36 +755,14 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
>  static int edt_ft5x06_ts_reset(struct i2c_client *client,
>  			struct edt_ft5x06_ts_data *tsdata)
>  {
> -	int error;
> -
> -	if (gpio_is_valid(tsdata->wake_pin)) {
> -		error = devm_gpio_request_one(&client->dev,
> -					tsdata->wake_pin, GPIOF_OUT_INIT_LOW,
> -					"edt-ft5x06 wake");
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Failed to request GPIO %d as wake pin, error %d\n",
> -				tsdata->wake_pin, error);
> -			return error;
> -		}
> -
> +	if (tsdata->wake_pin) {
>  		msleep(5);
> -		gpio_set_value(tsdata->wake_pin, 1);
> +		gpiod_set_value_cansleep(tsdata->wake_pin, 1);
>  	}
> -	if (gpio_is_valid(tsdata->reset_pin)) {
> -		/* this pulls reset down, enabling the low active reset */
> -		error = devm_gpio_request_one(&client->dev,
> -					tsdata->reset_pin, GPIOF_OUT_INIT_LOW,
> -					"edt-ft5x06 reset");
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Failed to request GPIO %d as reset pin, error %d\n",
> -				tsdata->reset_pin, error);
> -			return error;
> -		}
>  
> +	if (tsdata->reset_pin) {
>  		msleep(5);
> -		gpio_set_value(tsdata->reset_pin, 1);
> +		gpiod_set_value_cansleep(tsdata->reset_pin, 1);

So this leaves the reset pin active. How exactly was this tested?

Thanks.

-- 
Dmitry
