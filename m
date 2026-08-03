Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063664248DA
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779595; cv=fail; b=Lw+Saan+LQUFJNGb6gQV24dQGuG2PT/x1b/km8FyntUMtDwMmJajGqaQA+pPhtZxlrGJPIGSDgbQMkdOMAAoB7jCihpoQYt5D/C+dwXmQFLt66WzyLZp94uU0IxxJEclbtefxqRXsMtT1i3wPrymEy8MA213ioXRfvk/O/DNJ2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779595; c=relaxed/simple;
	bh=zOuLKk2dJwkcXaF4iA+7igo3Fp3YqMr2xXkdtbxae80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgfZOfSoTjjK48N8DcJr9dHXyx/cAmPbDDd+s4asHD8bqN5ZhVjaFnSgPrObCrU7PwyU3Iv1tkSte7OLHhL4zAZ3JqA2mWyQ++Pk1sFnW35Luew/c3ddSgcYYOFRHGFVT53k0YPf4balmYD/Zyr4EURAjoz/ONEaoMKjtIHa5h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jh+Vabg9; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jh+Vabg9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDMqSK5NUCQnI9CQhCsslEZB9vFaI7CmoqJF6d6cbR+YCzD4q+YhOVbImN+gByyQiPN/FiVlC/Bls6QAD5IVcJMFUPCTjGZrg9cOu0iyUQBd7f/YHI/ic9GHX+yaMDJPMOQUoRaul1grXRt1o8Syd7ic9wg5VMqhKjldoBALJMwRT18/v/AajfjsiVcfA8lIYbTMFhIEWfhGV4o6pYtXk6uspHws3g5H51uyLEV0+/SaWv3+W7/kPGaZTgqLCHAffGOO0aZO2cSKBRkl1aQ8yv7+VqUGrtJUVfkIpDyJi0J2TLbgQNkGeCOtKEdrPM15JnQR5BeSf+MMDatC7XyhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFnI6CfdW8TqFo6Vd7NTlznyWeomo6RyChOckmxRO0Q=;
 b=vbyPJCYIn0Yl0ko0vBSpdov6jKJ1qsPm+vWcMJH9IfsXcrpTouiMEErKhLUA3pkqdV0ib6YxvrTLQdHNyqjhiProrMsJvugNTtByj0U2Xfx3OLXBwDvl/FnIDzVnJetD18fISsW35GKHWeY3uD2Q010IFrP8GWY96yyIf266fb6e7d9OLKDtTy7QDhZ3eb+dkGmsf1jm8f2c6uqTFcQbMCCEQKR8JthqLqoMRJiTepOkagY6vZwLFDJYOfQRGPUgCdQ3/aIykf+8GkpxR+yiyR6bN/UgAASyilJix6dLOv15lGD27WR49JIqYIMtZ0k7MAEEBZUI3iLFgGgHG8W1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFnI6CfdW8TqFo6Vd7NTlznyWeomo6RyChOckmxRO0Q=;
 b=jh+Vabg9Dk5xPWg1tP4dXOwIIiE6EY5O+flU1u8IVsZsg6/IgtYp5/cz/r/F1Vf3CgT4Vc0ZRGTedObRyhNxQAY0SWluCIM08uhaDx+3mvaHpTp/Z91IBJ3wkDxvRc8e2cLtHSQBqN9rQQpVj7jrR643vaevnXPwjG9lKBAFG/8=
Received: from DM6PR05CA0058.namprd05.prod.outlook.com (2603:10b6:5:335::27)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 17:53:09 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::65) by DM6PR05CA0058.outlook.office365.com
 (2603:10b6:5:335::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Mon, 3
 Aug 2026 17:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:53:09 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:53:05 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 3/5] HID: amd_sfh: Add accessor to read the operating-mode sensor
