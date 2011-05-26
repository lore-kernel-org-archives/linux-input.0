From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: evdev - only signal polls on full packets
Date: Thu, 26 May 2011 00:47:35 -0700
Message-ID: <20110526074735.GA1388@core.coreip.homeip.net>
References: <BANLkTikUByGxerUPwXTN1E3g8E_cCvyaXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:52823 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab1EZHrl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2011 03:47:41 -0400
Received: by pxi16 with SMTP id 16so270034pxi.4
        for <linux-input@vger.kernel.org>; Thu, 26 May 2011 00:47:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikUByGxerUPwXTN1E3g8E_cCvyaXA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: linux-input@vger.kernel.org

Hi Jeffrey,

On Thu, May 26, 2011 at 12:37:22AM -0700, Jeffrey Brown wrote:
> Hi Dmitry,
> I was just reviewing the final patch for the EV_SYN wake-up
> optimization.  I'm glad to see it made it in.  It'll let me strip out
> some unsightly hacks elsewhere.  :)
> 
> Anyways, my original patch contained this proposed change to
> evdev_event, which seems to have been accidentally omitted:
> 
> -       wake_up_interruptible(&evdev->wait);
> +       if (full_sync)
> +               wake_up_interruptible(&evdev->wait);
>  }
> 
> The idea was that we should only wake waiters on the event device when
> we actually post an EV_SYN / SYN_REPORT to the queue.  Otherwise we
> end up making waiting threads runnable again only for them to go right
> back to sleep because the device still isn't readable.
> 
> So I think we want something like this in evdev_event:
> 
> if (type == EV_SYN && code == SYN_REPORT)
>    wake_up_interruptible(&evdev->wait);
> 
> What do you think?

Yep, it looks like in all this code shuffling I did miss that piece.
I'll fix that up, thanks for noticing.

-- 
Dmitry
