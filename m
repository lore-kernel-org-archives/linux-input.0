From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 2 Dec 2007 19:23:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712021918500.13260@jikos.suse.cz>
References: <4752DB8C.50608@rtr.ca> <4752E432.10504@rtr.ca>
 <Pine.LNX.4.64.0712021903460.12208@twin.jikos.cz> <4752F6C7.4040904@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:54837 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753615AbXLBSXu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2007 13:23:50 -0500
In-Reply-To: <4752F6C7.4040904@rtr.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rubini@vision.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sun, 2 Dec 2007, Mark Lord wrote:

> Reverting the drivers/hid directory does seem to improve behaviour. But 
> right now I have a "make -j4" happening in the background and the mouse 
> is ever so erratic again, despite the drivers/hid reversion.
> So it's a timing thing, somewhere. Maybe a scheduling thing?

Thanks a lot for your report Mark. Before we start digging deeply here -- 
Dmitry, do you think that this could be caused by your input-locking 
patches somehow? From Mark's report:

- it didn't happen with 2.6.23
- when drivers/hid is put back into 2.6.23 state, the problem still 
  persists in some sense

So there must have been some change elsewhere (USB, Input, something 
completely different) that introduced this problem.

> Jiri:  I know nothing about how mouse clicks are interpreted, or even 
> *where* or *how* double-click detection happens. Until this started 
> happening, I didn't even know which module was the driver for my mouse 
> (it's usbhid). Can you give a short tutorial, to help us understand 
> possible causes ?

First it would be really helpful to see if

- the HID driver really obtains two click events from USB stack. This 
  could be easily seen from HID debug output. I have written in previous 
  mail how to obtain this
- the output of evtest for the mouse device in /dev/input/event? (for 
  determinign the correcnt event number corresponding to your mouse, see 
  /proc/bus/input/devices)

Thanks,

-- 
Jiri Kosina
SUSE Labs
