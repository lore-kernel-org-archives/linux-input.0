From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] input: misc: gp2a: Add support for light sensor
Date: Fri, 25 Jan 2019 17:18:00 -0800
Message-ID: <20190126011800.GC212026@dtor-ws>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125175045.22576-3-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125175045.22576-3-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mchehab+samsung@kernel.org, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 25, 2019 at 06:50:43PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> The gp2a driver previously only supported the proximity part of the
> sensor while the hardware supports both.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/misc/Kconfig         |  2 +
>  drivers/input/misc/gp2ap002a00f.c  | 71 +++++++++++++++++++++++++++++-
>  include/linux/input/gp2ap002a00f.h |  4 ++
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2be9bc5..a532efb4e6d8 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -252,6 +252,8 @@ config INPUT_GP2A
>  	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
>  	depends on I2C
>  	depends on GPIOLIB || COMPILE_TEST
> +	depends on IIO
> +	select INPUT_POLLDEV
>  	help
>  	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
>  	  hooked to an I2C bus.
> diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
> index 79c8c4c56d1a..090c8c313295 100644
> --- a/drivers/input/misc/gp2ap002a00f.c
> +++ b/drivers/input/misc/gp2ap002a00f.c
> @@ -10,9 +10,12 @@
>   */
>  
>  #include <linux/i2c.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/irq.h>
>  #include <linux/slab.h>
>  #include <linux/input.h>
> +#include <linux/input-polldev.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/gpio.h>
> @@ -20,7 +23,9 @@
>  #include <linux/input/gp2ap002a00f.h>
>  
>  struct gp2a_data {
> +	struct iio_channel *channel;
>  	struct input_dev *input;
> +	struct input_polled_dev *poll_dev;
>  	const struct gp2a_platform_data *pdata;
>  	struct i2c_client *i2c_client;
>  };
> @@ -58,6 +63,19 @@ static irqreturn_t gp2a_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> +static void gp2a_poll(struct input_polled_dev *dev)
> +{
> +	struct gp2a_data *dt = dev->private;
> +	int ret, value;
> +
> +	ret = iio_read_channel_processed(dt->channel, &value);
> +	if (ret < 0)
> +		dev_err(&dt->i2c_client->dev, "failed to read value!");
> +
> +	input_report_abs(dev->input, ABS_MISC, value);
> +	input_sync(dev->input);

No, light sensor is not an input device, keep it in IIO please.

-- 
Dmitry
