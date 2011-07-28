From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v3 2/2] i8042: Enable OLPC's EC-based i8042
	wakeup control
Date: Thu, 28 Jul 2011 15:31:39 +0100 (BST)
Message-ID: <20110728143140.002459D401C__1481.5399110832$1311863577$gmane$org@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: dtor@mail.ru, dmitry.torokhov@gmail.com
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The OLPC XO laptop can be resumed from suspend via keyboard or mouse
activity. Hook up the i8042 driver to the OLPC EC controls to make
this possible.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/serio/i8042-x86ia64io.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

This depends on patches merged into linus master 2 days ago.

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
