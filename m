From: Pavel Machek <pavel@ucw.cz>
Subject: Re: patch staging-htc-dream-touchscreen-driver-for-staging.patch
	added to gregkh-2.6 tree
Date: Tue, 28 Jul 2009 00:55:46 +0200
Message-ID: <20090727225545.GC7142@elf.ucw.cz>
References: <20090720105340.GF19341@elf.ucw.cz> <1248710770577@kroah.org> <d6200be20907271545l4edc4480v22f6dec4cd3d5dc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44105 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbZG0Wzz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2009 18:55:55 -0400
Content-Disposition: inline
In-Reply-To: <d6200be20907271545l4edc4480v22f6dec4cd3d5dc9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: gregkh@suse.de, greg@kroah.com, swetland@google.com, linux-input@vger.kernel.org

On Mon 2009-07-27 15:45:48, Arve Hj?nnev?g wrote:
> On Mon, Jul 27, 2009 at 9:06 AM, <gregkh@suse.de> wrote:
> ...
> > This is original version from Arve, fixed only to compile; I do have
> > cleaner version, but I broken something inside, and this will preserve
> > authorship better. I originally tried to push the driver directly to
> > input/touchscreen, but the driver has some issues with interrupt
> > handling that are more difficult to fix than I expected at first.
> >
> 
> While it would be nice to use the threaded interrupt support, I don't
> see why that change cannot be postponed until the the threaded
> interrupt code supports this class of devices where the interrupt
> needs to be masked before the thread can run.

That's up to linux-input people, I guess. But... 

>From the discussion, it seems that the driver has more issues. I have
quite long list.

1) either it needs to switch to threaded interrupt supports, or all
the races need to be fixed.

[Comments I remember here is:]

(
> > +           ts->input_dev->name, ts->use_irq ? "interrupt" :
"polling");
> > +
> > +   return 0;
> > +
> > + err_input_register_device_failed:
> > +   input_free_device(ts->input_dev);
> > +
>
> Don't see canceling timer nor shutting off WQ here. Also, maybe
> implement open() and close() so we don't reschedule WQ while polling?_
)

2) it uses non-standard multitouch support. Either multitouch needs to
be disabled for merge, or it needs to switch to standard config.

3) poll mode should probably be removed.

4) minor stuff, like properly filling identification fields
(vendor/device/product) etc.

Yes, ideally it should be 3 or 4 patches and it is out of staging and
in the kernel proper. But as I already got patches for people trying
to help with cleaning, I believe staging is right place for
it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
