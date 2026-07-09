Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80938AC7B
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567429; cv=none; b=iWelaQB51kUyuy32l26tzI/SPpl0sGUXKiCNznG7B/0+pkanohwz68/VvOVaeoAVj1es4N6bJLKPmpquZfDT//n9gHV+4czyxza83wr0rPeQTFvQAiU8nU62vh5xp4wEeX4siVxHiXJcf3Iq9pJCNMfem0i+EYF7Frn0BOaI4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567429; c=relaxed/simple;
	bh=s7j6GFWZFUptJa+M5c+VCBqlPApjg7J2l2NYuGol0sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDgNoQG8PKXSmU6ME2PlHv9aOVX+jRfmJ8Xz3akUxvV2bwYrOAE37BXnJK5Lha3a66sxj6OXxb/goe29YuPV19d9UpSKdjVggt40BKoa+hZ4/TmRry/YmFEFh90pBLQOLAm2r352xmtJDr3bg+UseM88h+jHOlid1WUg8i4kOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASeYf8YB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASeYf8YB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e50c5d14cso67775185a.2
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567427; x=1784172227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCMbVTehKHoy2kV5ilLJjRnvgf4+u5A1kqJUxb1J4/M=;
        b=ASeYf8YBNWuiEuEN+N2xzF1i2dojm2aK7VdgpIWMohuDDGCNHHoGQHreFu2z/m2iUM
         ElT9nFNgHBm6GUR7+350WF6qc6WO3Y0tDaKX7whXlB94U87UPmGFjXZEbznVWPMeFsu4
         8SoRe21z6qjyouesxiFexvpUDuPV5INlTG41x6SjSEFusvJu7O4AddML4I2jGM73Fn24
         1LNwCydl5mKnUjLi29oBHeN4Z0jwBogL5dPug4KBJsQdLI4SEqbe/cO603VrZZu2J/o1
         JoOtSPnaQ0DmFm/yeJxO2OgKmg+STiljn8hEnlj7OqG4hydKBGGGfjqNkKF9XpOYpbvM
         rV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567427; x=1784172227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JCMbVTehKHoy2kV5ilLJjRnvgf4+u5A1kqJUxb1J4/M=;
        b=ikHWdIZTTvXsussaoST/M4hM/4kiRgoiDB2Yc/bVBDirwyEt0gId4g6KgfR2xRTszc
         WvLbQUMbStVii3REcB5lb/UE8sWqmIUZZxBkh2N7L/xWiRYsKCEdZ/xJfKZl0Z2C+I3W
         b6z6bncFs2rj2Z8aC9NhTyF8EAuq6DbcrjC82Ib91pbxaX/PzBpE5/YlUh7DUaPWjIWd
         uMu35dbppMcw0zIfwoHMpE+/L/Zp1O9KdCkv7uAVx0rZrF2f7J3Y7SnLQ5f73ZmZZu2N
         cw6/GCZ5AoGyIKUo7sU0mQYv8dPdXDwFNbz++lXyqvD91F5bCkfO0y6OYRwYa21O5hTC
         MPNg==
X-Gm-Message-State: AOJu0YyNkP7rHWtZrLr3qsYHLwwfBVthmRNFO3C8DBjj8PVKP35eoy6j
	r7iVGAj2KbZvyVo979uXfPtDsb7bGtw7/pYFdB5PjE2CW43UM9KezAe+
X-Gm-Gg: AfdE7cmcfkGRHLgSUmxp93hxiYx7oizmPKhmx3sg+rgMqU1zsSpttgWwM7sc7/upz26
	Cji2hYaWfkbGrkrtXGQi1CShKYyiibTcOX8pWa4/cNFvNQNAmg9dcBdkutwNBDSgtbnS6Wvjs5F
	IALmQpwNOyGpThCr4LH3IFOdrrS9+c4gZQLxjdq0IUlWujd0gDVISOvDxbW08LR+wXzf2w5wvSk
	QNgYluvNDQ+JZekAJh6Dh40+/qa0eS6w7/XVmjHATwDHk7ZLSttKUUDPFGAIduKa8dZnkU4TjgK
	rq9l+Ji3CdGkGttVqBvCauddEhTp4ZQA4j87Yhl/CvmP2IKA0YyxTFJQOg6nt0OUDV4En4+kl6u
	Q58gpTfjN0449SAkOzI3Hgb7tRBj92gu/qYUYV1Is/t7FlKl6I6lm/77pH4b7snb7SM9ttMRdyO
	cNjWhvyViIUS8EBUv7Jv0Tc/1TFgyWzcdy6kVMMCE3u7E9cddlZN3cQe0WiNPOIN1BsdPTZhKYW
	kdmgjCo
X-Received: by 2002:a05:620a:4014:b0:8cf:c106:faca with SMTP id af79cd13be357-92ecf61b812mr558579585a.36.1783567426980;
        Wed, 08 Jul 2026 20:23:46 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:46 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 7/9] HID: steelseries: Manage battery lifetime with refcounting
