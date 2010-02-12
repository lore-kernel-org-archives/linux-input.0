From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Fri, 12 Feb 2010 11:41:14 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002121139410.30967@pobox.suse.cz>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <1265933946-8318-2-git-send-email-rafi@seas.upenn.edu> <1265933946-8318-3-git-send-email-rafi@seas.upenn.edu> <20100212004247.GB6394@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42608 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab0BLKlQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 05:41:16 -0500
In-Reply-To: <20100212004247.GB6394@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, chatty@enac.fr

On Thu, 11 Feb 2010, Dmitry Torokhov wrote:

> > +		} else if (nd->emit_ghosts) {
> > +			/* emit filler points if so desired */
> > +			input_event(input, EV_ABS, ABS_MT_TRACKING_ID, i);
> > +			input_event(input, EV_ABS, ABS_MT_POSITION_X, 0);
> > +			input_event(input, EV_ABS, ABS_MT_POSITION_Y, 0);
> > +			input_event(input, EV_ABS, ABS_MT_ORIENTATION, 0);
> > +			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
> > +			input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, 0);
> > +			input_mt_sync(input);
> > +		}
> > +	}
> 
> Where's the final input_sync()? And if hid does it for us (I think it does)
> then syncs above are not needed.

Yes, it does, in hidinput_report_event(), after the custom ->event() 
callback has finished.

Thanks a lot Dmitry for beating me looking at the patches, I really 
appreciate that.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
