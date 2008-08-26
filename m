From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [patch]full runtime power management for usbhid
Date: Tue, 26 Aug 2008 16:28:49 +0200
Message-ID: <20080826142848.GB5496@ucw.cz>
References: <200808261139.14410.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4644 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756812AbYHZO24 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2008 10:28:56 -0400
Content-Disposition: inline
In-Reply-To: <200808261139.14410.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi!

> this patch enables full runtime power management for usbhid.
> Currently usbhid supports autosuspend only upon open and close. Thus
> it is useless for devices which are always opened, such as keyboards
> and mice. This patch enables the use of remote wakeup for devices that
> support it.
> 
> It suspends idle usb hid devices after a timeout if possible unless
> 
> - hiddev has opened the device
> - error handling is under way
> - a key is being held down
> (keyboards don't signal remote wakeup upon release of a key)
> - an led is active on the device
> (leds use too much power for a suspend device to keep lit -
> this can be overridden with a module parameter)

Hmm... so numlock now costs ~3W... perhaps we should be defaulting to
numlock=off, again?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
