From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 7/9] input: goodix: add power management support
Date: Thu, 04 Jun 2015 15:01:06 +0200
Message-ID: <1433422866.5346.23.camel@hadess.net>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
	 <1432817265-23891-8-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41277 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbFDNBN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jun 2015 09:01:13 -0400
In-Reply-To: <1432817265-23891-8-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>

On Thu, 2015-05-28 at 15:47 +0300, Irina Tirdea wrote:
> Implement suspend/resume for goodix driver.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  drivers/input/touchscreen/goodix.c | 81 
> +++++++++++++++++++++++++++++++++++---
>  1 file changed, 76 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c 
> b/drivers/input/touchscreen/goodix.c
> index 22052c9..ce7e834 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -37,6 +37,7 @@ struct goodix_ts_data {
>       unsigned int int_trigger_type;
>       struct gpio_desc *gpiod_int;
>       struct gpio_desc *gpiod_rst;
> +     unsigned long irq_flags;
>  };
>  
>  #define GOODIX_GPIO_INT_NAME         "irq"
> @@ -52,6 +53,9 @@ struct goodix_ts_data {
>  #define GOODIX_CONFIG_MAX_LENGTH     240
>  
>  /* Register defines */
> +#define GOODIX_REG_COMMAND           0x8040
> +#define GOODIX_CMD_SCREEN_OFF                0x05
> +
>  #define GOODIX_READ_COOR_ADDR                0x814E
>  #define GOODIX_REG_CONFIG_DATA               0x8047
>  #define GOODIX_REG_ID                        0x8140
> @@ -129,6 +133,11 @@ static int goodix_i2c_write(struct i2c_client 
> *client, u16 reg, u8 *buf,
>       return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
>  }
>  
> +static int goodix_i2c_write_u8(struct i2c_client *client, u16 reg, 
> u8 value)
> +{
> +     return goodix_i2c_write(client, reg, &value, sizeof(value));
> +}
> +
>  static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 
> *data)
>  {
>       int touch_num;
> @@ -227,6 +236,18 @@ static irqreturn_t goodix_ts_irq_handler(int 
> irq, void *dev_id)
>       return IRQ_HANDLED;
>  }
>  
> +static void goodix_free_irq(struct goodix_ts_data *ts)
> +{
> +     devm_free_irq(&ts->client->dev, ts->client->irq, ts);
> +}
> +
> +static int goodix_request_irq(struct goodix_ts_data *ts)
> +{
> +     return devm_request_threaded_irq(&ts->client->dev, ts
> ->client->irq,
> +                                      NULL, 
> goodix_ts_irq_handler,
> +                                      ts->irq_flags, ts->client
> ->name, ts);
> +}
> +
>  /**
>   * goodix_get_cfg - Get device config from ACPI/DT.
>   *
> @@ -562,7 +583,6 @@ static int goodix_ts_probe(struct i2c_client 
> *client,
>                          const struct i2c_device_id *id)
>  {
>       struct goodix_ts_data *ts;
> -     unsigned long irq_flags;
>       int error;
>       u16 version_info, id_info;
>  
> @@ -614,10 +634,8 @@ static int goodix_ts_probe(struct i2c_client 
> *client,
>       if (error)
>               return error;
>  
> -     irq_flags = goodix_irq_flags[ts->int_trigger_type] | 
> IRQF_ONESHOT;
> -     error = devm_request_threaded_irq(&ts->client->dev, client
> ->irq,
> -                                       NULL, 
> goodix_ts_irq_handler,
> -                                       irq_flags, client->name, 
> ts);
> +     ts->irq_flags = goodix_irq_flags[ts->int_trigger_type] | 
> IRQF_ONESHOT;
> +     error = goodix_request_irq(ts);
>       if (error) {
>               dev_err(&client->dev, "request IRQ failed: %d\n", 
> error);
>               return error;
> @@ -626,6 +644,58 @@ static int goodix_ts_probe(struct i2c_client 
> *client,
>       return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int goodix_suspend(struct device *dev)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     struct goodix_ts_data *ts = i2c_get_clientdata(client);
> +     int ret;
> +
> +     goodix_free_irq(ts);
> +     ret = gpiod_direction_output(ts->gpiod_int, 0);
> +     if (ret) {
> +             goodix_request_irq(ts);
> +             return ret;
> +     }
> +     usleep_range(5000, 6000);

I'd appreciate some references and explanations for those magic
numbers.

> +
> +     ret = goodix_i2c_write_u8(ts->client, GOODIX_REG_COMMAND,
> +                               GOODIX_CMD_SCREEN_OFF);
> +     if (ret) {
> +             dev_err(&ts->client->dev, "Screen off command 
> failed\n");
> +             gpiod_direction_input(ts->gpiod_int);
> +             goodix_request_irq(ts);
> +             return -EAGAIN;
> +     }
> +
> +     /*
> +      * To avoid waking up while is not sleeping,

You're missing a subject in that sentence.

> +      * delay 58ms to ensure reliability
> +      */
> +     msleep(58);

Why 58ms?

> +     return 0;
> +}
> +
> +static int goodix_resume(struct device *dev)
> +{
> +     struct i2c_client *client = to_i2c_client(dev);
> +     struct goodix_ts_data *ts = i2c_get_clientdata(client);
> +     int ret;
> +
> +     ret = gpiod_direction_output(ts->gpiod_int, 1);
> +     if (ret)
> +             return ret;
> +     usleep_range(2000, 5000);               /* 2ms~5ms */

Good comment, just missing a reference (anything that could help find
that information in the datasheets would be good).

> +     ret = goodix_int_sync(ts);
> +     if (ret)
> +             return ret;
> +
> +     return goodix_request_irq(ts);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(goodix_pm_ops, goodix_suspend, 
> goodix_resume);
> +
>  static const struct i2c_device_id goodix_ts_id[] = {
>       { "GDIX1001:00", 0 },
>       { }
> @@ -663,6 +733,7 @@ static struct i2c_driver goodix_ts_driver = {
>               .owner = THIS_MODULE,
>               .acpi_match_table = ACPI_PTR(goodix_acpi_match),
>               .of_match_table = of_match_ptr(goodix_of_match),
> +             .pm = &goodix_pm_ops,
>       },
>  };
>  module_i2c_driver(goodix_ts_driver);
