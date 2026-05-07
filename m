Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115D37BE8A;
	Thu,  7 May 2026 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146158; cv=none; b=Dfqt0UNBb7b2DvSyQtUAcUuZcfhNEjZwonn9d2jJkTqosCSY0ghJ9GFsMzenMiy65SlGJ4JKKXvui7FbZ66CVvZ1CkOHD2Ec7tQnJ0GE6v7L5qWyfSu7PvVvda7ToT/kSlyMvZhx5IXfpl85N0qyn+PAUFb4Wk5373V5X4cV5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146158; c=relaxed/simple;
	bh=VHu51KCain/DYYn3gz1hBFd8nOopB5zUykVRUjuUlzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz8mGiSjl+m/Ix7cyZv7ejJwwPESUfYAbZaYtSrIfa2TJ9G43ZITTL9MLd7odh498H9HFJJczMFg/o5iR3JGJK5J3lndSJZuDHnkV2xBP5+xUSHlfE91oMlFrnAcBw5D1hIA7fQhN2Y+1/eEhtIkn+SY9PMLru8jYjC4cLAaePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=O0ZNERNp; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="O0ZNERNp"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4gB6QK5Jl4z1FXZw;
	Thu,  7 May 2026 11:29:13 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4gB6QK25Kwz1FXZy;
	Thu,  7 May 2026 11:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778146153;
	bh=GofJ4cjc5NMrTAg/sjY16rkR1YSplZlsMbdB5r1HUwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0ZNERNpcCslwTmEtsKj6m0xfuOh3TC7RQ0SMgXfkMNsBmtAZ4eoCfeXPVxuDdEbS
	 E7kQ+Z8S2lEVeRPOiP6dFJwBEPfK60y+IGixlcL7nyTmtKVXKOJmRgJNJrtAEE9Frf
	 5NCGOoDSCuqPFbLIVWOXAc7f3TgqVt3+crCM7Qxjn01yz9NQtT3CQGqL0hnPafPxWD
	 ypn59k3e4jyuhoZCtlgpVAy4H6WzdHA8Lf+4XLBNstWAsMXOnA193lQsVrI2w9rDqx
	 Anzjsqqoc7d9MGU+CfM8uqadCU0GCN7e9utcOg8O6BkCFEbXw74t6nrW/YwLxQl20a
	 8D3pL21vLZGdQ==
From: =?UTF-8?q?Marcus=20Gren=C3=A4ngen?= <marcus@grenangen.se>
To: platform-driver-x86@vger.kernel.org,
	denis.benato@linux.dev
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	corentin.chary@gmail.com,
	marcus@grenangen.se
Subject: [PATCH v3 3/3] platform/x86: asus-armoury: add fn_lock firmware attribute
Date: Thu,  7 May 2026 11:29:11 +0200
Message-ID: <20260507092911.8855-4-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507092911.8855-1-marcus@grenangen.se>
References: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev>
 <20260507092911.8855-1-marcus@grenangen.se>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a fn_lock attribute to the asus-armoury firmware-attributes interface,
allowing userspace to read and set the Fn-lock state (whether F1-F12 keys
are primary or media/system keys are primary).

On most ASUS laptops fn-lock is backed by WMI DEVID 0x00100023. On
platforms where that DEVS call is a no-op (fnlock_use_hid quirk), the
store path dispatches via asus_wmi_fnlock_set(), which selects the HID
feature-report path internally. The show path returns -EOPNOTSUPP on
such platforms as the hardware provides no readback.

The attribute is only registered when the platform actually supports
fn-lock, either via the HID quirk (asus_wmi_fnlock_use_hid()) or a
functional WMI DEVID (armoury_has_devstate(ASUS_WMI_DEVID_FNLOCK)).
Registration state is tracked in fn_lock_registered so that removal
in the exit path is symmetric.

Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
---
 drivers/platform/x86/asus-armoury.c | 70 +++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 5b0987ccc270..fb8ad3b14aad 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -93,6 +93,7 @@ struct asus_armoury_priv {
 
 	u32 mini_led_dev_id;
 	u32 gpu_mux_dev_id;
+	bool fn_lock_registered;
 };
 
 static struct asus_armoury_priv asus_armoury = {
@@ -778,6 +779,58 @@ ASUS_ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
 ASUS_ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
 				  "Read the base TGP value");
 
+/*
+ * fn_lock: toggle whether Fn key is locked (F1-F12 primary) or unlocked
+ * (media/system keys primary).
+ *
+ * On most ASUS laptops this is backed by WMI DEVID 0x00100023. On some
+ * platforms (e.g. ProArt P16) that DEVS call is a no-op and the state must
+ * be sent as a HID feature report to the N-Key keyboard via hid-asus.
+ */
+static ssize_t fn_lock_current_value_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	u32 result;
+	int err;
+
+	if (asus_wmi_fnlock_use_hid())
+		return -EOPNOTSUPP;
+
+	err = armoury_get_devstate(attr, &result, ASUS_WMI_DEVID_FNLOCK);
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%u\n", result & 1);
+}
+
+static ssize_t fn_lock_current_value_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	bool enable;
+	int err;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	if (asus_wmi_fnlock_use_hid()) {
+		err = asus_hid_fnlock_set(enable);
+		if (err)
+			return err;
+	} else {
+		err = armoury_set_devstate(attr, enable ? 1 : 0, NULL,
+					   ASUS_WMI_DEVID_FNLOCK);
+		if (err)
+			return err;
+	}
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+	return count;
+}
+
+ASUS_ATTR_GROUP_BOOL(fn_lock, "fn_lock", "Set the Fn-lock state");
+
 /* If an attribute does not require any special case handling add it here */
 static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
@@ -926,6 +979,17 @@ static int asus_fw_attr_add(void)
 		}
 	}
 
+	if (asus_wmi_fnlock_use_hid() ||
+	    armoury_has_devstate(ASUS_WMI_DEVID_FNLOCK)) {
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 &fn_lock_attr_group);
+		if (err) {
+			pr_err("Failed to create sysfs-group for fn_lock\n");
+			goto err_remove_gpu_mux_group;
+		}
+		asus_armoury.fn_lock_registered = true;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
 		if (!armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
 			continue;
@@ -963,6 +1027,9 @@ static int asus_fw_attr_add(void)
 			sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
 					   armoury_attr_groups[i].attr_group);
 	}
+	if (asus_armoury.fn_lock_registered)
+		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &fn_lock_attr_group);
+err_remove_gpu_mux_group:
 	if (asus_armoury.gpu_mux_dev_id)
 		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
 err_remove_mini_led_group:
@@ -1138,6 +1205,9 @@ static void __exit asus_fw_exit(void)
 	if (asus_armoury.gpu_mux_dev_id)
 		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
 
+	if (asus_armoury.fn_lock_registered)
+		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &fn_lock_attr_group);
+
 	if (asus_armoury.mini_led_dev_id)
 		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mode_attr_group);
 
-- 
2.54.0

