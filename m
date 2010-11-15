From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: keyboard: MCS5080: support led blink when
 it's touched.
Date: Mon, 15 Nov 2010 00:36:40 -0800
Message-ID: <20101115083640.GA14559@core.coreip.homeip.net>
References: <4CE0B81A.9030501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58399 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0KOIgr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 03:36:47 -0500
Received: by iwn10 with SMTP id 10so6432329iwn.19
        for <linux-input@vger.kernel.org>; Mon, 15 Nov 2010 00:36:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE0B81A.9030501@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Kim, HeungJun" <riverful.kim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com

On Mon, Nov 15, 2010 at 01:33:30PM +0900, Kim, HeungJun wrote:
> This patch supports touchkey led blinking. The touchkey led lights
> on as soon as it touched. After LED_TIME, the led lights-off.
> 

I do not think it should be kept in the driver... Not everyone might
want that, for starters. I wonder if it needs to be plugged into LED
layer and then keyboard input might be used as a trigger for that LED.

Thanks.


> Signed-off-by: Heungjun Kim <riverful.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/input/keyboard/mcs_touchkey.c |   39 +++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 931b28c..e3fd31f 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -19,6 +19,7 @@
>  #include <linux/input.h>
>  #include <linux/irq.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
> 
>  /* MCS5000 Touchkey */
>  #define MCS5000_TOUCHKEY_STATUS                0x04
> @@ -32,6 +33,8 @@
>  #define MCS5080_TOUCHKEY_FW            0x01
>  #define MCS5080_TOUCHKEY_BASE_VAL      0x1
> 
> +#define LED_TIME                       500
> +
>  enum mcs_touchkey_type {
>         MCS5000_TOUCHKEY,
>         MCS5080_TOUCHKEY,
> @@ -46,6 +49,8 @@ struct mcs_touchkey_chip {
> 
>  struct mcs_touchkey_data {
>         void (*poweron)(int);
> +       struct delayed_work work;
> +       int suspended;
> 
>         struct i2c_client *client;
>         struct input_dev *input_dev;
> @@ -55,6 +60,30 @@ struct mcs_touchkey_data {
>         unsigned short keycodes[];
>  };
> 
> +static void mcs_touchkey_led(struct mcs_touchkey_data *data, int on)
> +{
> +       unsigned char buf;
> +
> +       if (data->suspended)
> +               return;
> +
> +       if (on)
> +               buf = 0x1;
> +       else
> +               buf = 0x2;
> +       i2c_master_send(data->client, &buf, 1);
> +}
> +
> +static void mcs_touchkey_work(struct work_struct *work)
> +{
> +       struct delayed_work *dw = to_delayed_work(work);
> +       struct mcs_touchkey_data *data;
> +
> +       data = container_of(dw, struct mcs_touchkey_data, work);
> +
> +       mcs_touchkey_led(data, 0);
> +}
> +
>  static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
>  {
>         struct mcs_touchkey_data *data = dev_id;
> @@ -89,6 +118,14 @@ static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
>         input_report_key(input, data->key_code, pressed);
>         input_sync(input);
> 
> +       if (pressed) {
> +               cancel_work_sync(&data->work.work);
> +               mcs_touchkey_led(data, 1);
> +       } else {
> +               if (!delayed_work_pending(&data->work))
> +                       schedule_delayed_work(&data->work, msecs_to_jiffies(LED_TIME));
> +       }
> +
>         dev_dbg(&client->dev, "key %d %d %s\n", data->key_val, data->key_code,
>                 pressed ? "pressed" : "released");
> 
> @@ -173,6 +210,8 @@ static int __devinit mcs_touchkey_probe(struct i2c_client *client,
>         if (pdata->poweron)
>                 data->poweron = pdata->poweron;
> 
> +       INIT_DELAYED_WORK(&data->work, mcs_touchkey_work);
> +
>         error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
>                         IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
>         if (error) {
> --
> 1.7.0.4

-- 
Dmitry
