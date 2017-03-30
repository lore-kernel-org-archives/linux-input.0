From: Rajat Jain <rajatja@google.com>
Subject: [PATCH] input: cros_ec_keyb: Add an EC event for sysrq
Date: Thu, 30 Mar 2017 15:18:07 -0700
Message-ID: <20170330221807.2983-1-rajatja@google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34758 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdC3WS2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 18:18:28 -0400
Received: by mail-pg0-f41.google.com with SMTP id 21so51823100pgg.1
        for <linux-input@vger.kernel.org>; Thu, 30 Mar 2017 15:18:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, rajatxjain@gmail.com, dtor@google.com, Rajat Jain <rajatja@google.com>

Some form factors (detachables / tablets) may not have a keyboard and
thus user may have to resort to using a defined EC UI to send sysrq(s)
to the kernel in order to collect crash info etc. This UI typically
is in the form of user pressing volume / power buttons in some specific
sequence and for some specific time. Add a new EC event that allows EC
to communicate the sysrq to the AP.

(We're skipping event number 5 because it has been reserved for
something else)

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 7 +++++++
 include/linux/mfd/cros_ec_commands.h  | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 6a250d65f8fe..00a3a830cd3a 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -30,6 +30,7 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/sysrq.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
@@ -260,6 +261,12 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 				     ckdev->ec->event_size);
 		break;
 
+	case EC_MKBP_EVENT_SYSRQ:
+		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
+		dev_dbg(ckdev->dev, "sysrq code from EC : %#x\n", val);
+		handle_sysrq(val);
+		break;
+
 	case EC_MKBP_EVENT_BUTTON:
 	case EC_MKBP_EVENT_SWITCH:
 		/*
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index f1ef6388c233..c93e7e0300ef 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2041,6 +2041,9 @@ enum ec_mkbp_event {
 	/* The state of the switches have changed. */
 	EC_MKBP_EVENT_SWITCH = 4,
 
+	/* EC sent a sysrq command */
+	EC_MKBP_EVENT_SYSRQ = 6,
+
 	/* Number of MKBP events */
 	EC_MKBP_EVENT_COUNT,
 };
@@ -2053,6 +2056,7 @@ union ec_response_get_next_data {
 
 	uint32_t   buttons;
 	uint32_t   switches;
+	uint32_t   sysrq;
 } __packed;
 
 struct ec_response_get_next_event {
-- 
2.12.2.564.g063fe858b8-goog

