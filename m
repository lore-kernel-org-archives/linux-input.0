Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF74F55DC;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839642; cv=none; b=mbbZGKqu9KNzjSfUP+qz5tw+86kY6/BMemLBoQvVMyHWr/LbQAR2tATLraKwFpSR5BPqifO63PBdjj1AffrT6secXOfKpzJ3DZjLIy5tXvzB15lZyV7JHiYi26RHudu3ei65+VW+xpLV2IMHvPamD0qV1bKGVoEPrUPoCC+oeoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839642; c=relaxed/simple;
	bh=oVC2OPbMytrGyqGp16WNvLqN40yybG3A50A+2gdxLrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tshx0XGT5zT6GghmjCbyPs0lXVCmD383o0eKEcolZGicv3St+D49P9mPVceNh9UQnyxyUC1nsgkcbZgEyOoZl/+/8S12IH9YCkJURlK/g1DUNeBuo1fCPVWdy7xNPLuNeP5iqvWCiNsucIwpRVHvI92awfk17gFonMLtnBAn7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP1lniAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP1lniAy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74ABAC4AF0B;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791839642;
	bh=oVC2OPbMytrGyqGp16WNvLqN40yybG3A50A+2gdxLrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DP1lniAy7U71A3z/j93CLuU8QiNcdAH2R8WXu+PXZTEFGI/8othrFxpaEcDnfDNNT
	 zaSWY5pqQef7mqVsRD4cHlzdKLLibafWKE6lsHxdY2OCqEPNeT/lqA2toLWMwJXDRS
	 kPqiZX+zyXxLUEz9deQiWnW3enA0vaiEWZ2xNWAXSRdSTDIp983Ou4Gf/gz6cTrkMv
	 IIoWOhLaQTl0scLS7WSqbeLw+2odaypF/1yBvPEq3Uy7vLq4rWlXZUYTcEBXyZXqdR
	 3YwdLDlIKexV9gLCk4K61BPqXF0TsG957hJW5S6PF+gW8/bgOAoEReT7GVzO9JwCta
	 LXXiz/ZVj4ZYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E2CC6B04;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 02:43:59 +0530
Subject: [PATCH v2 4/5] HID: UNCTRL: keep a single battery when a mouse has
 multiple connections
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v2-4-bd6752021753@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791839640; l=8007;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=sf4y8UVAPeG+2MHoOcvUfajg4bV670QJoKozbmcylj4=;
 b=reuhmoSq4NUVA8JR6fRpeyOhnfxIiSIgcGAz+3BM3BIDgXqvHD79U0arBF+gXmNf1cFEQsWq0
 Q28gFLh5wKVB+p3+u3CH+jWhgkwaXMnp6SLboVmB9JIjmRhr9zDR/et
X-Developer-Key: i=contact@bishwasaha.com; a=ed25519;
 pk=bW8B6BzX1VU4IIcYagrb5nNRxBho+rTXaQZ8fLx8CoU=
X-Endpoint-Received: by B4 Relay for contact@bishwasaha.com/20261012 with
 auth_id=1168
X-Original-From: Bishwa Bhusan Saha <contact@bishwasaha.com>
Reply-To: contact@bishwasaha.com

From: Bishwa Bhusan Saha <contact@bishwasaha.com>

The UNCTRL RAGE mouse can be connected over its 2.4 GHz dongle and
its wired connection at the same time. Both are visible as separate
devices on lsusb. Without this patch two separate batteries would be
detected in case of a single mouse connected over 2 interfaces. This
patch solves it by registering the power supply only on the connection
that can answer queries and taking it away when that connection goes
away.

Signed-off-by: Bishwa Bhusan Saha <contact@bishwasaha.com>
Assisted-by: GLM:glm-5.3
---
 drivers/hid/hid-unctrl-m1.c | 139 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 111 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
index d7e2f207e..624ac1365 100644
--- a/drivers/hid/hid-unctrl-m1.c
+++ b/drivers/hid/hid-unctrl-m1.c
@@ -16,9 +16,12 @@
  * answers over the interrupt out endpoint, where the queries go.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -45,19 +48,27 @@ static const u8 unctrl_battery_query[33] = {
 };
 
 struct unctrl_dev {
+	struct list_head list;
 	struct hid_device *hdev;
 
 	struct power_supply_desc battery_desc;
 	struct power_supply *battery;
 
+	/* raw_event runs in the completion path, so this is a spinlock. */
+	spinlock_t lock;
+
 	struct delayed_work battery_work;
 
 	u8 battery_capacity;
 	u8 mode;
 	bool online;
 	bool wired;
+	bool vendor;
 };
 
+static LIST_HEAD(unctrl_connections);
+static DEFINE_MUTEX(unctrl_lock);
+
 static enum power_supply_property unctrl_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,     POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,   POWER_SUPPLY_PROP_SCOPE,
