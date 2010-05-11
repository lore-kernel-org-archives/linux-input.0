From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Rotary encoder
Date: Tue, 11 May 2010 16:17:33 +0200
Message-ID: <20100511141733.GX30801@buzzloop.caiaq.de>
References: <4BE96550.9020800@solutionsradio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:50637 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0EKORz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 10:17:55 -0400
Content-Disposition: inline
In-Reply-To: <4BE96550.9020800@solutionsradio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jelle Martijn Kok <jmkok@solutionsradio.com>
Cc: linux-input@vger.kernel.org

Hi Jelle,

(please Cc: linux-input ML for such questions, as I'm not the only one
 decide about that topic ... )

On Tue, May 11, 2010 at 04:10:24PM +0200, Jelle Martijn Kok wrote:
> I saw you had contributed code for the rotary encoder.
> We made a similar device driver, but with some differences.

Good to see more users of the driver, and merging back your changes is
definitely appreciated.

> The differences:
> - We increase and decrease on every "00" and "11"
> - We send out input events "KEY_VOLUMEDOWN" and "KEY_VOLUMEUP".
> 
> So I made some changes to the rotary encoder files, that adds this
> functionality.
> Changes to the header file:
> - "steps" is replaced by "initial_value" "min_value" and "max_value"
> - "event_up" and "event_down" is added
> 
> "rotary_encoder.c" is modified such way that it matches these changes.
> 
> My questions:
> - Is the removal of the "steps" field an issue for compatibility ?

Yes. This driver has active users, so all changes should be
backwards-compatible. We could introduce an "initial_value", but I'm
against deprecating the "steps" parameter.

> - "relative mode" and the "key events" are quite similar, is this "ugly ?

No, they're not. One is an axis information, the other one is a button.
I have no problem adding the feature for button event generation,
though.

> - Are you willing to make these updates to the kernel ?

Could you send your changes as patch against the current kernel's git
HEAD please? That's much easier to review.

Thanks,
Daniel


> #ifndef __ROTARY_ENCODER_H__
> #define __ROTARY_ENCODER_H__
> 
> struct rotary_encoder_platform_data {
> 	unsigned int gpio_a;
> 	unsigned int gpio_b;
> 	unsigned int inverted_a;
> 	unsigned int inverted_b;
> 	unsigned int axis;
> 	unsigned int initial_value;
> 	unsigned int min_value;
> 	unsigned int max_value;
> 	unsigned int event_up;
> 	unsigned int event_down;
> 	bool relative_axis;
> 	bool rollover;
> };
> 
> #endif /* __ROTARY_ENCODER_H__ */

