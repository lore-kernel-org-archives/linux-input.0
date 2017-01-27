From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] input: cros_ec_keyb: Add Tablet Mode switch.
Date: Fri, 27 Jan 2017 11:52:35 +0100
Message-ID: <20170127105235.4727-1-enric.balletbo@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60722 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbdA0KzT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 05:55:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, Enric Balletbo Serra <enric.balletbo@collabora.com>

From: Gwendal Grignou <gwendal@chromium.org>

Add switch to report tablet mode.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
---

I should be included this patch in the following patch series but I missed the
patch and found later. Though it can be applied separetely.

 - [PATCH 1/2] mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
 - [PATCH 2/2] input: cros_ec_keyb: Add non-matrix buttons and switches

 drivers/input/keyboard/cros_ec_keyb.c | 5 +++++
 include/linux/mfd/cros_ec_commands.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index ad74ebc..604c7ad 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -111,6 +111,11 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
 		.bit		= EC_MKBP_LID_OPEN,
 		.inverted	= true,
 	},
+	{
+		.ev_type	= EV_SW,
+		.code		= SW_TABLET_MODE,
+		.bit		= EC_MKBP_TABLET_MODE,
+	},
 };
 
 /*
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index a01dde4..e793e9f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2094,6 +2094,7 @@ struct ec_response_get_next_event {
 
 /* Switches */
 #define EC_MKBP_LID_OPEN	0
+#define EC_MKBP_TABLET_MODE	1
 
 /*****************************************************************************/
 /* Temperature sensor commands */
-- 
2.9.3

