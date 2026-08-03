Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BE435EF0
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784566; cv=none; b=hG1oY3bQtuvF6+v1E4DMR0tSn7BcI7ooJpy3qxfnRVm223vydmLEd93lsgwWAbH1q5MLn2rA8eoWNZ+8sohaxx+FuVnTANba6pxltMjq3EOdywRW9U3ORV+HQaCZTzFpdAZE+Xc2Rjs+mJ6ua7N61SG1D/GOoBS/Lz2odMpwZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784566; c=relaxed/simple;
	bh=HcLY56V4G5qgz15CvOjbSYpkabPXRbcPz2MAIR5hkY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex/TfysbWhKqpyuSFX+jkj0LMo8p3/GJQsGsyBlF5ZzMJ3AE9iXh2Y8ehjZ3vT96/A7f1Bh8k5aTWNZo064FOpGPGtUwXi0inc3/nS+4ld9GKPJhmDXWDmDqsGSRgC8Bw/Yok1PpQ+lFNWqO7BRV5DnN3Qh4o555VNV7W9+Vkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkKuMmT1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkKuMmT1"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0ecfaee7so22925441cf.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784561; x=1786389361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3ueuoAKdkN9M8HNhpGDUHsXDw7G2MpREUxH5XZmVNo=;
        b=RkKuMmT1gl4UXrHdFDfQVtgsT57hhVx6tnLOSRXSGeBSOSUMdalfJTDhhnd3u3WbRE
         dZ9PlnfjqMTCCjCgRi1PSwcEssRO9DAjBNKzavKaaY+7QYqYCMOKnMQO740hpDwmQcLD
         CGN5FHPvaNPfkfN5qWFJgdL07gPKHBJr13w9R+v4Wckmi1+9x/UkmS2L5QoSksfXX71t
         acSkMnaYOnvCjlgRKeBhvIinzNFzDrFMd8dSLY+FqMxQM/aPrt01wD1nCb2H66AzAAws
         PvtiMA7pVUMMm9XZwDL74J+ObuMBXnY/Ux6QDKYVXIedWAbYv/resJimaEM/Fgjeo9T9
         7ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784561; x=1786389361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3ueuoAKdkN9M8HNhpGDUHsXDw7G2MpREUxH5XZmVNo=;
        b=lDKv9sJ7cyzFMycNda6EW4405IIPIcgYiIuYgxuuBFA5rnvrtnSwKCGBUuQGhvnt/l
         PxAOrxKNha0BZ37fjszoWs/lZF82Dmmo7nus8l7VTpYVeXPYfuEhKCs/zTex/oBvdYH2
         P6wYWMhfRhEQX3v9Bko5Gk3BHCxfuIVdJdsBzDXsE4F35iupMzYYv/8OtYGEFtg/3aCI
         CmPaSP28OJ6PmHNNsrGDcteFRglje1dgExC3IxbECYCWr8iLClmf6prkw/UvtB2Z+8CE
         6cv5to/cZO0gH3xPIPT/EuSqt5aaGDEwuZHbS5SHeQ7bHh8cRcoWo+MokPsY42nolwR1
         bysg==
X-Gm-Message-State: AOJu0YzcyoytlWZmXWz6ImIshvADTr0ziP6t9fOFi32APtBXEjbZ0sCH
	8N5b6pfl9IcAe9TczQQu3gS9BMeTGubhZ1UE60/OgNIGhG28XxXRARu4
X-Gm-Gg: AR+sD11/fn3V8+/5n3DeSNKln3LTkRyS/4lMcfe3zdjw5ifl9fqoP+8I85uhwBvZLf9
	DV+zTIfx3jFiXTPMZFjBO1+N77gdLz7e20HXIDKgtMQQ6XH5L1mNmELvwzeo/iPTKtR0z/odz1w
	VDkTDsZlj2i5md4QGoKiY9DqeUFM4qGKKB5oCm6pp3dr38720QYaf5hJROuUXMNRtKtw9n5wVht
	71nxQ7XWvl+wKlev0fO350KKu7A/fOrNVMjbP1a7ndKM71v8SSYb55MQF9iVmkzmoUZhoyZ+3Z1
	iHj+j2TlsH5IjTbSKfyxvTwE8jqcdQq/7ttJ12Ii2u8OXPyexg6+jWFz+y9YoODm+Pa9aEdA5tV
	sLDCwhiezcRGUJO6L8gASxGJBIimbwqX5aCVx7WoPHblVKu/+XLhWdtn/WuRwDffok0aHVamHFY
	832C/otkRVUrZcqCYLQX2pGmWsuJQ+xDDZmUcKds97PlxDlrtmnXlv7JTnTJpOvTBp4PazQm5hq
	1zy40YV3lfmzS85XpQ=
X-Received: by 2002:a05:622a:2b44:b0:528:17d9:2d99 with SMTP id d75a77b69052e-52b567f9725mr202750661cf.43.1785784561006;
        Mon, 03 Aug 2026 12:16:01 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:16:00 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 6/8] HID: steelseries: Manage battery lifetime with refcounting
Date: Mon,  3 Aug 2026 15:15:51 -0400
Message-ID: <20260803191553.66368-7-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
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

