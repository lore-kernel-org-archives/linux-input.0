From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ads7846 touchscreen: fix pressure
Date: Fri, 9 Oct 2009 09:35:07 -0700
Message-ID: <20091009163506.GE1092@core.coreip.homeip.net>
References: <20091006195413.GA1469@ucw.cz> <5d5443650910072209t63e3fa9dvff7ab2fee7bb2f88@mail.gmail.com> <20091008092433.GA26837@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933994AbZJIQf6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091008092433.GA26837@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 08, 2009 at 11:24:33AM +0200, Pavel Machek wrote:
> On Thu 2009-10-08 10:39:39, Trilok Soni wrote:
> > Hi Pavel,
> >=20
> > On Wed, Oct 7, 2009 at 1:24 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Zaurus, pressure is reported inverted -- the lighter the press=
ure,
> > > the bigger numerical value. This should fix it.
> > >
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > >
> > > --- linux-rc/drivers/input.ofic/touchscreen/ads7846.c =A0 2009-10=
-06 13:49:56.000000000 +0200
> > > +++ linux-rc/drivers/input/touchscreen/ads7846.c =A0 =A0 =A0 =A02=
009-10-06 21:18:25.000000000 +0200
> > > @@ -608,12 +609,12 @@
> > >
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_X, x);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_Y, y);
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSUR=
E, Rt);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSUR=
E, ts->pressure_max-Rt);
> >=20
> > but same behavior is seen by others using this chip on different
> > boards? If not, this has to be done through platform data.
>=20
> Well, I'd expect the chip to behave in similar way on all
> platforms. Of course, it would be good if someone with different hw
> tested it, but I do not have that hw...
>=20
> So I guess the best way is to make it go in early and see how it does
> in testing....

No, this is not how it works. Please do

	git log -- drivers/input/touchscreen/ads7846.c

and try to check with people who were working on this driver. I somehow
doubt that they'd overlook such obvious issue as inverted pressure
readings.

--=20
Dmitry
