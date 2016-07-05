From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 14/27] HID: wacom: EKR: add a worker to add/remove resources on addition/removal
Date: Tue,  5 Jul 2016 16:39:10 +0200
Message-ID: <1467729563-23318-15-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

wacom_remote_status_irq() sends information of addition/removal of EKR.
We want to allocate one input node per remote, so better having this
in a separate worker, not handled in the IRQ directly.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     | 11 +++++--
 drivers/hid/wacom_sys.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/hid/wacom_wac.c | 41 +++++++++----------------
 drivers/hid/wacom_wac.h |  7 +++++
 4 files changed, 106 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 8ac1eb8..1797e4b 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -90,6 +90,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/hid.h>
+#include <linux/kfifo.h>
 #include <linux/usb/input.h>
 #include <linux/power_supply.h>
 #include <asm/unaligned.h>
@@ -108,6 +109,7 @@
 enum wacom_worker {
 	WACOM_WORKER_WIRELESS,
 	WACOM_WORKER_BATTERY,
+	WACOM_WORKER_REMOTE,
 };
 
 struct wacom_group_leds {
@@ -122,6 +124,9 @@ struct wacom {
 	struct mutex lock;
 	struct work_struct wireless_work;
 	struct work_struct battery_work;
+	struct work_struct remote_work;
+	spinlock_t remote_lock;
+	struct kfifo remote_fifo;
 	struct wacom_leds {
 		struct wacom_group_leds *groups;
 		u8 llv;       /* status led brightness no button (1..127) */
@@ -149,6 +154,9 @@ static inline void wacom_schedule_work(struct wacom_wac *wacom_wac,
 	case WACOM_WORKER_BATTERY:
 		schedule_work(&wacom->battery_work);
 		break;
+	case WACOM_WORKER_REMOTE:
+		schedule_work(&wacom->remote_work);
+		break;
 	}
 }
 
@@ -168,7 +176,4 @@ int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value);
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report);
 void wacom_battery_work(struct work_struct *work);
-int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
-				   int index);
-void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4d4c737..7e01117 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1294,7 +1294,8 @@ DEVICE_EKR_ATTR_GROUP(2);
 DEVICE_EKR_ATTR_GROUP(3);
 DEVICE_EKR_ATTR_GROUP(4);
 
-int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial, int index)
+static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
+					  int index)
 {
 	int error = 0;
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
@@ -1318,7 +1319,7 @@ int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial, int index)
 	return 0;
 }
 
-void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
+static void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	int i;
@@ -1889,6 +1890,65 @@ fail:
 	return;
 }
 
