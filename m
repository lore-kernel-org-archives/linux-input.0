From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: Wonkiness with keyboard adapter - not sure if it's in USB or
	input systems
Date: Wed, 27 Apr 2011 18:27:18 +0100
Message-ID: <20110427172718.GA16118@gallifrey>
References: <11501.1303832820@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11501.1303832820@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> Running 2.6.39-rc1-mmotm at the moment on a Dell Latitude E6500, that wants an
> external USB keyboard/mouse and monitor when it's in its docking station in the
> office. I have an old Microsoft Natural keyboard that has a PS/2 connector, but
> I like the tactile feel so I didn't want to get rid of it.  So we recently got
> some PS2->USB adapters, which appear in lsusb as follows:
> 
> Bus 001 Device 006: ID 0e8f:0020 GreenAsia Inc. USB to PS/2 Adapter
> 
> Now, when I first power up the laptop in the docking station, it *does* see the
> keyboard just fine, and Grub is able to talk to it, and everything works (this
> particular boot, I was able to hit the space bar to get to the Grub menu, use
> arrow up/down to move between entries, all looked good).  So it isn't like the
> device needs any initialization above and beyond what the BIOS is doing at
> initial power-on.
> 
> However, when the Linux kernel starts up, it sees the adapter, but doesn't
> recognize key presses until I disconnect and then reconnect the keyboard:

I've experienced the same behaviour on at least two very different machines
(one a Tosh laptop, the other a Dell desktop), in both cases using a Model M
PS/2 keyboard connected to two different USB<->PS/2 converters (one a 
really ancient Belkin one and the other a recent no-name soap-on-a-rope type
thing).

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
