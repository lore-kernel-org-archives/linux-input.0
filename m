From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v4 2/2] i8042: Enable OLPC's EC-based i8042 wakeup control
Date: Tue,  2 Aug 2011 16:49:34 +0100 (BST)
Message-ID: <20110802154934.7B80B9D401C__34788.6661104441$1312303672$gmane$org@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:64591 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670Ab1HBQrl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2011 12:47:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, dilinger@queued.net

The OLPC XO laptop can be resumed from suspend via keyboard or mouse
activity. Hook up the i8042 driver to the OLPC EC controls to make
this possible.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/serio/i8042-x86ia64io.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 76b2e58..36f6015 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -9,6 +9,7 @@
 
 #ifdef CONFIG_X86
 #include <asm/x86_init.h>
+#include <asm/olpc.h>
 #endif
 
 /*
@@ -877,6 +878,13 @@ static inline void i8042_pnp_exit(void) { }
 
 static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
 {
+	if (!machine_is_olpc())
+		return;
+
+	if (may_wakeup)
+		olpc_ec_wakeup_set(EC_SCI_SRC_GAME);
+	else
+		olpc_ec_wakeup_clear(EC_SCI_SRC_GAME);
 }
 
 static int __init i8042_platform_init(void)
@@ -923,6 +931,9 @@ static int __init i8042_platform_init(void)
 
 	if (dmi_check_system(i8042_dmi_dritek_table))
 		i8042_dritek = true;
+
+	if (olpc_ec_wakeup_available())
+		i8042_enable_wakeup = true;
 #endif /* CONFIG_X86 */
 
 	return retval;
-- 
1.7.6

