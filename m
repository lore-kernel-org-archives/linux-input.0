Received: from m65s28.vlinux.de (m65s28.vlinux.de [83.151.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9F37D138
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.151.22.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777271968; cv=none; b=KnpK9b+eHyv5F9wgwRAzp2plsjtoMD5OXrwPsocE6JdOAUxPZeTFYoH83GfTA3h7+ttMl+PM9GhwhgO+WwxQjhIQ7ErAtPEUOEMzKPGsaSZN5QQeVWprEymbvjtZ3fUc/h3dNr0eT1nricz5c9VlcPLQ1dhTP0Si6xhN4MuvgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777271968; c=relaxed/simple;
	bh=zGr2MiaJCIIoGjUHV/V9LZkNhxnxC459zgBMAnhzilk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BuUwIgzz9cU6pwF90dnIW8Rjn0ijh40XXTl9iim8v/yLSC2RyovZTjaohnq14FNLxGk7P9IHyUXVF4BLf6eTZ3wGy9bel8bNjrMPNWtMajGVxitU7FNeKLVQEnPoBhXDK8k+8Z28aYeaOmPeKhIPlt3/AjX66Ajk6ZVkk2L6rzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net; spf=pass smtp.mailfrom=chaoticmind.net; dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b=Vw23hzMr; arc=none smtp.client-ip=83.151.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaoticmind.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chaoticmind.net header.i=@chaoticmind.net header.b="Vw23hzMr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chaoticmind.net; s=default; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nS0rTV2BfIneBKjrF7tjsYbLuA+dQpylwEvTuBzu7To=; b=Vw23hzMrC0eqOKxy5OMy5XWzDt
	7EIiC6K09UeanTopz/EsNZsf7kDUSnnj3kad3IyU5q3nOAR/7T7fXlLZNZ92PTfwWKu39n+xmiVhC
	O7vd6NHqljpFuMTK8LH4y7UF4ckWC/dNvwMSghkCekDhUOtMSNnXVMaxOdX6sdvpqI7UpQSpklxdo
	OqKpVgdVIRSBBFLesEyGphvVdzXmE5nfemo6sGZAh5M9ejXwkws9nztsrfGcf599Xz+aGuS4+Fi4n
	L048Rz8RSKi498bXVuj96CRnAJd/M+qefsOMgiQMZj92DfOc8KE957mch6yPwEQeaYKy0f2vWFvaN
	m4ibtlow==;
Received: from 165.99.104.92.dynamic.cust.swisscom.net ([92.104.99.165] helo=lothlorien.localnet)
	by m65s28.vlinux.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <hcb@chaoticmind.net>)
	id 1wHFMv-0002UZ-Mh; Mon, 27 Apr 2026 08:22:58 +0200
From: Helge Bahmann <hcb@chaoticmind.net>
To: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>,
 Sandeep Singh <Sandeep.singh@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, jikos@kernel.org,
 bentiss@kernel.org
Cc: linux-hid@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
Date: Mon, 27 Apr 2026 08:22:54 +0200
Message-ID: <6879487.lOV4Wx5bFT@lothlorien>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Add an input driver that interprets the "operation mode" sensor offered
by the amd sfh on some laptop models.

Add a quirk to make the driver work again with the Asus VivoBook
VivoBook (turn off the "disable interrupts" flag).

Expose the intr_disable flag as a module parameter in case it turns out
to be needed on further laptop models.

Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 25 ++++++++------
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c    | 43 ++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  6 ++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   |  9 +++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h   |  3 ++
 5 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 7017bfa59093..a24757c5a203 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -128,10 +128,16 @@ void amd_sfh_work_buffer(struct work_struct *work)
 	guard(mutex)(&mp2->lock);
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->sensor_sts[i] == SENSOR_ENABLED) {
-			report_size = mp2->mp2_ops->get_in_rep(i, cli_data->sensor_idx[i],
-							       cli_data->report_id[i], in_data);
-			hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
-					 in_data->input_report[i], report_size, 0);
+			if (cli_data->hid_sensor_hubs[i]) {
+				report_size = mp2->mp2_ops->get_in_rep(i, cli_data->sensor_idx[i],
+								       cli_data->report_id[i],
+								       in_data);
+				hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
+						 in_data->input_report[i], report_size, 0);
+			} else if (cli_data->sensor_idx[i] == op_idx &&
+				   cli_data->modeswitch_input) {
+				amdtp_modeswitch_report(i, cli_data->modeswitch_input, in_data);
+			}
 		}
 	}
 	schedule_delayed_work(&cli_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
@@ -327,15 +333,12 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)

 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		cl_data->cur_hid_dev = i;
