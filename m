From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elan_i2c - enable asynchronous probing
Date: Wed, 5 Aug 2015 12:02:30 -0700
Message-ID: <20150805190230.GA37676@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34651 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbbHETCe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Aug 2015 15:02:34 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: duson <dusonlin@emc.com.tw>, Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org

It takes a bit of time to go through controller power up sequence and
initialization. To not stall the overall boot progress let's probe the
controller asynchronously, given that userspace is usually prepared for
hot-plugging of input devices and thus does not rely on particular
ordering.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 0a076d3..67388f4 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1185,6 +1185,7 @@ static struct i2c_driver elan_driver = {
 		.pm	= &elan_pm_ops,
 		.acpi_match_table = ACPI_PTR(elan_acpi_id),
 		.of_match_table = of_match_ptr(elan_of_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= elan_probe,
 	.id_table	= elan_id,
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
