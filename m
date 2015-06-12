From: Dudley Du <dudl@cypress.com>
Subject: [PATCH 4/7] input: cyapa: fully support runtime suspend power management
Date: Fri, 12 Jun 2015 14:56:35 +0800
Message-ID: <1434092198-13018-5-git-send-email-dudl@cypress.com>
References: <1434092198-13018-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.cypress.com ([157.95.67.100]:58018 "EHLO
	smtp1.cypress.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbbFLHSX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 03:18:23 -0400
In-Reply-To: <1434092198-13018-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@euromail.se
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Fix the the runtime suspend power management not working issue when system
starts up and before user touches the trackpad device.
TEST=test on Chromebook.

Signed-off-by: Dudley Du <dudl@cypress.com>
---
 drivers/input/mouse/cyapa.c      | 79 +++++++++++++++++++++++++++-------------
 drivers/input/mouse/cyapa.h      |  2 +-
 drivers/input/mouse/cyapa_gen3.c |  4 +-
 drivers/input/mouse/cyapa_gen5.c | 21 +++++++----
 drivers/input/mouse/cyapa_gen6.c |  4 +-
 5 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 4146ab7..faead4d 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -371,7 +371,7 @@ static int cyapa_detect(struct cyapa *cyapa)
 static int cyapa_open(struct input_dev *input)
 {
 	struct cyapa *cyapa = input_get_drvdata(input);
-	struct i2c_client *client = cyapa->client;
+	struct device *dev = &cyapa->client->dev;
 	int error;
 
 	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
@@ -385,10 +385,9 @@ static int cyapa_open(struct input_dev *input)
 		 * when in operational mode.
 		 */
 		error = cyapa->ops->set_power_mode(cyapa,
-				PWR_MODE_FULL_ACTIVE, 0);
+				PWR_MODE_FULL_ACTIVE, 0, false);
 		if (error) {
-			dev_warn(&client->dev,
-				"set active power failed: %d\n", error);
+			dev_warn(dev, "set active power failed: %d\n", error);
 			goto out;
 		}
 	} else {
@@ -399,11 +398,15 @@ static int cyapa_open(struct input_dev *input)
 		}
 	}
 
-	enable_irq(client->irq);
-	if (!pm_runtime_enabled(&client->dev)) {
-		pm_runtime_set_active(&client->dev);
-		pm_runtime_enable(&client->dev);
+	enable_irq(cyapa->client->irq);
+	if (!pm_runtime_enabled(dev)) {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
 	}
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_sync_autosuspend(dev);
 out:
 	mutex_unlock(&cyapa->state_sync_lock);
 	return error;
@@ -412,17 +415,17 @@ out:
 static void cyapa_close(struct input_dev *input)
 {
 	struct cyapa *cyapa = input_get_drvdata(input);
-	struct i2c_client *client = cyapa->client;
+	struct device *dev = &cyapa->client->dev;
 
 	mutex_lock(&cyapa->state_sync_lock);
 
-	disable_irq(client->irq);
-	if (pm_runtime_enabled(&client->dev))
-		pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	disable_irq(cyapa->client->irq);
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	if (cyapa->operational)
-		cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0);
+		cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0, false);
 
 	mutex_unlock(&cyapa->state_sync_lock);
 }
@@ -533,7 +536,7 @@ static void cyapa_enable_irq_for_cmd(struct cyapa *cyapa)
 		 */
 		if (!input || cyapa->operational)
 			cyapa->ops->set_power_mode(cyapa,
-				PWR_MODE_FULL_ACTIVE, 0);
+				PWR_MODE_FULL_ACTIVE, 0, false);
 		/* Gen3 always using polling mode for command. */
 		if (cyapa->gen >= CYAPA_GEN5)
 			enable_irq(cyapa->client->irq);
@@ -548,7 +551,8 @@ static void cyapa_disable_irq_for_cmd(struct cyapa *cyapa)
 		if (cyapa->gen >= CYAPA_GEN5)
 			disable_irq(cyapa->client->irq);
 		if (!input || cyapa->operational)
-			cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0);
+			cyapa->ops->set_power_mode(cyapa,
+						   PWR_MODE_OFF, 0, false);
 	}
 }
 
@@ -615,7 +619,7 @@ static int cyapa_initialize(struct cyapa *cyapa)
 
 	/* Power down the device until we need it. */
 	if (cyapa->operational)
-		cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0);
+		cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0, false);
 
 	return 0;
 }
@@ -631,7 +635,8 @@ static int cyapa_reinitialize(struct cyapa *cyapa)
 
 	/* Avoid command failures when TP was in OFF state. */
 	if (cyapa->operational)
