From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fun with sony motion controllers: navigation controller
Date: Mon, 16 Mar 2015 14:05:47 +0100
Message-ID: <20150316130547.GA20976@amd>
References: <20150314191917.GA3680@amd>
 <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52744 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbbCPNFt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 09:05:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, frank.praznik@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon 2015-03-16 13:55:39, Jiri Kosina wrote:
> On Sat, 14 Mar 2015, Pavel Machek wrote:
> 
> > Hi!
> > 
> > After oopsing kernel with ps/3 peripherals, I decided to play some
> > more.
> > 
> > First "sony motion controller" (part of ps/3 move without the
> > led). Good news is that it no longer oopses. After pressing the PS
> > button, it seems to work, but it produces endless stream of events in
> > evtest:
> > 
> > Event: time 1426360519.967818, type 3 (EV_ABS), code 0 (ABS_X), value 131
> > Event: time 1426360519.967818, type 3 (EV_ABS), code 1 (ABS_Y), value 129
> > Event: time 1426360519.967818, type 3 (EV_ABS), code 59 (ABS_MT_DISTANCE), value 513
> > Event: time 1426360519.967818, type 3 (EV_ABS), code 60 (ABS_MT_TOOL_X), value 513
> > 
> > Should it really produce multitouch events?
> 
> Some sony devices are producing multitouch events. You unfortunately 
> didn't send us the VID/PID of the device you are playing with.

Umm. I thought multitouch events are for touchscreen. This is joystick
with accelerometer...?

Device is:

[10920.396060] usb 2-1: new full-speed USB device number 2 using
uhci_hcd
[10920.676076] usb 2-1: New USB device found, idVendor=054c,
idProduct=042f
[10920.676082] usb 2-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[10920.676085] usb 2-1: Product: Navigation Controller
[10920.676088] usb 2-1: Manufacturer: Sony

> Frank, I guess you'll handle this report once Pavel provides the necessary 
> data? Thanks.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
