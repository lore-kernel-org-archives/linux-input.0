From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fun with sony motion controllers: navigation controller
Date: Mon, 16 Mar 2015 23:28:46 +0100
Message-ID: <20150316222846.GA22289@amd>
References: <20150314191917.GA3680@amd>
 <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
 <20150316130547.GA20976@amd>
 <alpine.LNX.2.00.1503161453010.25438@pobox.suse.cz>
 <5506F628.1050901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5506F628.1050901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> >I am sure Frank will comment on this as well.
> 
> The Dualshock 3 is a special case in that every button except for start,
> select and the PS button are both digital and analog.  As such, the
> controller reports 27 axes that end up spilling over into the ABS_MT values.
> This mapping comes from the default HID descriptor from the device, so it's
> been this way from day 1.  If the navigation controller is basically the
> same as a DS3 then it will have the same issues.
> 
> To note, the DS3 only has 20 actual, physical axes meaning that 7 of the
> reported axes don't even do anything and I'm not sure why they are there.
> The HID descriptor could be rewritten to map everything in a more correct
> manner, but that would break the mapping that has been there for 8 or 9
> years at this point and probably break some user-space applications in the
> process.

Ok, makes sense, but could this go to the beggining of hid-sony.c file
as a comment, so that it is easy to find?

And BTW to you know anything about the other move controller? I have
code to light the LED (which I really wanted), but can't get other
data. In particular, I'd like temperature ;-).

[18788.740182] usb 2-2: new full-speed USB device number 2 using uhci_hcd
[18788.906163] usb 2-2: New USB device found, idVendor=054c, idProduct=03d5
[18788.906173] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[18788.906179] usb 2-2: Product: Motion Controller
[18788.906184] usb 2-2: Manufacturer: Sony Computer Entertainment
[18788.924254] input: Sony Computer Entertainment Motion Controller as
/devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:054C:03D5.0002/input/input12
[18788.981391] sony 0003:054C:03D5.0002: input,hidraw0: USB HID v1.10
Joystick [Sony Computer Entertainment Motion Controller] on
usb-0000:00:1d.0-2/input0

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