Date: Mon, 3 Aug 2026 23:22:28 +0530
Message-ID: <20260803175230.3839752-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
References: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9bb4fe-2951-48c4-a8b3-08def188147b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jr+upQwrT5/m2WKxkOQrkbuS+GksUEb22CPLPwqC1DGTzPXIPBde1AQcwQgeRxZxexSdYFXXqvSzdHe8Qz9cug+pjtZg4rrVdibwnt/IPIHP2HiTIHqm8d7TD+5/KMMQDKRHcz3dyMy25Zz0F6YP7QTxHwKGOM9HJUEbGaHx9UEhwBnBlBM8zrQRajMlDoQ7tR6UFUZeC4X54HYL8fnzVkM/ZmaSqN+u3rjqiUBBUXFSENBHdxs4F7bcqfFa7WShrihTWWP2UgJKdxsTVCALBCdn+51ye6mlIOtGyplEsvibnK5qZzOMRjMpfq0/o4Q8u080VrTCdIoxz1fQTbdpHk5kTGYoUVdWe8Nw2pl5SOUFMoLCJT858rmytE8znkp9WK8q+57nWG04m4f6vjIk+co6a9Gmv0FfSjnH42ehYiYoA6iIqY6zHilwIcvANj5xhnJv1ZjyEEeqca14CzAqePqwt/VoHF22XUfKdOP9d6xmP5OqbDTv2hYYvMhdDhdHWbnVg5hle2sf1jjNfZin/m4Dre3fQ/Hh4jtWVHOw5S/1CwE6vlwF72hVlGQy+CyExgE9J0NhjTpHU2wrRjagi4ZQ8gjZPBGld6Mns7JXs9bGSegDtbd2uUh6pfWICa9kIvQkmh+ElNqybz7jNe204vNQxklpy+sUlU8p6a++dL4UPc263bZeFn5Dm7LKIbMCnZZz5zoeHL3f3BTXhc/VZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+FB12CbN7tdzTi17l/QP4eBeXSr99/KuNGAfgakqVku2nujNHSE07AWp1MVJGm7zz/c0pJRAmCucVxvbEKj3cm1taMg19MLSjkacG4wwQYygmWIceI/Jj+nkrDl4KasaDGj+OUiBiEIs+sbrJPAZtC4EgryLVassRujbmN8ne2xl2uxjo9ZHuSLhcg7G07NYHcpFYEeLpJZRrMuUqpNZmowO2VXru66KAqJCjgyuKuQgjeOqJJWYP2zcuZnGuRJpYnOemTxP/RJ8E9dHyJlBUL2Z9s+EjlwwHS7OT5MdqGt0kdwKbTQAsmfOhDe3RfIPF1/YoAHzmiSjaSJ+1MrPRPrIbLwmlcyFlcN5ZUsbZLZA9l/RUeo+Dt8v1FTjFQxylBB9jtCen8iBdF0IhGavEG3gTAI9/qbF1DNBKa5zU5J1Go+Llsy31v3ZV+xg4SkE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:53:09.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9bb4fe-2951-48c4-a8b3-08def188147b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436

Allow other drivers to query the operating mode (laptop or tablet)
reported by the Sensor Fusion Hub. This is the interface used by the
tablet-mode switch driver to report the device posture to userspace.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 16 +++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  5 +++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  4 +++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 33 +++++++++++++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 -
 include/linux/amd-pmf-io.h                    | 14 ++++++++
 6 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 96ae792beeb6..ae6add0b9ce3 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -383,3 +383,19 @@ int amd_sfh_hid_client_deinit(struct amd_mp2_dev *privdata)
 
 	return 0;
 }
+
+bool amd_sfh_op_idx_enabled(struct amd_mp2_dev *mp2)
+{
+	struct amdtp_cl_data *cl = mp2->cl_data;
+	int i;
+
+	if (!cl)
+		return false;
+
+	for (i = 0; i < cl->num_hid_devices; i++)
+		if (cl->sensor_idx[i] == op_idx &&
+		    READ_ONCE(cl->sensor_sts[i]) == SENSOR_ENABLED)
+			return true;
+
+	return false;
+}
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index 68586f08ab23..0ca3254151ac 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -106,4 +106,9 @@ static inline u64 amd_get_p2c_val(struct amd_mp2_dev *mp2, u32 idx)
 {
 	return mp2->rver == 1 ? AMD_P2C_MSG_V1(idx) :  AMD_P2C_MSG(idx);
 }
+
+bool amd_sfh_op_idx_enabled(struct amd_mp2_dev *mp2);
+void sfh_set_emp2(struct amd_mp2_dev *mp2);
+void sfh_deinit_emp2(void);
+
 #endif
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 92801ca38957..4b1cd260410d 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -251,6 +251,8 @@ int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
 static void amd_mp2_pci_remove(void *privdata)
 {
 	struct amd_mp2_dev *mp2 = privdata;
+
+	sfh_deinit_emp2();
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
 	pcim_intx(mp2->pdev, false);
@@ -419,6 +421,7 @@ static void sfh_init_work(struct work_struct *work)
 		return;
 	}
 
+	sfh_set_emp2(mp2);
 	amd_sfh_clear_intr(mp2);
 	mp2->init_done = 1;
 }
