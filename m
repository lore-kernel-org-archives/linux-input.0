Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E8638D404
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235401; cv=none; b=qsVzstqx1NLy4UCebNOIswIhQwqd4vmA7P9GqGMRgdhIy9ePovnZY6OLu0RtK0zlWkJ/A6qZiMsjt3vbC+rQVtl3mAvp4aG2tUUEhP4rVUIgUYxDmoG8RdKuUQFC+5xT7TzJ0yHWOozXiLhhZxWwCqUcJ4zKv3TPM4cwf6cLkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235401; c=relaxed/simple;
	bh=/uf+tYRCv30wLgEyFf7yKMQ/cQcsSKLq3MBGRjzGglM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDCacCwmsIbal7WrqP5qj03S8Y9vcDyTgqi94ns+Lcpte2JgQxF9RBwwHrA8fUmchr6fdoN56gxFmLMi/a6foRg1eOm79FaeGRhIKg1Cb/9JTEJligaMQoNihlcQEaBPCum0VyEpwyB37JerEKP57qf2VJqB2dedn72U7Om0g3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9aYL8Db; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9aYL8Db"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517654b8e28so92881cf.3
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235399; x=1782840199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUE8ROcGyVtOfb4ujpYv/+QqsYON9a/smmrjbri2xF4=;
        b=A9aYL8DbMNnZt9ANuiggo53swq2M+KFUftwA5tpyc9d4ZYp/blQZ2oDdIs+V1pFLp0
         KnRMWJHjMkK6ze+7ffqh0l92+5Nz0F2CiqLsa7TjovZ2ivR06f78KoaduuAUAfo3oOkB
         K++UrIj63xamPAqOit1aoiajP8W0ShT25Vv0MOaSJT2qu0whOrFRF7Nbt5n1GKmVSddq
         L+PQqrvQ0WUxKiydfJfiafyGe9os+ijFtf/j9whZ2B7M06mKUboMYCN0vVg+yvgYdYLH
         oaerRjXePB3OQRuf3w6EgOcmD0iq2GvE7E70T8YIYn2r5scnPB22FAhzF97QRXOzY7LM
         WVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235399; x=1782840199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUE8ROcGyVtOfb4ujpYv/+QqsYON9a/smmrjbri2xF4=;
        b=Csqlh0LBk9yW/rclWGxGSpvkwAuTDxMlkK0k1Fn/Rszyr1pvIjOy6bCPehmLxaK6+Y
         BYMPcwt7G1b92waiQ5XkjvW2wqQ+3JbPhCo9YXjQgdti0TQYyfYyjT9ZL1zIrPeStR7g
         GgF9ENUG4dkWIIK4O7YNaEaE2LayNwgzsLjhj/P9zS/vqgRVF8cBuH+fwpZC0h+Qqa4N
         kThpbT24keFTgsa0y7hGhJLB5lI5j7wGJX5WgtXcm/eIghI25R2gSPj1NrGmL4wT1Vcp
         kNJXVn/51wvUyeK0XNXLcFgwJrOJ65rMRpsrQ9kKZQdiZOqMmio4Gw3ygWGVdLino8B1
         a7gw==
X-Gm-Message-State: AOJu0YyfXyOXuI4e+zeDo8O5ja5d8H7Y7BFCd6ZKifmRwdUXkKHjZUCs
	P9j79GkuH8olanKPDjz2TH9PA8sraIMsu8nzV5OaKW1RVUmH8GuB3kdCWqC6JA==
X-Gm-Gg: AfdE7cmwQ5FUxwRCckN08fsmWA3jksq1zxH/FLGTWJFXMAco9j8psg9C/ilM+dRYICl
	BGHFikW68VL8ml2eXHw24TJHmdPS5dKkLkHhUb3fpLBS92tIfKVqPDMEjKaG39MitbsLKuwJe5O
	AlkH3iaWxymHah/zogDSvw4QTlGgdfkdsGpxNuNTheZ3vwRxhspoLpgosEwa6c7xkg3BDQCcG8G
	3qmRY01fBYnKje/GAodQrr1Lo7Fg1oyU19IRUxJvm/XJiGa6jbQILl0C2lnldgYOLdjiUbyup7i
	lZC8TIOV34TI3YdHVE05rLOlr21TiFMoW5sVY4fHnt5O557iNaoQp4loFwnZHrXBBBUw2RAuKmg
	zm0X+mf7fm+wsdrzbgLxz7ShIS9IrkpRpXR742uX8rsUMmZHcwVde3f+SPGSIJl3HwjY1/wgjpT
	LhNzDEq4ZoYwE0HNUWmmxphiH2swem1yGFYx7mPtSE3+nL6Y/r
X-Received: by 2002:ac8:531a:0:b0:517:8011:3a4d with SMTP id d75a77b69052e-51a21b6673emr137372131cf.20.1782235399066;
        Tue, 23 Jun 2026 10:23:19 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:18 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 08/10] HID: steelseries: Manage battery lifetime with refcounting
Date: Tue, 23 Jun 2026 13:23:08 -0400
Message-ID: <20260623172310.272708-9-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/hid/hid-steelseries-arctis.c | 36 ++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 1f0e9cb5138f..734cf1eb8789 100644
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
@@ -268,9 +280,7 @@ static void steelseries_status_timer_work_handler(struct work_struct *work)
 
 static int steelseries_battery_register(struct steelseries_device *sd)
 {
-	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct power_supply_config battery_cfg = { .drv_data = sd, };
-	unsigned long n;
 	int ret;
 
 	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
@@ -278,9 +288,10 @@ static int steelseries_battery_register(struct steelseries_device *sd)
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
 
@@ -290,7 +301,7 @@ static int steelseries_battery_register(struct steelseries_device *sd)
 	sd->headset_connected = false;
 	steelseries_headset_set_wireless_status(sd->hdev, false);
 
-	sd->battery = devm_power_supply_register(&sd->hdev->dev,
+	sd->battery = power_supply_register(&sd->hdev->dev,
 			&sd->battery_desc, &battery_cfg);
 	if (IS_ERR(sd->battery)) {
 		ret = PTR_ERR(sd->battery);
@@ -330,10 +341,11 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
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
@@ -342,7 +354,7 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto err_put;
 
 	ret = hid_hw_open(hdev);
 	if (ret)
@@ -361,12 +373,15 @@ static int steelseries_arctis_probe(struct hid_device *hdev,
 
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
@@ -388,13 +403,20 @@ static void steelseries_arctis_remove(struct hid_device *hdev)
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
2.54.0

