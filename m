From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 4/6] mc13xxx: remove unused define
Date: Fri, 22 Jul 2011 16:17:10 +0200
Message-ID: <1311344232-29902-5-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-3-git-send-email-philippe.retornaz@epfl.ch>
 <1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:59329 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754463Ab1GVORX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2011 10:17:23 -0400
In-Reply-To: <1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch, gaowanlong@cn.fujitsu.com, shawn.guo@freescale.com

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 include/linux/mfd/mc13783.h |    2 --
 include/linux/mfd/mc13xxx.h |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
index 7d0f3d6..3756a30 100644
--- a/include/linux/mfd/mc13783.h
+++ b/include/linux/mfd/mc13783.h
@@ -112,8 +112,6 @@ static inline int mc13783_irq_ack(struct mc13783 *m=
c13783, int irq)
 #define MC13783_USE_CODEC	MC13XXX_USE_CODEC
 #define MC13783_USE_ADC		MC13XXX_USE_ADC
 #define MC13783_USE_RTC		MC13XXX_USE_RTC
-#define MC13783_USE_REGULATOR	MC13XXX_USE_REGULATOR
-#define MC13783_USE_LED		MC13XXX_USE_LED
=20
 #define MC13783_ADC_MODE_TS		1
 #define MC13783_ADC_MODE_SINGLE_CHAN	2
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index c064bea..cef1497 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -142,8 +142,6 @@ struct mc13xxx_platform_data {
 #define MC13XXX_USE_CODEC	(1 << 1)
 #define MC13XXX_USE_ADC		(1 << 2)
 #define MC13XXX_USE_RTC		(1 << 3)
-#define MC13XXX_USE_REGULATOR	(1 << 4)
-#define MC13XXX_USE_LED		(1 << 5)
 	unsigned int flags;
=20
 	struct mc13xxx_regulator_platform_data regulators;
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
