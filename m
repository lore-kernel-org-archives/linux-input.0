From: Max <ikj1234i@lightlink.com>
Subject: Re: Success! [was Re: Getting recent elantech touchpads to work]
Date: Wed, 2 Jun 2010 18:10:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.1006021746520.18973@adore2.lightlink.com>
References: <Pine.LNX.4.64.1005281743130.25516@adore2.lightlink.com>
 <20100602072538.GE3713@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adore.lightlink.com ([64.57.176.20]:47048 "EHLO
	adore2.lightlink.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758641Ab0FBWKQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 18:10:16 -0400
In-Reply-To: <20100602072538.GE3713@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


On Wed, 2 Jun 2010, Dmitry Torokhov wrote:

> Max, could you please try 2.6.31-rc1 and see if the touchapd is
> recognized there as well and what firmware version it reports. Also if
> you could describe features of the pad (number of buttons, etc) that
> would be great.

OK I assume you meant 2.6.35-rc1 ?

I downloaded the 2.6.35-rc1 bz2, extracted the files elantech.c and 
elantech.h from that, and copied those two into the existing kernel source 
tree (a 2.6.32 tree - for ubuntu 10.04).

Once again the detection looks to have worked OK (without needing 
"force").  I've pasted the dmesg output below.

Not sure what "features" you mean - there are two buttons which work as 
left and right buttons.  There are no other buttons associated with the 
touch pad.

I've noticed an occasional problem where the mouse pointer jumps to the 
left margin all by itself (this is using X/gnome).  This definitely 
happened with the "four patches" applied.  I can't say now whether it used 
to happen prior to the 4 patches :-\  (Would NOT want to go back to find 
out!).  Also haven't been using this new latest version long enough to 
know whether it also has the same glitch.

The original reason for trying the 4 patches was that the touchpad was 
being recognized as "IMPS/2 wheel mouse" (compatibility mode) and not as a 
touchpad.  The tap-to-click was ultra-sensitive and was driving me nuts.
Both the "4 patches" version and the new version properly detect the 
touchpad.

Best Regards

Max
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jun  2 17:45:22 mhp kernel: [34134.424271] psmouse serio4: ID: 10 00 64
Jun  2 17:45:22 mhp kernel: [34134.517976] elantech: assuming hardware version 2, firmware version 4.1.1
Jun  2 17:45:22 mhp kernel: [34134.553770] elantech: Synaptics capabilities query result 0x7e, 0x13, 0x0d.
Jun  2 17:45:22 mhp kernel: [34134.653227] input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio4/input/input9
