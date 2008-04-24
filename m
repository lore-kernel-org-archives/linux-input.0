From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC] ucb1400 touchscreen, irq auto probing and	ac97 with its private field
Date: Thu, 24 Apr 2008 22:33:28 +0100
Message-ID: <20080424213328.GD19029@sirena.org.uk>
References: <20080424140459.GB24212@Chamillionaire.breakpoint.cc> <20080424145749.GB22369@sirena.org.uk> <20080424150211.GC22369@sirena.org.uk> <20080424154410.GE26452@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3678 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbYDXVdg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 17:33:36 -0400
Content-Disposition: inline
In-Reply-To: <20080424154410.GE26452@Chamillionaire.breakpoint.cc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Cc: Jaroslav Kysela <perex@perex.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Thu, Apr 24, 2008 at 05:44:10PM +0200, Sebastian Siewior wrote:
> * Mark Brown | 2008-04-24 16:02:12 [+0100]:

> >> [3] is the issue with the WM97xx touchscreen drivers.  That's currently
> >> solved by exactly this issue - as far as I can see from the patch you

> >The second issue should be method.

> I don't think that this is the right way in this case:

Sorry, I didn't mean to suggest that this was desperately elegant.

> - this information equals a global variable. You can't have two
>   touchscreens without extra hacking.

Indeed.  In this case it doesn't really matter since it's vanishingly
unlikely that any such systems would actually exist.

> - if we keep doing this for all drivers (not just ucb1400) they gonna
>   look like drivers/usb/host/ehci-hcd.c (look line 998+) once this chip
>   spreads across buses.

The WM97xx driver avoids this by registering a child driver for the
platform code to bind to.  Again, I don't mean to suggest that this is
particularly elegant.
