From: Pavel Machek <pavel@suse.cz>
Subject: Re: proposal on runtime power management in hid
Date: Sat, 1 Nov 2008 19:30:24 +0100
Message-ID: <20081101183024.GA1531@ucw.cz>
References: <200810301704.01005.oliver@neukum.org> <alpine.LNX.1.10.0810310015250.31273@jikos.suse.cz> <200810311026.29916.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47900 "EHLO UNKNOWN"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752010AbYKASal (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 1 Nov 2008 14:30:41 -0400
Content-Disposition: inline
In-Reply-To: <200810311026.29916.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jslaby@suse.cz>, linux-pm@vger.kernel.org

Hi!

> > I think the simple and working solution would be never suspedning devices 
> > that have interface open through hidraw, unless user explicitly allows 
> > this through respective power/autosuspend setting in sysfs (which will by 
> > default be set to 'off' for HID devices anyway, right?).
> 
> That we already have. That's the simple copout. Do not enable autosuspend
> if you allow hidraw for a device. However, if normal users shall be able to use
> the hidraw device that means that autosuspend can never be enabled for the
> device, as we don't know when someone will use the device.
> 
> For hiddev we can do better, the device is not autosuspended while it is
> open. This allows allowing ordinary users to use the device. Doing so for
> hidraw would require to extended the low level hid API. But not as extensively
> as I suggested.
> 
> But I consider this to be a lost opportunity.
> Currently the ll driver must assume that the device is required to be fully
> operational when it is open. This means different things for ordinary input
> devices and "raw" devices. Raw devices must not be autosuspended when
> open at all. Ordinary devices must be able to process input.
> 
> But that is often overkill. In many situations, for example when a the screen
> saver is running, you only care that a key has been pressed, not which key.
> Drivers can save more power if they know this.


...way more power in some cases. Yes, I'd love to see interface like
that.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
