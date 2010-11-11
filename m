From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 11:24:34 -0800
Message-ID: <20101111192434.GA13163@core.coreip.homeip.net>
References: <AANLkTi=rxkJcmp8WLKCRnxqNd_1QBT4W_2YJNJBcsHzF@mail.gmail.com>
 <AANLkTimPUYXe=Pno8O2k_U7u9N+ob6EQMD_DCDtLDTS5@mail.gmail.com>
 <20101110050219.GB29110@barra.bne.redhat.com>
 <4CDA6D25.4070501@euromail.se>
 <20101110235355.GB4473@barra.bne.redhat.com>
 <4CDB3D6C.2000507@euromail.se>
 <20101111012251.GC2121@core.coreip.homeip.net>
 <AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
 <20101111082653.GC24415@core.coreip.homeip.net>
 <AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65158 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab0KKTYp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 14:24:45 -0500
Received: by gyh4 with SMTP id 4so1442330gyh.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 11:24:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Michal Suchanek <hramrach@centrum.cz>, Henrik Rydberg <rydberg@euromail.se>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 11:01:11AM -0800, Ping Cheng wrote:
> On Thu, Nov 11, 2010 at 12:26 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > I do not believe that current protocol design has an issue. MT prot=
ocol
> > is really for representing devices reporting multiple touches on th=
e same
> > working surface which means that size stays the same for all touche=
s.
>=20
> When we say multiple touches, do we mean multiple touches of the same
> type or different types? If we mean different types (pen and finger),
> the size could be different due to the differences in technology. For
> Bamboo, the size is different for pen and touch.
>=20

I want to say that generally for same tool, when it makes sense we can
scale so that different tools could pretend to have the same range. If
there are really 2 vastly different devices superimposed together then
maybe the best option is to treat them as 2 separate input devices.

> >> I am asking because to me it does not make any sense to scale the =
values.
> >>
> >> Devices that have a touch layer superimposed over LCD screen have =
to
> >> be calibrated for the system to know which ABS_X/Y corresponds to
> >> which pixel. I suspect that Bamboo P&T may have similar issue with=
 its
> >> two superimposed input devices. Alos somebody suggested that the i=
nput
> >> area usable for pen might be smaller than area usable for touch.
> >>
> >> This means we are most likely talking apples and oranges, even if =
we
> >> scale them to be the same size.
> >>
> >
> > No, I do not believe this is true. Consider touchscreen that you ca=
n
> > touch with either stylus or finger, with stylus having better
> > resolution suited for drawing/writing and finger just used for sele=
cting
> > UI objects. Obviously they work with the same number of pixels even
> > though ranges reported by the hardware might differ.
> >
> >> So I think it is most sensible to leave the scales are reported by=
 the
> >> hardware because that gives a hint to the application which receiv=
es
> >> the event that the inputs are in fact different. They will still b=
e
> >> when the events are scaled, it will be just harder to see from the
> >> client point of view.
> >
> > It really depends on the device in question and we have several opt=
ions:
> >
> > 1. Single multitouch device - unified working surface with the same
> > =A0 characteristics, kernel scales properly.
> >
> > 2. 2+ logical devices - may have different size/resolutions, usersp=
ace
> > =A0 will have to do arbitration if they are in the same physical pa=
ckage.
> >
> > With Bamboo I think option 1 makes more sense and is easier on ever=
yone.
>=20
> I agree with you on "different size/resolutions" and "unified working
> surface" for the two opitons above. And I also agree with you that we
> should leave the arbitration to the userland for MT events for both
> opitons.
>=20
> But, I think ABS_X/Y arbitration should be considered in the kernel t=
o
> reduce the overhead in userland.

With option 1 you have natural ST arbitration - the first touch gets to
report (ABS_X, ABS_Y), the rest will have to report ABS_MT_* till the
first touch is lifted, right?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
