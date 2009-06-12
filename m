From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH]input: Change timer function to workqueue for gpio_keys
	driver
Date: Fri, 12 Jun 2009 23:10:48 +0530
Message-ID: <5d5443650906121040n3f36c99eka01f5eb5274ee6ff@mail.gmail.com>
References: <20090608152420.0e76c302@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765032AbZFLRk5@vger.kernel.org>
In-Reply-To: <20090608152420.0e76c302@dxy.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, ben-linux@fluff.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Alek,

>
> From 35101ecc80cfc638ac80a2cea590ab86135be395 Mon Sep 17 00:00:00 200=
1
> From: Alek Du <alek.du@intel.com>
> Date: Fri, 8 May 2009 12:25:34 +0800
> Subject: [PATCH] input: Change timer function to workqueue for gpio_k=
eys driver
>
> The gpio_get_value function of I2C/SPI GPIO expander may sleep thus t=
his
> function call can not be called in a timer function.
>
> Signed-off-by: Alek Du <alek.du@intel.com>
> ---
> =A0drivers/input/keyboard/gpio_keys.c | =A0 32 ++++++++++++++--------=
----------
> =A01 files changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index ad67d76..9205ac6 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -22,13 +22,17 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/input.h>
> =A0#include <linux/gpio_keys.h>
> +#include <linux/workqueue.h>
>
> =A0#include <asm/gpio.h>
>
> =A0struct gpio_button_data {
> =A0 =A0 =A0 =A0struct gpio_keys_button *button;
> =A0 =A0 =A0 =A0struct input_dev *input;
> - =A0 =A0 =A0 struct timer_list timer;
> +/* Change timer func to workqueue func due to the fact that gpio_get=
_value
> + * may sleep for some i2c and spi GPIO expander
> + */

This is anyway goes into commit text and git history, so I don't see
any additional value in keeping this comment here. Patch looks good
otherwise, but it is better if someone can verify this driver having
direct gpio keys.

> + =A0 =A0 =A0 struct delayed_work work;
> =A0};
>
> =A0struct gpio_keys_drvdata {
> @@ -36,8 +40,10 @@ struct gpio_keys_drvdata {
> =A0 =A0 =A0 =A0struct gpio_button_data data[0];
> =A0};
>
> -static void gpio_keys_report_event(struct gpio_button_data *bdata)
> +static void gpio_keys_report_event(struct work_struct *work)
> =A0{
> + =A0 =A0 =A0 struct gpio_button_data *bdata =3D container_of(work,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_button_data=
, work.work);
> =A0 =A0 =A0 =A0struct gpio_keys_button *button =3D bdata->button;
> =A0 =A0 =A0 =A0struct input_dev *input =3D bdata->input;
> =A0 =A0 =A0 =A0unsigned int type =3D button->type ?: EV_KEY;
> @@ -47,13 +53,6 @@ static void gpio_keys_report_event(struct gpio_but=
ton_data *bdata)
> =A0 =A0 =A0 =A0input_sync(input);
> =A0}
>
> -static void gpio_check_button(unsigned long _data)
> -{
> - =A0 =A0 =A0 struct gpio_button_data *data =3D (struct gpio_button_d=
ata *)_data;
> -
> - =A0 =A0 =A0 gpio_keys_report_event(data);
> -}
> -
> =A0static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> =A0{
> =A0 =A0 =A0 =A0struct gpio_button_data *bdata =3D dev_id;
> @@ -62,10 +61,10 @@ static irqreturn_t gpio_keys_isr(int irq, void *d=
ev_id)
> =A0 =A0 =A0 =A0BUG_ON(irq !=3D gpio_to_irq(button->gpio));
>
> =A0 =A0 =A0 =A0if (button->debounce_interval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&bdata->timer,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies + msecs_to_jiff=
ies(button->debounce_interval));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_delayed_work(&bdata->work,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(button=
->debounce_interval));
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_keys_report_event(bdata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&bdata->work.work);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -112,8 +111,7 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata->input =3D input;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata->button =3D button;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 setup_timer(&bdata->timer,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_check_butt=
on, (unsigned long)bdata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_DELAYED_WORK(&bdata->work, gpio_ke=
ys_report_event);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D gpio_request(button->gpio, b=
utton->desc ?: "gpio_keys");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error < 0) {
> @@ -173,8 +171,7 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
> =A0fail2:
> =A0 =A0 =A0 =A0while (--i >=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(gpio_to_irq(pdata->buttons[i]=
=2Egpio), &ddata->data[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->buttons[i].debounce_interval=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&ddata->=
data[i].timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&ddata->data[i=
].work);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->buttons[i].gpio);
> =A0 =A0 =A0 =A0}
>
> @@ -198,8 +195,7 @@ static int __devexit gpio_keys_remove(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int irq =3D gpio_to_irq(pdata->buttons=
[i].gpio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(irq, &ddata->data[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->buttons[i].debounce_interval=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&ddata->=
data[i].timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&ddata->data[i=
].work);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->buttons[i].gpio);
> =A0 =A0 =A0 =A0}
>
> --
> 1.6.0.4
>


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
