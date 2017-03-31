From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Move wacom_remote_irq and wacom_remote_status_irq
Date: Fri, 31 Mar 2017 10:02:05 -0700
Message-ID: <20170331170205.28302-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36014 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933349AbdCaRCX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 13:02:23 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so18668184pgh.3
        for <linux-input@vger.kernel.org>; Fri, 31 Mar 2017 10:02:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

These two functions awkwardly break up the otherwise-contiguous chunk of
related Intuos IRQ functions with a 500 line tangent about the operation
of the EKR. Their presence makes it difficult to read/navigate through the
the Intuos code. Since there is no dependency between these functions, it
is possible to simply move them down somewhat. This commit moves them
to be after the final Intuos IRQ function.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 250 ++++++++++++++++++++++++------------------------
 1 file changed, 125 insertions(+), 125 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f1360381c8f5..716a68258f81 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -773,131 +773,6 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	return 0;
 }
 
-static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
-{
-	unsigned char *data = wacom_wac->data;
-	struct input_dev *input;
-	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
-	struct wacom_remote *remote = wacom->remote;
-	int bat_charging, bat_percent, touch_ring_mode;
-	__u32 serial;
-	int i, index = -1;
-	unsigned long flags;
-
-	if (data[0] != WACOM_REPORT_REMOTE) {
-		hid_dbg(wacom->hdev, "%s: received unknown report #%d",
-			__func__, data[0]);
-		return 0;
-	}
-
-	serial = data[3] + (data[4] << 8) + (data[5] << 16);
-	wacom_wac->id[0] = PAD_DEVICE_ID;
-
-	spin_lock_irqsave(&remote->remote_lock, flags);
-
-	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (remote->remotes[i].serial == serial) {
-			index = i;
-			break;
-		}
-	}
-
-	if (index < 0 || !remote->remotes[index].registered)
-		goto out;
-
-	input = remote->remotes[index].input;
-
-	input_report_key(input, BTN_0, (data[9] & 0x01));
-	input_report_key(input, BTN_1, (data[9] & 0x02));
-	input_report_key(input, BTN_2, (data[9] & 0x04));
-	input_report_key(input, BTN_3, (data[9] & 0x08));
-	input_report_key(input, BTN_4, (data[9] & 0x10));
-	input_report_key(input, BTN_5, (data[9] & 0x20));
-	input_report_key(input, BTN_6, (data[9] & 0x40));
-	input_report_key(input, BTN_7, (data[9] & 0x80));
-
-	input_report_key(input, BTN_8, (data[10] & 0x01));
-	input_report_key(input, BTN_9, (data[10] & 0x02));
-	input_report_key(input, BTN_A, (data[10] & 0x04));
-	input_report_key(input, BTN_B, (data[10] & 0x08));
-	input_report_key(input, BTN_C, (data[10] & 0x10));
-	input_report_key(input, BTN_X, (data[10] & 0x20));
-	input_report_key(input, BTN_Y, (data[10] & 0x40));
-	input_report_key(input, BTN_Z, (data[10] & 0x80));
-
-	input_report_key(input, BTN_BASE, (data[11] & 0x01));
-	input_report_key(input, BTN_BASE2, (data[11] & 0x02));
-
-	if (data[12] & 0x80)
-		input_report_abs(input, ABS_WHEEL, (data[12] & 0x7f));
-	else
-		input_report_abs(input, ABS_WHEEL, 0);
-
-	bat_percent = data[7] & 0x7f;
-	bat_charging = !!(data[7] & 0x80);
-
-	if (data[9] | data[10] | (data[11] & 0x03) | data[12])
-		input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
-	else
-		input_report_abs(input, ABS_MISC, 0);
-
-	input_event(input, EV_MSC, MSC_SERIAL, serial);
-
-	input_sync(input);
-
-	/*Which mode select (LED light) is currently on?*/
-	touch_ring_mode = (data[11] & 0xC0) >> 6;
-
-	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (remote->remotes[i].serial == serial)
-			wacom->led.groups[i].select = touch_ring_mode;
-	}
-
-	__wacom_notify_battery(&remote->remotes[index].battery, bat_percent,
-				bat_charging, 1, bat_charging);
-
-out:
-	spin_unlock_irqrestore(&remote->remote_lock, flags);
-	return 0;
-}
-
-static void wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
-{
-	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
-	unsigned char *data = wacom_wac->data;
-	struct wacom_remote *remote = wacom->remote;
-	struct wacom_remote_data remote_data;
-	unsigned long flags;
-	int i, ret;
-
-	if (data[0] != WACOM_REPORT_DEVICE_LIST)
-		return;
-
-	memset(&remote_data, 0, sizeof(struct wacom_remote_data));
-
-	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		int j = i * 6;
-		int serial = (data[j+6] << 16) + (data[j+5] << 8) + data[j+4];
-		bool connected = data[j+2];
-
-		remote_data.remote[i].serial = serial;
-		remote_data.remote[i].connected = connected;
-	}
-
-	spin_lock_irqsave(&remote->remote_lock, flags);
-
-	ret = kfifo_in(&remote->remote_fifo, &remote_data, sizeof(remote_data));
-	if (ret != sizeof(remote_data)) {
-		spin_unlock_irqrestore(&remote->remote_lock, flags);
-		hid_err(wacom->hdev, "Can't queue Remote status event.\n");
-		return;
-	}
-
-	spin_unlock_irqrestore(&remote->remote_lock, flags);
-
-	wacom_schedule_work(wacom_wac, WACOM_WORKER_REMOTE);
-}
-
 static inline bool report_touch_events(struct wacom_wac *wacom)
 {
 	return (touch_arbitration ? !wacom->shared->stylus_in_proximity : 1);
@@ -1116,6 +991,131 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	return 0;
 }
 
