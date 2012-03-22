From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: lm8333: add driver
Date: Thu, 22 Mar 2012 09:47:50 -0700
Message-ID: <4402228.zQRyQ2HOtM@dtor-d630.eng.vmware.com>
References: <20120322035244.GB20427@core.coreip.homeip.net> <20120322091145.GA2424@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50222 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2CVQsJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Mar 2012 12:48:09 -0400
Received: by ghrr11 with SMTP id r11so1933201ghr.19
        for <linux-input@vger.kernel.org>; Thu, 22 Mar 2012 09:48:08 -0700 (PDT)
In-Reply-To: <20120322091145.GA2424@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-input@vger.kernel.org

On Thursday, March 22, 2012 10:11:45 AM Wolfram Sang wrote:
> Hi Dmitry,
> 
> thanks for the immediate review!
> 
> > > This driver adds support for the keypad part of the LM8333 and provides
> > > hooks for possible GPIO/PWM drivers. Note that this is not a MFD device
> > > beause you cannot disable the keypad functionality which, thus, has to
> > > be handled by the core anyhow.
> > 
> > So it's like lm8323... In this case we should just add PWM handling
> > directly to this driver.
> 
> Not sure. There is a PWM framework in the making.

OK.

> 
> > > +
> > > +/* The accessors try twice because the first access may be needed for
> > > wakeup */ +
> > > +int lm8333_read8(struct lm8333 *lm8333, u8 cmd)
> > > +{
> > > +	int repeated = 0, ret;
> > > +
> > > +	do {
> > > +		ret = i2c_smbus_read_byte_data(lm8333->client, cmd);
> > > +	} while (ret < 0 && !repeated++);
> > 
> > So there is 1 retry... Why don't you have
> > 
> > 	do {
> > 	
> > 		...
> > 	
> > 	} while (ret < 0 && retries++ < LM8333_NUM_RETRIES);
> > 
> > to make it completely obvious.
> 
> I thought '!repeated' was readable, but will change that.

It is quite readable but I don't want to have any doubts when I look at the 
code at 2AM drunk ;)

> 
> > > +	lm8333 = devm_kzalloc(&client->dev, sizeof(*lm8333), GFP_KERNEL);
> > > +	input = input_allocate_device();
> > > +	if (!lm8333 || !input)
> > 
> > You leak memory here if input_allocate_device() succeeds but
> > devm_kzalloc fails. Situations like this is why I do not like devm_*
> > interface.
> 
> I see. Okay, the true flaw is that one should check for error cases
> seperately, but with devm_* one is tempted to combine that.

Without devm I most often do:

	xxx = kzalloc(sizeof(*xxx), GFP_KERNEL);
	input = input_allocate_device();
	if (!xxx || !input) {
		error = -ENOMEM;
		goto err_free_mem:
	}
	...

err_free_mem:
	input_free_device(input);
	kfree(xxx);

> 
> > > +static int __devexit lm8333_remove(struct i2c_client *client)
> > > +{
> > > +	struct lm8333 *lm8333 = i2c_get_clientdata(client);
> > > +
> > > +	input_unregister_device(lm8333->input);
> > > +	input_free_device(lm8333->input);
> > 
> > Also you need to free IRQ before you unregister (and free) input device,
> > otherwise you risk dereferencing already freed memory. Another example
> > why I hate devm_*.
> 
> Understood. The problem here is mixing devm_* setup with non_devm. So,
> it is an either-or-thingie? Hmmm...

There probably cases where devm_ may work but I find that mixing two paradigms 
just makes things harder for me. "Is this resource managed? Do I still have to 
release it manually even though it is managed? Does the order matter?"
Without devm_* I just need to pay attention if resource is refcounted or not, 
but otherwise I need to release everything I acquired and I control entire 
sequence.

Thanks.

-- 
Dmitry
