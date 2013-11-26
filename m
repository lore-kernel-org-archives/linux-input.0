From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] input: ixp4xx-beeper: don't use symbols from <mach/timex.h>
Date: Tue, 26 Nov 2013 15:29:01 +0100
Message-ID: <1385476141-29131-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44531 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab3KZO3M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 09:29:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>, kernel@pengutronix.de

mach/timex.h is about to be dropped so don't use symbols defined in
there. For ixp4xx there is a suitable substitute for IXP4XX_TIMER_FREQ,
i.e. a global and exported variable that holds the same value.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Hello,

I'd like to keep that patch in a series for the arm-soc people to pull =
that
get's rid of <mach/timex.h>, so please don't take this patch but only a=
ck to
keep coordinating the series as easy as possible.

I don't know who's Ack is good enough to be counted as maintainer ack, =
so
please point that out in your reply, too.

Thanks
Uwe

 drivers/input/misc/ixp4xx-beeper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ix=
p4xx-beeper.c
index 17ccba8..ed8e5e8 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -67,7 +67,7 @@ static int ixp4xx_spkr_event(struct input_dev *dev, u=
nsigned int type, unsigned
 	}
=20
 	if (value > 20 && value < 32767)
-		count =3D (IXP4XX_TIMER_FREQ / (value * 4)) - 1;
+		count =3D (ixp4xx_timer_freq / (value * 4)) - 1;
=20
 	ixp4xx_spkr_control(pin, count);
=20
--=20
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
