From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ff-core effect id handling in case of a failed effect upload
Date: Sat, 22 Feb 2014 22:30:43 -0800
Message-ID: <20140223063043.GB10151@core.coreip.homeip.net>
References: <CADbOyBRX8Zd=WyXpgWo8Kkg5HkAJHjSA0KCiJD_36PLiSKAQJQ@mail.gmail.com>
 <5304E0A0.5070007@iki.fi>
 <20140219210523.GA13951@core.coreip.homeip.net>
 <CADbOyBSR+CWouAQ+f7VjJcoqiC_J++O7cnjkx+2DqmQorhQ7wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62284 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaBWGaq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 01:30:46 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so5241248pab.9
        for <linux-input@vger.kernel.org>; Sat, 22 Feb 2014 22:30:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADbOyBSR+CWouAQ+f7VjJcoqiC_J++O7cnjkx+2DqmQorhQ7wg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, linux-input@vger.kernel.org, wine-devel@winehq.org

On Wed, Feb 19, 2014 at 11:14:18PM +0100, Elias Vanderstuyft wrote:
> On Wed, Feb 19, 2014 at 10:05 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Feb 19, 2014 at 06:49:36PM +0200, Anssi Hannula wrote:
> >> (added Dmitry to CC)
> >>
> >> 19.02.2014 13:42, Elias Vanderstuyft kirjoitti:
> >> > Hi,
> >> >
> >>
> >> Hi,
> >>
> >> > In the process of reviewing the Wine DInput translation layer, I
> >> > noticed an inconvenience (in the ff-core implementation?) that can
> >> > possibly lead to confusing problems to application developers (not
> >> > only for Wine), in short:
> >> > If a new (id==-1) effect was uploaded (look at
> >> > ff-core.c::input_ff_upload(...)) that failed (e.g. returning EINVAL),
> >> > ff-core will have assigned a positive number to the effect id. This
> >> > can be confusing because the dev->ff->effects[] array will not contain
> >> > an element at the index of that new effect id.
> >>
> >> I agree that this is a bit confusing, and the kernel code should
> >> probably be modified to not clobber the ioctl-provided effect on failure
> >> (effect->id is set to an "undefined" value, i.e. next free effect slot).
> >>
> >> Dmitry, WDYT?
> >
> > Yeah, it looks like we need to change evdev.c to read:
> >
> >                 error = input_ff_upload(dev, &effect, file);
> >                 if (error)
> >                         return error;
> >
> >                 if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
> >                         return -EFAULT;
> >
> >                 return 0;
> 
> Alright, who will create the patch?
> Do I may / have to do it?

If you could create the patch that would be appreciated.

Thanks.

-- 
Dmitry
