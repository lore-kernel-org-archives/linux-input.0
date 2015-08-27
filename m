From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 5/6] input: egalax_ts: Fix module autoload for OF platform
 driver
Date: Thu, 27 Aug 2015 19:00:46 +0200
Message-ID: <20150827170046.GA5618@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/input/touchscreen/egalax_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 4c56299..7380eec 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -265,6 +265,8 @@ static const struct of_device_id egalax_ts_dt_ids[] = {
 	{ /* sentinel */ }
 };
 
+MODULE_DEVICE_TABLE(of, egalax_ts_dt_ids);
+
 static struct i2c_driver egalax_ts_driver = {
 	.driver = {
 		.name	= "egalax_ts",
-- 
2.4.6
