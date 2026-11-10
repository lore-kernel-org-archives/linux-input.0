Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276076;
	b=RXMqT8ASvrbtvY6vBfxTEQCl8TDnnn4SDUTcVx3gs3GS13FBW9OJ701WjMQQAof9YR9s
	 rP/hvCOm6/WlP/p6Kc/JuAIY3SpJ7HigcH+19f3W3ZXA89YFU+yp3RjkL5mo6WX3HNosh
	 WCK064MIRg55ytGLwBMFJDAfjhmxjck9bNvdqgtZWovj2Bqo7lKqIUV/3fgyg1iieLlNo
	 DTmiLbEj4P6tAdFcwLkSNloMdwfkGA9UPMmBH/EMIrrTuuTQR0otEwVQuFhZU8bsjz1HU
	 EkszK/36ScMBpF/Fo4vivuIz9dyJXq3sxw/jqkqqGQHWpMh+KQKIvLUK4+pNAOlOAaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276076;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7a2LGI6SnaTCVfspM3YCywqqGri+7oAH2td8mYSDEVM=;
	b=JDKFWA99SANS+Av2ux/LNCoRYpja82UhNO02flqp8YvvF4Bz8bapaoV5RoLJ+Hm13BAR
	 PEQ4k4q3pDdPNLDK+fEMTnxeQTWrGBspbB0wTUX1C6NDlgig8rpRWlpY4fvWY44QoWhd9
	 eiNfIjk+0Ri+c9ov35TBLQPbQucM31F9aXStydieYGiJ9kv2QeLrwboVWcwppQ027iWwT
	 fzMbogjkRufqKEmMxenUItdiSe7iX2NIcWT0EMnfl9i+iyMo/3sk6pzYux05TjqlhyJbs
	 Fp+nkP9uEcoRUX1RTKPAxF3W036BTgC+qD8AbK+vObyJpk67ih3Ssz4UeAxNVRnDUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V1KFIf0F;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2460A6F77
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE2460A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V1KFIf0F
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nn1olpN2r1H2fU4Tau/Z8D7h1QOfkV8i5QZfgCnG8ag=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794276073; v=1; x=1794880873;
 b=V1KFIf0FqGrGSOSc4HdpPkYDqF0DjBxodWi2IVkcatjGEUnusu22BlQ6YZMmQLP/noAODBpN
 0qZv41zH2fe1T58u3Hd4YN348EEL0TYxS/ikDOUbgpTJYsYi/R2DQW/pLJ9u2H6aoduv3pHuhMI
 Q/VmtiuGRLI1rzkQ3att1FgA=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 18d11e292dcdd995;
	Tue, 10 Nov 2026 02:01:13 +0000
X-Mizu-Trace-ID: 18d11e292dcdd995
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v15 17/18] platform/x86: asus-armoury: pick the eGPU activation from the reported GPU
Date: Tue, 10 Nov 2026 02:00:35 +0000
Message-ID: <20261110020036.112884-18-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110020036.112884-1-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The egpu_enable attribute used to take four values. The WMI method
returned 1 for every one of them, so that return never said which
activation had been used. The extra values stayed while the right
choice was still unknown. It is known now: 0x0001 is NVIDIA, 0x0101
is AMD and 0x0201 is Intel, and a wrong value must not be sent. The
tools that drive this attribute only write 1, so the AMD and Intel
values were unused unless someone requested them by hand.

Writing 0 turns the eGPU off and writing 1 turns it on. The value
sent for 1 is the one that matches the GPU vendor of the connected
station, or NVIDIA when no vendor has been reported.

hid-asus reads that vendor from the station version query and reports
it through asus-wmi. Removing the station stores 0, which restores
the default. One mutex serializes the report. The connector is
proprietary, so only one XG Mobile can be attached, and one vendor
word is the whole state. The armoury store reads it while holding
egpu_mutex, in the same section as the WMI call.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c                     | 38 ++++++++++++++-
 drivers/platform/x86/asus-armoury.c        | 57 +++++++++++++---------
 drivers/platform/x86/asus-wmi.c            | 43 ++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h | 11 +++++
 4 files changed, 125 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 440ee26eb547..d4a24a19db63 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -89,6 +89,20 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define ASUS_XGM_TLV_TAG_LEN	3
 #define ASUS_XGM_TLV_HDR_LEN	(ASUS_XGM_TLV_TAG_LEN + 1)
 
