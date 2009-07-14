From: Andreas Mohr <andi@lisas.de>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Tue, 14 Jul 2009 22:25:45 +0200
Message-ID: <20090714202545.GA7707@rhlx01.hs-esslingen.de>
References: <20090714100634.GA4054@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756298AbZGNUZr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090714100634.GA4054@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Arve Hj?nnev?g <arve@android.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

> +       ts->snap_down[swapped] =3D -inactive_area_left;
> +       ts->snap_up[swapped] =3D max_x + inactive_area_right;
> +       ts->snap_down[!swapped] =3D -inactive_area_top;
> +       ts->snap_up[!swapped] =3D max_y + inactive_area_bottom;
> +       ts->snap_down_on[swapped] =3D snap_left_on;
> +       ts->snap_down_off[swapped] =3D snap_left_off;
> +       ts->snap_up_on[swapped] =3D max_x - snap_right_on;
> +       ts->snap_up_off[swapped] =3D max_x - snap_right_off;
> +       ts->snap_down_on[!swapped] =3D snap_top_on;
> +       ts->snap_down_off[!swapped] =3D snap_top_off;
> +       ts->snap_up_on[!swapped] =3D max_y - snap_bottom_on;
> +       ts->snap_up_off[!swapped] =3D max_y - snap_bottom_off;

Could this perhaps be represented by _one_ struct definition
and two representations of it, one for swapped and one for non-swapped =
case or so?
(although sometimes it=B4s reverted logic, might need more thought)
Sounds like an awful lot of repeated array calculations for no overly g=
ood reason
(unless gcc happens to fully optimize it into oblivion automatically).

Andreas Mohr
