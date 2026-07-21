Received: from m65s28.vlinux.de (m65s28.vlinux.de [83.151.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC739B484
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.151.22.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644159; cv=none; b=iQF1NXjlZZpea5/URzs/29gD7Mr91VFY87imwjROQbyh2ixP/lqZFACm5nEoDldM/vpLHtH+57WdOdxh7Ptqx6CcieccT1Z6TVtyOUrLr2jKGMLD9hC6LU3hCXv2RaMnXzH+kd3sTrZvdb8LObWqev+h9RWq8w+eAXxKURze6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644159; c=relaxed/simple;
	bh=tJcBzE0junPiZxwHAGlXr+oIRoL89UE9MFLN0WRj7Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/lPfth30kwlgq0jmHEpegmqDmrXW98tIgFzTu2wyt1/0OCsnXuCM/Ox4KlDqQ5sUrA0pEyRGPF5jVPACBERfRWylhVAoSjOw3bLRegejrbIWGZ+iTAz+tVSATzrl1omgRSoBs+dSU2/gj7oMUXsjD5LI0bvFbN8tC6NoDKIQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net; spf=pass smtp.mailfrom=chaoticmind.net; dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b=fAQ+MfhF; arc=none smtp.client-ip=83.151.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b="fAQ+MfhF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chaoticmind.net; s=default; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z0eld7AkQdwKAvEOq3cP5cBduJfrrQiF4eurdK5sKK8=; b=fAQ+MfhF9Ou+nT7Duw4Iv3Cav8
	HyJwAOQiwFo7dXf2z4ktkRkwesG5rm8Kum2GvyM4FZMszQzwPJt4UuBgFs7ZtTt19OSZtQQxg4MJI
	w1/Te6twHBCHVt2QhBjU1AwIH5Fjs3INIbxySykmCDQ1fzpp/OvYVlIgrHTHkv9BR98E7RlsgodXh
	DbKwxODW8K/5JoYdcxZ153z7WM2O2X9d+fT7L+qPrLmbzczczwq7YSGkV3Z7tkjquebHavGgAqTOh
	a71MbTAiAbIwyH0MSuvRqM8SXCoTKwEtEb8pRePeZQEpNbUIpzqqfM/gO+/QRRIqCi5AOSoaio/g9
	ue5tj1jw==;
Received: from pa49-196-176-77.pa.vic.optusnet.com.au ([49.196.176.77] helo=zephyr.localnet)
	by m65s28.vlinux.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <hcb@chaoticmind.net>)
	id 1wmBT7-0003Gw-8G; Tue, 21 Jul 2026 16:29:14 +0200
From: Helge Bahmann <hcb@chaoticmind.net>
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
 Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/2] amd-sfh-hid: tablet mode hid report and asus quirk
Date: Tue, 21 Jul 2026 16:29:05 +0200
Message-ID: <2108873.tdWV9SEqCh@zephyr>
In-Reply-To: <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
References:
 <6879487.lOV4Wx5bFT@lothlorien> <2632507.ElGaqSPkdT@lothlorien>
 <ecadaac8-e222-420a-ac5b-4d529fb3317e@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Add an input driver that interprets the "operation mode" sensor offered
by the amd sfh as a hid driver to generate a custom hid report (tablet
mode switch).

Add a quirk to restore compatibility of the driver with the Asus
VivoBook (turn off the "disable interrupts flag). Expose the
intr_disable flag as a module parameter in case it turns out to be
needed on further laptop models.

Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 19 ------------
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h         |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  9 ++++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |  3 ++
 .../hid_descriptor/amd_sfh_hid_desc.c         | 31 +++++++++++++++++++
 .../hid_descriptor/amd_sfh_hid_desc.h         |  9 ++++++
 .../hid_descriptor/amd_sfh_hid_report_desc.h  | 18 +++++++++++
 7 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 7017bfa59093..57ff708ca39b 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -254,19 +254,6 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 			goto cleanup;
 		}
 
