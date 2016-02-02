From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 0/3] Input: rotary-encoder - use more than two gpios
Date: Tue,  2 Feb 2016 11:24:35 +0100
Message-ID: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

Some time ago I sent a v1 of this, now after testing the changes more
deeply patch 3 changed a bit. The old series started with

	Date: Wed,  2 Dec 2015 11:07:11 +0100                                 =
                                                             =20
	From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>          =
                                                                  =20
	Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpio=
s as input                                                   =20
	Message-Id: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutr=
onix.de>                                                     =20

The two first patches are just preparation for the third patch.

There is an obvious improvement that allows detection of quick changes
more reliably with >2 gpios, but I didn't implement this yet. (With 4
GPIOs you can distinguish a counter clockwise movement of three states
from a clock wise movement of a single state. Still the patch is useful
as it makes these devices work at all.

My test device looks as follows:

        rotary@0 {
                compatible =3D "rotary-encoder";
                gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 GPIO=
_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_HIGH=
>;

                rotary-encoder,steps =3D <16>;
		rotary-encoder,steps-per-period =3D <16>;
        };

While Daniel Mack and Rojhalat Ibrahim agreed that this device is an
absolute encoder and should be supported by a simpler logic, I still
consider it worthwhile to get these patches in as a first step. Also th=
e
binding looks right, so IMHO the comments shouldn't stop this series
from going in.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (3):
  Input: rotary-encoder - make use of devm_* to simplify .probe and
    .remove
  Input: rotary-encoder - move configuration data to driver data
  Input: rotary-encoder - support more than 2 gpios as input

 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 arch/arm/mach-pxa/raumfeld.c                       |  25 +-
 drivers/input/misc/rotary_encoder.c                | 327 +++++++++----=
--------
 include/linux/rotary_encoder.h                     |   4 -
 4 files changed, 158 insertions(+), 200 deletions(-)

--=20
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
