From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [Patch v1] input:rohm based bu21013 touch panel controller driver
 support
Date: Wed, 08 Sep 2010 16:15:10 +0530
Message-ID: <4C876936.8090708@codeaurora.org>
References: <81C3A93C17462B4BBD7E272753C1057916DE7CC963@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:40607 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942Ab0IHKp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 06:45:28 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057916DE7CC963@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Naveen,

On 9/8/2010 3:54 PM, Naveen Kumar GADDIPATI wrote:
> Hi Dmitry,
> 
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Added the ROHM based bu21013 capacitive touch panel controller
> driver support with i2c interface.
> 
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> ---
> Modifications in v1:
>         --Updated with the Dmitry comments on Patch 0, but fuzz is not used to get the
>                 delta between two co-ordinates in multi touch.
>         --Updated with the Trilok comments on Patch 0

Thanks for the updates.

> 
> +config TOUCHSCREEN_BU21013
> +       tristate "BU21013 based touch panel controllers"
> +       depends on I2C
> +       help
> +         Say Y here if you have a bu21013 touchscreen connected to
> +         your system.
> +
> +         If unsure, say N.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called bu21013_ts.
> +

Dmitry, we do follow the alphabetical order for Kconfig and Makefile for touchscreen folder, right?

> +
> +/**
> + * bu21013_report_pen_down() - reports the pen down event
> + * @data:bu21013_ts_data structure pointer
> + * @count:touch count
> + *
> + * This function used to report the pen down interrupt to
> + * input subsystem and returns none
> + */
> +static void bu21013_report_pen_down(struct bu21013_ts_data *data, int count)
> +{
> +       input_report_abs(data->in_dev, ABS_X, data->x_pos[0]);
> +       input_report_abs(data->in_dev, ABS_Y, data->y_pos[0]);
> +       input_report_key(data->in_dev, BTN_TOUCH, 1);
> +
> +       if (data->chip->multi_touch) {
> +               if (count > 1)
> +                       input_report_key(data->in_dev, BTN_2, 1);

Dmitry,

Do you prefer the method of supporting ST and MT like the code above? My preference
would be to keep only MT, because the chip supports MT.

> +
> +               input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +                                                       data->x_pos[0]);
> +               input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +                                                       data->y_pos[0]);
> +               input_mt_sync(data->in_dev);
> +
> +               if (count > 1) {
> +                       input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +                                                               data->x_pos[1]);
> +                       input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +                                                               data->y_pos[1]);
> +                       input_mt_sync(data->in_dev);
> +               }
> +       }
> +       input_sync(data->in_dev);
> +       data->previous_press_reported = count;
> +}
> +/**
> + * bu21013_report_pen_up() - reports the pen up event
> + * @data:bu21013_ts_data structure pointer
> + *
> + * This function used to report the pen up interrupt
> + * to input subsystem and returns none
> + */
> +static void bu21013_report_pen_up(struct bu21013_ts_data *data)
> +{
> +       input_report_key(data->in_dev, BTN_TOUCH, 0);
> +       if (data->chip->multi_touch) {
> +               input_report_key(data->in_dev, BTN_2, 0);

Let's wait for Dmitry to comment on the above question, and we can take it from there.

> +               input_mt_sync(data->in_dev);
> +       }
> +       input_sync(data->in_dev);
> +       data->previous_press_reported = 0;
> +}

> +}
> +
> +/**
> + * bu21013_gpio_irq() - gpio thread function for touch interrupt
> + * @irq: irq value
> + * @device_data:void pointer
> + *
> + * This gpio thread function for touch interrupt
> + * and returns irqreturn_t.
> + */
> +static irqreturn_t bu21013_gpio_irq(int irq, void *device_data)
> +{
> +       struct bu21013_ts_data *data = (struct bu21013_ts_data *)device_data;

casting not needed.

> +       struct i2c_client *i2c = data->client;
> +       int retval;
> +
> +       do {
> +               retval = bu21013_do_touch_report(data);
> +               if (retval < 0) {
> +                       dev_err(&i2c->dev, "bu21013_do_touch_report failed\n");
> +                       return IRQ_NONE;
> +               }
> +
> +               data->intr_pin = data->chip->irq_read_val();
> +               if (data->intr_pin == PEN_DOWN_INTR)
> +                       wait_event_timeout(data->wait, data->touch_stopped,
> +                                                       msecs_to_jiffies(10));
> +       } while (!data->intr_pin && !data->touch_stopped);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +

> +#ifdef CONFIG_PM
> +/**
> + * bu21013_suspend() - suspend the touch screen controller
> + * @client: pointer to i2c client structure
> + * @mesg: message from power manager
> + *
> + * This funtion is used to suspend the
> + * touch panel controller and returns integer
> + */
> +static int bu21013_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +       struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
> +
> +       bu21013_data->touch_stopped = true;

I will come back on this shortly after looking at the code which uses this flag, and
why it doesn't need locks.

> +static int __devinit bu21013_probe(struct i2c_client *i2c,
> +                                       const struct i2c_device_id *id)
> +{
> +       int retval;
> +       struct bu21013_ts_data *bu21013_data;
> +       struct input_dev *in_dev;
> +       short x_max;
> +       short y_max;
> +       struct bu21013_platform_device *pdata = i2c->dev.platform_data;
> +

Please add i2c_check_functionality check.

> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("NAVEEN KUMAR G");

E-mail address please.

> +MODULE_DESCRIPTION("bu21013 touch screen controller driver");

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
