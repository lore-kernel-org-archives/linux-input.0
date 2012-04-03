From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] input/tps6507x-ts: fix MODULE_ALIAS to match driver name
Date: Tue,  3 Apr 2012 16:24:11 +0200
Message-ID: <1333463051-29986-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58734 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab2DCOYa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 10:24:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, Todd Fischer <todd.fischer@ridgerun.com>

This is needed to make module auto loading work.

Cc: Todd Fischer <todd.fischer@ridgerun.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/touchscreen/tps6507x-ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/to=
uchscreen/tps6507x-ts.c
index 6c6f6d8..da2cb08 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -376,4 +376,4 @@ module_platform_driver(tps6507x_ts_driver);
 MODULE_AUTHOR("Todd Fischer <todd.fischer@ridgerun.com>");
 MODULE_DESCRIPTION("TPS6507x - TouchScreen driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:tps6507x-tsc");
+MODULE_ALIAS("platform:tps6507x-ts");
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
