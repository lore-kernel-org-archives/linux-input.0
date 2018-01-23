From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v4 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 23 Jan 2018 10:33:35 +0100
Message-ID: <20180123103335.6d27a31b@dell-desktop.home>
References: <20171201153957.13053-1-mylene.josserand@free-electrons.com>
        <20171201153957.13053-2-mylene.josserand@free-electrons.com>
        <20180122201109.GA651@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54112 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeAWJdi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 04:33:38 -0500
In-Reply-To: <20180122201109.GA651@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

Hello Marcus,

Thank you for the review.

Le Mon, 22 Jan 2018 21:11:09 +0100,
Marcus Folkesson <marcus.folkesson@gmail.com> a écrit :

> Mylene,
> 
> On Fri, Dec 01, 2017 at 04:39:56PM +0100, Mylène Josserand wrote:
> > +++ b/drivers/input/touchscreen/cyttsp5.c
> > @@ -0,0 +1,1110 @@
> > +/*
> > + * Parade TrueTouch(TM) Standard Product V5 Module.
> > + * For use with Parade touchscreen controllers.
> > + *
> > + * Copyright (C) 2015 Parade Technologies
> > + * Copyright (C) 2012-2015 Cypress Semiconductor
> > + * Copyright (C) 2017 Free Electrons
> > + *
> > + * Author: Mylène Josserand <mylene.josserand@free-electrons.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2, and only version 2, as published by the
> > + * Free Software Foundation.  
> 
> Please use SPDX license Identifier to describe the license.
> 
> E.g.
> SPDX-License-Identifier: GPL-2.0
> 
> Also, the MODULE_LICENSE means GPL 2.0 or later per module.h and this does
> not match the license description.
> 
> Could you make sure they are in sync?

You are right, I will check that, thanks.

> 
> 
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/crc-itu-t.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/gpio.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/input/touchscreen.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>  
> 
> #include <linux/bitops.h>
> 
> since you are using BIT()

okay

> 
> 
> [snip]
> 
> 
> > +static int cyttsp5_setup_input_device(struct device *dev)
> > +{
> > +	struct cyttsp5 *ts = dev_get_drvdata(dev);
> > +	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> > +	int max_x, max_y, max_p;
> > +	int max_x_tmp, max_y_tmp;
> > +	int rc;
> > +
> > +	__set_bit(EV_ABS, ts->input->evbit);
> > +	__set_bit(EV_REL, ts->input->evbit);
> > +	__set_bit(EV_KEY, ts->input->evbit);
> > +
> > +	max_x_tmp = si->sensing_conf_data.res_x;
> > +	max_y_tmp = si->sensing_conf_data.res_y;
> > +	max_x = max_y_tmp - 1;
> > +	max_y = max_x_tmp - 1;
> > +	max_p = si->sensing_conf_data.max_z;
> > +
> > +	input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].max, 0);
> > +
> > +	__set_bit(ABS_MT_POSITION_X, ts->input->absbit);
> > +	__set_bit(ABS_MT_POSITION_Y, ts->input->absbit);
> > +	__set_bit(ABS_MT_PRESSURE, ts->input->absbit);  
> 
> Not needed, input_set_abs_params() will set the bits for you below.

Yes, I will remove it.

> 
> 
> > +
> > +	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, max_x, 0, 0);
> > +	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
> > +	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, max_p, 0, 0);
> > +
> > +	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 0);
> > +	input_set_abs_params(ts->input, ABS_MT_TOUCH_MINOR, 0, MAX_AREA, 0, 0);
> > +
> > +	rc = input_register_device(ts->input);
> > +	if (rc < 0)
> > +		dev_err(dev, "Error, failed register input device r=%d\n", rc);
> > +
> > +	return rc;
> > +}
> > +
> > +  
> 
> [snip]
> 
> > +static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
> > +				      struct cyttsp5_hid_desc *desc)
> > +{
> > +	struct device *dev = ts->dev;
> > +	__le16 hid_desc_register = HID_DESC_REG;
> > +	int rc;
> > +	u8 cmd[2];
> > +
> > +	/* Read HID descriptor length and version */
> > +	mutex_lock(&ts->system_lock);
> > +	ts->hid_cmd_state = HID_CMD_BUSY;
> > +	mutex_unlock(&ts->system_lock);
> > +
> > +	/* Set HID descriptor register */
> > +	memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
> > +
> > +	rc = cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
> > +	if (rc < 0) {
> > +		dev_err(dev, "Failed to get HID descriptor, rc=%d\n", rc);
> > +		goto error;
> > +	}
> > +
> > +	rc = wait_event_timeout(ts->wait_q, (ts->hid_cmd_state == HID_CMD_DONE),
> > +				msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT));
> > +	if (!rc) {
> > +		dev_err(ts->dev, "HID get descriptor timed out\n");
> > +		rc = -ETIME;
> > +		goto error;
> > +	}
> > +
> > +	memcpy(desc, ts->response_buf, sizeof(struct cyttsp5_hid_desc));
> > +
> > +	/* Check HID descriptor length and version */
> > +	if (le16_to_cpu(desc->hid_desc_len) != sizeof(*desc) ||
> > +	    le16_to_cpu(desc->bcd_version) != HID_VERSION) {
> > +		dev_err(dev, "Unsupported HID version\n");
> > +		return -ENODEV;  
> 
> Maybe it is supposed to return here, but all other faults use "goto
> error".

Yep, I will use 'goto' instead of 'return' here.

> 
> > +	}
> > +
> > +	goto exit;
> > +
> > +error:
> > +	mutex_lock(&ts->system_lock);
> > +	ts->hid_cmd_state = HID_CMD_DONE;
> > +	mutex_unlock(&ts->system_lock);
> > +exit:
> > +	return rc;
> > +}
> > +  
> 
> [snip]
> 
> > +static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> > +			 const char *name)
> > +{
> > +	struct cyttsp5 *ts;
> > +	struct cyttsp5_sysinfo *si;
> > +	int rc = 0, i;
> > +
> > +	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > +	if (!ts)
> > +		return -ENOMEM;
> > +
> > +	/* Initialize device info */
> > +	ts->regmap = regmap;
> > +	ts->dev = dev;
> > +	si = &ts->sysinfo;
> > +	dev_set_drvdata(dev, ts);
> > +
> > +	/* Initialize mutexes and spinlocks */  
> 
> No spinlocks here :-)