+/*
+ * Four PCI IDs at the start of the version payload, high byte first:
+ * vendor, device, then the two subsystem IDs.
+ */
+enum {
+	ASUS_XGM_PCI_VENDOR,
+	ASUS_XGM_PCI_DEVICE,
+	ASUS_XGM_PCI_SUBSYS0,
+	ASUS_XGM_PCI_SUBSYS1,
+	ASUS_XGM_PCI_ID_COUNT,
+};
+
+#define ASUS_XGM_PCI_ID_LEN	(ASUS_XGM_PCI_ID_COUNT * sizeof(u16))
+
 /*
  * Every station answer echoes the report id, the opcode and the
  * subcommand, then the payload.
@@ -255,6 +269,7 @@ struct asus_xgm_info {
 	char part_number[ASUS_XGM_INFO_LEN];
 	char firmware_version[ASUS_XGM_INFO_LEN];
 	char generation[ASUS_XGM_INFO_LEN];
+	u16 pci_id[ASUS_XGM_PCI_ID_COUNT];
 };
 
 struct asus_touchpad_info {
@@ -5206,6 +5221,18 @@ static int asus_xgm_get_version(struct hid_device *hdev,
 	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
 			 buf, len, ASUS_XGM_TAG_FIRMWARE);
 
+	/*
+	 * The IDs are stored high byte first. On a captured GC33Y the
+	 * payload begins 10 de 27 17 21 fb 10 43: NVIDIA 0x10de, device
+	 * 0x2717, 0x21fb and ASUS 0x1043.
+	 */
+	if (len < ASUS_XGM_RESP_PAYLOAD + ASUS_XGM_PCI_ID_LEN)
+		return -ENODATA;
+
+	for (int i = 0; i < ASUS_XGM_PCI_ID_COUNT; i++)
+		info->pci_id[i] = get_unaligned_be16(buf + ASUS_XGM_RESP_PAYLOAD +
+						     i * sizeof(u16));
+
 	return 0;
 }
 
@@ -5586,6 +5613,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
 			 info->firmware_version, info->generation);
 
+	asus_wmi_egpu_set_vendor(info->pci_id[ASUS_XGM_PCI_VENDOR]);
+
 	/*
 	 * The attribute group is not devm-managed: a creation failure is
 	 * fatal and unwound through asus_xgm_init_err, while on the unbind
@@ -5634,6 +5663,7 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
 
 	return 0;
 asus_xgm_init_err:
+	asus_wmi_egpu_set_vendor(0);
 	sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
 	drvdata->xgm_info = NULL;
 	drvdata->xgm_led = NULL;
@@ -5867,8 +5897,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
-	if (drvdata->xgm_info)
+	if (drvdata->xgm_info) {
+		asus_wmi_egpu_set_vendor(0);
 		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	}
 
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
@@ -5894,8 +5926,10 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
-	if (drvdata->xgm_info)
+	if (drvdata->xgm_info) {
+		asus_wmi_egpu_set_vendor(0);
 		sysfs_remove_group(&hdev->dev.kobj, &asus_xgm_attr_group);
+	}
 
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index fb382de5b57b..dcf2e761016d 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -86,6 +86,8 @@ struct asus_armoury_priv {
 	 * sequences and dGPU connection status:
 	 * do not allow concurrent changes or changes
 	 * before a reboot if dGPU got disabled.
+	 * The activation section reads the reported GPU vendor here.
+	 * That word is covered by egpu_vendor_lock in asus-wmi.
 	 */
 	struct mutex egpu_mutex;
 
@@ -538,13 +540,28 @@ static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
 ASUS_WMI_SHOW_INT(dgpu_disable_current_value, ASUS_WMI_DEVID_DGPU);
 ASUS_ATTR_GROUP_BOOL(dgpu_disable, "dgpu_disable", "Disable the dGPU");
 
