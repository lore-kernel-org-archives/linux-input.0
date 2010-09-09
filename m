From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [Patch v2] input:rohm based bu21013 touch panel controller driver
 support
Date: Thu, 09 Sep 2010 17:40:41 +0530
Message-ID: <4C88CEC1.1010209@codeaurora.org>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:35628 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab0IIMKq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 08:10:46 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Naveen,

On 9/9/2010 5:06 PM, Naveen Kumar GADDIPATI wrote:
> Hi Dmitry,
> 
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Added the ROHM based bu21013 capacitive touch panel controller
> driver support with i2c interface.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> ---
> Modifications in v2:
>         --Updated with the Dmitry comments on Patch v1
>         --Updated with the Trilok comments on Patch v1

Thanks for the updates. Few comments.

> +
> +/**
> + * bu21013_report_pen_down() - reports the pen down event
> + * @data:bu21013_ts_data structure pointer

One space after ":" right? Applies to whole patch.

> + * @count:touch count
> + *
> + * This function used to report the pen down interrupt to
> + * input subsystem and returns none
> + */
> +static void bu21013_report_pen_down(struct bu21013_ts_data *data, int count)
> +{
> +       int i;
> +
> +       input_report_abs(data->in_dev, ABS_X, data->x_pos[0]);
> +       input_report_abs(data->in_dev, ABS_Y, data->y_pos[0]);
> +       input_report_key(data->in_dev, BTN_TOUCH, count);
> +
> +       if (data->chip->multi_touch) {
> +               for (i = 0; i < count; i++) {
> +                       input_report_abs(data->in_dev, ABS_MT_POSITION_X,
> +                                                       data->x_pos[i]);
> +                       input_report_abs(data->in_dev, ABS_MT_POSITION_Y,
> +                                                       data->y_pos[i]);

Wondering why you don't need to report TOUCH_MAJOR and WIDTH_MAJOR?

> +static int bu21013_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +       struct bu21013_ts_data *bu21013_data = i2c_get_clientdata(client);
> +
> +       bu21013_data->touch_stopped = true;
> +       wake_up(&bu21013_data->wait);
> +       if (device_may_wakeup(&client->dev))

I don't find the device_init_wakeup call in the probe function.

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
> +       if (!i2c) {
> +               dev_err(&i2c->dev, "i2c client not defined\n");
> +               retval = -EINVAL;
> +               return retval;
> +       }

Do we think this will ever happen?

Please also add i2c_check_functionality call.

> +
> +static struct i2c_driver bu21013_driver = {
> +       .driver = {
> +               .name   =       DRIVER_TP,
> +               .owner  =       THIS_MODULE,
> +       },
> +       .probe          =       bu21013_probe,
> +#ifdef CONFIG_PM
> +       .suspend        =       bu21013_suspend,
> +       .resume         =       bu21013_resume,
> +#endif

Better to move these suspend and resume to dev_pm_ops.

> +       .remove         =       __devexit_p(bu21013_remove),
> +       .id_table       =       bu21013_id,
> +};
> +

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