I forgot to remove the comment from vendor's driver, thanks :)

> 
> > +	mutex_init(&ts->system_lock);
> > +
> > +	/* Initialize wait queue */
> > +	init_waitqueue_head(&ts->wait_q);
> > +
> > +	/* Reset the gpio to be in a reset state */
> > +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(ts->reset_gpio)) {
> > +		rc = PTR_ERR(ts->reset_gpio);
> > +		dev_err(dev, "Failed to request reset gpio, error %d\n", rc);
> > +		return rc;
> > +	}
> > +	gpiod_set_value(ts->reset_gpio, 1);
> > +  
> 
> [snip]
> 
> > +static struct i2c_driver cyttsp5_i2c_driver = {
> > +	.driver = {
> > +		.name = CYTTSP5_NAME,
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = of_match_ptr(cyttsp5_of_match),
> > +	},
> > +	.probe = cyttsp5_i2c_probe,
> > +	.remove = cyttsp5_i2c_remove,
> > +	.id_table = cyttsp5_i2c_id,
> > +};
> > +
> > +module_i2c_driver(cyttsp5_i2c_driver);
> > +
> > +MODULE_LICENSE("GPL");  
> 
> From linux/module.h:
> 
> /*
>  * The following license idents are currently accepted as indicating free
>  * software modules
>  *
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]
> 

Okay, noted.

> 
> 
> > +MODULE_DESCRIPTION("Touchscreen driver for Cypress TrueTouch Gen 5 Product");
> > +MODULE_AUTHOR("Mylène Josserand <mylene.josserand@free-electrons.com>");
> > -- 
> > 2.11.0
> >   
> 
> Best regards
> Marcus Folkesson

Best regards,

-- 
Mylène Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
