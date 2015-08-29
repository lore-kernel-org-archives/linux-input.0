From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH v2 3/6] input: regulator-haptic: Fix module autoload for OF
 platform driver
Date: Sat, 29 Aug 2015 12:47:26 +0200
Message-ID: <20150829104726.GA20770@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jaewon Kim <jaewon02.kim@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Fabian Frederick <fabf@skynet.be>, Axel Lin <axel.lin@ingics.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---

Better without an empty line between of_device_id and MODULE_DEVICE_TABLE.

Thanks,
Luis

 drivers/input/misc/regulator-haptic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index 6bf3f10..a804705 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -249,6 +249,7 @@ static const struct of_device_id regulator_haptic_dt_match[] = {
 	{ .compatible = "regulator-haptic" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, regulator_haptic_dt_match);
 
 static struct platform_driver regulator_haptic_driver = {
 	.probe		= regulator_haptic_probe,
-- 
2.4.6
