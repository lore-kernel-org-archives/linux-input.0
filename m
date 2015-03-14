From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fun with sony motion controllers: motion controller
Date: Sat, 14 Mar 2015 21:53:30 +0100
Message-ID: <20150314205330.GA10997@amd>
References: <20150314191917.GA3680@amd>
 <20150314192331.GA4089@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48835 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbCNUxc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Mar 2015 16:53:32 -0400
Content-Disposition: inline
In-Reply-To: <20150314192331.GA4089@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, jikos@suse.cz, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi!

> Second "sony motion controller" (part of ps/3 move with the big
> LED). The LED is something I'd really like to work.
> 
> It is detected:
> 
> [  741.363723] input: Sony Computer Entertainment Motion Controller as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:054C:03D5.000A/input/input19
> [  741.421269] hid-generic 0003:054C:03D5.000A: input,hiddev0,hidraw0:
> USB HID v1.10 Gamepad [Sony Computer Entertainment Motion Controller]
> on usb-0000:00:1d.0-1/input0
> 
> root@amd:~# evtest /dev/input/event7
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x54c product 0x3d5 version 0x110
> Input device name: "Sony Computer Entertainment Motion Controller"
> Supported events:
>   Event type 0 (EV_SYN)
>     Event type 1 (EV_KEY)
> ...
> Properties:
> Testing ... (interrupt to exit)
> 
> But no matter what I do, I don't get any events in evtest, or any
> changes in jstest.
> 
> /sys/class/power_supply does not appear and /sys/class/leds does not
> change.
> 
> Is this controller supported at all? What interface should be used for
> talking to the RGB LED?
> 
> Yes, I'd really like the LED to work. The rest would be nice bonus.

I tried adding USB id's to hid-sony.c, but no luck. But this is
strange:

pavel@amd:/data/l/linux/samples/hidraw$ sudo ./hid-example
/dev/hidraw3
Report Descriptor Size: 178
Report Descriptor:
5 1 9 5 a1 1 85 1 5 9 19 1 29 18 15 0 25 1 35 0 45 1 75 1 95 18 81 2 6
0 ff 9 24 75 8 95 3 81 2 5 1 9 30 9 31 9 32 9 35 15 0 26 ff 0 95 4 81
2 6 0 ff 9 20 95 26 81 2 85 2 9 21 95 30 91 2 85 6 9 27 95 8 91 2 85 3
9 23 95 8 b1 2 85 10 9 22 95 30 b1 2 85 e0 9 25 95 30 b1 2 85 11 9 26
95 30 b1 2 c0 6 2 ff 9 20 a1 1 9 21 85 4 15 0 26 ff 0 75 8 95 f b1 2 9
22 85 5 95 16 b1 2 c0 6 3 ff 9 20 a1 1 9 21 85 a0 15 0 26 ff 0 75 8 95
22 b1 2 9 22 85 a1 95 16 b1 2 c0

Raw Name: Sony Computer Entertainment Motion Controller
Raw Phys: usb-0000:00:1d.0-1/input0
Raw Info:
    bustype: 3 (USB)
    	     vendor: 0x054c
	     	     product: 0x03d5
		     HIDIOCSFEATURE: Broken pipe
		     HIDIOCGFEATURE: Broken pipe
		     write() wrote 2 bytes
		     read: Resource temporarily unavailable
		     pavel@amd:/data/l/linux/samples/hidraw$

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
