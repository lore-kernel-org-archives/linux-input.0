From: Jean Lucas <jean@4ray.co>
Subject: [PATCH] Input: atmel_mxt_ts: Add touchscreen support for Chromebooks
 with upstream coreboot
Date: Fri, 8 Dec 2017 03:06:36 -0500
Message-ID: <20171208080634.GA22605@racecar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mute.4ray.co ([163.172.156.253]:37554 "EHLO 4ray.co"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750927AbdLHINV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Dec 2017 03:13:21 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Chromebooks use coreboot for system initialization. coreboot has always
had the default mainboard vendor string for Google machines set to
"Google". Google engineers set this string to "GOOGLE" for the coreboot
copy within their Chromium OS tree. The atmel_mxt_ts driver in its
current state is set to match the latter case; it will only bind to a
Chromebook's touchscreen either if the device uses the vendor coreboot
firmware (providing the matching mainboard vendor string), or if a user
running upstream coreboot has manually set the string to "GOOGLE". Let's
add a match for coreboot's default.

Signed-off-by: Jean Lucas <jean@4ray.co>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db..43d1ea4145d7 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3038,6 +3038,14 @@ static const struct dmi_system_id mxt_dmi_table[] = {
 		},
 		.driver_data = chromebook_platform_data,
 	},
+	{
+		/* Chromebooks with a custom coreboot version */
+		.ident = "Chromebook",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+		},
+		.driver_data = chromebook_platform_data,
+	},
 	{ }
 };
 
-- 
2.15.1

