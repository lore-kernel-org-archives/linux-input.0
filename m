From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v3 0/3] Input: rotary_encoder - Fixups for Dmitry's rework and support for >2 gpios
Date: Fri,  5 Feb 2016 13:08:18 +0100
Message-ID: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

This bases on top of

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input rotary-encode=
r

(currently at 557a30f2f046).

Dmitry, I assume you will squash the two fixups accordingly, otherwise
just tell me, then I create proper patches.

Also let me note that with threaded irqs I'm able to rotate my device
quicker than irq handling happens. So a quick counterclockwise rotation
might be detected as single step clockwise rotation.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (3):
  fixup! Input: rotary_encoder - convert to use gpiod API
  fixup! Input: rotary_encoder - use threaded irqs
  Input: rotary-encoder - support more than 2 gpios as input

 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 arch/arm/mach-pxa/raumfeld.c                       |   2 +-
 drivers/input/misc/rotary_encoder.c                | 158 +++++++++----=
--------
 3 files changed, 68 insertions(+), 94 deletions(-)

--=20
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
