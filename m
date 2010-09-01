From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Wed, 01 Sep 2010 13:55:01 +0200
Message-ID: <4C7E3F15.7070302@euromail.se>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>	<AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>	<4C7B7595.6060904@euromail.se> <AANLkTimCxMpy3B9Cz9_HDGNvXGykCAN3yTc+6KVyVHkp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:42722 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab0IALzV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 07:55:21 -0400
In-Reply-To: <AANLkTimCxMpy3B9Cz9_HDGNvXGykCAN3yTc+6KVyVHkp@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 09/01/2010 12:48 PM, Ping Cheng wrote:

[...]

>> In the hope that it would work to register only the active endnode,
>> plus getting a natural definition of every endnode of the usb device.

> 
> We always get two logical ports for the pen and touch devices, which
> are created by udev (or something in the kernel that I am not so
> sure). The Wacom driver can not do much about it. I guess the firmware
> of your touch-only Bamboo added the pen interface to the protocol.
> That's why you see two ports (I can not access the device to test my
> idea before next month).


It should be fine, the extra device will only have mouse capabilities and will
not be used for anything.

>> Since Ping had issues
>> with this too, I will change it to the read-and-modify-later approach used in
>> the rest of the driver.
> 
> Thank you for your consideration. Please use the existing approach so
> we can maintain an unified interface. There should not be too much
> confusion with the existing approach since pen and touch will not be
> on the same logical port anyway.


Will send out a new version shortly.

>>> Also, what does BOOT mean?  In Bamboo Pen&Touch device, this would be
>>> the pen input.  So at minimum BAMBOO_PEN is more accurate name.
>>
>>
>> For the Bamboo Touch, pen is not accurate. Boot comes from the HID specification
>> (boot interface, mouse protocol), but no name seems appropriate since the node
>> should not even be there.
> 
> Right now, we just tell users to ignore pen or touch if their device
> does not support pen or touch (running an X server older than 1.4). In
> the X Wacom driver for servers newer than 1.4, we check the valid
> tools supported by the device before adding them. End users should not
> need to worry about those details, at least in theory.
> 
> Maybe we can add this "tool type check method" into the evdev and/or
> synaptics X driver as well?


Given the current and coming fixes to udev, I think we will be able to sort it
out well on that level, although it would not hurt if the X drivers were a bit
more selective during preinit.

Cheers,
Henrik
