From: Daniel Mack <daniel@caiaq.de>
Subject: Re: rotary encoder
Date: Thu, 17 Jun 2010 13:37:25 +0200
Message-ID: <20100617113725.GD17833@buzzloop.caiaq.de>
References: <7A46ED6446BE4CF7AAC51205F1B5A88B@tech>
 <20100602132031.GB2695@buzzloop.caiaq.de>
 <BA41AF5D757645AD94502E4B0A29158A@tech>
 <20100602135251.GC2695@buzzloop.caiaq.de>
 <888FDE7800AB4E278ED6DF185FEDC869@tech>
 <20100617101021.GB17833@buzzloop.caiaq.de>
 <B221BAA24375436992F7587DF15BB812@tech>
 <20100617112135.GC17833@buzzloop.caiaq.de>
 <B111F158EBCF48779A16E4EF5FAA2F84@tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:34551 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab0FQLhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jun 2010 07:37:32 -0400
Content-Disposition: inline
In-Reply-To: <B111F158EBCF48779A16E4EF5FAA2F84@tech>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Vasil'ev <tech@digiton.ru>
Cc: linux-input@vger.kernel.org

Hi Dmitriy,

Sorry, but your patch can't be reviewed that way. It removes the whole
driver and adds a complete new version, which is not what a patch should
normally do.

Could you please check out the latest sources from git, copy your
version of the driver to the tree and then run 'git diff'?

This howto can give you a good start:

  http://linux.yyz.us/git-howto.html


Also, please have a look at the file Documentation/CodingStyle,
especially because your indentation and comments are not as they should
be.

I'd be happy to give feedback, but there are some rules to follow to
make that process feasible.

Thanks,
Daniel


