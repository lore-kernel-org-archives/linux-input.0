From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] Input: gpio_mouse - switch to using input device polling
 mode
Date: Thu, 3 Oct 2019 00:42:19 +0200
Message-ID: <20191002224219.GA6203@samfundet.no>
References: <20191002220048.GA137235@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002220048.GA137235@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Around Wed 02 Oct 2019 15:00:48 -0700 or thereabout, Dmitry Torokhov wrote:
> Now that instances of input_dev support polling mode natively,
> we no longer need to create input_polled_dev instance.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/input/mouse/Kconfig      |  1 -
>  drivers/input/mouse/gpio_mouse.c | 45 ++++++++++++++------------------
>  2 files changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index 652c38e3c0b5..bf738d3b7fe4 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -381,7 +381,6 @@ config MOUSE_VSXXXAA
>  config MOUSE_GPIO
>  	tristate "GPIO mouse"
>  	depends on GPIOLIB || COMPILE_TEST
> -	select INPUT_POLLDEV
>  	help
>  	  This driver simulates a mouse on GPIO lines of various CPUs (and some
>  	  other chips).
> diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
> index 461436f6f087..23507fce3a2b 100644
> --- a/drivers/input/mouse/gpio_mouse.c
> +++ b/drivers/input/mouse/gpio_mouse.c
> @@ -8,7 +8,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/input-polldev.h>
> +#include <linux/input.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/property.h>
>  #include <linux/of.h>
> @@ -43,10 +43,9 @@ struct gpio_mouse {
>   * Timer function which is run every scan_ms ms when the device is opened.
>   * The dev input variable is set to the the input_dev pointer.
>   */
> -static void gpio_mouse_scan(struct input_polled_dev *dev)
> +static void gpio_mouse_scan(struct input_dev *input)
>  {
> -	struct gpio_mouse *gpio = dev->private;
> -	struct input_dev *input = dev->input;
> +	struct gpio_mouse *gpio = input_get_drvdata(input);
>  	int x, y;
>  
>  	if (gpio->bleft)
> @@ -71,18 +70,17 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct gpio_mouse *gmouse;
> -	struct input_polled_dev *input_poll;
>  	struct input_dev *input;
> -	int ret;
> +	int error;
>  
>  	gmouse = devm_kzalloc(dev, sizeof(*gmouse), GFP_KERNEL);
>  	if (!gmouse)
>  		return -ENOMEM;
>  
>  	/* Assign some default scanning time */
> -	ret = device_property_read_u32(dev, "scan-interval-ms",
> -				       &gmouse->scan_ms);
> -	if (ret || gmouse->scan_ms == 0) {
> +	error = device_property_read_u32(dev, "scan-interval-ms",
> +					 &gmouse->scan_ms);
> +	if (error || gmouse->scan_ms == 0) {
>  		dev_warn(dev, "invalid scan time, set to 50 ms\n");
>  		gmouse->scan_ms = 50;
>  	}
> @@ -112,23 +110,14 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  	if (IS_ERR(gmouse->bright))
>  		return PTR_ERR(gmouse->bright);
>  
> -	input_poll = devm_input_allocate_polled_device(dev);
> -	if (!input_poll) {
> -		dev_err(dev, "not enough memory for input device\n");
> +	input = devm_input_allocate_device(dev);
> +	if (!input)
>  		return -ENOMEM;
> -	}
> -
> -	platform_set_drvdata(pdev, input_poll);
> -
> -	/* set input-polldev handlers */
> -	input_poll->private = gmouse;
> -	input_poll->poll = gpio_mouse_scan;
> -	input_poll->poll_interval = gmouse->scan_ms;
>  
> -	input = input_poll->input;
>  	input->name = pdev->name;
>  	input->id.bustype = BUS_HOST;
> -	input->dev.parent = &pdev->dev;
> +
> +	input_set_drvdata(input, gmouse);
>  
>  	input_set_capability(input, EV_REL, REL_X);
>  	input_set_capability(input, EV_REL, REL_Y);
> @@ -139,10 +128,16 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  	if (gmouse->bright)
>  		input_set_capability(input, EV_KEY, BTN_RIGHT);
>  
> -	ret = input_register_polled_device(input_poll);
> -	if (ret) {
> +	error = input_setup_polling(input, gpio_mouse_scan);
> +	if (error)
> +		return error;
> +
> +	input_set_poll_interval(input, gmouse->scan_ms);
> +
> +	error = input_register_device(input);
> +	if (error) {
>  		dev_err(dev, "could not register input device\n");
> -		return ret;
> +		return error;
>  	}
>  
>  	dev_dbg(dev, "%d ms scan time, buttons: %s%s%s\n",
> -- 
> 2.23.0.444.g18eeb5a265-goog
-- 
mvh
Hans-Christian Noren Egtvedt
