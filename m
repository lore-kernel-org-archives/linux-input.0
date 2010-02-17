From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
  quirky remote
Date: Wed, 17 Feb 2010 16:20:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002171620060.30967@pobox.suse.cz>
References: <3711715e0912310013u25e921cbqe6abb7c1621109e@mail.gmail.com>  <20100102025312.GC5788@core.coreip.homeip.net>  <3711715e1001020152s626739daw6cdf2d7742a0d959@mail.gmail.com>  <alpine.LNX.2.00.1001022221320.2277@pobox.suse.cz>
 <3711715e1001180233k36072dd2r518c0b388bc8d475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52161 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757397Ab0BQPUq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 10:20:46 -0500
In-Reply-To: <3711715e1001180233k36072dd2r518c0b388bc8d475@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Thomas <waynethomas69@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, 18 Jan 2010, Wayne Thomas wrote:

> I've had a look around in the udev source code for an idea of how you 
> intend on this to be implemented, but unfortunately couldn't find a 
> sutiable example to examine.  As such I wont be of much use to you with 
> in this regard. Something I did note however was that there is at least 
> five different quirky drivers that are using the 0x0ffbc0000 HID usage 
> page (defined as HID_UP_LOGIVENDOR), a handful of which do nothing more 
> than capture the keypresses from this usage page.  Comparing the keys in 
> question I realised that they could have been captured under a single 
> quirky driver, if not in hid-input itself.  It appears to me that a new 
> generation of Windows MCE remote devices are coming onto the market that 
> are using this usage page as standard.  I was going to fiddle around 
> with this but instead will wait to see how this will be implemented in 
> udev. Sorry I couldn't relieve some of your work-load.

udev keymaps are described in README.keymap.txt in udev package. You can 
find current version on 
http://git.kernel.org/?p=linux/hotplug/udev.git;a=blob;f=extras/keymap/README.keymap.txt;h=9c2d5dc16a151d57720b1dfe39e784f1b1d47367;hb=HEAD

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
