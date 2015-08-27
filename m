From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 3/6] input: regulator-haptic: Fix module autoload for OF
 platform driver
Date: Thu, 27 Aug 2015 18:59:49 +0200
Message-ID: <20150827165949.GA5557@goodgumbo.baconseed.org>
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
 drivers/input/misc/regulator-haptic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index 6bf3f10..2218b3d 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -250,6 +250,8 @@ static const struct of_device_id regulator_haptic_dt_match[] = {
 	{ /* sentinel */ },
 };
 
+MODULE_DEVICE_TABLE(of, regulator_haptic_dt_match);
+
 static struct platform_driver regulator_haptic_driver = {
 	.probe		= regulator_haptic_probe,
 	.driver		= {
-- 
2.4.6