-/* Values map for eGPU activation requests. */
-static u32 egpu_status_map[] = {
-	[0] = 0x00000000U,
-	[1] = 0x00000001U,
-	[2] = 0x00000101U,
-	[3] = 0x00000201U,
-};
+/*
+ * egpu_default_enable_value() - Activation value for the connected station
+ *
+ * The eGPU switch activation value selects the vendor of the external
+ * GPU: 0x0001 activates NVIDIA, 0x0101 AMD and 0x0201 Intel. Pick the
+ * value matching the GPU vendor reported for the connected station,
+ * and fall back to NVIDIA when no vendor has been reported. The caller
+ * holds egpu_mutex. asus_wmi_egpu_vendor() takes egpu_vendor_lock.
+ *
+ * Return: the activation value for the reported GPU vendor
+ */
+static u32 egpu_default_enable_value(void)
+{
+	switch (asus_wmi_egpu_vendor()) {
+	case PCI_VENDOR_ID_ATI:
+		return 0x0101;
+	case PCI_VENDOR_ID_INTEL:
+		return 0x0201;
+	default:
+		return 0x0001;
+	}
+}
 
 /*
  * armoury_pci_rescan() - Performs a PCI rescan
@@ -578,11 +595,17 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
 	if (err)
 		return err;
 
-	if (requested >= ARRAY_SIZE(egpu_status_map))
+	if (requested > 1)
 		return -EINVAL;
-	enable = egpu_status_map[requested];
 
 	scoped_guard(mutex, &asus_armoury.egpu_mutex) {
+		/*
+		 * 0 deactivates the eGPU. 1 activates it with the value for
+		 * the GPU reported for the connected station. Read that
+		 * vendor in this section.
+		 */
+		enable = requested ? egpu_default_enable_value() : 0;
+
 		/* Ensure the eGPU is connected before attempting to activate it. */
 		if (enable) {
 			err = armoury_get_devstate(NULL, &result, ASUS_WMI_DEVID_EGPU_CONNECTED);
@@ -661,7 +684,7 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
 static ssize_t egpu_enable_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
 						char *buf)
 {
-	int i, err;
+	int err;
 	u32 status;
 
 	scoped_guard(mutex, &asus_armoury.egpu_mutex) {
@@ -670,20 +693,10 @@ static ssize_t egpu_enable_current_value_show(struct kobject *kobj, struct kobj_
 			return err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(egpu_status_map); i++) {
-		if (egpu_status_map[i] == status)
-			return sysfs_emit(buf, "%u\n", i);
-	}
-
-	return -EIO;
+	return sysfs_emit(buf, "%u\n", status != 0);
 }
 
-static ssize_t egpu_enable_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
-						char *buf)
-{
-	return armoury_attr_enum_list(buf, ARRAY_SIZE(egpu_status_map));
-}
-ASUS_ATTR_GROUP_ENUM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
+ASUS_ATTR_GROUP_BOOL(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
 
 /* Device memory available to APU */
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a65090429ca7..16836e7ee3dc 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -881,6 +881,49 @@ static DEVICE_ATTR_RW(dgpu_disable);
 #endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* eGPU ********************************************************************/
+
+/*
+ * One XG Mobile can be attached: the connector is proprietary, so
+ * this word is the whole report. 0 means the station is gone and
+ * the next activation uses the default value. egpu_vendor_lock
+ * covers the word. The armoury store holds egpu_mutex and then
+ * calls the getter, which takes this lock. The setter does not
+ * take egpu_mutex.
+ */
+static DEFINE_MUTEX(egpu_vendor_lock);
+static u16 egpu_gpu_vendor;
+
+/**
+ * asus_wmi_egpu_set_vendor() - Report the vendor of the external GPU
+ * @vendor: PCI vendor ID, or 0 when the station is removed
+ *
+ * Pass 0 when the station is removed. That restores the default
+ * activation value. egpu_vendor_lock serializes this with
+ * asus_wmi_egpu_vendor().
+ */
+void asus_wmi_egpu_set_vendor(u16 vendor)
+{
+	guard(mutex)(&egpu_vendor_lock);
+	egpu_gpu_vendor = vendor;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_egpu_set_vendor, "ASUS_WMI");
+
+/**
+ * asus_wmi_egpu_vendor() - Vendor of the external GPU
+ *
+ * Takes egpu_vendor_lock for the copy and releases it before
+ * returning. The armoury store calls this while holding egpu_mutex.
+ *
+ * Return: the PCI vendor ID last reported with
+ * asus_wmi_egpu_set_vendor(), or 0 when no station is known.
+ */
+u16 asus_wmi_egpu_vendor(void)
+{
+	guard(mutex)(&egpu_vendor_lock);
+	return egpu_gpu_vendor;
+}
+EXPORT_SYMBOL_NS_GPL(asus_wmi_egpu_vendor, "ASUS_WMI");
+
 #if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t egpu_enable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index b5ed8c83ace1..a53b2828bb1d 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -204,6 +204,8 @@ int asus_hid_register_listener(struct asus_hid_listener *cdev);
 void asus_hid_unregister_listener(struct asus_hid_listener *cdev);
 int asus_hid_event(enum asus_hid_event event);
 bool asus_wmi_custom_fan_curve_is_enabled(void);
+void asus_wmi_egpu_set_vendor(u16 vendor);
+u16 asus_wmi_egpu_vendor(void);
 #else
 static inline void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
 {
@@ -239,6 +241,15 @@ static inline bool asus_wmi_custom_fan_curve_is_enabled(void)
 {
 	return false;
 }
+
+static inline void asus_wmi_egpu_set_vendor(u16 vendor)
+{
+}
+
+static inline u16 asus_wmi_egpu_vendor(void)
+{
+	return 0;
+}
 #endif
 
 #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */
-- 
2.47.3

