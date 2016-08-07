From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH] [TRIVIAL] input: touchscreen: ads7846 Remove redundant
 regulator_disable call
Date: Sun, 7 Aug 2016 08:50:34 +0200
Message-ID: <6af51f31-1a28-7b6e-3e83-866a0a1135ea@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:41878 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbcHGG4T (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Aug 2016 02:56:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

ADS7846 regulator is disabled twice in a row in ads7846_remove(). Valid
one is in ads7846_disable().

Removing the ads7846 module causes warning about unbalanced disables.

  ...
  WARNING: CPU: 0 PID: 29269 at drivers/regulator/core.c:2251 _regulator_disable+0xf8/0x130
  unbalanced disables for vads7846
  CPU: 0 PID: 29269 Comm: rmmod Tainted: G      D W       4.7.0+ #3
  Hardware name: HTC Magician
  ...
    show_stack+0x10/0x14
    __warn+0xd8/0x100
    warn_slowpath_fmt+0x38/0x48
    _regulator_disable+0xf8/0x130
    regulator_disable+0x34/0x60
    ads7846_remove+0x58/0xd4 [ads7846]
    spi_drv_remove+0x1c/0x34
    __device_release_driver+0x84/0x114
    driver_detach+0x8c/0x90
    bus_remove_driver+0x5c/0xc8
    SyS_delete_module+0x1a0/0x238
    ret_fast_syscall+0x0/0x38

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/input/touchscreen/ads7846.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a61b215..1ce3ecb 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1473,7 +1473,6 @@ static int ads7846_remove(struct spi_device *spi)
 
 	ads784x_hwmon_unregister(spi, ts);
 
-	regulator_disable(ts->reg);
 	regulator_put(ts->reg);
 
 	if (!ts->get_pendown_state) {
-- 
2.9.2

