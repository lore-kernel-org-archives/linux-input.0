From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] gpio: adp5588 - use "unsigned" for the setup and teardown callbacks
Date: Mon, 10 Feb 2014 12:24:04 -0500
Message-ID: <1392053045-12121-1-git-send-email-jeff.dagenais@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:59937 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbaBJRYX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Feb 2014 12:24:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com, dmitry.torokhov@gmail.com, dtor@mail.ru, linus.walleij@linaro.org, gnurou@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>

to comply with the rest of the GPIO drivers.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 include/linux/i2c/adp5588.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index d8341cb..c215304 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -161,10 +161,10 @@ struct adp5588_gpio_platform_data {
 	unsigned irq_base;	/* interrupt base # */
 	unsigned pullup_dis_mask; /* Pull-Up Disable Mask */
 	int	(*setup)(struct i2c_client *client,
-				int gpio, unsigned ngpio,
+				unsigned gpio, unsigned ngpio,
 				void *context);
 	int	(*teardown)(struct i2c_client *client,
-				int gpio, unsigned ngpio,
+				unsigned gpio, unsigned ngpio,
 				void *context);
 	void	*context;
 };
-- 
1.8.5.3

