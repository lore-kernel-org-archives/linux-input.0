From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom_w8001 - drop use of ABS_MT_TOOL_TYPE
Date: Thu, 14 Jul 2016 09:42:29 -0700
Message-ID: <20160714164229.GA17106@dtor-ws>
References: <20160111035151.GA24743@jelly.redhat.com>
 <20160111081233.GA27512@dtor-ws>
 <CAKdAkRRtYyd37_-5LiVCBX=ajWF9O+hupk=4uw6Juc7LQxNdsQ@mail.gmail.com>
 <CAF8JNhJb4pxLjkdH7_X+AKTkBVtUD1Fbe9v_C2=q_sHptrvZgQ@mail.gmail.com>
 <20160714055759.GA4889@jelly.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35915 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbcGNQmd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2016 12:42:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id t190so31607979pfb.3
        for <linux-input@vger.kernel.org>; Thu, 14 Jul 2016 09:42:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160714055759.GA4889@jelly.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Ping Cheng <pinglinux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>

On Thu, Jul 14, 2016 at 03:57:59PM +1000, Peter Hutterer wrote:
> On Wed, Jul 13, 2016 at 05:22:30PM -0700, Ping Cheng wrote:
> > On Wednesday, July 13, 2016, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Mon, Jan 11, 2016 at 12:12 AM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > On Mon, Jan 11, 2016 at 01:51:51PM +1000, Peter Hutterer wrote:
> > > >> As of e0361b70175f0cd6199dd9ed6679632de73973d4
> > > >>   Input: wacom_w8001 - split the touch and pen devices into two devices
> > > >> the touch events aren't multiplexed over the same device anymore, the use of
> > > >> ABS_MT_TOOL_TYPE is superfluous. And even before then it only ever sent
> > > >> MT_TOOL_TYPE_FINGER anyway.
> > > >>
> > > >> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > >
> > > > Applied, thank you.
> > >
> > > Hmm, so I applied that but removal of input_mt_report_slot_state()
> > > means that we do not generate tacking IDs for the contacts.
> > 
> > You are right. I have a set of patches to clean up the code. It is
> > still under testing/reviewing...
> > 
> > >
> > > Revert?
> > 
> > It may be quicker to revert this one now. I'll submit the clean up set later.
> 
> yeah, I agree and we found another bug with these devices. It'll be easier
> to merge the fixed set.

OK, reverted (and revert marked for stable). I added your acks to the
revert commit.

Thanks!

-- 
Dmitry
