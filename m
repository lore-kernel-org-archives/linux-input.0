From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Wonkiness with keyboard adapter - not sure if it's in USB or
 input systems
Date: Wed, 27 Apr 2011 13:23:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104271316370.2239-100000@iolanthe.rowland.org>
References: <alpine.LNX.2.00.1104262319240.12035@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37632 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759677Ab1D0RXc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Apr 2011 13:23:32 -0400
In-Reply-To: <alpine.LNX.2.00.1104262319240.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Valdis.Kletnieks@vt.edu, Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 26 Apr 2011, Jiri Kosina wrote:

> It seems like the BIOS handover of the USB input device doesn't work 
> properly.
> 
> The way things usually work in such situations -- BIOS is able to 
> understand USB input devices in a very basic mode (hidp) and translate the 
> events into PS/2-looking events, so that things like grub (which don't 
> understand USB HID) are able to see keyboard events -- BIOS presents those 
> as PS/2 devices.
> 
> Once kernel is booted, it takes over devices in this 'legacy' mode from 
> BIOS, and initializes them properly as USB input devices.
> 
> Seems like this process is broken on your system. Could you please try to 
> disable legacy USB emulation in your BIOS, and see if the problem 
> persists? (it will make USB keyboard unavailable in grub).

If the drivers are set up properly in the initrd image, this shouldn't 
be a problem.  Still, it's worth testing.  A good test would be to use 
two keyboards, one attached to the PS2 port for typing in the 
decryption key and one attached to the adapter.  Does the second 
keyboard work after the kernel has finished starting up?

If it doesn't, does "rmmod ehci ; modprobe ehci" make any difference?  

Also, once the kernel is running, it is possible to fire up usbmon and
see what it reveals.

Alan Stern

