From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Thu, 17 Nov 2011 00:44:17 +0400
Message-ID: <4EC420A1.7080502@emcraft.com>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com> <20111114172809.GD12659@core.coreip.homeip.net> <4EC1832D.3080405@emcraft.com> <20111114213241.GA26418@core.coreip.homeip.net> <20111115101715.7b330e1d@wker> <20111115174137.GB15129@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:44542 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1KPUoP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 15:44:15 -0500
In-Reply-To: <20111115174137.GB15129@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>, linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Dmitry, Anatolij,

On 15.11.2011 21:41, Dmitry Torokhov wrote:
>>> Do you really need to read gpio state in IRQ? Can't you simply rely on
>>> 'event' do decide whether to emit input events?
>>
>> We can't rely on the 'event' only. The peculiar behaviour of the
>> touch controller enforces this. The touch controller toggles the
>> interrupt line when you keep the finger down. The rate is not exactly
>> specified by the the manufacturer (~80/sec). Measured rate deviates
>> from this specified rate. Valid touch packet data can be read when
>> interrupt line is pulled down.
> 
> So what ensures that the gpio line stays low between the check and the
> time you get access to i2c bus and get around reading the data.

Anatolij, could you please comment on this? What can we do about this?
Check the pin state after i2c read maybe?

>> The designer of the target device
>> insisted on driver implementation reading touch packet data only
>> when irq line is pulled down.
> 
> Well... have you tried checkign whether it is really necessary. Because
> if it is not necessary you could do away with the platform data
> altogether.

My understanding is that it's really necessary. We had initial driver
version without this checking and that resulted in some troubles. I'd
like to drop the platform data too, but I think we really need it.

Regards, Ilya.
