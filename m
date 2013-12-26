From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Add ff-memless-next module
Date: Thu, 26 Dec 2013 08:58:37 -0800
Message-ID: <1388077117.2459.10.camel@joe-AO722>
References: <4629786.9msWpURVJS@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4629786.9msWpURVJS@geidi-prime>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com
List-Id: linux-input@vger.kernel.org

On Thu, 2013-12-26 at 17:33 +0100, Michal Mal=FD wrote:
> This patch adds "ff-memless-next" module. This module is based on the=
 current
> "ff-memless" module but it has considerably extended capabilities. Th=
ese include:
[]
> Why is this written as a new module and not a patch for "ff-memless"?=
 This
> module uses a different API for the HW-specific driver; this was a ne=
cessary
> step to make use of the module's additional features. All 25 drivers =
that
> currently use "ff-memless" would have to be updated. "ff-memless-next=
" currently
> does not support FF_RUMBLE which is needed to support various joypads=
=2E

Thanks for that explanation.

[]

> +static unsigned long mlnx_get_envelope_update_time(const struct mlnx=
_effect *mlnxeff,
> +						   const unsigned long update_rate_jiffies)
> +{

> +	/* Effect has an envelope with nonzero fade time */
> +	if (mlnxeff->effect.replay.length) {
> +		if (!envelope->fade_length)
> +			return mlnxeff->stop_at;
> +
> +		/* Schedule the next update when the fade begins */
> +		if (time_before(mlnxeff->updated_at, mlnxeff->fade_begin))
> +			return mlnxeff->fade_begin;
> +
> +		/* Already fading */
> +		else {
> +			fade_next =3D mlnxeff->updated_at + update_rate_jiffies;
> +

There's no need for an else and extra indentation here
=20
	if (foo)
		return;
	else {			/* unnecessary else */
		bar...
	}

please just use

	if (foo)
		return;

	bar...

> +			/* Schedule update when the effect stops */
> +			if (time_after(fade_next, mlnxeff->stop_at))
> +				return mlnxeff->stop_at;
> +			/* Schedule update at the next checkpoint */
> +			else
> +				return fade_next;
> +		}
> +	}
