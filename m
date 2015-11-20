From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Add maxtouch to I2C table for
 module autoload
Date: Fri, 20 Nov 2015 16:32:32 -0300
Message-ID: <564F7550.1080300@osg.samsung.com>
References: <1448046582-20231-1-git-send-email-javier@osg.samsung.com>
 <20151120191558.GD26895@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38186 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163023AbbKTTch (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 14:32:37 -0500
In-Reply-To: <20151120191558.GD26895@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Hello Dmitry,

On 11/20/2015 04:15 PM, Dmitry Torokhov wrote:
> On Fri, Nov 20, 2015 at 04:09:42PM -0300, Javier Martinez Canillas wrote:
>> The Atmel maxtouch DT binding documents that the compatible string for
>> the device is "atmel,maxtouch" and the I2C core always reports a module
>> alias of the form i2c:alias where alias is the compatible string model:
>>
>> $ grep MODALIAS /sys/devices/platform/12e00000.i2c/i2c-8/8-004b/uevent
>> MODALIAS=i2c:maxtouch
> 
> Do we know why we are not reporting modalias as "of:..." so that
> autoloading using the of table works properly?
>

Yes we do but is not that easy to fix without risking breaking autload
in a lot of drivers that are relying on the current behavior.

I posted a patch series to fix the OF and I2C tables for all the
drivers that could find in mainline and in the cover letter I explain
the problem in detail:

https://lkml.org/lkml/2015/7/30/519

But is not complete because the .driver_data in i2c_device_id is an
kernel_ulong_t while the .data in of_device_id is a const void * so
some casting will be needed to add an OF table in some drivers that
still lack one and I wanted to discuss that a little bit to see if
the I2C core could return a common data field in both cases.
 
> It sounds like the of matching and modalias is quite a mess at the
> moment.
>

Agreed, I2C is specially complicated because not only OF drivers need a
I2C table for module autoloading but also the core uses the I2C table
to match devices and pass a struct i2c_device_id to their probe function.

Now this requirement has become more relaxed since Lee's series mentioned
in my cover letter were merged but still most I2C drivers use an I2C table
for this legacy reason. So there isn't too much gain in cleaning up the
modalias reporting if most drivers still need an I2C table anyways.
 
> Thanks.
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
