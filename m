From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HowTo write a driver for 2 multiplexed PS/2 ports over 1 UART?
Date: Sat, 18 Apr 2009 16:46:00 -0700
Message-ID: <20090418234559.GD32346@dtor-d630.eng.vmware.com>
References: <1239861274.29831.118.camel@linux-51e8.site> <49E6CEAA.9060608@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:6827 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbZDRXqH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2009 19:46:07 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1390214rvb.1
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2009 16:46:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49E6CEAA.9060608@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-input@vger.kernel.org

Hi Heiko,

On Thu, Apr 16, 2009 at 08:22:34AM +0200, Heiko Schocher wrote:
> Hello,
> 
> I maybe get a projekt, where I have 2 PS/2 ports (a keyboard and a mousse)
> connected to one UART and the multiplexing is done by a PIC.
> 
> I searched in actual 2.6 Kernel sources for such a solution, but
> couln;t find one. Overlooked I something?
> 
> For 2.4er Kernel there was such a driver, see
> 
> http://git.denx.de/?p=linuxppc_2_4_devel.git;a=blob;f=drivers/char/ps2mult.c
> 
> but, I think, this is no longer portable to 2.6.
> 
> So, thats why I am here and want to ask the experts how to solve
> this problem in a mainline acceptable way, before I make a hack,
> that never has a chance to go in mainline.
> 
> Some suggestions from me (maybe they are all bad)
> 
> I looked in drivers/input/serio/serio.c and could think of adding
> the multiplexing in serio_interrupt(), and call serio_driver specific
> serio->drv->interrupt functions, when I know, which byte come from
> which device. But, if I see it right, I can only add one "struct
> serio_driver *drv;" driver to one serio port, so it is not possible
> to handle 2 or more devices over one serio port :-(
> Maybe we enhance this too ... ?
> 
> Or I make a combinated (keyboard/mousse) driver which uses one
> serio port ... but I think thats a bad idea, also no idea, in which
> directory i have to add such a driver.
> 
> So I think it would nice to have the possibility to add more than
> one serio_driver to a serio_port and add a "multiplexer" layer ...
> but I am new to the input layer, so I ask the experts.
> 
> Hopefully I just missed something in actual code, and there is
> better/easier way? ;-)
>

You need to create 2 serio ports in your driver and have it send data
into appropriate port, depending on what device it came from. If you
take a look at i8042 driver it does exactly that. We have 1 serio port
for keyboard and eithe 1 or 4 AUX serio ports. In i8042_interrupt we
check the status bit to figure to which serio port incoming byte should
be routed and act accordingly.

Hope this helps.

-- 
Dmitry
