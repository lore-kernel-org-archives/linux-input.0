From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: keyboard: MCS5080: support suspend/resume.
Date: Mon, 15 Nov 2010 00:32:35 -0800
Message-ID: <20101115083235.GA11594@core.coreip.homeip.net>
References: <4CE0B7B1.6060404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45458 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757753Ab0KOIcl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 03:32:41 -0500
Received: by iwn10 with SMTP id 10so6428589iwn.19
        for <linux-input@vger.kernel.org>; Mon, 15 Nov 2010 00:32:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE0B7B1.6060404@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Kim, HeungJun" <riverful.kim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi Kim,

On Mon, Nov 15, 2010 at 01:31:45PM +0900, Kim, HeungJun wrote:
> This patch supports suspend/resume functions for mcs5080 touchkey
> driver.
> 
> Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/mcs_touchkey.c |   41 +++++++++++++++++++++++++++++++++
>  include/linux/i2c/mcs.h               |    1 +
>  2 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 63b849d..06385f5 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -45,6 +45,8 @@ struct mcs_touchkey_chip {
>  };
> 
>  struct mcs_touchkey_data {
> +       void (*poweron)(int);

int (*poweron)(bool);

The method must be able to signal errors.

> +
>         struct i2c_client *client;
>         struct input_dev *input_dev;
>         struct mcs_touchkey_chip chip;
> @@ -168,6 +170,8 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
> 
>         if (pdata->cfg_pin)
>                 pdata->cfg_pin();
> +       if (pdata->poweron)
> +               data->poweron = pdata->poweron;
> 
>         error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
>                         IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
> @@ -202,6 +206,41 @@ static int __devexit mcs_touchkey_remove(struct i2c_client *client)
>         return 0;
>  }
> 
> +#ifdef CONFIG_PM
> +static int mcs_touchkey_suspend(struct i2c_client *client, pm_message_t mesg)

Newer code should use dev_pm_ops please.
`
> +{
> +       struct mcs_touchkey_data *data = i2c_get_clientdata(client);
> +
> +       /* Disable the work */
> +       disable_irq(client->irq);
> +
> +       /* Don't I2C operation since we don't know I2C bus is dead already */

? I am not quite sure what you are trying to say here...

> +
> +       /* Finally turn off the power */
> +       if (data->poweron)
> +               data->poweron(0);
> +
> +       return 0;
> +}
> +
> +static int mcs_touchkey_resume(struct i2c_client *client)
> +{
> +       struct mcs_touchkey_data *data = i2c_get_clientdata(client);
> +
> +       /* Enable the device first */
> +       if (data->poweron)
> +               data->poweron(1);
> +
> +       /* Enable irq again */
> +       enable_irq(client->irq);
> +
> +       return 0;
> +}
> +#else
> +#define mcs_touchkey_suspend   NULL
> +#define mcs_touchkey_resume    NULL
> +#endif
> +
>  static const struct i2c_device_id mcs_touchkey_id[] = {
>         { "mcs5000_touchkey", MCS5000_TOUCHKEY },
>         { "mcs5080_touchkey", MCS5080_TOUCHKEY },
> @@ -216,6 +255,8 @@ static struct i2c_driver mcs_touchkey_driver = {
>         },
>         .probe          = mcs_touchkey_probe,
>         .remove         = __devexit_p(mcs_touchkey_remove),
> +       .suspend        = mcs_touchkey_suspend,
> +       .resume         = mcs_touchkey_resume,
>         .id_table       = mcs_touchkey_id,
>  };
> 
> diff --git a/include/linux/i2c/mcs.h b/include/linux/i2c/mcs.h
> index 725ae7c..c4a3869 100644
> --- a/include/linux/i2c/mcs.h
> +++ b/include/linux/i2c/mcs.h
> @@ -18,6 +18,7 @@
>  #define MCS_KEY_CODE(v)                ((v) & 0xffff)
> 
>  struct mcs_platform_data {
> +       void (*poweron)(int);
>         void (*cfg_pin)(void);
> 
>         /* touchscreen */
> --
> 1.7.0.4

Shouldn't you call poweron() at driver bind and unbind time (if you do not want to
supply open() and close() methods which wold be the best option)?

Thanks.

-- 
Dmitry
