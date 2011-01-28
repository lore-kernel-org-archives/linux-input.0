From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 12:54:04 -0800
Message-ID: <20110128205403.GI6252@core.coreip.homeip.net>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
 <20110128173048.GC2586@polaris.bitmath.org>
 <AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
 <20110128184654.GG6252@core.coreip.homeip.net>
 <AANLkTikgTYQvhTzEHWw0Yhigno7TLJ8jm9jaw10mOhk+@mail.gmail.com>
 <20110128193731.GH6252@core.coreip.homeip.net>
 <AANLkTi=31ckFhy28R30=64+BBmHkn43DA8js1b0pdoQ4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54635 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1A1UyQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 15:54:16 -0500
Received: by iyj18 with SMTP id 18so2950777iyj.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 12:54:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=31ckFhy28R30=64+BBmHkn43DA8js1b0pdoQ4@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 12:08:18PM -0800, Ping Cheng wrote:
> On Fri, Jan 28, 2011 at 11:37 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Fri, Jan 28, 2011 at 11:01:39AM -0800, Ping Cheng wrote:
> >> On Fri, Jan 28, 2011 at 10:46 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Fri, Jan 28, 2011 at 10:23:59AM -0800, Ping Cheng wrote:
> >> >> On Fri, Jan 28, 2011 at 9:30 AM, Henrik Rydberg <rydberg@euroma=
il.se> wrote:
> >> >> > Hi Ping,
> >> >> >
> >> >> >> This is mainly required by the serial pen and touch devices =
since
> >> >> >> both pen and touch are on the same port. Updated the USB one=
s to
> >> >> >> keep MT event definition consistent among serial and USB dev=
ices.
> >> >> >
> >> >> > Why is this change performed? What does the patch do? Please =
elaborate
> >> >> > a little bit.
> >> >>
> >> >> Let's see if I can explain it clearer or not.
> >> >>
> >> >> We need to report resolution to userland for wacom_w8001.c. Sin=
ce pen
> >> >> and touch data are reported through the same logical port for s=
erial
> >> >> devices, using input_abs_set_res =A0for ABS_X/Y, =A0we can only=
 pass the
> >> >> resolution for pen or touch. So, I let ABS_X/Y report pen resol=
ution
> >> >> since most legacy ST clients process pen data over touch. Howev=
er, for
> >> >> multi-touch clients, especially for those that support gestures=
, touch
> >> >> resolution is needed to calculate the physical distance between=
 two
> >> >> touch points. Using =A0ABS_MT_POSITION_X/Y does not cause confu=
sion and
> >> >> it is quite intuitive.
> >> >
> >> > We just went through the round of why we should scale events fro=
m
> >> > different tools when they use the same event devices and I do no=
t see
> >> > why MT data is any different.
> >>
> >> At the time when we worked on that, we did not consider resolution=
=2E We
> >> only scaled the logical values.
> >>
> >> > Devices have only one set of physical axes (MT or not)
> >>
> >> You are right if the device only supports one type of tools. Yes, =
ST
> >> or pen can go with ABS_X/Y. MT goes with MT. However, we are deali=
ng
> >> with a dual tool case: pen and touch on the same port. Using only =
one
> >> set of axes would not be able to cover both tool events and pass t=
he
> >> resolution to the userland.
> >>
> >> > so I believe
> >> > min, max and resultion should be reported on ABS_X, Y, X, etc, o=
r, if
> >> > you want to have this data in ABS_MT_POSITION, it should be trhe=
 same.
> >>
> >> max/min is different from resolution. We can scale max/min since t=
hey
> >> are logical data. But we can not change the device's physical size=
=2E
> >> That's the root cause of the "stubborn" nature of resolution.
> >
> > This is the same device so it should have the same physical dimensi=
ons,
> > right?
>=20
> No, pen and touch use different chips. They can have different sizes.

It does not matter how many chips you have inside. What matters whether
they share a working surface or not. If working surface is the same (an=
d
consequentially you have single input_dev structure) then dimensions ar=
e
the same.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
