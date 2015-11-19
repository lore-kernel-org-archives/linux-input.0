From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 4/8] Input: goodix - add power management support
Date: Thu, 19 Nov 2015 10:24:33 -0800
Message-ID: <20151119182433.GB24773@dtor-ws>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
 <1447936001-21420-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447936001-21420-5-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 19, 2015 at 02:26:37PM +0200, Irina Tirdea wrote:
> Implement suspend/resume for goodix driver.
> 
> The suspend and resume process uses the gpio pins.
> If the device ACPI/DT information does not declare gpio pins,
> suspend/resume will not be available for these devices.
> 
> This is based on Goodix datasheets for GT911 and GT9271
> and on Goodix driver gt9xx.c for Android (publicly available
> in Android kernel trees for various devices).
> 
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/input/touchscreen/goodix.c | 96 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 0911b0c9..0fd472d 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -45,6 +45,7 @@ struct goodix_ts_data {
>  	u16 version;
>  	char *cfg_name;
>  	struct completion firmware_loading_complete;
> +	unsigned long irq_flags;
>  };
>  
>  #define GOODIX_GPIO_INT_NAME		"irq"
> @@ -61,6 +62,9 @@ struct goodix_ts_data {
>  #define GOODIX_CONFIG_967_LENGTH	228
>  
>  /* Register defines */
> +#define GOODIX_REG_COMMAND		0x8040
> +#define GOODIX_CMD_SCREEN_OFF		0x05
> +
>  #define GOODIX_READ_COOR_ADDR		0x814E
>  #define GOODIX_REG_CONFIG_DATA		0x8047
>  #define GOODIX_REG_ID			0x8140
> @@ -162,6 +166,11 @@ static int goodix_i2c_write(struct i2c_client *client, u16 reg, const u8 *buf,
>  	return ret < 0 ? ret : (ret != 1 ? -EIO : 0);
>  }
>  
> +static int goodix_i2c_write_u8(struct i2c_client *client, u16 reg, u8 value)
> +{
> +	return goodix_i2c_write(client, reg, &value, sizeof(value));
> +}
> +
>  static int goodix_get_cfg_len(u16 id)
>  {
>  	switch (id) {
> @@ -281,6 +290,18 @@ static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void goodix_free_irq(struct goodix_ts_data *ts)
> +{
> +	devm_free_irq(&ts->client->dev, ts->client->irq, ts);
> +}
> +
> +static int goodix_request_irq(struct goodix_ts_data *ts)
> +{
> +	return devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
> +					 NULL, goodix_ts_irq_handler,
> +					 ts->irq_flags, ts->client->name, ts);
> +}
> +
>  /**
>   * goodix_check_cfg - Checks if config fw is valid
>   *
> @@ -585,7 +606,6 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
>  static int goodix_configure_dev(struct goodix_ts_data *ts)
>  {
>  	int error;
> -	unsigned long irq_flags;
>  
>  	goodix_read_config(ts);
>  
> @@ -593,10 +613,8 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
>  	if (error)
>  		return error;
>  
> -	irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
> -	error = devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
> -					  NULL, goodix_ts_irq_handler,
> -					  irq_flags, ts->client->name, ts);
> +	ts->irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
> +	error = goodix_request_irq(ts);
>  	if (error) {
>  		dev_err(&ts->client->dev, "request IRQ failed: %d\n", error);
>  		return error;
> @@ -720,6 +738,73 @@ static int goodix_ts_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int __maybe_unused goodix_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct goodix_ts_data *ts = i2c_get_clientdata(client);
> +	int error;
> +
> +	/* We need gpio pins to suspend/resume */
> +	if (!ts->gpiod_int || !ts->gpiod_rst)
> +		return 0;
> +
> +	wait_for_completion(&ts->firmware_loading_complete);

This is not that nice as it may lead to angry splats from the PM core if
firmware loading takes too long and we start suspending before it
completes.

Rafael, if we issue pm_stay_awake() before requesting firmware and
pm_relax() once it is done, will this prevent the current suspend
timeouts?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
