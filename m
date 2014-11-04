From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Tue, 4 Nov 2014 10:06:48 -0800
Message-ID: <20141104180648.GA440@dtor-ws>
References: <54424770.9090600@gmail.com>
 <20141021223311.GG8609@dtor-ws>
 <544889FD.5030004@gmail.com>
 <54489803.9030803@selasky.org>
 <CAF8JNhJ8ZR5vvtcrOvv9-ySzN4aytBziEO90_Kif=Q4q7WgwmA@mail.gmail.com>
 <54548E63.6060306@selasky.org>
 <20141104080816.GB13100@dtor-ws>
 <CAF8JNhLPgG-dROf2f0Z6_8UBN7e_o_uicUDrO2sn+2yPgqdCmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:57942 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaKDSGx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2014 13:06:53 -0500
Received: by mail-ie0-f171.google.com with SMTP id x19so8060149ier.16
        for <linux-input@vger.kernel.org>; Tue, 04 Nov 2014 10:06:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAF8JNhLPgG-dROf2f0Z6_8UBN7e_o_uicUDrO2sn+2yPgqdCmQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Hans Petter Selasky <hps@selasky.org>, Denis Akiyakov <d.akiyakov@gmail.com>, linux-input <linux-input@vger.kernel.org>, "nox@jelal.kn-bremen.de >> Juergen Lock" <nox@jelal.kn-bremen.de>

On Tue, Nov 04, 2014 at 09:38:38AM -0800, Ping Cheng wrote:
> Hi Dmitry,
> 
> On Tue, Nov 4, 2014 at 12:08 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sat, Nov 01, 2014 at 08:40:19AM +0100, Hans Petter Selasky wrote:
> >> On 11/01/14 00:27, Ping Cheng wrote:
> >> >If touch_input is NULL on FreeBSD, you need to figure out the root
> >> >cause. Checking on touch_input itself would not fix the root cause...
> >>
> >> Right.
> >>
> >> The root cause is that FreeBSD launches two instances of the driver,
> >> running in two different userland processes, for the two different
> >> Wacom interfaces on a common USB device. In Linux the wacom
> >> interface drivers are running from the same kernel, and can share
> >> the data in question, but in FreeBSD's webcamd emulation, this
> >> doesn't work. Then the first wacom probe call would have to grab the
> >> second interface.
> >>
> >> Technically speaking this is a FreeBSD only problem and I plan to
> >> deliver a patch with the webcamd software to fix this, like already
> >> suggested to you guys. This situation can also happen on Linux in
> >> case of a "BadUSB" device. That's why I think that the NULL check
> >> should be upstreamed.
> >
> > Hmm, looking at this again it seems that we just cross our fingers and
> > hope that both interfaces are enumerated by the time we get event data
> > from the device. I do not think this is quite safe. We probably should
> > be checking the overall state of probing (i.e. whether we are done
> > probing both interfaces) before processing data for the device.
> 
> Are you going to make a patch to address the issue?

Not in the nearest future, sorry.

> 
> > Or maybe we should just forcibly try claiming secondary interface
> > while probing primary instead of messing with shared data item.
> 
> If we incorporate the above idea into a patch, we need to keep in mind
> that not all tablets support touch data. So, not all tablets have two
> interfaces.

Right, but we do know the models that use multiple interfaces, right?

-- 
Dmitry
