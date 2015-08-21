From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Thu, 20 Aug 2015 17:06:01 -0700
Message-ID: <CAKdAkRTYuN5NKjCdYXnTQGqc7KOaM28TU80yJhO=-8rX1Dg+Bg@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
	<CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
	<20150820230840.GB12900@localhost>
	<20150820231339.GA7236@localhost>
	<CAMmwwr_ZGvMODEHEawV+06tWmtoA5pYZAx1dYX1x4CopybmtqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34308 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbHUAGC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 20:06:02 -0400
Received: by oiey141 with SMTP id y141so2449188oie.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 17:06:01 -0700 (PDT)
In-Reply-To: <CAMmwwr_ZGvMODEHEawV+06tWmtoA5pYZAx1dYX1x4CopybmtqA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Balla <gaborwho@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Gabor,

On Thu, Aug 20, 2015 at 4:35 PM, Gabor Balla <gaborwho@gmail.com> wrote:
> Hi Dmitry,
>
>> How about this one?
>
> It looks fine for me, I've also tested it and it works.

Thanks for trying it out!

> Still, can we do something about synaptics_set_disable_gesture() function too?
> Not sure what it does, but it certainly looks like it could break EWmode.
> I've included a possible solution.

As I mentioned this is called from a sysfs attribute and that
attribute is only created when the touchpad is used in relative mode,
so W-bit is guaranteed to be off when this fucntion is running.

Thanks.

-- 
Dmitry