+static void wacom_remote_work(struct work_struct *work)
+{
+	struct wacom *wacom = container_of(work, struct wacom, remote_work);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_remote_data data;
+	unsigned long flags;
+	unsigned int count;
+	u32 serial;
+	int i, k;
+
+	spin_lock_irqsave(&wacom->remote_lock, flags);
+
+	count = kfifo_out(&wacom->remote_fifo, &data, sizeof(data));
+
+	if (count != sizeof(data)) {
+		hid_err(wacom->hdev,
+			"workitem triggered without status available\n");
+		spin_unlock_irqrestore(&wacom->remote_lock, flags);
+		return;
+	}
+
+	if (!kfifo_is_empty(&wacom->remote_fifo))
+		wacom_schedule_work(&wacom->wacom_wac, WACOM_WORKER_REMOTE);
+
+	spin_unlock_irqrestore(&wacom->remote_lock, flags);
+
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		serial = data.remote[i].serial;
+		if (data.remote[i].connected) {
+
+			if (wacom_wac->serial[i] == serial)
+				continue;
+
+			if (wacom_wac->serial[i]) {
+				wacom_remote_destroy_attr_group(wacom,
+							wacom_wac->serial[i]);
+			}
+
+			/* A remote can pair more than once with an EKR,
+			 * check to make sure this serial isn't already paired.
+			 */
+			for (k = 0; k < WACOM_MAX_REMOTES; k++) {
+				if (wacom_wac->serial[k] == serial)
+					break;
+			}
+
+			if (k < WACOM_MAX_REMOTES) {
+				wacom_wac->serial[i] = serial;
+				continue;
+			}
+			wacom_remote_create_attr_group(wacom, serial, i);
+
+		} else if (wacom_wac->serial[i]) {
+			wacom_remote_destroy_attr_group(wacom,
+							wacom_wac->serial[i]);
+		}
+	}
+}
+
 static int wacom_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -1931,6 +1991,17 @@ static int wacom_probe(struct hid_device *hdev,
 	mutex_init(&wacom->lock);
 	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
+	INIT_WORK(&wacom->remote_work, wacom_remote_work);
+	spin_lock_init(&wacom->remote_lock);
+
+	if (kfifo_alloc(&wacom->remote_fifo,
+			5 * sizeof(struct wacom_remote_data),
+			GFP_KERNEL)) {
+		dev_err(&hdev->dev,
+			"%s:failed allocating remote_fifo\n", __func__);
+		error = -ENOMEM;
+		goto fail_type;
+	}
 
 	/* ask for the report descriptor to be loaded by HID */
 	error = hid_parse(hdev);
@@ -1953,8 +2024,9 @@ static int wacom_probe(struct hid_device *hdev,
 
 	return 0;
 
-fail_type:
 fail_parse:
+	kfifo_free(&wacom->remote_fifo);
+fail_type:
 	hid_set_drvdata(hdev, NULL);
 	return error;
 }
@@ -1972,6 +2044,8 @@ static void wacom_remove(struct hid_device *hdev)
 
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
+	cancel_work_sync(&wacom->remote_work);
+	kfifo_free(&wacom->remote_fifo);
 	kobject_put(wacom->remote_dir);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 932d3ee..4f4a2b9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -827,7 +827,9 @@ static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	unsigned char *data = wacom_wac->data;
-	int i;
+	struct wacom_remote_data remote_data = {0};
+	unsigned long flags;
+	int i, ret;
 
 	if (data[0] != WACOM_REPORT_DEVICE_LIST)
 		return 0;
@@ -837,36 +839,21 @@ static int wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 		int serial = (data[j+6] << 16) + (data[j+5] << 8) + data[j+4];
 		bool connected = data[j+2];
 
-		if (connected) {
-			int k;
-
-			if (wacom_wac->serial[i] == serial)
-				continue;
+		remote_data.remote[i].serial = serial;
+		remote_data.remote[i].connected = connected;
+	}
 
-			if (wacom_wac->serial[i]) {
-				wacom_remote_destroy_attr_group(wacom,
-							wacom_wac->serial[i]);
-			}
+	spin_lock_irqsave(&wacom->remote_lock, flags);
 
-			/* A remote can pair more than once with an EKR,
-			 * check to make sure this serial isn't already paired.
-			 */
-			for (k = 0; k < WACOM_MAX_REMOTES; k++) {
-				if (wacom_wac->serial[k] == serial)
-					break;
-			}
+	ret = kfifo_in(&wacom->remote_fifo, &remote_data, sizeof(remote_data));
+	if (ret != sizeof(remote_data)) {
+		hid_err(wacom->hdev, "Can't queue Remote status event.\n");
+		return 0;
+	}
 
-			if (k < WACOM_MAX_REMOTES) {
-				wacom_wac->serial[i] = serial;
-				continue;
-			}
-			wacom_remote_create_attr_group(wacom, serial, i);
+	spin_unlock_irqrestore(&wacom->remote_lock, flags);
 
-		} else if (wacom_wac->serial[i]) {
-			wacom_remote_destroy_attr_group(wacom,
-							wacom_wac->serial[i]);
-		}
-	}
+	wacom_schedule_work(wacom_wac, WACOM_WORKER_REMOTE);
 
 	return 0;
 }
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index d5b973d..c2c65b8 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -218,6 +218,13 @@ struct hid_data {
 	int num_received;
 };
 
+struct wacom_remote_data {
+	struct {
+		u32 serial;
+		bool connected;
+	} remote[WACOM_MAX_REMOTES];
+};
+
 struct wacom_wac {
 	char pen_name[WACOM_NAME_MAX];
 	char touch_name[WACOM_NAME_MAX];
-- 
2.5.5
