From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC 1/2] input: mt: Add method to extract the MT slot state
Date: Fri, 28 Jan 2011 19:34:13 +0100
Message-ID: <20110128183413.GA2553@polaris.bitmath.org>
References: <1296124547-3323-1-git-send-email-benjamin.tissoires@enac.fr>
 <1296124547-3323-2-git-send-email-benjamin.tissoires@enac.fr>
 <20110127120603.GB15626@polaris.bitmath.org>
 <AANLkTim7DbxhEO7vHPFcC1PFf=d2mSEyL+wurzUQa0pg@mail.gmail.com>
 <20110128173355.GD2586@polaris.bitmath.org>
 <AANLkTikM-DguswOb6Hv5jgkrirfFf+MHTJgK_Xk45gz5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:42421 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755385Ab1A1Se7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 13:34:59 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikM-DguswOb6Hv5jgkrirfFf+MHTJgK_Xk45gz5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Jiri Kosina <jkosina@suse.cz>, Chris Bagwell <chris@cnpbagwell.com>, Rafi Rubin <rafi@seas.upenn.edu>, Stephane Chatty <chatty@lii-enac.fr>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > Thanks for the patches, Benjamin, perhaps they do need a bit of
> > rewrite or a new ioctl. We will see what happens.
> >
> 
> Today  I found a bug in these 2 patches: they send garbage with
> devices that use protocol A.
> This is definitely a bad idea to send the input_absinfo.
> 
> In addition to that, using the original behavior (which seems better)
> does not seems to add sth in regard to input_mt_get_value.
> It would just add some guards that can be resumed in just a test:
> (code >= ABS_MT_FIRST && code <= ABS_MT_LAST && dev->mt &&
> 	slot >= 0 && slot < dev->mtsize)
> 
> Henrik, if you want to introduce the new IOCTL, feel free, I don't
> need it right now.

Ok - for the record, neither of us actually re-initiated this thing,
so it still falls into the nice-to-have category. The good thing is
there is now a clear path on how to proceed.

Thanks Benjamin.

Henrik
