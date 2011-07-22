From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 2/6] mc13xxx: implicitly register led subdevice
Date: Fri, 22 Jul 2011 16:17:08 +0200
Message-ID: <1311344232-29902-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:59305 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754286Ab1GVORV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 10:17:21 -0400
In-Reply-To: <1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch, gaowanlong@cn.fujitsu.com, shawn.guo@freescale.com

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 drivers/mfd/mc13xxx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index c238f6b..2867c21 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -772,7 +772,7 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
=20
-	if (pdata->flags & MC13XXX_USE_LED)
+	if (pdata->leds)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
=20
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
