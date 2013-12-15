From: Joe Perches <joe@perches.com>
Subject: Re: [RFC] Add ff-memless-next driver
Date: Sat, 14 Dec 2013 18:04:02 -0800
Message-ID: <1387073042.2276.21.camel@joe-AO722>
References: <20107437.IkYg87uJMY@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20107437.IkYg87uJMY@geidi-prime>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, elias.vds@gmail.com, anssi.hannula@iki.fi
List-Id: linux-input@vger.kernel.org

On Sun, 2013-12-15 at 01:19 +0100, Michal Mal=FD wrote:
> diff --git a/drivers/input/ff-memless-next.c b/drivers/input/ff-memle=
ss-next.c
[]
> +static inline s32 mlnx_clamp_level(const s32 level)
> +{
> +	return (level > 0x7fff) ? 0x7fff : ((level < -0x7fff) ? -0x7fff : l=
evel);

	clamp(level, -0x7fff, 0x7fff);
[]
> +static inline int mlnx_is_conditional(const struct ff_effect *effect=
)
> +{
> +	return (effect->type =3D=3D FF_DAMPER) || (effect->type =3D=3D FF_F=
RICTION) || (effect->type =3D=3D FF_INERTIA) || (effect->type =3D=3D FF=
_SPRING);
> +}

Maybe try to run your patch through scripts/checkpatch.pl

bool?
80 char line max? (true for the file, not just here)
switch?
	switch (effect->type) {
	case FF_DAMPER:
	case FF_FRICTION:
	case FF_INERTIA:
	case FF_SPRING:
		return true;
	}
	return false;