@@ -448,6 +451,7 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	privdata->pdev = pdev;
 	dev_set_drvdata(&pdev->dev, privdata);
+
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index dd2720bae65c..097c5513ccd8 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -84,6 +84,12 @@ void sfh_deinit_emp2(void)
 	emp2 = NULL;
 }
 
+void sfh_set_emp2(struct amd_mp2_dev *mp2)
+{
+	guard(mutex)(&emp2_lock);
+	emp2 = mp2;
+}
+
 void sfh_interface_init(struct amd_mp2_dev *mp2)
 {
 	mp2->mp2_ops = &amd_sfh_ops;
@@ -91,6 +97,31 @@ void sfh_interface_init(struct amd_mp2_dev *mp2)
 	emp2 = mp2;
 }
 
+static int amd_sfh_op_mode_info(u32 *op_mode)
+{
+	struct sfh_op_mode mode;
+	bool present;
+
+	if (!op_mode)
+		return -EINVAL;
+	if (!emp2)
+		return -ENODEV;
+
+	present = emp2->sfh1_1_ops ? emp2->dev_en.is_sra_present
+				   : (emp2->mp2_ver == MP2_VER_V2 &&
+				      amd_sfh_op_idx_enabled(emp2));
+	if (!present)
+		return -ENODEV;
+
+	mode.val = readl(emp2->mmio + amd_get_c2p_val(emp2, 3));
+	dev_dbg(&emp2->pdev->dev, "op-mode: %s (mode=%u)\n",
+		mode.op_mode.mode == SFH_MODE_TABLET ? "tablet" : "laptop",
+		mode.op_mode.mode);
+	*op_mode = mode.op_mode.mode;
+
+	return 0;
+}
+
 static int amd_sfh_mode_info(u32 *platform_type, u32 *laptop_placement)
 {
 	struct sfh_op_mode mode;
@@ -175,6 +206,8 @@ int amd_get_sfh_info(struct amd_sfh_info *sfh_info, enum sfh_message_type op)
 		case MT_SRA:
 			return amd_sfh_mode_info(&sfh_info->platform_type,
 						 &sfh_info->laptop_placement);
+		case MT_OP_MODE:
+			return amd_sfh_op_mode_info(&sfh_info->op_mode);
 		}
 	}
 	return -EINVAL;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 665c99ad779f..56258c4d1b3a 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -185,7 +185,6 @@ struct sfh_op_mode {
 };
 
 void sfh_interface_init(struct amd_mp2_dev *mp2);
-void sfh_deinit_emp2(void);
 void amd_sfh1_1_set_desc_ops(struct amd_mp2_ops *mp2_ops);
 int amd_sfh_float_to_int(u32 flt32_val);
 #endif
diff --git a/include/linux/amd-pmf-io.h b/include/linux/amd-pmf-io.h
index 55198d2875cc..dc59c43bd8f2 100644
--- a/include/linux/amd-pmf-io.h
+++ b/include/linux/amd-pmf-io.h
@@ -19,11 +19,13 @@
  * @MT_HPD: Message ID to know the Human presence info from MP2 FW
  * @MT_ALS: Message ID to know the Ambient light info from MP2 FW
  * @MT_SRA: Message ID to know the SRA data from MP2 FW
+ * @MT_OP_MODE: Message ID to know the operating-mode (tablet/laptop) info
  */
 enum sfh_message_type {
 	MT_HPD,
 	MT_ALS,
 	MT_SRA,
+	MT_OP_MODE,
 };
 
 /**
@@ -44,12 +46,24 @@ enum sfh_hpd_info {
  * @user_present: Populates the user presence information
  * @platform_type: Operating modes (clamshell, flat, tent, etc.)
  * @laptop_placement: Device states (ontable, onlap, outbag)
+ * @op_mode: Operating-mode field (see enum sfh_dev_mode); used for tablet detection
  */
 struct amd_sfh_info {
 	u32 ambient_light;
 	u8 user_present;
 	u32 platform_type;
 	u32 laptop_placement;
+	u32 op_mode;
+};
+
+/**
+ * enum sfh_dev_mode - SFH operating-mode field (sfh_op_mode.mode, bits 0-2)
+ * @SFH_MODE_LAPTOP: Device is in laptop/clamshell posture
+ * @SFH_MODE_TABLET: Device is in tablet posture
+ */
+enum sfh_dev_mode {
+	SFH_MODE_LAPTOP	= 1,
+	SFH_MODE_TABLET	= 3,
 };
 
 enum laptop_placement {
-- 
2.34.1

