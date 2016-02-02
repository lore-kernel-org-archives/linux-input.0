From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2 0/3] Input: rotary-encoder - use more than two gpios
Date: Tue, 2 Feb 2016 13:08:07 +0100
Message-ID: <56B09C27.8070009@zonque.org>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:34927 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755177AbcBBMIK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 07:08:10 -0500
In-Reply-To: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Hi Uwe,

Thanks for the update.

On 02/02/2016 11:24 AM, Uwe Kleine-K=C3=B6nig wrote:
> Some time ago I sent a v1 of this, now after testing the changes more
> deeply patch 3 changed a bit. The old series started with
>=20
> 	Date: Wed,  2 Dec 2015 11:07:11 +0100                               =
                                                               =20
> 	From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>        =
                                                                    =20
> 	Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two gp=
ios as input                                                   =20
> 	Message-Id: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengu=
tronix.de>                                                     =20
>=20
> The two first patches are just preparation for the third patch.
>=20
> There is an obvious improvement that allows detection of quick change=
s
> more reliably with >2 gpios, but I didn't implement this yet. (With 4
> GPIOs you can distinguish a counter clockwise movement of three state=
s
> from a clock wise movement of a single state. Still the patch is usef=
ul
> as it makes these devices work at all.
>=20
> My test device looks as follows:
>=20
>         rotary@0 {
>                 compatible =3D "rotary-encoder";
>                 gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GP=
IO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HI=
GH>;
>=20
>                 rotary-encoder,steps =3D <16>;
> 		rotary-encoder,steps-per-period =3D <16>;
>         };
>=20
> While Daniel Mack and Rojhalat Ibrahim agreed that this device is an
> absolute encoder and should be supported by a simpler logic, I still
> consider it worthwhile to get these patches in as a first step. Also =
the
> binding looks right, so IMHO the comments shouldn't stop this series
> from going in.

I still don't understand why this is implemented that way, rather than
going for a much simpler logic of interpretation that also allows users
to read out the absolute position.

The code to read the value would be really just as simple as reading al=
l
GPIOs and or-ing their values into the result, and skip the state
machine completely. This code would be active if a new attribute
(something like 'rotary-encoder,hardware-absolute') is set, or even
implicitly, when more than 2 GPIOs are specified.

Is there any reason for not doing that?


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
