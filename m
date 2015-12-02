From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Add maxtouch to I2C table for
 module autoload
Date: Wed, 2 Dec 2015 17:15:13 -0300
Message-ID: <565F5151.20808@osg.samsung.com>
References: <1448046582-20231-1-git-send-email-javier@osg.samsung.com>
 <20151120191558.GD26895@dtor-ws> <564F7550.1080300@osg.samsung.com>
 <564F7889.3050402@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53561 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbbLBUPP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 15:15:15 -0500
In-Reply-To: <564F7889.3050402@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Hello Dmitry,

On 11/20/2015 04:46 PM, Javier Martinez Canillas wrote:
> On 11/20/2015 04:32 PM, Javier Martinez Canillas wrote:
> 
> [snip]
> 
>>
>> But is not complete because the .driver_data in i2c_device_id is an
>> kernel_ulong_t while the .data in of_device_id is a const void * so
>> some casting will be needed to add an OF table in some drivers that
> 
> Some casting in the tables *and* some logic to get the .data from the
> OF table entries, so something like the following will be needed:
> 
> static int foo_i2c_probe(struct i2c_client *i2c,
>                          const struct i2c_device_id *id)
> {
>         struct of_device_id *match;
>         kernel_ulong_t data;
> 
>         if (i2c->dev.of_node) {
>                match = of_match_node(of_match, i2c->dev.of_node);
> 	       if (!match)
>                         return -EINVAL;
> 
>                data = (kernel_ulong_t)match->data;
>         } else {
>                data = id->driver_data;
> 	}
> 	...
> }
> 
> while currently I2C drivers just rely on the model part of the compatible
> string to match with the entry in the I2C device ID table and the core
> always passing the correct .driver_data to the probe function.
> 
> So as you can see, converting all the drivers to not rely on the I2C table
> requires some refactoring before proper OF modalias reporting can be used.
>

Any comments about this? I'm planning to address all this at some point but
for now I think we would need $SUBJECT to have module autoloading working
on this driver when the device is registered via OF.
 
> Best regards,
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
