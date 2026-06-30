Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76E3DD532
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840587; cv=none; b=dNfN0WqbzCtTBrutVoC1nwH/NxUY5ibH60VWnAWK+i7sh5k4QRcTC+Zz6GOUvbAheD436MYPbAssq3xHMcfRxuTWU9QdEQNbKOf42Em8oQYavopv1mS5b9McAQPlja7E8ItX+4icKHjvWLKZU9QJGo9bas6PyoL66jgIEVB7mKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840587; c=relaxed/simple;
	bh=ixUawZmhF8pP9mSvVNY8U6gK59QFNr3yOmLZSFUMKTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gd3H0t/qrMWsJKf7MNQ548g08nepVccbYHoqDaXFjT+2Mc47DMM4rlVqmlHJY0dPePPY0Ui474i8TejpJHLOHQR77T71cEyD1FAGcyLnfImVImxNr2hisJczpsivBO0GQe5lNPOFxitPCf+uvAY6pxmRCa26DetY4LXOnszWArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMIavjgz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMIavjgz"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so28289796d6.3
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840585; x=1783445385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKRGnNZP+4gjXpzxxj42erDflh/9VqIEG+cgo/cKwpY=;
        b=AMIavjgzlgzHOuXdlFei5umk/EBbSMpqSxIK5sxILM6iqr5LHGJFwDqmO7imQ3h3Yy
         7MK4ZqXkJQi/D8JJgGoVYflcq+pO4q38gnV/odXSwTh0JuqDMsazeIpcGUIW2pEK+kbP
         IEHtuxZNI0enD55FllYE3S9HCSyY6XOV84LtoiZsxPADIVtYO9tGEj9Hevm9aXLdnlfT
         3NIUGmeo2NEEB4BCKvEkewj+dcKf34oqmuMCY5sXkAwJ1AewHLfy/NtkQ9ObbLKUKkRV
         HvKHyIfCCx3mM2Owl1mlb7P/HBqKCmiRi7kGv9leHMvQ3omu5e58h6IfJe1s5egjN1E4
         gwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840585; x=1783445385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKRGnNZP+4gjXpzxxj42erDflh/9VqIEG+cgo/cKwpY=;
        b=mSJp76m2TGTNRmUCxGAC518SUfjjHQeVZ0sjR+aE8qwHGBmY3fn+f8/mjmiOMk691X
         sh3ktuxQkAkDsn5DtTlCj2junayS8fBVeWjK4g5EIiyhZ7nHXh2Xqdf5rNyJwJxhZYFH
         jZVSBCjj8XkYs4U4yg6MuEjuA/97IFesC4cnCAE6IHq0qnW0RhOK4wLdS+5A3VfLh9iJ
         Vwb1bn+Yt5Jo6aMx9DskhqjmYkEaYri599A3Wm0nRRVrgmIeNs6p24cUlJruOMTZ+5Ul
         R0Z0cUsZcc8YrZBdv5Gqrixs34JRd/vlhsnkouDesf/XZxWOYDBC6241fyaBH/5VfI7j
         c1og==
X-Gm-Message-State: AOJu0YybhhJcD1RDib0vzJiTJdXrgvlV5aMiAkYpAOgch7szPHKbQSAY
	xGf+/p0VSlBfA8/PhmO8YJrXydgU62ot6DKvH3wgX7LfTlbUhcfBiSR4
X-Gm-Gg: AfdE7ckdQ0x61Si8jUEFEWrnEv6TzswhJJLfoOux3UqDx1DmnYP64gZgF5ZAf7Vr5Vq
	OxJkUF73ylyfa63v8rBsympH22e3/9TuWaDyuojOmrsc1TuzBJ22O2fplT53DLzIIiBJzbOVDDR
	WIKkxSExaSb2OegXknJ6OcmqGvpaYUN52aNkyPlHPbm5mfSBQ5kcBchfLk3hB5XPMAOu7Yq9Avw
	MzjTmX1Ugp0XR202cNu1wtGx03mvrxsH3bIbpecfeKag+yc8EepZ3TWfAbgLC+yK+sGrewu8phT
	dTFpKAXHSFcMtFBqbLsTdrqGYYK43rSLn7LtOHHNlvJl07/VMeSeonllks0a3bdlELMYkyH2+1M
	gNcnldAE2/mbz+eytaFTmh99sA4/3egE4IR7rv9fQwK4WMrcFuUH4dOUvuqYAiplIrlBLcIzyfH
	skQHsSTZwXOwos/3rZhOHX/M3TifNzfAp9g/UY55nAUIWc1uh0
X-Received: by 2002:a0c:ee67:0:b0:8f0:744d:f99d with SMTP id 6a1803df08f44-8f2d1df82cemr16595336d6.45.1782840584714;
        Tue, 30 Jun 2026 10:29:44 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:44 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 7/9] HID: steelseries: Manage battery lifetime with refcounting
Date: Tue, 30 Jun 2026 13:29:28 -0400
Message-ID: <629543d56cfbd59ba118082880e86307b2aade26.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
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
index d1552bf6567b..6c745058f70e 100644
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
2.54.0

