From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [RFC] Add ff-memless-next driver
Date: Sun, 15 Dec 2013 14:07:34 +0100
Message-ID: <5807033.13lmKIeEg9@geidi-prime>
References: <20107437.IkYg87uJMY@geidi-prime> <1387073042.2276.21.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1387073042.2276.21.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, elias.vds@gmail.com, anssi.hannula@iki.fi
List-Id: linux-input@vger.kernel.org

On Saturday 14 of December 2013 18:04:02 Joe Perches wrote:
> On Sun, 2013-12-15 at 01:19 +0100, Michal Mal=FD wrote:
> > diff --git a/drivers/input/ff-memless-next.c
> > b/drivers/input/ff-memless-next.c
> []
>=20
> > +static inline s32 mlnx_clamp_level(const s32 level)
> > +{
> > +	return (level > 0x7fff) ? 0x7fff : ((level < -0x7fff) ? -0x7fff :
> > level);
>=20
> 	clamp(level, -0x7fff, 0x7fff);
> []
>=20
> > +static inline int mlnx_is_conditional(const struct ff_effect *effe=
ct)
> > +{
> > +	return (effect->type =3D=3D FF_DAMPER) || (effect->type =3D=3D FF=
_FRICTION) ||
> > (effect->type =3D=3D FF_INERTIA) || (effect->type =3D=3D FF_SPRING)=
; +}
>=20
> Maybe try to run your patch through scripts/checkpatch.pl
>=20
> bool?
> 80 char line max? (true for the file, not just here)
> switch?
> 	switch (effect->type) {
> 	case FF_DAMPER:
> 	case FF_FRICTION:
> 	case FF_INERTIA:
> 	case FF_SPRING:
> 		return true;
> 	}
> 	return false;

Okay, thanks for the input. I found a problem regarding effect updating=
 in the code anyway. I'll submit a corrected version of the patch once =
I'm sure it's fixed.

Michal
