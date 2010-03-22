From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc0
Date: Sun, 21 Mar 2010 23:37:47 -0700
Message-ID: <20100322063747.GF31621@core.coreip.homeip.net>
References: <20100301080342.GH765@core.coreip.homeip.net>
 <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
 <20100309175107.GB23378@core.coreip.homeip.net>
 <8bd0f97a1003090958i741f4ffm3528450e89089e9@mail.gmail.com>
 <20100309181037.GB19814@core.coreip.homeip.net>
 <8bd0f97a1003091013q565f8b1bse66b48d9c9a25600@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:52130 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0CVGh4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 02:37:56 -0400
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003091013q565f8b1bse66b48d9c9a25600@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>

On Tue, Mar 09, 2010 at 01:13:34PM -0500, Mike Frysinger wrote:
> On Tue, Mar 9, 2010 at 13:10, Dmitry Torokhov wrote:
> > On Tue, Mar 09, 2010 at 12:58:24PM -0500, Mike Frysinger wrote:
> >> On Tue, Mar 9, 2010 at 12:51, Dmitry Torokhov wrote:
> >> > On Tue, Mar 09, 2010 at 09:44:08AM -0500, Mike Frysinger wrote:
> >> >> On Mon, Mar 1, 2010 at 03:03, Dmitry Torokhov wrote:
> >> >> > Hi Linus,
> >> >> >
> >> >> > Please pull from:
> >> >> >
> >> >> > =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/=
dtor/input.git for-linus
> >> >> > or
> >> >> > =A0 =A0 =A0 =A0master.kernel.org:/pub/scm/linux/kernel/git/dt=
or/input.git for-linus
> >> >> >
> >> >> > to receive first round of updates for the input subsystem.
> >> >>
> >> >> i'm trying to figure out what the problem is with the ADXL34x a=
nd
> >> >> AD714x drivers you seem to have accepted (at least, you didnt s=
ay
> >> >> there was anything left for us to do). =A0i would have expected=
 them to
> >> >> be in 2.6.33/2.6.34 already, but it seems they arent moving now=
=2E =A0so
> >> >> what's up ?
> >> >
> >> > I am still spooked by the fact that this is an accelerometer and=
 does
> >> > not have to be an input device but maybe used for different purp=
oses as
> >> > well.
> >>
> >> the AD714x is not an accelerometer, it's a capacitance touch senso=
r
> >>
> >
> > OK, will dig it up.
>=20
> thanks
>=20

Mike, could you please take a look at mny 'next' branch and give the
version there a try - I made a couple of small changes before
applying...

Thanks!

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
