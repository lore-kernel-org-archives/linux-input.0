From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ads7846 touchscreen: fix pressure
Date: Thu, 8 Oct 2009 11:24:33 +0200
Message-ID: <20091008092433.GA26837@elf.ucw.cz>
References: <20091006195413.GA1469@ucw.cz> <5d5443650910072209t63e3fa9dvff7ab2fee7bb2f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58130 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbZJHJZT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2009 05:25:19 -0400
Content-Disposition: inline
In-Reply-To: <5d5443650910072209t63e3fa9dvff7ab2fee7bb2f88@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Thu 2009-10-08 10:39:39, Trilok Soni wrote:
> Hi Pavel,
>=20
> On Wed, Oct 7, 2009 at 1:24 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Zaurus, pressure is reported inverted -- the lighter the pressur=
e,
> > the bigger numerical value. This should fix it.
> >
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >
> > --- linux-rc/drivers/input.ofic/touchscreen/ads7846.c =A0 2009-10-0=
6 13:49:56.000000000 +0200
> > +++ linux-rc/drivers/input/touchscreen/ads7846.c =A0 =A0 =A0 =A0200=
9-10-06 21:18:25.000000000 +0200
> > @@ -608,12 +609,12 @@
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_X, x);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_Y, y);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE,=
 Rt);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE,=
 ts->pressure_max-Rt);
>=20
> but same behavior is seen by others using this chip on different
> boards? If not, this has to be done through platform data.

Well, I'd expect the chip to behave in similar way on all
platforms. Of course, it would be good if someone with different hw
tested it, but I do not have that hw...

So I guess the best way is to make it go in early and see how it does
in testing....
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