+static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
+{
+	unsigned char *data = wacom_wac->data;
+	struct input_dev *input;
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	struct wacom_remote *remote = wacom->remote;
+	int bat_charging, bat_percent, touch_ring_mode;
+	__u32 serial;
+	int i, index = -1;
+	unsigned long flags;
+
+	if (data[0] != WACOM_REPORT_REMOTE) {
+		hid_dbg(wacom->hdev, "%s: received unknown report #%d",
+			__func__, data[0]);
+		return 0;
+	}
+
+	serial = data[3] + (data[4] << 8) + (data[5] << 16);
+	wacom_wac->id[0] = PAD_DEVICE_ID;
+
+	spin_lock_irqsave(&remote->remote_lock, flags);
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (remote->remotes[i].serial == serial) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0 || !remote->remotes[index].registered)
+		goto out;
+
+	input = remote->remotes[index].input;
+
+	input_report_key(input, BTN_0, (data[9] & 0x01));
+	input_report_key(input, BTN_1, (data[9] & 0x02));
+	input_report_key(input, BTN_2, (data[9] & 0x04));
+	input_report_key(input, BTN_3, (data[9] & 0x08));
+	input_report_key(input, BTN_4, (data[9] & 0x10));
+	input_report_key(input, BTN_5, (data[9] & 0x20));
+	input_report_key(input, BTN_6, (data[9] & 0x40));
+	input_report_key(input, BTN_7, (data[9] & 0x80));
+
+	input_report_key(input, BTN_8, (data[10] & 0x01));
+	input_report_key(input, BTN_9, (data[10] & 0x02));
+	input_report_key(input, BTN_A, (data[10] & 0x04));
+	input_report_key(input, BTN_B, (data[10] & 0x08));
+	input_report_key(input, BTN_C, (data[10] & 0x10));
+	input_report_key(input, BTN_X, (data[10] & 0x20));
+	input_report_key(input, BTN_Y, (data[10] & 0x40));
+	input_report_key(input, BTN_Z, (data[10] & 0x80));
+
+	input_report_key(input, BTN_BASE, (data[11] & 0x01));
+	input_report_key(input, BTN_BASE2, (data[11] & 0x02));
+
+	if (data[12] & 0x80)
+		input_report_abs(input, ABS_WHEEL, (data[12] & 0x7f));
+	else
+		input_report_abs(input, ABS_WHEEL, 0);
+
+	bat_percent = data[7] & 0x7f;
+	bat_charging = !!(data[7] & 0x80);
+
+	if (data[9] | data[10] | (data[11] & 0x03) | data[12])
+		input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+	else
+		input_report_abs(input, ABS_MISC, 0);
+
+	input_event(input, EV_MSC, MSC_SERIAL, serial);
+
+	input_sync(input);
+
+	/*Which mode select (LED light) is currently on?*/
+	touch_ring_mode = (data[11] & 0xC0) >> 6;
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (remote->remotes[i].serial == serial)
+			wacom->led.groups[i].select = touch_ring_mode;
+	}
+
+	__wacom_notify_battery(&remote->remotes[index].battery, bat_percent,
+				bat_charging, 1, bat_charging);
+
+out:
+	spin_unlock_irqrestore(&remote->remote_lock, flags);
+	return 0;
+}
+
+static void wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
+{
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	unsigned char *data = wacom_wac->data;
+	struct wacom_remote *remote = wacom->remote;
+	struct wacom_remote_data remote_data;
+	unsigned long flags;
+	int i, ret;
+
+	if (data[0] != WACOM_REPORT_DEVICE_LIST)
+		return;
+
+	memset(&remote_data, 0, sizeof(struct wacom_remote_data));
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		int j = i * 6;
+		int serial = (data[j+6] << 16) + (data[j+5] << 8) + data[j+4];
+		bool connected = data[j+2];
+
+		remote_data.remote[i].serial = serial;
+		remote_data.remote[i].connected = connected;
+	}
+
+	spin_lock_irqsave(&remote->remote_lock, flags);
+
+	ret = kfifo_in(&remote->remote_fifo, &remote_data, sizeof(remote_data));
+	if (ret != sizeof(remote_data)) {
+		spin_unlock_irqrestore(&remote->remote_lock, flags);
+		hid_err(wacom->hdev, "Can't queue Remote status event.\n");
+		return;
+	}
+
+	spin_unlock_irqrestore(&remote->remote_lock, flags);
+
+	wacom_schedule_work(wacom_wac, WACOM_WORKER_REMOTE);
+}
+
 static int int_dist(int x1, int y1, int x2, int y2)
 {
 	int x = x2 - x1;
-- 
2.12.0

