From: Russell Shaw <rjshaw@netspace.net.au>
Subject: Re: Evdev uniq id
Date: Sat, 06 Nov 2010 20:49:55 +1100
Message-ID: <4CD524C3.10300@netspace.net.au>
References: <4CD38B2B.3080200@netspace.net.au> <20101106094541.GA16663@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out6.netspace.net.au ([203.10.110.88]:54104 "EHLO
	smtp.netspace.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754118Ab0KFJt5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 05:49:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.netspace.net.au (Postfix) with ESMTP id 348BD1C41D4
	for <linux-input@vger.kernel.org>; Sat,  6 Nov 2010 20:49:55 +1100 (EST)
Received: from smtp.netspace.net.au ([127.0.0.1])
	by localhost (mail-out6.netpace.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yR1uD2cH4S3D for <linux-input@vger.kernel.org>;
	Sat,  6 Nov 2010 20:49:53 +1100 (EST)
Received: from [192.168.0.10] (220.253-234-241.VIC.netspace.net.au [220.253.234.241])
	by smtp.netspace.net.au (Postfix) with ESMTPA id C031A1C41E0
	for <linux-input@vger.kernel.org>; Sat,  6 Nov 2010 20:49:52 +1100 (EST)
In-Reply-To: <20101106094541.GA16663@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input <linux-input@vger.kernel.org>

On 06/11/10 20:45, Dmitry Torokhov wrote:
> Hi Russell,
>
> On Fri, Nov 05, 2010 at 03:42:19PM +1100, Russell Shaw wrote:
>> Hi,
>> In X, i want an application program to apply settings to a specific
>> mouse/puck device, regardless of how many other devices have been
>> plugged in since the last session.
>>
>> Prefereably, a manufacturer-model-serial_number call would be available
>> from evdev.
>>
>> Minimally, a uniq non-changing ID could be useful. I found this in
>> linux-2.6.31.1/drivers/input/evdev.c:
>>
>>    if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUNIQ(0)))
>>      return str_to_user(dev->uniq, _IOC_SIZE(cmd), p);
>>
>> How is "dev->uniq" constructed?
>
> USB HID devices populate this field with data from descriptor.iSerialNumber.
> I suppose we should do that in other USB drivers as well, patches are
> welcome.

Hi Dmitry.T,
I was just getting around to seeing if i could add manufacturer-model-
serial_number ioctl functionality.
