From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Elo TouchSystems touchscreen support? (04e7:0022)
Date: Wed, 18 May 2011 23:14:17 +0100
Message-ID: <1305756860.2010.2.camel@novo.hadess.net>
References: <1296485689.7756.9.camel@novo.hadess.net>
	 <20110131212842.GB1603@polaris.bitmath.org>
	 <AANLkTi=8O=p6-zTdMete7uhrT5OKODZXROKyoGPURJ3h@mail.gmail.com>
	 <1296561717.15349.5.camel@novo.hadess.net>
	 <AANLkTim=RV1Cd0k08gv-DDho-Mim64bR7RRJ+c7D1RZf@mail.gmail.com>
	 <1296650569.2123.2.camel@novo.hadess.net>
	 <AANLkTinOK+=J64NRWZjit3S7hAdGVXxRE9HYkxTxrxON@mail.gmail.com>
	 <AANLkTi=MGNLfLHQpVEyJGtE-j-D0dj-RWXAihW1xMKDe@mail.gmail.com>
	 <1296922260.4223.4.camel@novo.hadess.net>
	 <AANLkTi=yTh4YSPSQBnPFPyen9vfyfYGiT6GJVEKwGHjh@mail.gmail.com>
	 <1297098262.29885.14.camel@novo.hadess.net>
	 <AANLkTikxyJWxGH2P4WXMHqCbyOuKJaGgMBjxAWRsAREw@mail.gmail.com>
	 <AANLkTinfLunV5viac9vrvGfOwd-Z17ryJdfro9gtp+yB@mail.gmail.com>
	 <1298045713.2049.54.camel@novo.hadess.net>
	 <AANLkTik+xiJZNo8wcg=BpuwJnRA-0grgiW6P0VaKfGjH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47829 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab1ERWOX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 18:14:23 -0400
In-Reply-To: <AANLkTik+xiJZNo8wcg=BpuwJnRA-0grgiW6P0VaKfGjH@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Hello Benjamin,

On Fri, 2011-02-18 at 21:03 +0100, Benjamin Tissoires wrote:
> On Fri, Feb 18, 2011 at 17:15, Bastien Nocera <hadess@hadess.net> wrote:
> > On Tue, 2011-02-08 at 15:47 +0100, Benjamin Tissoires wrote:
> >> Hi Bastien,
> >>
> >> Can you give a try to the attached patch (it goes on top of the previous patch).
> >> It would be great if you could play a little with mtdiag (or any other
> >> multitouch application) and tell me if there is any problem.
> >
> > The patch to work well, at least for touches with a single finger. I
> > launched mtdiag, but I have absolutely no idea what to test with it.
> >
> > Hints?
> >
> >
> 
> Hi,
> 
> If you run mtdiag as root, your multitouch panel should appear with a
> button "activate".
> Click on activate, and it will show up a canvas in which the different
> touch you made on the panel will be represented by a circle. The
> bigger circle represents the mouse emulation of the device.

I finally took the time to build and test those patches you sent me, on
top of the Fedora 15 kernel, and they work great. When in fullscreen,
mtdiag works as expected though the roughness of touch is probably
because my screen is dirty as hell :)

Could you please get those pushed upstream?

Thanks for the work.

Cheers

