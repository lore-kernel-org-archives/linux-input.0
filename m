From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver (second version)
Date: Sat, 1 Jan 2011 23:41:39 -0800
Message-ID: <20110102074139.GA5429@core.coreip.homeip.net>
References: <4D1C60F1.5090305@armadeus.com>
 <4D1DACFF.9070504@codeaurora.org>
 <4D1DC09F.2030404@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39412 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1ABIqh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Jan 2011 03:46:37 -0500
Content-Disposition: inline
In-Reply-To: <4D1DC09F.2030404@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabien Marteau <fabien.marteau@armadeus.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Fabien,

On Fri, Dec 31, 2010 at 12:38:07PM +0100, Fabien Marteau wrote:
> Hi Trilok,
> 
> > 
> >> +	int ret;
> >> +
> >> +	mutex_lock(&plat_dat->button_lock);
> >> +	ret = gpio_get_value(plat_dat->button_gpio);
> >> +	if (ret)
> >> +		input_report_key(plat_dat->input_dev, BTN_JOYSTICK, 0);
> >> +	else
> >> +		input_report_key(plat_dat->input_dev, BTN_JOYSTICK, 1);
> >> +	input_sync(plat_dat->input_dev);
> >> +	mutex_unlock(&plat_dat->button_lock);
> > 
> > Do you need this lock? Please explain.
> 
> If gpio_get_value() sleep, I need it to avoid race condition.

Race condition with what though?

> 
> >> +static int as5011_i2c_write(struct i2c_client *client,
> >> +			    uint8_t aRegAddr,
> >> +			    uint8_t aValue)
> >> +{
> >> +	int ret;
> >> +	uint8_t data[2] = { aRegAddr, aValue };
> > 
> > No CamelCases please. Please run scripts/checkpatch.pl on your patch before submission.
> 
> I had no warning for CamelCases name.

This goes wihtout saying ;)

> 
> >> +static int __devinit as5011_probe(struct i2c_client *client,
> >> +			const struct i2c_device_id *id)
> >> +{
> >> +	struct as5011_platform_data *plat_dat = client->dev.platform_data;
> >> +	int retval = 0;
> >> +
> >> +	plat_dat->num = g_num;
> >> +	g_num++;
> > 
> > What is g_num++ and why it has to be global?
> 
> It's for interruptions name, if several as5011 joystick I set a number different for each joystick :
> 
> 	scnprintf(plat_dat->button_irq_name,
> 		  SIZE_NAME,
> 		  "as5011_%d_button",
> 		  plat_dat->num);

Right, but who cares about having different names? Just mark all
interrupts as5011_button and as5011_joystick or even simply use "as5011"
for everything and call it a day.

-- 
Dmitry
