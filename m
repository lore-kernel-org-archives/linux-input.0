From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v2 6/8] Input: sx8654 - add sx8650 support
Date: Mon, 28 Jan 2019 16:12:44 -0800
Message-ID: <20190129001244.GG34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218083931.11549-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218083931.11549-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: mark.rutland@arm.com, robh+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Richard,

On Tue, Dec 18, 2018 at 09:39:31AM +0100, Richard Leitner wrote:
> The sx8654 and sx8650 are quite similar, therefore add support for the
> sx8650 within the sx8654 driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 193 +++++++++++++++++++++++++++++++++----
>  1 file changed, 173 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index afa4da138fe9..4939863efbef 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -29,7 +29,7 @@
>  
>  #include <linux/input.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -44,9 +44,11 @@
>  #define I2C_REG_IRQSRC			0x23
>  #define I2C_REG_SOFTRESET		0x3f
>  
> +#define I2C_REG_SX8650_STAT		0x05
> +#define SX8650_STAT_CONVIRQ		0x80
> +
>  /* commands */
>  #define CMD_READ_REGISTER		0x40
> -#define CMD_MANUAL			0xc0
>  #define CMD_PENTRG			0xe0
>  
>  /* value for I2C_REG_SOFTRESET */
> @@ -58,6 +60,7 @@
>  
>  /* bits for RegTouch1 */
>  #define CONDIRQ				0x20
> +#define RPDNT_100K			0x00
>  #define FILT_7SA			0x03
>  
>  /* bits for I2C_REG_CHANMASK */
> @@ -71,14 +74,122 @@
>  /* power delay: lower nibble of CTRL0 register */
>  #define POWDLY_1_1MS			0x0b
>  
> +/* for sx8650, as we have no pen release IRQ there: timeout in ns following the
> + * last PENIRQ after which we assume the pen is lifted.
> + */
> +#define SX8650_PENIRQ_TIMEOUT		msecs_to_jiffies(10)
> +
>  #define MAX_12BIT			((1 << 12) - 1)
> +#define MAX_I2C_READ_LEN		10 /* see datasheet section 5.1.5 */
> +
> +/* channel definition */
> +#define CH_X				0x00
> +#define CH_Y				0x01
> +
> +struct sx865x_data {
> +	u8 cmd_manual;
> +	u8 chan_mask;
> +	u8 has_irq_penrelease;
> +	u8 has_reg_irqmask;

I changed these 2 to bools.

> +	irq_handler_t irqh;
> +};
>  
>  struct sx8654 {
>  	struct input_dev *input;
>  	struct i2c_client *client;
>  	struct gpio_desc *gpio_reset;
> +
> +	spinlock_t		lock; /* for input reporting from irq/timer */
> +	struct timer_list	timer;
> +
> +	const struct sx865x_data *data;
>  };
>  
> +static inline void sx865x_penrelease(struct sx8654 *ts)
> +{
> +	struct input_dev *input_dev = ts->input;
> +
> +	input_report_key(input_dev, BTN_TOUCH, 0);
> +	input_sync(input_dev);
> +}
> +
> +static void sx865x_penrelease_timer_handler(struct timer_list *t)
> +{
> +	struct sx8654 *ts = from_timer(ts, t, timer);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +	sx865x_penrelease(ts);
> +	spin_unlock_irqrestore(&ts->lock, flags);
> +	dev_dbg(&ts->client->dev, "penrelease by timer\n");
> +}
> +
> +static irqreturn_t sx8650_irq(int irq, void *handle)
> +{
> +	struct sx8654 *ts = handle;
> +	struct device *dev = &ts->client->dev;
> +	int len, i;
> +	unsigned long flags;
> +	u8 stat;
> +	u16 x, y;
> +	u8 data[MAX_I2C_READ_LEN];
> +	u16 ch;
> +	u16 chdata;
> +	u8 readlen = hweight32(ts->data->chan_mask) * 2;
> +
> +	stat = i2c_smbus_read_byte_data(ts->client, CMD_READ_REGISTER
> +						    | I2C_REG_SX8650_STAT);
> +
> +	if (!(stat & SX8650_STAT_CONVIRQ)) {
> +		dev_dbg(dev, "%s ignore stat [0x%02x]", __func__, stat);
> +		return IRQ_HANDLED;
> +	}
> +
> +	len = i2c_master_recv(ts->client, data, readlen);
> +	if (len != readlen) {
> +		dev_dbg(dev, "ignore short recv (%d)\n", len);
> +		return IRQ_HANDLED;
> +	}
> +
> +	spin_lock_irqsave(&ts->lock, flags);
> +
> +	x = 0;
> +	y = 0;
> +	for (i = 0; (i + 1) < len; i++) {
> +		chdata = data[i] << 8;
> +		i++;
> +		chdata += data[i];

So you reading be16 form the wire. I annotated data array as such and
used be16_to_cpu() here.

> +
> +		if (unlikely(chdata == 0xFFFF)) {
> +			dev_dbg(dev, "invalid qualified data @ %d\n", i);
> +			continue;
> +		} else if (unlikely(chdata & 0x8000)) {
> +			dev_warn(dev, "hibit @ %d [0x%04x]\n", i, chdata);
> +			continue;
> +		}
> +
> +		ch = chdata >> 12;
> +		if      (ch == CH_X)
> +			x = chdata & MAX_12BIT;
> +		else if (ch == CH_Y)
> +			y = chdata & MAX_12BIT;
> +		else
> +			dev_warn(dev, "unknown channel %d [0x%04x]\n", ch,
> +				 chdata);
> +	}
> +
> +	input_report_abs(ts->input, ABS_X, x);
> +	input_report_abs(ts->input, ABS_Y, y);
> +	input_report_key(ts->input, BTN_TOUCH, 1);
> +	input_sync(ts->input);
> +	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
> +
> +	mod_timer(&ts->timer, jiffies + SX8650_PENIRQ_TIMEOUT);
> +	spin_unlock_irqrestore(&ts->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t sx8654_irq(int irq, void *handle)
>  {
>  	struct sx8654 *sx8654 = handle;
> @@ -127,6 +238,22 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct sx865x_data sx8650_data = {
> +	.cmd_manual = 0xb0,
> +	.has_irq_penrelease = 0,
> +	.has_reg_irqmask = 0,

Changed both to false.

> +	.chan_mask = (CONV_X | CONV_Y),
> +	.irqh = sx8650_irq,
> +};
> +
> +static const struct sx865x_data sx8654_data = {
> +	.cmd_manual = 0xc0,
> +	.has_irq_penrelease = 1,
> +	.has_reg_irqmask = 1,

Changed both to true.

> +	.chan_mask = (CONV_X | CONV_Y),
> +	.irqh = sx8654_irq,
> +};
> +

Moved the structures closer to where they are used.

>  static int sx8654_reset(struct sx8654 *ts)
>  {
>  	int err;
> @@ -182,13 +309,13 @@ static void sx8654_close(struct input_dev *dev)
>  	disable_irq(client->irq);
>  
>  	/* enable manual mode mode */
> -	error = i2c_smbus_write_byte(client, CMD_MANUAL);
> +	error = i2c_smbus_write_byte(client, sx8654->data->cmd_manual);
>  	if (error) {
>  		dev_err(&client->dev, "writing command CMD_MANUAL failed");
>  		return;
>  	}
>  
> -	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, 0);
> +	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, RATE_MANUAL);
>  	if (error) {
>  		dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
>  		return;
> @@ -221,6 +348,20 @@ static int sx8654_probe(struct i2c_client *client,
>  	}
>  	dev_dbg(&client->dev, "got GPIO reset pin\n");
>  
> +	sx8654->data = of_device_get_match_data(&client->dev);

Changed to device_get_match_data() in case someone would use it on
non-OF platform.

> +	if (!sx8654->data)
> +		sx8654->data = (const struct sx865x_data *)id->driver_data;
> +	if (!sx8654->data) {
> +		dev_err(&client->dev, "invalid or missing device data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!sx8654->data->has_irq_penrelease) {
> +		dev_dbg(&client->dev, "use timer for penrelease\n");
> +		timer_setup(&sx8654->timer, sx865x_penrelease_timer_handler, 0);
> +		spin_lock_init(&sx8654->lock);

You should also make sure the timer is not running when you are tearing
down the device. I added del_timer_sync() call to sx8654_close().

> +	}
> +
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
> @@ -248,29 +389,31 @@ static int sx8654_probe(struct i2c_client *client,
>  	}
>  
>  	error = i2c_smbus_write_byte_data(client, I2C_REG_CHANMASK,
> -					  CONV_X | CONV_Y);
> +					  sx8654->data->chan_mask);
>  	if (error) {
>  		dev_err(&client->dev, "writing to I2C_REG_CHANMASK failed");
>  		return error;
>  	}
>  
> -	error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
> -					  IRQ_PENTOUCH_TOUCHCONVDONE |
> -						IRQ_PENRELEASE);
> -	if (error) {
> -		dev_err(&client->dev, "writing to I2C_REG_IRQMASK failed");
> -		return error;
> +	if (sx8654->data->has_reg_irqmask) {
> +		error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
> +						  IRQ_PENTOUCH_TOUCHCONVDONE |
> +							IRQ_PENRELEASE);
> +		if (error) {
> +			dev_err(&client->dev, "writing I2C_REG_IRQMASK failed");
> +			return error;
> +		}
>  	}
>  
>  	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH1,
> -					  CONDIRQ | FILT_7SA);
> +					  CONDIRQ | RPDNT_100K | FILT_7SA);
>  	if (error) {
>  		dev_err(&client->dev, "writing to I2C_REG_TOUCH1 failed");
>  		return error;
>  	}
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
> -					  NULL, sx8654_irq,
> +					  NULL, sx8654->data->irqh,
>  					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					  client->name, sx8654);
>  	if (error) {
> @@ -292,18 +435,28 @@ static int sx8654_probe(struct i2c_client *client,
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id sx8654_of_match[] = {
> -	{ .compatible = "semtech,sx8654", },
> -	{ .compatible = "semtech,sx8655", },
> -	{ .compatible = "semtech,sx8656", },
> -	{ },
> +	{
> +		.compatible = "semtech,sx8650",
> +		.data = &sx8650_data,
> +	}, {
> +		.compatible = "semtech,sx8654",
> +		.data = &sx8654_data,
> +	}, {
> +		.compatible = "semtech,sx8655",
> +		.data = &sx8654_data,
> +	}, {
> +		.compatible = "semtech,sx8656",
> +		.data = &sx8654_data,
> +	}, {},
>  };
>  MODULE_DEVICE_TABLE(of, sx8654_of_match);
>  #endif
>  
>  static const struct i2c_device_id sx8654_id_table[] = {
> -	{ "semtech_sx8654", 0 },
> -	{ "semtech_sx8655", 0 },
> -	{ "semtech_sx8656", 0 },
> +	{ .name = "semtech_sx8650", .driver_data = (long)&sx8650_data },
> +	{ .name = "semtech_sx8654", .driver_data = (long)&sx8654_data },
> +	{ .name = "semtech_sx8655", .driver_data = (long)&sx8654_data },
> +	{ .name = "semtech_sx8656", .driver_data = (long)&sx8654_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
> -- 
> 2.11.0
> 

Applied with above mentioned changes, please take a look in case I
messed up.

Thanks.

-- 
Dmitry
