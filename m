From: Nick Bowler <nbowler@draconx.ca>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Mon, 24 Aug 2015 19:44:21 -0400
Message-ID: <CAN_QmVy+MsjS7=9+13NaKJLcxe4o_xQVKvyX1+pV0usfnYzALg@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
	<CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
	<20150820230840.GB12900@localhost>
	<20150820231339.GA7236@localhost>
	<20150824175729.GC22442@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36241 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbHXXoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2015 19:44:21 -0400
Received: by ykfw73 with SMTP id w73so139183627ykf.3
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2015 16:44:21 -0700 (PDT)
In-Reply-To: <20150824175729.GC22442@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Gabor Balla <gaborwho@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Andrew Duggan <andrew.duggan@gmail.com>

On 2015-08-24, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 20, 2015 at 04:13:39PM -0700, Dmitry Torokhov wrote:
[...]
> > On Fri, Aug 21, 2015 at 1:01 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
[...]
> > > Ah, wait, not quite still. So we actually do want to disable
> > > gestures when in Absolute mode (non extended). Although frankly I
> > > do not think we'll ever see pre 4.0 Synaptics device in a wild.
[...]
> > How about this one?
>
> Nick, Benjamin, could you please give this a spin?
[...]
> > Input: synaptics - fix handling of disabling gesture mode

Applied on top of 4.1.6, appears to fix the trackpoint buttons on my X250.

Thanks,
  Nick
