From: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH 2/2] input: gt801_2plus1 - Add initial support for
 Goodix GT801 2+1
Date: Mon, 07 Dec 2015 11:10:17 +0200
Message-ID: <1449479417.6984.2.camel@plaes.org>
References: <201512071608.oGt2n0Wn%fengguang.wu@intel.com>
	 <alpine.DEB.2.02.1512070933400.2037@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plaes.org ([188.166.43.21]:43199 "EHLO plaes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240AbbLGJKU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Dec 2015 04:10:20 -0500
In-Reply-To: <alpine.DEB.2.02.1512070933400.2037@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>, linux-sunxi@googlegroups.com, kbuild-all@01.org

On Mon, 2015-12-07 at 09:34 +0100, Julia Lawall wrote:
> It looks like braces may be mising.=C2=A0 Please check.

Thanks, nice catch!

It's actually messed up indenting. Code works as intended.
>=20
> julia
>=20
> On Mon, 7 Dec 2015, kbuild test robot wrote:
>=20
> > Hi Priit,
> >=20
> > [auto build test WARNING on mripard/sunxi/for-next]
> > [also build test WARNING on next-20151203]
> > [cannot apply to input/next v4.4-rc4]
> >=20
> > url:=C2=A0=C2=A0=C2=A0 https://github.com/0day-ci/linux/commits/Pri=
it-Laes/input-D
> river-for-Goodix-GT801-2-1-touchscreen/20151207-152831
> > base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/m=
ripard/lin
> ux.git=C2=A0sunxi/for-next
> > :::::: branch date: 46 minutes ago
> > :::::: commit date: 46 minutes ago
> >=20
> > >> drivers/input/touchscreen/gt801_2plus1.c:119:3-30: code aligned
> with following code on line 120
> >=20
> > git remote add linux-review https://github.com/0day-ci/linux
> > git remote update linux-review
> > git checkout d66df313f96e04572821e49cada65cb5c1bea9e2
> > vim +119 drivers/input/touchscreen/gt801_2plus1.c
> >=20
> > d66df313 Priit Laes 2015-12-07=C2=A0 113=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > d66df313 Priit Laes 2015-12-07=C2=A0 114=C2=A0=20
> > d66df313 Priit Laes 2015-12-07=C2=A0 115=C2=A0=C2=A0=C2=A0/* Build =
touch map */
> > d66df313 Priit Laes 2015-12-07=C2=A0 116=C2=A0=C2=A0=C2=A0touch_num=
 =3D 0;
> > d66df313 Priit Laes 2015-12-07=C2=A0 117=C2=A0=C2=A0=C2=A0for (i =3D=
 0; (touch_raw !=3D 0)
> && (i < ts->max_touch_num); i++) {
> > d66df313 Priit Laes 2015-12-07=C2=A0 118=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (touch_raw & 1)
> > d66df313 Priit Laes 2015-12-07
> @119=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0touch_map[touch_num++] =
=3D i;
> > d66df313 Priit Laes 2015-12-07 @120=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0touch_raw >>=3D
> 1;
> > d66df313 Priit Laes 2015-12-07=C2=A0 121=C2=A0=C2=A0=C2=A0}
> > d66df313 Priit Laes 2015-12-07=C2=A0 122=C2=A0=20
> > d66df313 Priit Laes 2015-12-07=C2=A0 123=C2=A0=C2=A0=C2=A0/* Calcul=
ate checksum */
> >=20
> > ---
> > 0-DAY kernel test infrastructure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Open Source
> Technology Center
> > https://lists.01.org/pipermail/kbuild-all=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0; Intel
> Corporation
> >=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