On Thu, Jun 17, 2010 at 03:29:51PM +0400, Dmitriy Vasil'ev wrote:
> diff -ur linux-2.6.34/Documentation/input/rotary-encoder.txt
> linux/Documentation/input/rotary-encoder.txt
> --- linux-2.6.34/Documentation/input/rotary-encoder.txt Mon May 17
> 01:17:36 2010
> +++ linux/Documentation/input/rotary-encoder.txt Thu Jun 17 13:24:14 2010
> @@ -86,16 +86,26 @@
> 
> #define GPIO_ROTARY_A 1
> #define GPIO_ROTARY_B 2
> +#define GPIO_ROTARY_S 3
> 
> static struct rotary_encoder_platform_data my_rotary_encoder_info = {
> - .steps  = 24,
> - .axis  = ABS_X,
> - .relative_axis = false,
> - .rollover = false,
> + .steps  = 1,
> + .type  = EV_KEY, //(EV_KEY, EV_REL, EV_ABS)
>  .gpio_a  = GPIO_ROTARY_A,
>  .gpio_b  = GPIO_ROTARY_B,
>  .inverted_a = 0,
>  .inverted_b = 0,
> + .codeleft = KEY_LEFT, //(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)
> + .coderight = KEY_RIGHT, //(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)
> + .rollover = 0,
> + .button  = {
> +  .code = KEY_ENTER,
> +  .gpio = GPIO_ROTARY_S,
> +  .active_low = 1,
> +  .type = EV_KEY,
> +  .debounce_interval = 10,
> +  .rep = false
> + }
> };
> 
> static struct platform_device rotary_encoder_device = {
> diff -ur linux-2.6.34/drivers/input/misc/rotary_encoder.c
> linux/drivers/input/misc/rotary_encoder.c
> --- linux-2.6.34/drivers/input/misc/rotary_encoder.c Mon May 17
> 01:17:36 2010
> +++ linux/drivers/input/misc/rotary_encoder.c Thu Jun 17 13:40:16 2010
> @@ -1,257 +1,356 @@
> -/*
> - * rotary_encoder.c
> - *
> - * (c) 2009 Daniel Mack <daniel@caiaq.de>
> - *
> - * state machine code inspired by code from Tim Ruetz
> - *
> - * A generic driver for rotary encoders connected to GPIO lines.
> - * See file:Documentation/input/rotary_encoder.txt for more information
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/input.h>
> -#include <linux/device.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio.h>
> -#include <linux/rotary_encoder.h>
> -#include <linux/slab.h>
> -
> -#define DRV_NAME "rotary-encoder"
> -
> -struct rotary_encoder {
> - struct input_dev *input;
> - struct rotary_encoder_platform_data *pdata;
> -
> - unsigned int axis;
> - unsigned int pos;
> -
> - unsigned int irq_a;
> - unsigned int irq_b;
> -
> - bool armed;
> - unsigned char dir; /* 0 - clockwise, 1 - CCW */
> -};
> -
> -static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
> -{
> - struct rotary_encoder *encoder = dev_id;
> - struct rotary_encoder_platform_data *pdata = encoder->pdata;
> - int a = !!gpio_get_value(pdata->gpio_a);
> - int b = !!gpio_get_value(pdata->gpio_b);
> - int state;
> -
> - a ^= pdata->inverted_a;
> - b ^= pdata->inverted_b;
> - state = (a << 1) | b;
> -
> - switch (state) {
> -
> - case 0x0:
> -  if (!encoder->armed)
> -   break;
> -
> -  if (pdata->relative_axis) {
> -   input_report_rel(encoder->input, pdata->axis,
> -      encoder->dir ? -1 : 1);
> -  } else {
> -   unsigned int pos = encoder->pos;
> -
> -   if (encoder->dir) {
> -    /* turning counter-clockwise */
> -    if (pdata->rollover)
> -     pos += pdata->steps;
> -    if (pos)
> -     pos--;
> -   } else {
> -    /* turning clockwise */
> -    if (pdata->rollover || pos < pdata->steps)
> -     pos++;
> -   }
> -   if (pdata->rollover)
> -    pos %= pdata->steps;
> -   encoder->pos = pos;
> -   input_report_abs(encoder->input, pdata->axis,
> -      encoder->pos);
> -  }
> -  input_sync(encoder->input);
> -
> -  encoder->armed = false;
> -  break;
> -
> - case 0x1:
> - case 0x2:
> -  if (encoder->armed)
> -   encoder->dir = state - 1;
> -  break;
> -
> - case 0x3:
> -  encoder->armed = true;
> -  break;
> - }
> -
> - return IRQ_HANDLED;
> -}
> -
> -static int __devinit rotary_encoder_probe(struct platform_device *pdev)
> -{
> - struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> - struct rotary_encoder *encoder;
> - struct input_dev *input;
> - int err;
> -
> - if (!pdata) {
> -  dev_err(&pdev->dev, "missing platform data\n");
> -  return -ENOENT;
> - }
> -
> - encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
> - input = input_allocate_device();
> - if (!encoder || !input) {
> -  dev_err(&pdev->dev, "failed to allocate memory for device\n");
> -  err = -ENOMEM;
> -  goto exit_free_mem;
> - }
> -
> - encoder->input = input;
> - encoder->pdata = pdata;
> - encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> - encoder->irq_b = gpio_to_irq(pdata->gpio_b);
> -
> - /* create and register the input driver */
> - input->name = pdev->name;
> - input->id.bustype = BUS_HOST;
> - input->dev.parent = &pdev->dev;
> -
> - if (pdata->relative_axis) {
> -  input->evbit[0] = BIT_MASK(EV_REL);
> -  input->relbit[0] = BIT_MASK(pdata->axis);
> - } else {
> -  input->evbit[0] = BIT_MASK(EV_ABS);
> -  input_set_abs_params(encoder->input,
> -         pdata->axis, 0, pdata->steps, 0, 1);
> - }
> -
> - err = input_register_device(input);
> - if (err) {
> -  dev_err(&pdev->dev, "failed to register input device\n");
> -  goto exit_free_mem;
> - }
> -
> - /* request the GPIOs */
> - err = gpio_request(pdata->gpio_a, DRV_NAME);
> - if (err) {
> -  dev_err(&pdev->dev, "unable to request GPIO %d\n",
> -   pdata->gpio_a);
> -  goto exit_unregister_input;
> - }
> -
> - err = gpio_direction_input(pdata->gpio_a);
> - if (err) {
> -  dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> -   pdata->gpio_a);
> -  goto exit_unregister_input;
> - }
> -
> - err = gpio_request(pdata->gpio_b, DRV_NAME);
> - if (err) {
> -  dev_err(&pdev->dev, "unable to request GPIO %d\n",
> -   pdata->gpio_b);
> -  goto exit_free_gpio_a;
> - }
> -
> - err = gpio_direction_input(pdata->gpio_b);
> - if (err) {
> -  dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> -   pdata->gpio_b);
> -  goto exit_free_gpio_a;
> - }
> -
> - /* request the IRQs */
> - err = request_irq(encoder->irq_a, &rotary_encoder_irq,
> -     IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> -     DRV_NAME, encoder);
> - if (err) {
> -  dev_err(&pdev->dev, "unable to request IRQ %d\n",
> -   encoder->irq_a);
> -  goto exit_free_gpio_b;
> - }
> -
> - err = request_irq(encoder->irq_b, &rotary_encoder_irq,
> -     IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> -     DRV_NAME, encoder);
> - if (err) {
> -  dev_err(&pdev->dev, "unable to request IRQ %d\n",
> -   encoder->irq_b);
> -  goto exit_free_irq_a;
> - }
> -
> - platform_set_drvdata(pdev, encoder);
> -
> - return 0;
> -
> -exit_free_irq_a:
> - free_irq(encoder->irq_a, encoder);
> -exit_free_gpio_b:
> - gpio_free(pdata->gpio_b);
> -exit_free_gpio_a:
> - gpio_free(pdata->gpio_a);
> -exit_unregister_input:
> - input_unregister_device(input);
> - input = NULL; /* so we don't try to free it */
> -exit_free_mem:
> - input_free_device(input);
> - kfree(encoder);
> - return err;
> -}
> -
> -static int __devexit rotary_encoder_remove(struct platform_device *pdev)
> -{
> - struct rotary_encoder *encoder = platform_get_drvdata(pdev);
> - struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> -
> - free_irq(encoder->irq_a, encoder);
> - free_irq(encoder->irq_b, encoder);
> - gpio_free(pdata->gpio_a);
> - gpio_free(pdata->gpio_b);
> - input_unregister_device(encoder->input);
> - platform_set_drvdata(pdev, NULL);
> - kfree(encoder);
> -
> - return 0;
> -}
> -
> -static struct platform_driver rotary_encoder_driver = {
> - .probe  = rotary_encoder_probe,
> - .remove  = __devexit_p(rotary_encoder_remove),
> - .driver  = {
> -  .name = DRV_NAME,
> -  .owner = THIS_MODULE,
> - }
> -};
> -
> -static int __init rotary_encoder_init(void)
> -{
> - return platform_driver_register(&rotary_encoder_driver);
> -}
> -
> -static void __exit rotary_encoder_exit(void)
> -{
> - platform_driver_unregister(&rotary_encoder_driver);
> -}
> -
> -module_init(rotary_encoder_init);
> -module_exit(rotary_encoder_exit);
> -
> -MODULE_ALIAS("platform:" DRV_NAME);
> -MODULE_DESCRIPTION("GPIO rotary encoder driver");
> -MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
> -MODULE_LICENSE("GPL v2");
> -
> +/*
> + * rotary_encoder.c
> + *
> + * (c) 2009 Daniel Mack <daniel@caiaq.de>
> + *
> + * state machine code inspired by code from Tim Ruetz
> + *
> + * A generic driver for rotary encoders connected to GPIO lines.
> + * See file:Documentation/input/rotary_encoder.txt for more information
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/rotary_encoder.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +#include <linux/sched.h>
> +
> +#define DRV_NAME "rotary-encoder"
> +
> +struct rotary_encoder_button_data {
> + struct rotary_encoder_button button;
> + unsigned int irq;
> + struct timer_list timer;
> + struct work_struct work;
> +};
> +
> +struct rotary_encoder {
> + struct input_dev *input;
> + struct rotary_encoder_platform_data *pdata;
> +
> + unsigned int pos;
> +
> + unsigned int irq_a;
> + unsigned int irq_b;
> +
> + bool armed;
> + unsigned char dir; /* 0 - clockwise, 1 - CCW */
> +
> + struct rotary_encoder_button_data bdata;
> +};
> +
> +static struct rotary_encoder* encoder;
> +
> +static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
> +{
> + struct rotary_encoder *encoder = dev_id;
> + struct rotary_encoder_platform_data *pdata = encoder->pdata;
> + int a = !!gpio_get_value(pdata->gpio_a);
> + int b = !!gpio_get_value(pdata->gpio_b);
> + int state;
> +
> + a ^= pdata->inverted_a;
> + b ^= pdata->inverted_b;
> + state = (a << 1) | b;
> +
> + switch (state) {
> +
> + case 0x0:
> +  if (!encoder->armed)
> +   break;
> +
> +  if (pdata->type == EV_REL) {
> +   input_report_rel(encoder->input, pdata->codeleft,
> +      encoder->dir ? -1 : 1);
> +  } else
> +  if (pdata->type == EV_ABS) {
> +   unsigned int pos = encoder->pos;
> +
> +   if (encoder->dir) {
> +    /* turning counter-clockwise */
> +    if (pdata->rollover)
> +     pos += pdata->steps;
> +    if (pos)
> +     pos--;
> +   } else {
> +    /* turning clockwise */
> +    if (pdata->rollover || pos < pdata->steps)
> +     pos++;
> +   }
> +   if (pdata->rollover)
> +    pos %= pdata->steps;
> +   encoder->pos = pos;
> +   input_report_abs(encoder->input, pdata->codeleft,
> +      encoder->pos);
> +  } else
> +  if (pdata->type == EV_KEY)
> +  {
> +   input_report_key(encoder->input, encoder->dir ? pdata->codeleft
> : pdata->coderight, 1);
> +   input_sync(encoder->input);
> +   input_report_key(encoder->input, encoder->dir ? pdata->codeleft
> : pdata->coderight, 0);
> +   input_sync(encoder->input);
> +  }
> +
> +  encoder->armed = false;
> +  break;
> +
> + case 0x1:
> + case 0x2:
> +  if (encoder->armed)
> +   encoder->dir = state - 1;
> +  break;
> +
> + case 0x3:
> +  encoder->armed = true;
> +  break;
> + }
> +
> + return IRQ_HANDLED;
> +}
> +
> +static void rotary_encoder_report_event(struct rotary_encoder *encoder)
> +{
> + struct rotary_encoder_button *button = &(encoder->bdata.button);
> + struct input_dev *input = encoder->input;
> + int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
> +
> + input_event(input, EV_KEY, button->code, !!state);
> + input_sync(input);
> +}
> +
> +static void rotary_encoder_work_func(struct work_struct *work)
> +{
> + struct rotary_encoder *encoder =
> +  container_of(work, struct rotary_encoder, bdata.work);
> +
> + rotary_encoder_report_event(encoder);
> +}
> +
> +static void rotary_encoder_timer(unsigned long _data)
> +{
> + struct rotary_encoder *encoder = (struct rotary_encoder *)_data;
> +
> + schedule_work(&encoder->bdata.work);
> +}
> +
> +static irqreturn_t rotary_encoder_key_irq(int irq, void *dev_id)
> +{
> + struct rotary_encoder *encoder = dev_id;
> + struct rotary_encoder_button_data *bdata = &encoder->bdata;
> + struct rotary_encoder_button *button = &bdata->button;
> +
> + if (button->debounce_interval)
> +  mod_timer(&bdata->timer,
> +   jiffies + msecs_to_jiffies(button->debounce_interval));
> + else
> +  schedule_work(&bdata->work);
> +
> + return IRQ_HANDLED;
> +}
> +
> +static int __devinit rotary_encoder_probe(struct platform_device *pdev)
> +{
> + struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> + struct rotary_encoder *encoder;
> + struct input_dev *input;
> + int err;
> +
> + if (!pdata) {
> +  dev_err(&pdev->dev, "missing platform data\n");
> +  return -ENOENT;
> + }
> +
> + encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
> + input = input_allocate_device();
> + if (!encoder || !input) {
> +  dev_err(&pdev->dev, "failed to allocate memory for device\n");
> +  err = -ENOMEM;
> +  goto exit_free_mem;
> + }
> +
> + encoder->input = input;
> + encoder->pdata = pdata;
> + encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> + encoder->irq_b = gpio_to_irq(pdata->gpio_b);
> + encoder->bdata.irq = gpio_to_irq(pdata->button.gpio);
> +
> + /* create and register the input driver */
> + input->name = pdev->name;
> + input->id.bustype = BUS_HOST;
> + input->dev.parent = &pdev->dev;
> +
> + /* Enable auto repeat feature of Linux input subsystem */
> + if (pdata->button.rep)
> +  set_bit(EV_REP, input->evbit);
> +
> + encoder->bdata.button = pdata->button;
> + //input_set_capability(input, EV_KEY, bdata->button.code);
> +
> + set_bit(pdata->type, input->evbit);
> + set_bit(pdata->codeleft, input->keybit);
> + set_bit(pdata->coderight, input->keybit);
> + //
> + set_bit(encoder->bdata.button.type, input->evbit);
> + set_bit(encoder->bdata.button.code, input->keybit);
> +
> + setup_timer(&encoder->bdata.timer, rotary_encoder_timer, (unsigned
> long)encoder);
> + INIT_WORK(&encoder->bdata.work, rotary_encoder_work_func);
> +
> + err = input_register_device(input);
> + if (err) {
> +  dev_err(&pdev->dev, "failed to register input device\n");
> +  goto exit_free_mem;
> + }
> +
> + /* request the GPIOs */
> + err = gpio_request(pdata->gpio_a, DRV_NAME);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to request GPIO %d\n",
> +   pdata->gpio_a);
> +  goto exit_unregister_input;
> + }
> +
> + err = gpio_direction_input(pdata->gpio_a);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +   pdata->gpio_a);
> +  goto exit_unregister_input;
> + }
> +
> + err = gpio_request(pdata->gpio_b, DRV_NAME);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to request GPIO %d\n",
> +   pdata->gpio_b);
> +  goto exit_free_gpio_a;
> + }
> +
> + err = gpio_direction_input(pdata->gpio_b);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +   pdata->gpio_b);
> +  goto exit_free_gpio_a;
> + }
> +
> + err = gpio_request(pdata->button.gpio, DRV_NAME);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to request GPIO %d\n",
> +   pdata->button.gpio);
> +  goto exit_free_gpio_b;
> + }
> +
> + err = gpio_direction_input(pdata->button.gpio);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
> +   pdata->button.gpio);
> +  goto exit_free_gpio_b;
> + }
> +
> + /* request the IRQs */
> + err = request_irq(encoder->irq_a, &rotary_encoder_irq,
> +     IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> +     DRV_NAME, encoder);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to request IRQ %d\n",
> +   encoder->irq_a);
> +  goto exit_free_gpio_s;
> + }
> +
> + err = request_irq(encoder->irq_b, &rotary_encoder_irq,
> +     IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> +     DRV_NAME, encoder);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to request IRQ %d\n",
> +   encoder->irq_b);
> +  goto exit_free_irq_a;
> + }
> +
> + err = request_irq(encoder->bdata.irq, &rotary_encoder_key_irq,
> +     IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> +     DRV_NAME, encoder);
> + if (err) {
> +  dev_err(&pdev->dev, "unable to request IRQ %d\n",
> +   encoder->bdata.irq);
> +  goto exit_free_irq_b;
> + }
> +
> + platform_set_drvdata(pdev, encoder);
> +
> + return 0;
> +exit_free_irq_b:
> + free_irq(encoder->irq_b, encoder);
> +exit_free_irq_a:
> + free_irq(encoder->irq_a, encoder);
> +exit_free_gpio_s:
> + gpio_free(pdata->button.gpio);
> +exit_free_gpio_b:
> + gpio_free(pdata->gpio_b);
> +exit_free_gpio_a:
> + gpio_free(pdata->gpio_a);
> +exit_unregister_input:
> + input_unregister_device(input);
> + input = NULL; /* so we don't try to free it */
> +exit_free_mem:
> + input_free_device(input);
> + kfree(encoder);
> + return err;
> +}
> +
> +static int __devexit rotary_encoder_remove(struct platform_device *pdev)
> +{
> + struct rotary_encoder *encoder = platform_get_drvdata(pdev);
> + struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> +
> + free_irq(encoder->irq_a, encoder);
> + free_irq(encoder->irq_b, encoder);
> + free_irq(encoder->bdata.irq, encoder);
> + if (pdata->button.debounce_interval)
> +  del_timer_sync(&encoder->bdata.timer);
> + cancel_work_sync(&encoder->bdata.work);
> + gpio_free(pdata->gpio_a);
> + gpio_free(pdata->gpio_b);
> + gpio_free(pdata->button.gpio);
> + input_unregister_device(encoder->input);
> + platform_set_drvdata(pdev, NULL);
> + kfree(encoder);
> +
> + return 0;
> +}
> +
> +static struct platform_driver rotary_encoder_driver = {
> + .probe  = rotary_encoder_probe,
> + .remove  = __devexit_p(rotary_encoder_remove),
> + .driver  = {
> +  .name = DRV_NAME,
> +  .owner = THIS_MODULE,
> + }
> +};
> +
> +static int __init rotary_encoder_init(void)
> +{
> + return platform_driver_register(&rotary_encoder_driver);
> +}
> +
> +static void __exit rotary_encoder_exit(void)
> +{
> + platform_driver_unregister(&rotary_encoder_driver);
> +}
> +
> +module_init(rotary_encoder_init);
> +module_exit(rotary_encoder_exit);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_DESCRIPTION("GPIO rotary encoder driver");
> +MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
> +MODULE_LICENSE("GPL v2");
> +
> diff -ur linux-2.6.34/include/linux/rotary_encoder.h
> linux/include/linux/rotary_encoder.h
> --- linux-2.6.34/include/linux/rotary_encoder.h Mon May 17 01:17:36 2010
> +++ linux/include/linux/rotary_encoder.h Thu Jun 17 14:23:26 2010
> @@ -1,15 +1,28 @@
> #ifndef __ROTARY_ENCODER_H__
> #define __ROTARY_ENCODER_H__
> 
> +struct rotary_encoder_button {
> + /* Configuration parameters */
> + u16 code;  /* input event code (KEY_*, SW_*) */
> + int gpio;
> + int active_low;
> + //char *desc;
> + u16 type;  /* input event type (EV_KEY, EV_SW) */
> + int debounce_interval; /* debounce ticks interval in msecs */
> + bool rep;/* enable input subsystem auto repeat */
> +};
> +
> struct rotary_encoder_platform_data {
>  unsigned int steps;
> - unsigned int axis;
> + u16 type; /*(EV_KEY, EV_REL, EV_ABS)*/
>  unsigned int gpio_a;
>  unsigned int gpio_b;
>  unsigned int inverted_a;
>  unsigned int inverted_b;
> - bool relative_axis;
> + u16 codeleft; /*(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)*/
> + u16 coderight; /*(REL_X, REL_Y, ABS_X, ABS_Y, KEY_...)*/
>  bool rollover;
> + struct rotary_encoder_button button;
> };
> 
> #endif /* __ROTARY_ENCODER_H__ */
> 
> ----- Original Message ----- From: "Daniel Mack" <daniel@caiaq.de>
> To: "Dmitriy Vasil'ev" <tech@digiton.ru>
> Cc: <linux-input@vger.kernel.org>
> Sent: Thursday, June 17, 2010 3:21 PM
> Subject: Re: rotary encoder
> 
> 
> >On Thu, Jun 17, 2010 at 02:48:08PM +0400, Dmitriy Vasil'ev wrote:
> >>I added .diff file.
> >>I am sorry, but I can do it only for kernel version 2.6.34
> >>See attach.
> >
> >Please, just put the patch inline, not as attachment and not zipped.
> >That way, the patch can be commented line-by-line.
> >
> >Thanks,
> >Daniel
> 
