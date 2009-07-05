From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] Input: mark serio and i8042 as suspended when hibernating too.
Date: Sat,  4 Jul 2009 23:13:39 -0300
Message-ID: <1246760019-4120-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753914AbZGECOL@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rjw@sisk.pl, maciej.rutecki@gmail.com, alan-jenkins@tuffmail.co.uk, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
List-Id: linux-input@vger.kernel.org

serio ports are not being restarted any longer because resume operations
after hibernate do nothing, since the device has not been marked as
suspended. This happens because suspend is only considering the SUSPEND
event but not the FREEZE event.

Note that this driver has still to migrate to dev_pm_ops, but this fixes
this particular bug now.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/input/serio/i8042.c |    7 ++++---
 drivers/input/serio/serio.c |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index f919bf5..582245c 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -934,10 +934,11 @@ static bool i8042_suspended;
 
 static int i8042_suspend(struct platform_device *dev, pm_message_t state)
 {
-	if (!i8042_suspended && state.event == PM_EVENT_SUSPEND) {
+	if (!i8042_suspended && state.event == PM_EVENT_SUSPEND)
 		i8042_controller_reset();
-		i8042_suspended = true;
-	}
+
+	i8042_suspended = state.event == PM_EVENT_SUSPEND ||
+			  state.event == PM_EVENT_FREEZE;
 
 	return 0;
 }
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index fb17573..d66f494 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -935,10 +935,11 @@ static int serio_suspend(struct device *dev, pm_message_t state)
 {
 	struct serio *serio = to_serio_port(dev);
 
-	if (!serio->suspended && state.event == PM_EVENT_SUSPEND) {
+	if (!serio->suspended && state.event == PM_EVENT_SUSPEND)
 		serio_cleanup(serio);
-		serio->suspended = true;
-	}
+
+	serio->suspended = state.event == PM_EVENT_SUSPEND ||
+			   state.event == PM_EVENT_FREEZE;
 
 	return 0;
 }
-- 
1.6.3
