From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PROBLEM: 3.8.0-rc4 keyboard failure at boot
Date: Tue, 22 Jan 2013 14:51:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301221449090.20374@pobox.suse.cz>
References: <20130121213604.GA31225@16s.us> <20130122001346.GD16638@core.coreip.homeip.net> <alpine.LNX.2.00.1301221122380.20374@pobox.suse.cz> <20130122121947.GB27072@16s.us> <alpine.LNX.2.00.1301221341550.20374@pobox.suse.cz>
 <20130122134658.GA27683@16s.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130122134658.GA27683@16s.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Brad Tilley <brad@16s.us>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 22 Jan 2013, Brad Tilley wrote:

> > Could you please provide dmesg output from both working and non-working 
> > case?
> 
> See attached. Two dmesgs from the same machine. One from 3.7.3, the 
> other from 3.8-rc4 (with a ps2 keyboard). USB keyboards on this machine 
> never work with 3.8, but always works with 3.7.
> 
> I used an old ps2 keyboard to enter the dm-crypt password. After that, 
> the boot process continues and the USB keyboard and mouse become active 
> and begin to work. However, USB keyboards do not work when the user is 
> prompted to enter the dm-crypt decryption password early in the boot 
> process. That's the primary issue.

Ah, I see, that's a very important piece of information. This might be 
related to USB BIOS handoff then.

Do you happen to have "Legacy USB" option (or similar, such as "USB 
emulation" the name is not consistent between different BIOS vendors and 
versions) in your BIOS? Does toggling it change the behavior?

Adding linux-usb@ to CC.

> 
> > Also /proc/bus/input/devices content would be interesting (in case you are 
> > able to log remotely into the machine).
> 
> See attached. One from 3.7.3 the other from 3.8-rc4 (again, the 3.8 
> kernel is using a ps2 keyboard and a USB keyboard).
> 
> > Does replugging the keyboard fix the problem with 50% probability?
> 
> Replugging the keyboard does not fix the problem, nor does plugging it 
> into different USB ports or swapping USB keyboards.
> 
> > Are other USB devices (such as mice) affected by this as well?
> 
> Users are attempting to enter the dm-crypt decryption password during 
> boot so they have not noticed nor complained about mouse failure, only 
> keyboard failure.

-- 
Jiri Kosina
SUSE Labs
