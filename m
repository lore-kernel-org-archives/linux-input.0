From: "Oskar Schirmer" <os@emlix.com>
Subject: [PATCH] ad7877: fix spi word size to 16 bit
Date: Thu,  6 May 2010 12:37:44 +0200
Message-ID: <1273142265-11929-1-git-send-email-os@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.87]:49000 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab0EFLCw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 May 2010 07:02:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oskar Schirmer <os@emlix.com>, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>

With no word size given in the users platform data,
a generic spi host controller driver will assume a default
word size of eight bit. This causes transmission to be
performed bytewise, which will fail on little endian
machines for sure. Failure on big endian depends on usage
of slave select to mark word boundaries.

Anyway, ad7877 is specified to work with 16 bit per word,
so unconditionally set the word size accordingly.

Signed-off-by: Oskar Schirmer <os@emlix.com>
Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
Signed-off-by: Oliver Schneidewind <osw@emlix.com>
---
 drivers/input/touchscreen/ad7877.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchsc=
reen/ad7877.c
index e019d53..92acd85 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -669,6 +669,8 @@ static int __devinit ad7877_probe(struct spi_device=
 *spi)
 		dev_dbg(&spi->dev, "SPI CLK %d Hz?\n",spi->max_speed_hz);
 		return -EINVAL;
 	}
+	spi->bits_per_word =3D 16;
+	spi_setup(spi);
=20
 	ts =3D kzalloc(sizeof(struct ad7877), GFP_KERNEL);
 	input_dev =3D input_allocate_device();
--=20
1.5.3.7

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