-		if (cl_data->sensor_idx[i] == op_idx) {
-			info.period = AMD_SFH_IDLE_LOOP;
-			info.sensor_idx = cl_data->sensor_idx[i];
-			info.dma_address = cl_data->sensor_dma_addr[i];
-			mp2_ops->start(privdata, info);
-			cl_data->sensor_sts[i] = amd_sfh_wait_for_response(privdata,
-									   cl_data->sensor_idx[i],
-									   SENSOR_ENABLED);
-			if (cl_data->sensor_sts[i] == SENSOR_ENABLED)
-				cl_data->is_any_sensor_enabled = true;
-			continue;
-		}
-
 		cl_data->sensor_sts[i] = SENSOR_DISABLED;
 		cl_data->sensor_requested_cnt[i] = 0;
 		cl_data->cur_hid_dev = i;
@@ -327,12 +314,6 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
 
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		cl_data->cur_hid_dev = i;
-		if (cl_data->sensor_idx[i] == op_idx) {
-			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
-				cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
-				cl_data->sensor_sts[i]);
-			continue;
-		}
 
 		if (cl_data->sensor_sts[i] == SENSOR_ENABLED) {
 			rc = amdtp_hid_probe(i, cl_data);
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
index 7452b0302953..c1b62e5df2ff 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
@@ -78,4 +78,5 @@ void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
 int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type);
 void amd_sfh_set_report(struct hid_device *hid, int report_id, int report_type);
 void amdtp_hid_wakeup(struct hid_device *hid);
+
 #endif
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1d9f955573aa..cd9cff75f114 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -39,6 +39,8 @@ module_param_named(sensor_mask, sensor_mask_override, int, 0444);
 MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
 
 static bool intr_disable = true;
+module_param_named(intr_disable, intr_disable, bool, 0444);
+MODULE_PARM_DESC(intr_disable, "override the interrupt disable sensor bit");
 
 static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts)
 {
@@ -317,6 +319,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 435 G7"),
 		},
 	},
+	{
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420UA_TM420UA"),
+		}
+	},
 	{}
 };
 
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 2eb61f4e8434..5e968894ebe4 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -83,6 +83,9 @@ enum sensor_idx {
 	als_idx = 19
 };
 
