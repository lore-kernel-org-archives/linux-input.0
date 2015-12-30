From: Lyude <cpaul@redhat.com>
Subject: [PATCH] HID: wacom: Fix deadlock on proximity in events with the Intuos Draw
Date: Wed, 30 Dec 2015 12:08:27 -0500
Message-ID: <1451495307-11600-1-git-send-email-cpaul@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889AbbL3RIt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2015 12:08:49 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>
Cc: Lyude <cpaul@redhat.com>

Unfortunately, when we have an Intuos Draw connected using a USB
connection, wacom's IRQ handler will be called while the lock for the
usbhid driver is held by hid_ctrl. This means when we try to schedule a
new proximity event in wacom_intuos_schedule_prox_event() by calling
hid_hw_request(), we'll try to take the lock a second time which
deadlocks the system. This patch fixes that behavior by initializing a
worker when we have a INTUOSHT2 device connected, and using that worker
to schedule the proximity event instead.

Signed-off-by: Lyude <cpaul@redhat.com>
---
 drivers/hid/wacom_wac.c | 9 +++++++--
 drivers/hid/wacom_wac.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 01a4f05..b59ded6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -433,8 +433,10 @@ exit:
 	return retval;
 }
 
-static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
+static void wacom_intuos_schedule_prox_event(struct work_struct *work)
 {
+	struct wacom_wac *wacom_wac =
+		container_of(work, struct wacom_wac, intuos_prox_event_worker);
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	struct hid_report *r;
 	struct hid_report_enum *re;
@@ -624,7 +626,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	/* don't report other events if we don't know the ID */
 	if (!wacom->id[idx]) {
 		/* but reschedule a read of the current tool */
-		wacom_intuos_schedule_prox_event(wacom);
+		schedule_work(&wacom->intuos_prox_event_worker);
 		return 1;
 	}
 
@@ -2675,6 +2677,9 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 
 		if (features->type == INTUOSHT2) {
 			wacom_setup_basic_pro_pen(wacom_wac);
+
+			INIT_WORK(&wacom_wac->intuos_prox_event_worker,
+				  wacom_intuos_schedule_prox_event);
 		} else {
 			__clear_bit(ABS_MISC, input_dev->absbit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 877c24a..c24cfdc 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -237,6 +237,7 @@ struct wacom_wac {
 	int ps_connected;
 	u8 bt_features;
 	u8 bt_high_speed;
+	struct work_struct intuos_prox_event_worker;
 	struct hid_data hid_data;
 };
 
-- 
2.5.0

