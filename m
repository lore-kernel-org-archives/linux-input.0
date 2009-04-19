From: Heiko Schocher <hs@denx.de>
Subject: Re: HowTo write a driver for 2 multiplexed PS/2 ports over 1 UART?
Date: Sun, 19 Apr 2009 12:04:25 +0200
Message-ID: <49EAF729.2010603@denx.de>
References: <1239861274.29831.118.camel@linux-51e8.site> <49E6CEAA.9060608@denx.de> <20090418234559.GD32346@dtor-d630.eng.vmware.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42222 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbZDSKrb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Apr 2009 06:47:31 -0400
In-Reply-To: <20090418234559.GD32346@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dmitry,

Dmitry Torokhov wrote:
> On Thu, Apr 16, 2009 at 08:22:34AM +0200, Heiko Schocher wrote:
>> Hello,
>>
>> I maybe get a projekt, where I have 2 PS/2 ports (a keyboard and a mousse)
>> connected to one UART and the multiplexing is done by a PIC.
>>
>> I searched in actual 2.6 Kernel sources for such a solution, but
>> couln;t find one. Overlooked I something?
>>
>> For 2.4er Kernel there was such a driver, see
>>
>> http://git.denx.de/?p=linuxppc_2_4_devel.git;a=blob;f=drivers/char/ps2mult.c
>>
>> but, I think, this is no longer portable to 2.6.
>>
>> So, thats why I am here and want to ask the experts how to solve
>> this problem in a mainline acceptable way, before I make a hack,
>> that never has a chance to go in mainline.
>>
>> Some suggestions from me (maybe they are all bad)
>>
>> I looked in drivers/input/serio/serio.c and could think of adding
>> the multiplexing in serio_interrupt(), and call serio_driver specific
>> serio->drv->interrupt functions, when I know, which byte come from
>> which device. But, if I see it right, I can only add one "struct
>> serio_driver *drv;" driver to one serio port, so it is not possible
>> to handle 2 or more devices over one serio port :-(
>> Maybe we enhance this too ... ?
>>
>> Or I make a combinated (keyboard/mousse) driver which uses one
>> serio port ... but I think thats a bad idea, also no idea, in which
>> directory i have to add such a driver.
>>
>> So I think it would nice to have the possibility to add more than
>> one serio_driver to a serio_port and add a "multiplexer" layer ...
>> but I am new to the input layer, so I ask the experts.
>>
>> Hopefully I just missed something in actual code, and there is
>> better/easier way? ;-)
>>
> 
> You need to create 2 serio ports in your driver and have it send data
> into appropriate port, depending on what device it came from. If you
> take a look at i8042 driver it does exactly that. We have 1 serio port
> for keyboard and eithe 1 or 4 AUX serio ports. In i8042_interrupt we
> check the status bit to figure to which serio port incoming byte should
> be routed and act accordingly.

Ah, thanks for this hint :-)

OK, so I have to write a serial driver for the uart on my hardware,
and add this in drivers/serio, right?

Hmm.. spontaneous I think (maybe it is a bad thought), what do you
think to the following approach:

I didn;t want to write a new serio driver for my uart (mpc5200 internal
PSC Uart), because there is a working tty driver for this, and the multi-
plexing functionality is just a protocoll ... so I think of using
the drivers/serio/serport.c and add this "multiplexing" functionality
to the serport.c driver ... is this worth about to think?

this should be a more general approach then writting a special serial
driver for "my" UART ... what do you think?

> Hope this helps.

of course, thanks!

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
