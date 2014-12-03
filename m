From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/speaker: additional clicks and tones for future...
Date: Wed, 3 Dec 2014 14:52:29 -0800
Message-ID: <20141203225229.GE16951@dtor-ws>
References: <20141102001740.eklhad@comcast.net>
 <20141203195811.GB16951@dtor-ws>
 <20141103160258.eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:53013 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaLCWwd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 17:52:33 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so13681490igj.10
        for <linux-input@vger.kernel.org>; Wed, 03 Dec 2014 14:52:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141103160258.eklhad@comcast.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karl Dahlke <eklhad@comcast.net>
Cc: vojtech@ucw.cz, linux-input@vger.kernel.org

On Wed, Dec 03, 2014 at 04:02:58PM -0500, Karl Dahlke wrote:
> Thank you for your thoughtful reply.
> 
> > I do not think it is a good idea to add SND_PULSE as it can be easily
> > implemented by SND_TONE.
> 
> It isn't that simple.
> Example: if a tone is playing for any reason the clicks do not interrupt
> the tone. (It would sound terrible, I've tried it).
> Clicks and tones are different in spirit and in implementation,
> almost orthogonal, and my code manages all this.

Even if it sounds horrible why would not you want feedback for key press
if there is tone? Would you not rather want to know that key press has
been registered?

> 
> > Also, what if you want clicks to go through sound card and not the speaker
> 
> But you see, in my world, I precisely don't want that to happen,
> because sometimes the sound card isn't working.

I understand that you might not want to use sound card, that does not
mean that nobody else would now want it. There are boxes without pcspkr
or where speaker is provided by different module.

> There are lots of reasons a sound card might not work,
> alsa and modules and pulseaudio are more finicky than you might think,
> not to mention the speech adapters that sit on top of them.
> If any link in this chain is broken, I get no speech, period.
> If I then don't get the clicks or tones either, I'm really lost at sea.

You should be able to work directly with ALSA though, right? That would
cut some of the stack away.

> Thus the modules that I write,
> and that other people write as well,
> specifically send small diagnostics through the pc speaker,
> because that just might be all the feedback we have.
> Here is a good example, grub, or maybe it's grub2,
> can't reasonably be expected to work through a sound card,
> so it can actually generate morse code at the pc speaker to help us load
> the desired OS.

But grub is not an OS, so naturally it does not have sound card
support. It also does not support any of the haptic devices that might
be connected to the box but that does not mean that haptic devices are
not suitable as feedback devices.

> It's just a different philosophy that we have I guess.
> So instead of reinventing these routines over and over I thought it might be
> useful to have some of this common functionality in the pcspkr driver
> in the kernel.
> I mean it's already halfway there, this is just the other half.
> All managed just like tones are managed today.
> It's just the icing on the cake.
> 

I am sorry, but I still believe that doing this in pcspkr/tty would be
doing this at the wrong level and userspace solution would be the right
one.  It does not need to use real sound card if you prefer not to, but
I do not think it should prohibit using it or any other device that can
provide adequate feedback.

Thanks.

-- 
Dmitry
