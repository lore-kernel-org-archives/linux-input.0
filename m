From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 1/6] mc13xxx: Unconditionally register regulator subdevice
Date: Thu, 21 Jul 2011 20:04:18 +0200
Message-ID: <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:36339 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751598Ab1GUSEr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 14:04:47 -0400
In-Reply-To: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 drivers/mfd/mc13xxx-core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 7e4d44b..c238f6b 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -763,10 +763,8 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_CODEC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
=20
-	if (pdata->flags & MC13XXX_USE_REGULATOR) {
-		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
-				&pdata->regulators, sizeof(pdata->regulators));
-	}
+	mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
+		&pdata->regulators, sizeof(pdata->regulators));
=20
 	if (pdata->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
