From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 15/19] input/ti_am335x_tsc: tiny cleanup
Date: Tue, 4 Jun 2013 09:49:19 -0700
Message-ID: <20130604164919.GD26400@core.coreip.homeip.net>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-16-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:42976 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab3FDQtW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 12:49:22 -0400
Content-Disposition: inline
In-Reply-To: <1369681926-22185-16-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Felipe Balbi <balbi@ti.com>

On Mon, May 27, 2013 at 09:12:02PM +0200, Sebastian Andrzej Siewior wro=
te:
> Things that can be done to done without using make up:
> - reduce config_inp from 20 elements to 4
>   The loop goes 0=E2=80=A63 so elements 4=E2=80=A619 remain unused.
> - put the shift for analog_line into one line, since config_inp is u3=
2 we
>   don't need to worry about sign extension,
> - check if he DT values are 0=E2=80=A63 as expected
> - replace "err =3D -EINVAL; goto err" with "return -EINVAL;" as there=
 is no
>   cleanup and this is less code
> - pull out "config[analog_line[i]][0=E2=80=A63];" from the switch cas=
e and use
>   magic to the 0=E2=80=A63 correct.
> - since we removed so much lines, spent a few to get
>   "config[an_line][wi_order];" done.
> - get rid of "val32, wires_conf" and assign the values directly. This=
 is
>   just init code but we can still save a few cycles.
> - remove titsc_config_wires() from resume path. ->bit_yn & friends ar=
e only
>   written once and not changed so as long as we assume that our DDR w=
ill
>   have no biflips we can skip that.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> +		analog_line[i] =3D (ts_dev->config_inp[i] & 0xF0) >> 4;
>  		wire_order[i] =3D ts_dev->config_inp[i] & 0x0F;
> +		if (WARN_ON(analog_line[i] > 4))
> +				return -EINVAL;
> +		if (WARN_ON(wire_order[i] > 4))
> +				return -EINVAL;

=46ormatting is still a bit off here...

Thanks,

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