-		if (cl_data->sensor_idx[i] == op_idx) {
-			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
-				cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
-				cl_data->sensor_sts[i]);
-			continue;
-		}

 		if (cl_data->sensor_sts[i] == SENSOR_ENABLED) {
-			rc = amdtp_hid_probe(i, cl_data);
+			if (cl_data->sensor_idx[i] != op_idx)
+				rc = amdtp_hid_probe(i, cl_data);
+			else
+				rc = amdtp_modeswitch_probe(i, cl_data);
 			if (rc)
 				goto cleanup;
 		} else {
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
index 81f3024b7b1b..44008c02b63c 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
@@ -181,4 +181,47 @@ void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
 			cli_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
+
+	/* note: cli_data->modeswitch_input implicitly cleaned by devres */
+}
+
+int amdtp_modeswitch_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
+{
+	struct amd_mp2_dev *mp2 = container_of(cli_data->in_data, struct amd_mp2_dev, in_data);
+	struct device *dev = &mp2->pdev->dev;
+	struct input_dev *input;
+	int rc;
+
+	input = devm_input_allocate_device(dev);
+	if (IS_ERR(input))
+		return PTR_ERR(input);
+
+	input->name = "AMD SFH tablet mode switch sensor";
+	input->id.bustype = BUS_PCI;
+
+	input_set_capability(input, EV_SW, SW_TABLET_MODE);
+
+	rc = input_register_device(input);
+	if (rc)
+		goto cleanup;
+
+	cli_data->modeswitch_input = input;
+
+	return 0;
+
+cleanup:
+	return rc;
+}
+
+void amdtp_modeswitch_report(u32 index, struct input_dev *input, struct amd_input_data *in_data)
+{
+	u32 *sensor_virt_addr = in_data->sensor_virt_addr[index];
+	u32 value = sensor_virt_addr[0];
+
+	if (value == AMD_SFH_OP_IDX_MODE_TABLET)
+		input_report_switch(input, SW_TABLET_MODE, 1);
+	else
+		input_report_switch(input, SW_TABLET_MODE, 0);
+
+	input_sync(input);
 }
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
index 7452b0302953..20aff7b75fbd 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
@@ -11,6 +11,8 @@
 #ifndef AMDSFH_HID_H
 #define AMDSFH_HID_H

+#include <linux/input.h>
+
 #define MAX_HID_DEVICES		7
 #define AMD_SFH_HID_VENDOR	0x1022
 #define AMD_SFH_HID_PRODUCT	0x0001
@@ -50,6 +52,7 @@ struct amdtp_cl_data {
 	u8 sensor_idx[MAX_HID_DEVICES];
 	u8 *feature_report[MAX_HID_DEVICES];
 	u8 request_done[MAX_HID_DEVICES];
+	struct input_dev *modeswitch_input;
 	struct amd_input_data *in_data;
 	struct delayed_work work;
 	struct delayed_work work_buffer;
@@ -78,4 +81,7 @@ void amdtp_hid_remove(struct amdtp_cl_data *cli_data);
 int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type);
 void amd_sfh_set_report(struct hid_device *hid, int report_id, int report_type);
 void amdtp_hid_wakeup(struct hid_device *hid);
+int amdtp_modeswitch_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data);
+void amdtp_modeswitch_report(u32 index, struct input_dev *input, struct amd_input_data *in_data);
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
--
2.47.3




