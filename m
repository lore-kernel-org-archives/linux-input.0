From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: ff-memless: Change FF_ENVELOPE_INTERVAL to a
 module parameter.
Date: Thu, 3 Sep 2015 10:41:17 -0700
Message-ID: <20150903174117.GA19537@dtor-ws>
References: <1440762993-31329-1-git-send-email-kalle.jokiniemi@jolla.com>
 <20150829002925.GA8298@dtor-ws>
 <55E4148A.5050109@jolla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33132 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbICRlV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:41:21 -0400
Received: by pacex6 with SMTP id ex6so48152791pac.0
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2015 10:41:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55E4148A.5050109@jolla.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Cc: linux-input@vger.kernel.org

On Mon, Aug 31, 2015 at 11:47:06AM +0300, Kalle Jokiniemi wrote:
> Hi,
> 
> On 29.08.2015 03:29, Dmitry Torokhov wrote:
> >Hi Kalle,
> >
> >On Fri, Aug 28, 2015 at 02:56:33PM +0300, Kalle Jokiniemi wrote:
> >>Sometimes you need to have tighter control over the ff-memless
> >>effects. E.g. when creating short button / VKB press effects,
> >>the effect duration is typically <= 40ms, and you want to have
> >>a short acceleration period in beginning and fade out the end
> >>to avoid "electric tooth brush" effect. With 50ms envelope
> >>interval this control is not possible.
> >>
> >>To allow this control without patching over ff-memless, change the
> >>FF_ENVELOPE_INTERVAL macro to a module parameter that can be modified
> >>via kernel command line or during runtime from
> >>/sys/module/ff_memless/parameters/ff_envelope_interval sysfs file.
> >
> >How would users know that they need to change this parameter? Could we
> >maybe adjust sampling time dynamically, based on the attack length of
> >the envelope?
> 
> Well, I'm looking after some parts of the Sailfish OS haptics /
> vibrator parts, and consider myself a user. For haptic effects (e.g.
> the VKB example above), I know I need as short as I can get to be
> able to tune those effects to work best with the Hardware I'm
> working with. Then for long alarm vibrations, the interval doesn't
> matter that much. But typically I would just set it to the smallest
> I can get with HZ setting the kernel has.
> 
> I've been thinking the "user" for this setting more as a system
> administrator / OS maintainer / device maker setting. But your idea
> could maybe work. Top of my head the downside would be added
> complexity, and slight "unpredictability" of the function if the
> timing changes dynamically. Would we then again need a user space
> setting for the threshold where to start using longer timers?

I'd say keep the interval between [5,50] msecs and scale it that you
have at least N points for the attack duration. I.e if you decide that
you want at least 8 points you do:

	interval = attack_duration / 8;
	interval = clamp_val(interval, 5, 50);

> 
> BTW, how would you feel about hr timers instead of jiffy based
> timing in ff-memless? That is a bit of a bottle neck for me (I see
> some jitter on the first event and typical 100Hz kernel only gives
> 10ms control interval).

I do not have objections to doing this.

Thanks.

-- 
Dmitry