Date: Wed,  8 Jul 2026 23:23:14 -0400
Message-ID: <20260709032316.1908460-8-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

The next change shares one steelseries_device between two HID
interfaces, so the state can outlive either interface. Stop using devm
for it. Reference count the struct with a kref and free it from
steelseries_device_release(). Register and unregister the power supply
explicitly, and clear sd->battery under sd->lock in remove() so it is
not touched after it is unregistered.

Drop the global atomic battery counter and name the power supply after
the device (hdev->uniq, or dev_name() when empty), as hid-input and the
other HID battery drivers do.

No functional change for the current single-interface devices.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 47 +++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index b54f20f081a2..e534aa44e70a 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -8,6 +8,8 @@
 
 #include <linux/device.h>
 #include <linux/hid.h>
+#include <linux/kref.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
@@ -30,6 +32,8 @@ struct steelseries_device_info {
 };
 
 struct steelseries_device {
+	struct kref refcnt;
+
 	struct hid_device *hdev;
 	const struct steelseries_device_info *info;
 
@@ -45,6 +49,14 @@ struct steelseries_device {
 	bool removed;
 };
 
+static void steelseries_device_release(struct kref *ref)
+{
+	struct steelseries_device *sd =
+		container_of(ref, struct steelseries_device, refcnt);
+
+	kfree(sd);
+}
+
 /*
  * Headset report helpers
  */
@@ -267,9 +279,8 @@ static void steelseries_status_timer_work_handler(struct work_struct *work)
 
 static int steelseries_battery_register(struct steelseries_device *sd)
 {
-	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct power_supply_config battery_cfg = { .drv_data = sd, };
-	unsigned long n;
+	struct power_supply *battery;
 	int ret;
 
 	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
@@ -277,9 +288,10 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_battery_props);
 	sd->battery_desc.get_property = steelseries_battery_get_property;
 	sd->battery_desc.use_for_apm = 0;
-	n = atomic_inc_return(&battery_no) - 1;
 	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
-						"steelseries_headset_battery_%ld", n);
+					       "steelseries_headset_battery_%s",
+					       sd->hdev->uniq[0] ? sd->hdev->uniq :
+					       dev_name(&sd->hdev->dev));
 	if (!sd->battery_desc.name)
 		return -ENOMEM;
 
@@ -289,17 +301,19 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	sd->headset_connected = false;
 	steelseries_headset_set_wireless_status(sd->hdev, false);
 
-	sd->battery = devm_power_supply_register(&sd->hdev->dev,
+	battery = power_supply_register(&sd->hdev->dev,
 			&sd->battery_desc, &battery_cfg);
-	if (IS_ERR(sd->battery)) {
-		ret = PTR_ERR(sd->battery);
-		sd->battery = NULL;
+	if (IS_ERR(battery)) {
+		ret = PTR_ERR(battery);
 		hid_err(sd->hdev,
 				"%s:power_supply_register failed with error %d\n",
 				__func__, ret);
 		return ret;
 	}
-	power_supply_powers(sd->battery, &sd->hdev->dev);
+	power_supply_powers(battery, &sd->hdev->dev);
+
+	/* Assign on success only, so a concurrent raw_event never sees an ERR_PTR. */
+	sd->battery = battery;
 
 	return 0;
 }
@@ -329,10 +343,11 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
 	if (interface_num != info->sync_interface)
 		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
-	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
+	sd = kzalloc_obj(*sd, GFP_KERNEL);
 	if (!sd)
 		return -ENOMEM;
 
+	kref_init(&sd->refcnt);
 	sd->hdev = hdev;
 	sd->info = info;
 	spin_lock_init(&sd->lock);
@@ -341,7 +356,7 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto err_put;
 
 	ret = hid_hw_open(hdev);
 	if (ret)
@@ -360,12 +375,15 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
 
 err_stop:
 	hid_hw_stop(hdev);
+err_put:
+	kref_put(&sd->refcnt, steelseries_device_release);
 	return ret;
 }
 
 static void steelseries_arctis_remove(struct hid_device *hdev)
 {
 	struct steelseries_device *sd;
+	struct power_supply *battery;
 	unsigned long flags;
 	struct usb_interface *intf;
 	u8 interface_num;
@@ -387,13 +405,20 @@ static void steelseries_arctis_remove(struct hid_device *hdev)
 	if (interface_num == sd->info->sync_interface) {
 		spin_lock_irqsave(&sd->lock, flags);
 		sd->removed = true;
+		battery = sd->battery;
+		sd->battery = NULL;
 		spin_unlock_irqrestore(&sd->lock, flags);
 
 		cancel_delayed_work_sync(&sd->status_work);
+
+		if (battery)
+			power_supply_unregister(battery);
 	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
+	kref_put(&sd->refcnt, steelseries_device_release);
 }
 
 static int steelseries_arctis_raw_event(struct hid_device *hdev,
-- 
2.55.0

