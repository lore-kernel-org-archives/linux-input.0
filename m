From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 2/3] Input: ALPS - Clean up TrackStick handling for
 SS5 hardware
Date: Thu, 10 Nov 2016 16:19:42 +0100
Message-ID: <20161110151942.GA3969@pali>
References: <20161024210122.GA2919@TopQuark.net>
 <20161108151430.GN2927@TopQuark.net>
 <20161108151621.GO2927@TopQuark.net>
 <20161109121443.GC19557@pali>
 <20161110142739.GT2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35775 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933884AbcKJPTu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Nov 2016 10:19:50 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so3806111wme.2
        for <linux-input@vger.kernel.org>; Thu, 10 Nov 2016 07:19:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161110142739.GT2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Thursday 10 November 2016 09:27:39 Paul Donohue wrote:
> On Wed, Nov 09, 2016 at 01:14:43PM +0100, Pali Rohár wrote:
> > On Tuesday 08 November 2016 10:16:21 Paul Donohue wrote:
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -1267,18 +1267,11 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
> > >  	case SS4_PACKET_ID_STICK:
> > > +		f->st.x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
> > > +		f->st.y = -(s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
> > > +		f->pressure = (s8)(p[4] & 0x7f);
> > 
> > This is not correct. Those fields values are used for single touch
> > events from touchpad -- not from trackstick.
> > 
> > Btw, you have access to packet also in process functions, so you can
> > extract x, y and pressure in process function too.
> 
> I was trying to keep all of the decoding logic in alps_decode_ss4_v2().
> And since there aren't any fields specifically for the trackstick in
> alps_fields, I figured the single touch fields would be an appropriate
> place to stash those coordinates.
> 
> But if you would prefer to move some of the trackstick decoding logic to
> alps_process_packet_ss4_v2(), I can do that.

I see that e.g. alps_process_packet_v1_v2() or alps_process_packet_v6()
or alps_process_trackstick_packet_v3() having decode logic... So for me
it make sense to have it same also in ss4. But if some other developers
prefer something different, let us know!

>From current code I understand that decode functions are there to fill
"struct alps_fields" and process functions to process and send events.

I would suggest to read code for other alps protocol versions and have
similar behaviour for ss4 as for other protocol versions. At least this
produce code which will be consistent...

-- 
Pali Rohár
pali.rohar@gmail.com
