Received: from smtp-out1.simply.com (smtp-out1.simply.com [94.231.106.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F30332EC8;
	Wed,  6 May 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096024; cv=none; b=TmDADFsJNpvZIya14iMEQETx1YkncGgXVrJU1Jw3NUKes0UT/Bcs8Y0IcJuwHVBx23/KjQ4b1jhETWxGTTeMiWdHeAD3urEO/69EPplczEsvyAIPd/xiAed8JH7/w8ksJv28iATM7vns1DBNXeeHRaWTVxaW0W25kK7zrskl+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096024; c=relaxed/simple;
	bh=8Hi7J7f3Jc7rM9ymARnR7xQY4X+5J79J7sltTqwI5KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5eOIi5Lds7NlhXApvYVijxymHU2j00z6gtAEZf4AMTtdeQgJ+mZBBEicyd5ManG1IX7ahPOWnkTU7omkqyfo0aWg3u6rAkuqEUUB+bkh9NwjigW8J7+K7dF/UfmZ3butaCMBWMSBkbVipitJN+zBgDUhl1m5rWcZLPkQNamDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se; spf=pass smtp.mailfrom=grenangen.se; dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b=DHFLEchz; arc=none smtp.client-ip=94.231.106.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grenangen.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grenangen.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenangen.se header.i=@grenangen.se header.b="DHFLEchz"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4g9lt06c3Cz1DHpW;
	Wed,  6 May 2026 21:33:28 +0200 (CEST)
Received: from localhost (h-217-27-171-125.A498.priv.bahnhof.se [217.27.171.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4g9lt05F8Fz1DDSy;
	Wed,  6 May 2026 21:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenangen.se;
	s=simplycom2; t=1778096008;
	bh=M3+Ob8zDodFfm/vUJ1ZC2GL/XQp5y9tvpEeAGHcwyvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHFLEchzx5/TAxiUCmE/g9p8p7syVaQrVPUeaW0Njfv26DGPcU0bBXAL29GObYvqp
	 g1kLq8oQ4AD9ldPhGH7W4S8s4RaS4D7fgHbM6cmEt1tof2VQDuLmXF/BKFlivqzxlB
	 UwwiBRgUw+t24Z0elUbFkmvX60uKIuzBviKNIPXYxyWvKatUGom7KTKBU2Pr4jQf6V
	 2n2V/PiUv52ppuoXarH+FYclYB6tAzxyFEtnsi5FkFzj0p3U0+suN0kvCh3DbCK/VT
	 MmvtvxpCwTzQHsP0iuCbmrRo5OI/8rV9U2mfvToAu7ktgEAgtkv1RtMjChQ4Jh26Dp
	 0YKgeOgXd3RwA==
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
Subject: [PATCH v2 3/3] platform/x86: asus-armoury: add fn_lock firmware attribute
Date: Wed,  6 May 2026 21:33:26 +0200
Message-ID: <20260506193326.5862-4-marcus@grenangen.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506193326.5862-1-marcus@grenangen.se>
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
 <20260506193326.5862-1-marcus@grenangen.se>
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

On most ASUS laptops fn-lock is backed by WMI DEVID 0x00100023 and the
attribute uses armoury_get/set_devstate() as normal. On platforms where
the WMI DEVS call is a no-op (fnlock_use_hid quirk, e.g. ProArt P16), the
store path calls asus_hid_fnlock_notify() to send the feature report
directly to the N-Key keyboard via hid-asus. The show path returns
-EOPNOTSUPP on such platforms as the hardware provides no readback.

The fnlock_use_hid flag is detected at init time via dmi_match() on
DMI_PRODUCT_FAMILY. A direct DMI check is used rather than reading the
asus-nb-wmi quirk flag because asus-armoury and asus-nb-wmi are both
loadable modules at the same init level, so the asus_ref pointer set by
asus-wmi may not yet be valid when asus-armoury initialises.

Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
---
 drivers/platform/x86/asus-armoury.c | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 5b0987ccc270..9d7646eff944 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -93,6 +93,7 @@ struct asus_armoury_priv {
 
 	u32 mini_led_dev_id;
 	u32 gpu_mux_dev_id;
+	bool fnlock_use_hid;
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
+	if (asus_armoury.fnlock_use_hid)
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
+	if (asus_armoury.fnlock_use_hid) {
+		err = asus_hid_fnlock_notify(enable);
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
@@ -926,6 +979,16 @@ static int asus_fw_attr_add(void)
 		}
 	}
 
+	if (asus_armoury.fnlock_use_hid ||
+	    armoury_has_devstate(ASUS_WMI_DEVID_FNLOCK)) {
+		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
+					 &fn_lock_attr_group);
+		if (err) {
+			pr_err("Failed to create sysfs-group for fn_lock\n");
+			goto err_remove_gpu_mux_group;
+		}
+	}
+
 	for (i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
 		if (!armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
 			continue;
@@ -963,6 +1026,8 @@ static int asus_fw_attr_add(void)
 			sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
 					   armoury_attr_groups[i].attr_group);
 	}
+	sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &fn_lock_attr_group);
+err_remove_gpu_mux_group:
 	if (asus_armoury.gpu_mux_dev_id)
 		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
 err_remove_mini_led_group:
@@ -1121,6 +1186,8 @@ static int __init asus_fw_init(void)
 
 	init_rog_tunables();
 
+	asus_armoury.fnlock_use_hid = dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16");
+
 	/* Must always be last step to ensure data is available */
 	return asus_fw_attr_add();
 }
@@ -1138,6 +1205,8 @@ static void __exit asus_fw_exit(void)
 	if (asus_armoury.gpu_mux_dev_id)
 		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
 
+	sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &fn_lock_attr_group);
+
 	if (asus_armoury.mini_led_dev_id)
 		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mode_attr_group);
 
-- 
2.54.0

