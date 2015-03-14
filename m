From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fun with sony motion controllers: motion controller
Date: Sat, 14 Mar 2015 20:23:31 +0100
Message-ID: <20150314192331.GA4089@amd>
References: <20150314191917.GA3680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44687 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbCNTXd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Mar 2015 15:23:33 -0400
Content-Disposition: inline
In-Reply-To: <20150314191917.GA3680@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, jikos@suse.cz, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi!

Second "sony motion controller" (part of ps/3 move with the big
LED). The LED is something I'd really like to work.

It is detected:

[  741.363723] input: Sony Computer Entertainment Motion Controller as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/0003:054C:03D5.000A/input/input19
[  741.421269] hid-generic 0003:054C:03D5.000A: input,hiddev0,hidraw0:
USB HID v1.10 Gamepad [Sony Computer Entertainment Motion Controller]
on usb-0000:00:1d.0-1/input0

root@amd:~# evtest /dev/input/event7
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x54c product 0x3d5 version 0x110
Input device name: "Sony Computer Entertainment Motion Controller"
Supported events:
  Event type 0 (EV_SYN)
    Event type 1 (EV_KEY)
...
Properties:
Testing ... (interrupt to exit)

But no matter what I do, I don't get any events in evtest, or any
changes in jstest.

/sys/class/power_supply does not appear and /sys/class/leds does not
change.

Is this controller supported at all? What interface should be used for
talking to the RGB LED?

Yes, I'd really like the LED to work. The rest would be nice bonus.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
