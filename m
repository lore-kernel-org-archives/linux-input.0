From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc0
Date: Tue, 9 Mar 2010 10:10:37 -0800
Message-ID: <20100309181037.GB19814@core.coreip.homeip.net>
References: <20100301080342.GH765@core.coreip.homeip.net>
 <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
 <20100309175107.GB23378@core.coreip.homeip.net>
 <8bd0f97a1003090958i741f4ffm3528450e89089e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003090958i741f4ffm3528450e89089e9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 09, 2010 at 12:58:24PM -0500, Mike Frysinger wrote:
> On Tue, Mar 9, 2010 at 12:51, Dmitry Torokhov wrote:
> > On Tue, Mar 09, 2010 at 09:44:08AM -0500, Mike Frysinger wrote:
> >> On Mon, Mar 1, 2010 at 03:03, Dmitry Torokhov wrote:
> >> > Hi Linus,
> >> >
> >> > Please pull from:
> >> >
> >> > =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/dto=
r/input.git for-linus
> >> > or
> >> > =A0 =A0 =A0 =A0master.kernel.org:/pub/scm/linux/kernel/git/dtor/=
input.git for-linus
> >> >
> >> > to receive first round of updates for the input subsystem.
> >>
> >> i'm trying to figure out what the problem is with the ADXL34x and
> >> AD714x drivers you seem to have accepted (at least, you didnt say
> >> there was anything left for us to do). =A0i would have expected th=
em to
> >> be in 2.6.33/2.6.34 already, but it seems they arent moving now. =A0=
so
> >> what's up ?
> >
> > I am still spooked by the fact that this is an accelerometer and do=
es
> > not have to be an input device but maybe used for different purpose=
s as
> > well.
>=20
> the AD714x is not an accelerometer, it's a capacitance touch sensor
>

OK, will dig it up.
=20
> i understand the ADXL34x is a bit wonky, but what else would you
> propose ?  or just leave the driver in limbo forever until people
> forget about it ?

No, just till we have proper framework for it to be merged into.

--=20
Dmitry
