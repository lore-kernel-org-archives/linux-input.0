From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] wm97xx-core: Fix driver name
Date: Mon, 26 May 2008 14:42:01 +0100
Message-ID: <1211809323-4742-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1211809323-4742-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755627AbYEZNmW@vger.kernel.org>
In-Reply-To: <1211809323-4742-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rodolfo Giometti <giometti@enneenne.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-input@vger.kernel.org

Fix driver name - thanks to Guennadi Liakhovetski <g.liakhovetski@gmx.de> for
reporting this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index ba6fb28..8a00918 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -802,7 +802,7 @@ void wm97xx_unregister_mach_ops(struct wm97xx *wm)
 EXPORT_SYMBOL_GPL(wm97xx_unregister_mach_ops);
 
 static struct device_driver wm97xx_driver = {
-	.name =		"ac97",
+	.name =		"wm97xx-ts",
 	.bus =		&ac97_bus_type,
 	.owner =	THIS_MODULE,
 	.probe =	wm97xx_probe,
-- 
1.5.5.1
