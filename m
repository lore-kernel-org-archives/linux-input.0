From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ff-core effect id handling in case of a failed effect upload
Date: Wed, 19 Feb 2014 13:05:23 -0800
Message-ID: <20140219210523.GA13951@core.coreip.homeip.net>
References: <CADbOyBRX8Zd=WyXpgWo8Kkg5HkAJHjSA0KCiJD_36PLiSKAQJQ@mail.gmail.com>
 <5304E0A0.5070007@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:59231 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbaBSVF1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 16:05:27 -0500
Received: by mail-pd0-f178.google.com with SMTP id fp1so883536pdb.9
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 13:05:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5304E0A0.5070007@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Elias Vanderstuyft <elias.vds@gmail.com>, linux-input@vger.kernel.org, wine-devel@winehq.org

On Wed, Feb 19, 2014 at 06:49:36PM +0200, Anssi Hannula wrote:
> (added Dmitry to CC)
> 
> 19.02.2014 13:42, Elias Vanderstuyft kirjoitti:
> > Hi,
> > 
> 
> Hi,
> 
> > In the process of reviewing the Wine DInput translation layer, I
> > noticed an inconvenience (in the ff-core implementation?) that can
> > possibly lead to confusing problems to application developers (not
> > only for Wine), in short:
> > If a new (id==-1) effect was uploaded (look at
> > ff-core.c::input_ff_upload(...)) that failed (e.g. returning EINVAL),
> > ff-core will have assigned a positive number to the effect id. This
> > can be confusing because the dev->ff->effects[] array will not contain
> > an element at the index of that new effect id.
> 
> I agree that this is a bit confusing, and the kernel code should
> probably be modified to not clobber the ioctl-provided effect on failure
> (effect->id is set to an "undefined" value, i.e. next free effect slot).
> 
> Dmitry, WDYT?

Yeah, it looks like we need to change evdev.c to read:

		error = input_ff_upload(dev, &effect, file);
		if (error)
			return error;

		if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
			return -EFAULT;

		return 0;

Unfortunately applications should still expect changed effect ID for
quite some time.

Thanks.

-- 
Dmitry
