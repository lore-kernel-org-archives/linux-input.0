From: Heiko Schocher <hs@denx.de>
Subject: HowTo write a driver for 2 multiplexed PS/2 ports over 1 UART?
Date: Thu, 16 Apr 2009 08:22:34 +0200
Message-ID: <49E6CEAA.9060608@denx.de>
References: <1239861274.29831.118.camel@linux-51e8.site>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47020 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbZDPGfI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2009 02:35:08 -0400
In-Reply-To: <1239861274.29831.118.camel@linux-51e8.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I maybe get a projekt, where I have 2 PS/2 ports (a keyboard and a mousse)
connected to one UART and the multiplexing is done by a PIC.

I searched in actual 2.6 Kernel sources for such a solution, but
couln;t find one. Overlooked I something?

For 2.4er Kernel there was such a driver, see

http://git.denx.de/?p=linuxppc_2_4_devel.git;a=blob;f=drivers/char/ps2mult.c

but, I think, this is no longer portable to 2.6.

So, thats why I am here and want to ask the experts how to solve
this problem in a mainline acceptable way, before I make a hack,
that never has a chance to go in mainline.

Some suggestions from me (maybe they are all bad)

I looked in drivers/input/serio/serio.c and could think of adding
the multiplexing in serio_interrupt(), and call serio_driver specific
serio->drv->interrupt functions, when I know, which byte come from
which device. But, if I see it right, I can only add one "struct
serio_driver *drv;" driver to one serio port, so it is not possible
to handle 2 or more devices over one serio port :-(
Maybe we enhance this too ... ?

Or I make a combinated (keyboard/mousse) driver which uses one
serio port ... but I think thats a bad idea, also no idea, in which
directory i have to add such a driver.

So I think it would nice to have the possibility to add more than
one serio_driver to a serio_port and add a "multiplexer" layer ...
but I am new to the input layer, so I ask the experts.

Hopefully I just missed something in actual code, and there is
better/easier way? ;-)

TIA
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
