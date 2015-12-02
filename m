From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two gpios as input
Date: Wed,  2 Dec 2015 11:07:11 +0100
Message-ID: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34936 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932489AbbLBKHd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 05:07:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, devicetree@vger.kernel.org, linux-input@vger.kernel.org

Hello,

some time ago I worked on the rotary encoder driver to make it support
more than two input lines. This is the (only slightly tested[1]) rebase=
 of
this series on top of 4.4-rc2 (from 4.1).

It would be great to get some feedback, especially (but not only) for m=
y
change to raumfeld.c.

Before Ezequiel's patch 3a341a4c30d4 ("Input: rotary-encoder - add
support for quarter-period mode") we had a dt property
"rotary-encoder,half-period" defined. It's presence meant that we had 2
indents per period; it's absence that there is only 1. Ezequiel
introduced rotary-encoder,steps-per-period instead when adding support
for quarter-period mode (which has 4 indents per period).

Up to now (i.e. with two inputs) a period has length 4. Now with (say)
four inputs a period has length 16 instead. Now how should this be
modeled in dt? This series implements that I have to pass

	rotary-encoder,steps-per-period =3D <16>;

now for "quarter-period mode" (i.e. 4 indents per 4 state changes[2]),
but that feels unnatural. I'd prefer to set a property to <1> instead,
meaning the device has an indent for each state change[2]. half-period
mode would be <2> and full-period mode would be <4>. But I don't have a
nice name for such a property and maybe it's easier to live with
steps-per-period =3D <16>? What do you think?

Also note that these patches are not as technically versatile as
possible. With 4 (n) input lines we could detect a quick rotation where=
 the
machine's latency only allows to sample after 7 (2^(n-1)-1) state
changes. Currently this is not implemented, but can be done later.

Best regards
Uwe

[1] the machine that has the device is ~600 km away from me
[2] if you have a better word for that, please tell me.

Uwe Kleine-K=C3=B6nig (3):
  input: rotary_encoder: make use of devm_* to simplify .probe and
    .remove
  input: rotary_encoder: move configuration data to driver data
  input: rotary_encoder: support more than 2 gpios as input

 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 arch/arm/mach-pxa/raumfeld.c                       |  25 +-
 drivers/input/misc/rotary_encoder.c                | 283 ++++++++++---=
--------
 include/linux/rotary_encoder.h                     |   4 -
 4 files changed, 153 insertions(+), 161 deletions(-)

--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
