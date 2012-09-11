From: "Mathias Laurenz Baumann" <marenz@supradigital.org>
Subject: Modifying keycodes or scancodes of keyboard devices
Date: Tue, 11 Sep 2012 17:21:31 +0200
Message-ID: <op.wkg8x5kq486orv@labs03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s1.constructdoors.de ([178.248.242.98]:48145 "EHLO
	s1.constructdoors.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550Ab2IKP1v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Sep 2012 11:27:51 -0400
Received: from labs03 (p5DC56916.dip.t-dialin.net [93.197.105.22])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s1.constructdoors.de (Postfix) with ESMTPSA id 0C93A28C0DA
	for <linux-input@vger.kernel.org>; Tue, 11 Sep 2012 17:21:31 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I want to write a kernel module that hooks in somewhere between the  
keyboard driver and whatever
uses the resulting key events (e.g. evdev or xkb).

My goal is to modify the keycodes or scancodes (whatever works best and is  
least amount of work)
reported to the next function in the input processing chain, with the  
intended result of
modifying the keyboard layout.

I could of course just use xkb and create a custom mapping, but my  
experience with those is that
many applications have trouble with some mappings. One example is the  
neo-layout[1] which provides
alternative mappings for the arrow keys or the navigation keys like pos1,  
end, return and the
numblock, only activated when a certain modifier is active (e.g. AltGr).  
Many programs have trouble
when those alternatives are used.

My idea is to do that mapping on a level deeper than xkb can provide, thus  
avoiding those problems and faking
a keyboard that has that layout in hardware, at least from the point of  
view of xkb.

I have no experience with kernel hacking, but I did some reading and..  
well here is my idea:

There are the functions input_set_keycode[0] and input_get_keycode which  
sound like they do what I want to do.
So I figured, I write a simple kernel module that just calls these  
functions with the mappings I want to do.

Trouble is, they also want a pointer to the device that this concerns.
That is of course a reasonable thing to require for that function, just  
that I have no idea where to get that from.

I couldn't find any function that would return me a list of the input  
devices.

I also saw input_grab_* and input_inject_* which sounds like it could also  
be used for my purpose .. but input_set_keycode seemed more reasonable ....

So my questions are:
* Is this approach feasible? Would it work?
* If yes, where to I get the struct input_dev* device, or a list of them,  
from?
* If no, what approach do you suggest?

     --Marenz


[0]  
http://kernel.org/doc/htmldocs/device-drivers/API-input-set-keycode.html
[1] http://neo-layout.org
