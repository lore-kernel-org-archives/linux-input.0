From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Fri, 12 Feb 2010 00:09:28 -0800
Message-ID: <20100212080928.GA7777@core.coreip.homeip.net>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
 <1265933946-8318-2-git-send-email-rafi@seas.upenn.edu>
 <1265933946-8318-3-git-send-email-rafi@seas.upenn.edu>
 <20100212004247.GB6394@core.coreip.homeip.net>
 <4B74C6AB.1010704@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:63714 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab0BLIJd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 03:09:33 -0500
Received: by gxk24 with SMTP id 24so2091538gxk.1
        for <linux-input@vger.kernel.org>; Fri, 12 Feb 2010 00:09:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B74C6AB.1010704@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

On Thu, Feb 11, 2010 at 10:10:35PM -0500, Rafi Rubin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >> +			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
> >> +			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
> >> +			input_mt_sync(input);
> >> +		}
> >> +	}
> > 
> > Where's the final input_sync()? And if hid does it for us (I think it does)
> > then syncs above are not needed.
> 
> It seems the normal input_sync calls are unnecessary for the single touch device.
> 
> The mt syncs are necessary to separate each contact.  And since we are caching the
> contacts we need to emit those.  The final normal input_sync is handled by hid.
> 
> On a side note, once I pulled the st input syncs, the mt device stopped getting them.
> I had to undo the blocking of CONTACTCOUNT which restores the normal syncs from hid.

Ah, these are 2 different devices... I need to increase my coffee
intake.

OK, so I re-read the patch again and it you are splittig the one
physical device in 2 - one legacy single tap and another multi-touch.
If I understand it correctly that means that the same gesture can be
potentially sent through bnoth devices. So in this case how system
should decide which device to use and which device to ignore?

-- 
Dmitry
