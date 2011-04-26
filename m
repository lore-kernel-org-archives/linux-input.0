From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Wonkiness with keyboard adapter - not sure if it's in USB or
 input systems
Date: Tue, 26 Apr 2011 23:29:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1104262319240.12035@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1104261453300.2035-100000@iolanthe.rowland.org> <23191.1303845136@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23191.1303845136@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 26 Apr 2011, Valdis.Kletnieks@vt.edu wrote:

> > > Bus 001 Device 006: ID 0e8f:0020 GreenAsia Inc. USB to PS/2 Adapter
> 
> > Have you tried testing the adapter by plugging it in after the system 
> > is running?
> 
> It works fine at the Grub screen.
> 
> It *doesn't* work for the kernel when it initially starts up, even though a few
> seconds ago the hardware worked just fine.
> 
> It *does* work after I've unplugged/replugged it - I've tested both the USB
> side and the PS2 side, in either case it starts working.
> 
> I'm not sure what difference "plug it in after it's running" and "unplug/
> replug" will have. I suppose I could test that, but I'm suspecting the results
> will be "it works fine after plugging it in once the kernel is up".

It seems like the BIOS handover of the USB input device doesn't work 
properly.

The way things usually work in such situations -- BIOS is able to 
understand USB input devices in a very basic mode (hidp) and translate the 
events into PS/2-looking events, so that things like grub (which don't 
understand USB HID) are able to see keyboard events -- BIOS presents those 
as PS/2 devices.

Once kernel is booted, it takes over devices in this 'legacy' mode from 
BIOS, and initializes them properly as USB input devices.

Seems like this process is broken on your system. Could you please try to 
disable legacy USB emulation in your BIOS, and see if the problem 
persists? (it will make USB keyboard unavailable in grub).

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