-		cyapa->ops->set_power_mode(cyapa, PWR_MODE_FULL_ACTIVE, 0);
+		cyapa->ops->set_power_mode(cyapa,
+					   PWR_MODE_FULL_ACTIVE, 0, false);
 
 	error = cyapa_detect(cyapa);
 	if (error)
@@ -650,7 +655,8 @@ out:
 	if (!input || !input->users) {
 		/* Reset to power OFF state to save power when no user open. */
 		if (cyapa->operational)
-			cyapa->ops->set_power_mode(cyapa, PWR_MODE_OFF, 0);
+			cyapa->ops->set_power_mode(cyapa,
+						   PWR_MODE_OFF, 0, false);
 	} else if (!error && cyapa->operational) {
 		/*
 		 * Make sure only enable runtime PM when device is
@@ -658,6 +664,10 @@ out:
 		 */
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
+
+		pm_runtime_get_sync(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_sync_autosuspend(dev);
 	}
 
 	return error;
@@ -667,8 +677,8 @@ static irqreturn_t cyapa_irq(int irq, void *dev_id)
 {
 	struct cyapa *cyapa = dev_id;
 	struct device *dev = &cyapa->client->dev;
+	int error;
 
-	pm_runtime_get_sync(dev);
 	if (device_may_wakeup(dev))
 		pm_wakeup_event(dev, 0);
 
@@ -687,7 +697,24 @@ static irqreturn_t cyapa_irq(int irq, void *dev_id)
 			goto out;
 		}
 
-		if (!cyapa->operational || cyapa->ops->irq_handler(cyapa)) {
+		if (cyapa->operational) {
+			error = cyapa->ops->irq_handler(cyapa);
+
+			/*
+			 * Apply runtime power management to touch report event
+			 * except the events caused by the command responses.
+			 * Note:
+			 * It will introduce about 20~40 ms additional delay
+			 * time in receiving for first valid touch report data.
+			 * The time is used to exceute device runtime resume
+			 * process.
+			 */
+			pm_runtime_get_sync(dev);
+			pm_runtime_mark_last_busy(dev);
+			pm_runtime_put_sync_autosuspend(dev);
+		}
+
+		if (!cyapa->operational || error) {
 			if (!mutex_trylock(&cyapa->state_sync_lock)) {
 				cyapa->ops->sort_empty_output_data(cyapa,
 					NULL, NULL, NULL);
@@ -699,8 +726,6 @@ static irqreturn_t cyapa_irq(int irq, void *dev_id)
 	}
 
 out:
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_sync_autosuspend(dev);
 	return IRQ_HANDLED;
 }
 
@@ -1341,7 +1366,7 @@ static int __maybe_unused cyapa_suspend(struct device *dev)
 		power_mode = device_may_wakeup(dev) ? cyapa->suspend_power_mode
 						    : PWR_MODE_OFF;
 		error = cyapa->ops->set_power_mode(cyapa, power_mode,
-				cyapa->suspend_sleep_time);
+				cyapa->suspend_sleep_time, true);
 		if (error)
 			dev_err(dev, "suspend set power mode failed: %d\n",
 					error);
@@ -1395,7 +1420,8 @@ static int __maybe_unused cyapa_runtime_suspend(struct device *dev)
 
 	error = cyapa->ops->set_power_mode(cyapa,
 			cyapa->runtime_suspend_power_mode,
-			cyapa->runtime_suspend_sleep_time);
+			cyapa->runtime_suspend_sleep_time,
+			false);
 	if (error)
 		dev_warn(dev, "runtime suspend failed: %d\n", error);
 
@@ -1407,7 +1433,8 @@ static int __maybe_unused cyapa_runtime_resume(struct device *dev)
 	struct cyapa *cyapa = dev_get_drvdata(dev);
 	int error;
 
-	error = cyapa->ops->set_power_mode(cyapa, PWR_MODE_FULL_ACTIVE, 0);
+	error = cyapa->ops->set_power_mode(cyapa,
+					   PWR_MODE_FULL_ACTIVE, 0, false);
 	if (error)
 		dev_warn(dev, "runtime resume failed: %d\n", error);
 
diff --git a/drivers/input/mouse/cyapa.h b/drivers/input/mouse/cyapa.h
index 090d5be..cc30367 100644
--- a/drivers/input/mouse/cyapa.h
+++ b/drivers/input/mouse/cyapa.h
@@ -273,7 +273,7 @@ struct cyapa_dev_ops {
 	int (*sort_empty_output_data)(struct cyapa *,
 			u8 *, int *, cb_sort);
 
-	int (*set_power_mode)(struct cyapa *, u8, u16);
+	int (*set_power_mode)(struct cyapa *, u8, u16, bool);
 
 	int (*set_proximity)(struct cyapa *, bool);
 };
diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index 47004bb..2d077e5 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -950,7 +950,7 @@ static u16 cyapa_get_wait_time_for_pwr_cmd(u8 pwr_mode)
  * Device power mode can only be set when device is in operational mode.
  */
 static int cyapa_gen3_set_power_mode(struct cyapa *cyapa, u8 power_mode,
-				     u16 always_unused)
+		u16 always_unused, bool is_suspend_unused)
 {
 	int ret;
 	u8 power;
@@ -1107,7 +1107,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
 		 * may cause problems, so we set the power mode first here.
 		 */
 		error = cyapa_gen3_set_power_mode(cyapa,
-				PWR_MODE_FULL_ACTIVE, 0);
+				PWR_MODE_FULL_ACTIVE, 0, false);
 		if (error)
 			dev_err(dev, "%s: set full power mode failed: %d\n",
 				__func__, error);
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index d1cd7a7..5ab0cd2 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 #include <linux/crc-itu-t.h>
+#include <linux/pm_runtime.h>
 #include "cyapa.h"
 
 
@@ -1565,7 +1566,7 @@ int cyapa_pip_deep_sleep(struct cyapa *cyapa, u8 state)
 }
 
 static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
-		u8 power_mode, u16 sleep_time)
+		u8 power_mode, u16 sleep_time, bool is_suspend)
 {
 	struct device *dev = &cyapa->client->dev;
 	u8 power_state;
@@ -1574,9 +1575,6 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
 	if (cyapa->state != CYAPA_STATE_GEN5_APP)
 		return 0;
 
-	/* Dump all the report data before do power mode commmands. */
-	cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
-
 	if (PIP_DEV_GET_PWR_STATE(cyapa) == UNINIT_PWR_MODE) {
 		/*
 		 * Assume TP in deep sleep mode when driver is loaded,
@@ -1679,8 +1677,8 @@ static int cyapa_gen5_set_power_mode(struct cyapa *cyapa,
 		 * is suspending which may cause interrput line unable to be
 		 * asserted again.
 		 */
-		cyapa_empty_pip_output_data(cyapa, NULL, NULL, NULL);
-		cyapa_gen5_disable_pip_report(cyapa);
+		if (is_suspend)
+			cyapa_gen5_disable_pip_report(cyapa);
 
 		PIP_DEV_SET_PWR_STATE(cyapa,
 			cyapa_sleep_time_to_pwr_cmd(sleep_time));
@@ -2515,7 +2513,7 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
 		 * the device state is requeried.
 		 */
 		error = cyapa_gen5_set_power_mode(cyapa,
-				PWR_MODE_FULL_ACTIVE, 0);
+				PWR_MODE_FULL_ACTIVE, 0, false);
 		if (error)
 			dev_warn(dev, "%s: failed to set power active mode.\n",
 				__func__);
@@ -2756,7 +2754,16 @@ int cyapa_pip_irq_handler(struct cyapa *cyapa)
 		/*
 		 * Device wake event from deep sleep mode for touch.
 		 * This interrupt event is used to wake system up.
+		 *
+		 * Note:
+		 * It will introduce about 20~40 ms additional delay
+		 * time in receiving for first valid touch report data.
+		 * The time is used to exceute device runtime resume
+		 * process.
 		 */
+		pm_runtime_get_sync(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_sync_autosuspend(dev);
 		return 0;
 	} else if (report_id != PIP_TOUCH_REPORT_ID &&
 			report_id != PIP_BTN_REPORT_ID &&
diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 693d152..9d76715 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -431,7 +431,7 @@ static int cyapa_gen6_deep_sleep(struct cyapa *cyapa, u8 state)
 }
 
 static int cyapa_gen6_set_power_mode(struct cyapa *cyapa,
-		u8 power_mode, u16 sleep_time)
+		u8 power_mode, u16 sleep_time, bool is_suspend)
 {
 	struct device *dev = &cyapa->client->dev;
 	struct gen6_interval_setting *interval_setting =
@@ -692,7 +692,7 @@ static int cyapa_gen6_operational_check(struct cyapa *cyapa)
 		 * the device state is requeried.
 		 */
 		error = cyapa_gen6_set_power_mode(cyapa,
-				PWR_MODE_FULL_ACTIVE, 0);
+				PWR_MODE_FULL_ACTIVE, 0, false);
 		if (error)
 			dev_warn(dev, "%s: failed to set power active mode.\n",
 				__func__);
-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

