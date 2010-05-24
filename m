From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Mon, 24 May 2010 11:04:12 -0700
Message-ID: <20100524180411.GA6033@core.coreip.homeip.net>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>
 <20100524155901.GB3182@core.coreip.homeip.net>
 <AANLkTin9ahtqL7jrUP4C0zF9-P3rUg7ktN93-hcqdDnj@mail.gmail.com>
 <201005241021.02731.dmitry.torokhov@gmail.com>
 <4BFABBD0.9020202@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:49606 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0EXSES (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 14:04:18 -0400
Content-Disposition: inline
In-Reply-To: <4BFABBD0.9020202@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

On Mon, May 24, 2010 at 07:48:00PM +0200, Henrik Rydberg wrote:
> Dmitry Torokhov wrote:
> [...]
> >>>> I think we need to add an ioctl to enable user land driver/client to
> >>>> signal the kernel driver to send all events without filtering, just
> >>>> once. Hot-plugged devices and X driver starts after user has contacted
> >>>> with the device are two examples that the client would miss filtered
> >>>> events.
> >>>>
> >>>> Dmitry, do you think it is a valid suggestion?
> >>> What about using EVIOCGKEY/EVIOCGSW/EVIOCGABS?
> >> Those EVIOCs only give us the static values (max/min/supported keys,
> >> etc.).  We need their dynamic input data here, the actual x, y,
> >> button, pressure, etc. Am I missing something about those EVIOs?
> >>
> > 
> > Yes you are ;) Supported events are reported via EVIOCGBIT, EVIOCGKEY and
> > EVIOCGSW will return current state of keys/switches. As far as EVIOCGABS
> > goes, it also returns, besides min/max/etc, last reported _values_ of the
> > ABS_* events.
> > 
> 
> Ping is not alone. :-)
> 
> But it does not work for MT events -- yet.
> 

Yes, this is true.

I think the most interesting is the switch data, since they may not change
at all. The rest is transient and should refresh "fairly quickly".

-- 
Dmitry