@@ -74,9 +85,11 @@ static int unctrl_battery_get_property(struct power_supply *psy,
 	u8 capacity, mode;
 	bool online;
 
-	capacity = dev->battery_capacity;
-	mode = dev->mode;
-	online = dev->online;
+	scoped_guard(spinlock_irqsave, &dev->lock) {
+		capacity = dev->battery_capacity;
+		mode = dev->mode;
+		online = dev->online;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -148,13 +161,34 @@ static void unctrl_battery_timer_tick(struct work_struct *work)
 			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
 }
 
-/* Register the power supply of this connection and start reporting. */
+static struct unctrl_dev *unctrl_battery_owner(void)
+{
+	struct unctrl_dev *dev;
+
+	list_for_each_entry(dev, &unctrl_connections, list) {
+		if (dev->battery)
+			return dev;
+	}
+
+	return NULL;
+}
+
+/*
+ * Register the power supply on the connection the mouse talks over,
+ * a wired connection takes it away from a receiver. Called with
+ * unctrl_lock held.
+ */
 static int unctrl_battery_register(struct unctrl_dev *dev)
 {
 	struct power_supply_config config = { .drv_data = dev };
+	struct unctrl_dev *owner;
 	struct power_supply *battery;
 	int ret;
 
+	owner = unctrl_battery_owner();
+	if (owner == dev || (owner && (!dev->wired || owner->wired)))
+		return 0;
+
 	battery = power_supply_register(&dev->hdev->dev, &dev->battery_desc,
 					&config);
 	if (IS_ERR(battery)) {
@@ -166,10 +200,24 @@ static int unctrl_battery_register(struct unctrl_dev *dev)
 	}
 
 	power_supply_powers(battery, &dev->hdev->dev);
-	dev->battery = battery;
+	scoped_guard(spinlock_irqsave, &dev->lock)
+		dev->battery = battery;
 	hid_info(dev->hdev, "%s:battery registered as %s\n", __func__,
 		 dev->battery_desc.name);
 
+	/* the takeover cannot fail now, our supply already exists */
+	if (owner) {
+		struct power_supply *owner_battery;
+
+		cancel_delayed_work_sync(&owner->battery_work);
+		/* so a raw_event cannot touch the supply being unregistered */
+		scoped_guard(spinlock_irqsave, &owner->lock) {
+			owner_battery = owner->battery;
+			owner->battery = NULL;
+		}
+		power_supply_unregister(owner_battery);
+	}
+
 	unctrl_fetch_battery(dev->hdev);
 	queue_delayed_work(system_freezable_wq, &dev->battery_work,
 			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
@@ -223,6 +271,8 @@ static int unctrl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->battery_capacity = 100;
 	dev->mode = UNCTRL_MODE_RECEIVER;
 	dev->wired = hdev->product == USB_DEVICE_ID_UNCTRL_M1_WIRED;
+	dev->vendor = vendor;
+	spin_lock_init(&dev->lock);
 
 	dev->battery_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						"unctrl-m1-%04x-battery",
@@ -254,19 +304,26 @@ static int unctrl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hid_set_drvdata(hdev, dev);
 
+	/* the list membership, the registration and any failure cleanup are
+	 * one step under unctrl_lock, so a concurrent handover cannot hand
+	 * this probe a battery while it is failing out
+	 */
+	mutex_lock(&unctrl_lock);
+	list_add_tail(&dev->list, &unctrl_connections);
 	ret = unctrl_battery_register(dev);
 	if (ret)
-		goto err_del;
+		list_del(&dev->list);
+	mutex_unlock(&unctrl_lock);
 
-	return 0;
+	if (ret) {
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+		hid_set_drvdata(hdev, NULL);
+		kfree(dev);
+		return ret;
+	}
 
-err_del:
-	hid_device_io_stop(hdev);
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
-	hid_set_drvdata(hdev, NULL);
-	kfree(dev);
-	return ret;
+	return 0;
 }
 
 static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
@@ -286,15 +343,20 @@ static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (data[5] != UNCTRL_MODE_RECEIVER && data[5] != UNCTRL_MODE_WIRED)
 		return 0;
 
-	/* the receiver reports 0% while the mouse is switched off */
-	dev->battery_capacity = min_t(u8, data[4], 100);
-	dev->mode = data[5];
-	dev->online = dev->battery_capacity != 0;
-	battery = dev->battery;
-
-	/* only schedules a work, so this is safe from the completion path */
-	if (battery)
-		power_supply_changed(battery);
+	scoped_guard(spinlock_irqsave, &dev->lock) {
+		/* the receiver reports 0% while the mouse is switched off */
+		dev->battery_capacity = min_t(u8, data[4], 100);
+		dev->mode = data[5];
+		dev->online = dev->battery_capacity != 0;
+		battery = dev->battery;
+		/*
+		 * Only schedules a work, so safe from the completion path that
+		 * raw_event runs in. Under the lock so that the unregistering side
+		 * is either done or still blocked when we touch the pointer.
+		 */
+		if (battery)
+			power_supply_changed(battery);
+	}
 
 	return 0;
 }
@@ -302,20 +364,41 @@ static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
 static void unctrl_remove(struct hid_device *hdev)
 {
 	struct unctrl_dev *dev = hid_get_drvdata(hdev);
+	struct unctrl_dev *other;
 
 	/* Stop polling before the transport goes down. */
-	if (dev) {
-		cancel_delayed_work_sync(&dev->battery_work);
+	if (dev)
 		hid_hw_close(hdev);
-	}
 
 	hid_hw_stop(hdev);
 
 	if (!dev)
 		return;
 
-	if (dev->battery)
-		power_supply_unregister(dev->battery);
+	/*
+	 * Pass the battery to a capable connection without one, so that it
+	 * keeps being reported when the owner disappears.
+	 */
+	mutex_lock(&unctrl_lock);
+	list_del(&dev->list);
+	/* out of the list, nothing can reach this device anymore */
+	cancel_delayed_work_sync(&dev->battery_work);
+	if (dev->battery) {
+		struct power_supply *battery;
+
+		scoped_guard(spinlock_irqsave, &dev->lock) {
+			battery = dev->battery;
+			dev->battery = NULL;
+		}
+		power_supply_unregister(battery);
+		list_for_each_entry(other, &unctrl_connections, list) {
+			if (!other->vendor || other->battery)
+				continue;
+			unctrl_battery_register(other);
+			break;
+		}
+	}
+	mutex_unlock(&unctrl_lock);
 
 	hid_set_drvdata(hdev, NULL);
 	kfree(dev);

-- 
2.56.0