> /*
>  * rotary_encoder.c
>  *
>  * (c) 2009 Daniel Mack <daniel@caiaq.de>
>  *
>  * state machine code inspired by code from Tim Ruetz
>  *
>  * A generic driver for rotary encoders connected to GPIO lines.
>  * See file:Documentation/input/rotary_encoder.txt for more information
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License version 2 as
>  * published by the Free Software Foundation.
>  */
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/interrupt.h>
> #include <linux/input.h>
> #include <linux/device.h>
> #include <linux/platform_device.h>
> #include <linux/gpio.h>
> #include <linux/rotary_encoder.h>
> 
> #define DRV_NAME "rotary-encoder"
> 
> struct rotary_encoder {
> 	struct input_dev *input;
> 	struct rotary_encoder_platform_data *pdata;
> 
> 	unsigned int axis;
> 	unsigned int pos;
> 
> 	unsigned int irq_a;
> 	unsigned int irq_b;
> 
> 	int last_state;
> 	//~ bool armed;
> 	//~ unsigned char dir;	/* 0 - clockwise, 1 - CCW */
> };
> 
> static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
> {
> 	struct rotary_encoder *encoder = dev_id;
> 	struct rotary_encoder_platform_data *pdata = encoder->pdata;
> 	int a = !!gpio_get_value(pdata->gpio_a);
> 	int b = !!gpio_get_value(pdata->gpio_b);
> 	int state;
> 
> 	a ^= pdata->inverted_a;
> 	b ^= pdata->inverted_b;
> 	state = (a << 1) | b;
> 
> 	// Only process in the rest states
> 	if (((state == 0x0) || (state == 0x3)) && ((encoder->last_state == 0x01) || (encoder->last_state == 0x02)))  {
> 		int state_exor = state ^ encoder->last_state;
> 		int dir = 0;
> 
> 		if (state_exor == 0x01) {
> 			dir = +1;
> 			if (pdata->event_up) {
> 				input_report_key(encoder->input, pdata->event_up, 1);
> 				input_report_key(encoder->input, pdata->event_up, 0);
> 			}
> 		}
> 		else {
> 			dir = -1;
> 			if (pdata->event_down) {
> 				input_report_key(encoder->input, pdata->event_down, 1);
> 				input_report_key(encoder->input, pdata->event_down, 0);
> 			}
> 		}
> 
> 		if (dir) {
> 			if (pdata->relative_axis) {
> 				input_report_rel(encoder->input, pdata->axis, dir);
> 			}
> 			else {
> 				unsigned int pos = encoder->pos;
> 
> 				if (dir == -1) {
> 					/* turning counter-clockwise */
> 					if (pos > pdata->min_value)
> 						pos--;
> 					else if (pdata->rollover)
> 						pos = pdata->max_value;
> 				} 
> 				else {
> 					/* turning clockwise */
> 					if (pos < pdata->max_value)
> 						pos++;
> 					else if (pdata->rollover)
> 						pos = pdata->min_value;
> 				}
> 				encoder->pos = pos;
> 				input_report_abs(encoder->input, pdata->axis, encoder->pos);
> 			}
> 			input_sync(encoder->input);
> 		}
> 	}
> 
> 	/* always store the state - even on a 00 or 11 */
> 	encoder->last_state = state;
> 
> 	return IRQ_HANDLED;
> }
> 
> static int __devinit rotary_encoder_probe(struct platform_device *pdev)
> {
> 	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> 	struct rotary_encoder *encoder;
> 	struct input_dev *input;
> 	int err;
> 
> 	if (!pdata) {
> 		dev_err(&pdev->dev, "missing platform data\n");
> 		return -ENOENT;
> 	}
> 
> 	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
> 	input = input_allocate_device();
> 	if (!encoder || !input) {
> 		dev_err(&pdev->dev, "failed to allocate memory for device\n");
> 		err = -ENOMEM;
> 		goto exit_free_mem;
> 	}
> 
> 	encoder->input = input;
> 	encoder->pdata = pdata;
> 	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
> 	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
> 	encoder->pos = pdata->initial_value;
> 
> 	/* create and register the input driver */
> 	input->name = pdev->name;
> 	input->id.bustype = BUS_HOST;
> 	input->dev.parent = &pdev->dev;
> 
> 	if (pdata->event_up || pdata->event_down) {
> 		input->evbit[0] |= BIT(EV_KEY);
> 		set_bit(pdata->event_up, input->keybit);
> 		set_bit(pdata->event_down, input->keybit);
> 		clear_bit(KEY_RESERVED, input->keybit);
> 		input_set_capability(input, EV_MSC, MSC_SCAN);
> 	}
> 	if (pdata->relative_axis) {
> 		input->evbit[0] |= BIT_MASK(EV_REL);
> 		input->relbit[0] = BIT(pdata->axis);
> 	}
> 	else {
> 		input->evbit[0] |= BIT_MASK(EV_ABS);
> 		input_set_abs_params(encoder->input, pdata->axis, 
> 			pdata->min_value, pdata->max_value, 
> 			0, 1);
> 	}
> 
> 	err = input_register_device(input);
> 	if (err) {
> 		dev_err(&pdev->dev, "failed to register input device\n");
> 		goto exit_free_mem;
> 	}
> 
> 	/* request the GPIOs */
> 	err = gpio_request(pdata->gpio_a, DRV_NAME);
> 	if (err) {
> 		dev_err(&pdev->dev, "unable to request GPIO %d\n",
> 			pdata->gpio_a);
> 		goto exit_unregister_input;
> 	}
> 
> 	err = gpio_request(pdata->gpio_b, DRV_NAME);
> 	if (err) {
> 		dev_err(&pdev->dev, "unable to request GPIO %d\n",
> 			pdata->gpio_b);
> 		goto exit_free_gpio_a;
> 	}
> 
> 	/* request the IRQs */
> 	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
> 			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> 			  DRV_NAME, encoder);
> 	if (err) {
> 		dev_err(&pdev->dev, "unable to request IRQ %d\n",
> 			encoder->irq_a);
> 		goto exit_free_gpio_b;
> 	}
> 
> 	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
> 			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
> 			  DRV_NAME, encoder);
> 	if (err) {
> 		dev_err(&pdev->dev, "unable to request IRQ %d\n",
> 			encoder->irq_b);
> 		goto exit_free_irq_a;
> 	}
> 
> 	platform_set_drvdata(pdev, encoder);
> 
> 	return 0;
> 
> exit_free_irq_a:
> 	free_irq(encoder->irq_a, encoder);
> exit_free_gpio_b:
> 	gpio_free(pdata->gpio_b);
> exit_free_gpio_a:
> 	gpio_free(pdata->gpio_a);
> exit_unregister_input:
> 	input_unregister_device(input);
> 	input = NULL; /* so we don't try to free it */
> exit_free_mem:
> 	input_free_device(input);
> 	kfree(encoder);
> 	return err;
> }
> 
> static int __devexit rotary_encoder_remove(struct platform_device *pdev)
> {
> 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
> 	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> 
> 	free_irq(encoder->irq_a, encoder);
> 	free_irq(encoder->irq_b, encoder);
> 	gpio_free(pdata->gpio_a);
> 	gpio_free(pdata->gpio_b);
> 	input_unregister_device(encoder->input);
> 	platform_set_drvdata(pdev, NULL);
> 	kfree(encoder);
> 
> 	return 0;
> }
> 
> static struct platform_driver rotary_encoder_driver = {
> 	.probe		= rotary_encoder_probe,
> 	.remove		= __devexit_p(rotary_encoder_remove),
> 	.driver		= {
> 		.name	= DRV_NAME,
> 		.owner	= THIS_MODULE,
> 	}
> };
> 
> static int __init rotary_encoder_init(void)
> {
> 	return platform_driver_register(&rotary_encoder_driver);
> }
> 
> static void __exit rotary_encoder_exit(void)
> {
> 	platform_driver_unregister(&rotary_encoder_driver);
> }
> 
> module_init(rotary_encoder_init);
> module_exit(rotary_encoder_exit);
> 
> MODULE_ALIAS("platform:" DRV_NAME);
> MODULE_DESCRIPTION("GPIO rotary encoder driver");
> MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
> MODULE_LICENSE("GPL v2");
> 

