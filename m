From: Andreas Mohr <andi@lisas.de>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Tue, 14 Jul 2009 22:33:01 +0200
Message-ID: <20090714203301.GA11390@rhlx01.hs-esslingen.de>
References: <20090714100634.GA4054@elf.ucw.cz> <20090714202545.GA7707@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756485AbZGNUdF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090714202545.GA7707@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Tue, Jul 14, 2009 at 10:25:45PM +0200, Andreas Mohr wrote:
> Hi,
>=20
> > +       ts->snap_down[swapped] =3D -inactive_area_left;
> > +       ts->snap_up[swapped] =3D max_x + inactive_area_right;
> > +       ts->snap_down[!swapped] =3D -inactive_area_top;
> > +       ts->snap_up[!swapped] =3D max_y + inactive_area_bottom;
> > +       ts->snap_down_on[swapped] =3D snap_left_on;
> > +       ts->snap_down_off[swapped] =3D snap_left_off;
> > +       ts->snap_up_on[swapped] =3D max_x - snap_right_on;
> > +       ts->snap_up_off[swapped] =3D max_x - snap_right_off;
> > +       ts->snap_down_on[!swapped] =3D snap_top_on;
> > +       ts->snap_down_off[!swapped] =3D snap_top_off;
> > +       ts->snap_up_on[!swapped] =3D max_y - snap_bottom_on;
> > +       ts->snap_up_off[!swapped] =3D max_y - snap_bottom_off;
>=20
> Could this perhaps be represented by _one_ struct definition
> and two representations of it, one for swapped and one for non-swappe=
d case or so?
> (although sometimes it=B4s reverted logic, might need more thought)
> Sounds like an awful lot of repeated array calculations for no overly=
 good reason
> (unless gcc happens to fully optimize it into oblivion automatically)=
=2E

-ETOOMUCHBEER

Of course we need to swap orthogonal members individually,
thus this kind of code.
However maybe there=B4s still a more elegant way of doing this.

Andreas Mohr
