From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Add maxtouch to I2C table for
 module autoload
Date: Thu, 10 Dec 2015 20:07:47 -0300
Message-ID: <566A05C3.30204@osg.samsung.com>
References: <1448046582-20231-1-git-send-email-javier@osg.samsung.com>
 <20151120191558.GD26895@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:34364 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145AbbLJXHx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 18:07:53 -0500
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
> It sounds like the of matching and modalias is quite a mess at the
> moment.
>

I already explained the issues with OF modalias and why I believe
$SUBJECT is the least bad solution for now until the I2C subsystem
is changed to properly report OF modalias.

Please let me know if you are considering applying this or if
module autoloading will be broken for this driver in the meantime.
 
> Thanks.
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