+#define AMD_SFH_OP_IDX_MODE_LAPTOP 1
+#define AMD_SFH_OP_IDX_MODE_TABLET 3
+
 enum mem_use_type {
 	USE_DRAM,
 	USE_C2P_REG,
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
index ef1f9be8b893..7e807b92d296 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
@@ -42,6 +42,11 @@ static int get_report_descriptor(int sensor_idx, u8 *rep_desc)
 		memcpy(rep_desc, gyro3_report_descriptor,
 		       sizeof(gyro3_report_descriptor));
 		break;
+	case op_idx: /* op */
+		memset(rep_desc, 0, sizeof(tablet_mode_report_descriptor));
+		memcpy(rep_desc, tablet_mode_report_descriptor,
+		       sizeof(tablet_mode_report_descriptor));
+		break;
 	case mag_idx: /* Magnetometer */
 		memset(rep_desc, 0, sizeof(comp3_report_descriptor));
 		memcpy(rep_desc, comp3_report_descriptor,
@@ -87,6 +92,16 @@ static u32 get_descr_sz(int sensor_idx, int descriptor_name)
 			return sizeof(struct gyro_feature_report);
 		}
 		break;
+	case op_idx:
+		switch (descriptor_name) {
+		case descr_size:
+			return sizeof(tablet_mode_report_descriptor);
+		case input_size:
+			return sizeof(struct tablet_mode_input_report);
+		case feature_size:
+			return sizeof(struct tablet_mode_feature_report);
+		}
+		break;
 	case mag_idx:
 		switch (descriptor_name) {
 		case descr_size:
@@ -139,6 +154,7 @@ static u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
 {
 	struct accel3_feature_report acc_feature;
 	struct gyro_feature_report gyro_feature;
+	struct tablet_mode_feature_report tablet_mode_feature;
 	struct magno_feature_report magno_feature;
 	struct hpd_feature_report hpd_feature;
 	struct als_feature_report als_feature;
@@ -164,6 +180,11 @@ static u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
 		memcpy(feature_report, &gyro_feature, sizeof(gyro_feature));
 		report_size = sizeof(gyro_feature);
 		break;
+	case op_idx: /* op */
+		get_common_features(&tablet_mode_feature.common_property, report_id);
+		memcpy(feature_report, &tablet_mode_feature, sizeof(tablet_mode_feature));
+		report_size = sizeof(tablet_mode_feature);
+		break;
 	case mag_idx: /* Magnetometer */
 		get_common_features(&magno_feature.common_property, report_id);
 		magno_feature.magno_headingchange_sensitivity = HID_DEFAULT_SENSITIVITY;
@@ -212,6 +233,7 @@ static u8 get_input_report(u8 current_index, int sensor_idx, int report_id,
 	u8 supported_input = privdata->mp2_acs & GENMASK(3, 0);
 	struct magno_input_report magno_input;
 	struct accel3_input_report acc_input;
+	struct tablet_mode_input_report tablet_mode_input;
 	struct gyro_input_report gyro_input;
 	struct hpd_input_report hpd_input;
 	struct als_input_report als_input;
@@ -238,6 +260,15 @@ static u8 get_input_report(u8 current_index, int sensor_idx, int report_id,
 		memcpy(input_report, &gyro_input, sizeof(gyro_input));
 		report_size = sizeof(gyro_input);
 		break;
+	case op_idx: /* op */
+		tablet_mode_input.report_id = 0x11;
+		if (sensor_virt_addr[0] == 3)
+			tablet_mode_input.tablet_state = 1;
+		else
+			tablet_mode_input.tablet_state = 0;
+		memcpy(input_report, &tablet_mode_input, sizeof(tablet_mode_input));
+		report_size = sizeof(tablet_mode_input);
+		break;
 	case mag_idx: /* Magnetometer */
 		get_common_inputs(&magno_input.common_property, report_id);
 		magno_input.in_magno_x = (int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
index 882434b1501f..ff82e47eb3ca 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
@@ -114,4 +114,13 @@ struct hpd_input_report {
 	u8 human_presence;
 } __packed;
 
+struct tablet_mode_feature_report {
+	struct common_feature_property common_property;
+} __packed;
+
+struct tablet_mode_input_report {
+	u8 report_id;    /* Muss 0x11 (17) sein */
+	u8 tablet_state; /* Bit 0: Status, Bits 1-7: Padding */
+} __packed;
+
 #endif
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index 67ec2d6a417d..f95368534fc6 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -776,4 +776,22 @@ static const u8 hpd_report_descriptor[] = {
 0X81, 0x02,		 /* HID Input (Data_Var_Abs) */
 0xC0			 /* HID end collection */
 };
+
+/* tablet mode switch */
+static const u8 tablet_mode_report_descriptor[] = {
+0x05, 0x0C,		/* HID usage consumer electronics */
+0x09, 0x01,		/* HID usage */
+0xA1, 0x00,		/* HID collection (Physical) */
+0x85, 0x11,		/* HID report id */
+0x0A, 0xFF, 0x02,	/* HID usage (unallocated -- (ab)used for tablet mode) */
+0x15, 0x00,		/* HID logical Min_8(0) */
+0x25, 0x01,		/* HID logical Max_8(1) */
+0x75, 0x01,		/* HID report size(1) */
+0x95, 0x01,		/* HID report count (1) */
+0X81, 0x02,		/* HID input (Data_Var_Abs) */
+0x75, 0x01,		/* HID report size (1) */
+0x95, 0x07,		/* HID report count (7) */
+0x81, 0x03,		/* HID input (Data_Var_Abs) */
+0xC0			/* HID end collection */
+};
 #endif
-- 
2.47.3



