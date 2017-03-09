From: Jingkui Wang <jkwang@google.com>
Subject: [PATCH] drivers: Remove OF dependency in drv260x driver
Date: Wed, 8 Mar 2017 16:54:02 -0800
Message-ID: <CACMZmvWLBHPVjaDbqL3Xjibwc+v+c5dgC75Pq7cSmpCG+=tmwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

As the driver is using generic device properties, it should work
properly when CONFIG_OF is turned off. This patch removes the
ifdef CONFIGOF and make sure the driver always have of_match_table.

Signed-off-by: Jingkui Wang <jkwang@google.com>
---
 drivers/input/misc/drv260x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index fb089d3..17eb84a 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -652,7 +652,6 @@ static const struct i2c_device_id drv260x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, drv260x_id);

-#ifdef CONFIG_OF
 static const struct of_device_id drv260x_of_match[] = {
  { .compatible = "ti,drv2604", },
  { .compatible = "ti,drv2604l", },
@@ -661,13 +660,12 @@ static const struct of_device_id drv260x_of_match[] = {
  { }
 };
 MODULE_DEVICE_TABLE(of, drv260x_of_match);
-#endif

 static struct i2c_driver drv260x_driver = {
  .probe = drv260x_probe,
  .driver = {
  .name = "drv260x-haptics",
- .of_match_table = of_match_ptr(drv260x_of_match),
+ .of_match_table = drv260x_of_match,
  .pm = &drv260x_pm_ops,
  },
  .id_table = drv260x_id,
-- 
2.6.6
