From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] Input: elants_i2c - enable asynchronous probing
Date: Wed, 5 Aug 2015 11:51:37 -0700
Message-ID: <20150805185137.GA31337@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33332 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbHESvk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2015 14:51:40 -0400
Received: by pdrh1 with SMTP id h1so4001684pdr.0
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2015 11:51:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Charlie Mooney <charliemooney@chromium.org>, James Chen <james.chen@emc.com.tw>, Scott Liu <scott.liu@emc.com.tw>, linux-kernel@vger.kernel.org

It takes a bit of time to go through controller power up sequence and
initialization. To not stall the overall boot progress let's probe the
controller asynchronously, given that userspace is usually prepared for
hot-plugging of input devices and thus does not rely on particular
ordering.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/elants_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 1912265..6f71556 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -1410,6 +1410,7 @@ static struct i2c_driver elants_i2c_driver = {
 		.pm = &elants_i2c_pm_ops,
 		.acpi_match_table = ACPI_PTR(elants_acpi_id),
 		.of_match_table = of_match_ptr(elants_of_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_i2c_driver(elants_i2c_driver);
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
