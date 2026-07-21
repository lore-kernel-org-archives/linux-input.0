Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541F404BE9
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655895; cv=fail; b=gnGw/xCTnEfyFvcXbGpvNambCOeNhOZtJJKikA8+DnXzRKcYjooXWKtDIYK+1Swj0fHbJEK1vrt9CJhA3ECOkTcBLhGceIg7EVty13v51j5OuIvlD3vfDmdjuK2uFp5zKbcgZgeh7tDbvz5PBUbkfqNGsIaa5IEbDVsAnXH51ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655895; c=relaxed/simple;
	bh=IAAaRAULVltWxV6lZjMPCHMTyccTyo2ipB5f2DIn5Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvfhwI/jT10Rttg9pIne5ofgGli1qyJZ1QDNjND/2BfJoTeUeTdYG9AaCarrb932zrmrDnCvqot8960lAHuK1JYGHutU1C2T03wowLdRgp0QouvXc5kB/Joxtosx49p8KtMk6a+iA2a4QBBaDudsbxPWgADKmFjTInaWYdnLjLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1gcMaat3; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1gcMaat3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhHqw4WLemA3XCWJpNaqSn/ycLL+2GP2r6YIAL+T63mI/xwwAG40QQFKe4LBHgCzojhftuNr2w51PJbMN+ky6LxmqLFELSs1vgCYZqeqi9G/0ZIBImHQBMQed7uoK9GImHeCblx1MMjqYxfAbCkB3z3BSAWNkGsMtgaW3B5aEcM7dmMiMgl3sEa1q5O5iNqaEszXpL4TsAPd/f1cjp6l74NBlomJ2B++SnkvAy5QbpopmDRXgePsi82711O9Go04Cr9KfMs7ZLtRiET1HRDLy+mMMTfCuz7pcYBmgAtkkGQqkzSQHcOLhchDdVDFAJFSbreQAn/ND8szqazv7iAa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoSNI3FCDR/l5rd/a7A1dhBCpGTGIT2bDM4KK0dBFck=;
 b=XtVzt9sqCnQEvBUFxAePw2F2QrTCXEMpvO8kAmveYnnzGn2HTgE28bVFIy5RaxWIRmGHZuFvYYG7Gnqwvuwx2h9HxX0GaqCuemMbk6JCDS7X5bCAKwT6XQUbzwdIgfFRZhhgqHqN9QQh7oCfSdnSxIAwrlVsX5pZarp+PYrItgJQ0qXeuXjJE6dZcY0TprgRrn/jnBDSS41zpuDtUAJwmIFtSBR5Qg67ZGJods/SeVazMTCfK5N81UR8342275tJytlyLJ1/0gYonDVlSX0inCogPwonXY8F8Z/thpVKjerxgNmobPj4xAc0yZXTV2V5qiJRJNGmGQlcw+pRcf3rPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoSNI3FCDR/l5rd/a7A1dhBCpGTGIT2bDM4KK0dBFck=;
 b=1gcMaat3yp5yGFgDnHbdbUwl8K6ibekE2278JDXRlqZSxg8NpU9Hvntey5ZOAO1Dhm+/fwC/jznXbbxQlP7j4H3d1W5ChFMbjGIGfMAIb3F/bHOq0ZlnRJhDVHDjhcS3nsOJzoDW593fs7hNmnxjQyzVvv9cBNfTSwka78pmAYo=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:44:50 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::30) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 17:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:44:49 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 12:44:46 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/3] HID: amd_sfh: Add accessor to read the operating-mode sensor
Date: Tue, 21 Jul 2026 23:14:20 +0530
Message-ID: <20260721174422.3109166-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
References: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: c71c067a-6fc2-40a5-fefe-08dee74fc371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s59K7iKJHSIpHnrzbtNrNZRkPJsqzlyaLDT8GxhcSB7B8kcgduEy/ihN4tzkQROMHXreM4FKuIVvSvXBkBwecxBlPcvMWnIDwHTN+ZZv0j/yBW8dLKp9hD6KH77waXe5if9qMUeaif6gR5XnU9WfFt61XaoPpNTMYzZOALT5res9BOcsX4eAXFL2fuyNF1D5h5/npyTeoDPnTMBiYCWfYq+55lCm83Y+iUgu495JPP/sMgnlEyKZquKpOhpDxVcjRaFthq6THGiKRwAS5SjEKKmCAJA6MLtTdRnYv8ONcETTe9hG34jeAy0jBHoIrToa4FTHmotMHPURuBoXFeD6Dtz3LFCGOQvk82whvBqZPYyRlx7ipR7EaFt8Y+3Okndza43z3sVrfoili3h6A/lit8S7TBNIRWuVRjxJEJgTiUmLb/hCDdAp1Cvv3620wBBPq0MVnzHpDPiomEiJiWqc5w2OYZkPGRqL/FjeITfOSE+6FTGvVAbwHw3r3SeetjAKW67rfrWKqTUT/YzN23ATYIMJo0+4jn0uaIXOYtp7zEG28SjrP83tH+LZAUYFQA4dGSW6sdN0+DQhmOH7sBUP8tvWVfMzDMeFBI4xX9bbkYyr1hSFSi/sFhbd0bt1x/d4gwgsdpEynMGRNL1+VVtuPXsevAipNv9G0fk1ApuYY3afrWwGJm7QAqaZ+CxipaIm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1zSf67g8Ihujo8G9VzChw84DSY9TzBc7QF7/a4GR9UTNXEJo5+6UpWLgpC5vldSpOvhUj+NmyK2uoV/jd98LhXJSFVtAox4d+KHrer2X8Kb6Oa8DG5SVKeUr2EXZbICJ9jdE9dqMdqqVWibZN06ulf8FqJz2IE2XVYzzQ6q8fprqrmnU7kQtIDYJmJkmXuaRV0GEL86McqVU6U4d4rnKXAs0j5kBzsIhsDUo2n76xx/R6IYOvGuFadEfEHeSXo/ab/GO4MH1c9lyEGeqMl3FVSEKnRGWxaczPwKwZ+jY5IgrS08fen+rKmgNrVpUBA9EhR5ly3Thz0yDPz0bhpkV9Vlli2xHJZb/fN0OZv0cLxc6gfvGyowO1rFV9StDG7NhDprNb3vPJO/TG6CS1GwFB/DAPwJLv3lZqI9jJhLeMlFY4QVjzbP13vw//N+8klyq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:44:49.9856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71c067a-6fc2-40a5-fefe-08dee74fc371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

Allow other drivers to query the operating mode (laptop or tablet)
reported by the Sensor Fusion Hub. This is the interface used by the
tablet-mode switch driver to report the device posture to userspace.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 16 +++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  5 +++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 12 +++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 33 +++++++++++++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 -
 include/linux/amd-pmf-io.h                    | 14 ++++++++
 6 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 96ae792beeb6..0f5346d2174c 100644
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
+		    cl->sensor_sts[i] == SENSOR_ENABLED)
+			return true;
+
+	return false;
+}
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index 78f830c133e5..cad7d5f8fd4d 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -100,4 +100,9 @@ static inline u64 amd_get_p2c_val(struct amd_mp2_dev *mp2, u32 idx)
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
index 4b81cebdc335..a3672a9302c5 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -248,6 +248,11 @@ int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
 	return num_of_sensors;
 }
 
+static void amd_sfh_deinit_emp2_action(void *unused)
+{
+	sfh_deinit_emp2();
+}
+
 static void amd_mp2_pci_remove(void *privdata)
 {
 	struct amd_mp2_dev *mp2 = privdata;
@@ -447,6 +452,7 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	privdata->pdev = pdev;
 	dev_set_drvdata(&pdev->dev, privdata);
+
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -471,6 +477,10 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (rc)
 		return rc;
 
+	rc = devm_add_action_or_reset(&pdev->dev, amd_sfh_deinit_emp2_action, NULL);
+	if (rc)
+		return rc;
+
 	privdata->sfh1_1_ops = (const struct amd_sfh1_1_ops *)id->driver_data;
 	if (privdata->sfh1_1_ops) {
 		if (boot_cpu_data.x86 >= 0x1A)
@@ -480,6 +490,7 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		if (rc)
 			return rc;
 
+		sfh_set_emp2(privdata);
 		schedule_work(&privdata->work);
 		return 0;
 	}
@@ -498,6 +509,7 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		return rc;
 	}
 
+	sfh_set_emp2(privdata);
 	schedule_work(&privdata->work);
 	return 0;
 }
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 837d59e7a661..74b3d3382a82 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -81,12 +81,43 @@ void sfh_deinit_emp2(void)
 	emp2 = NULL;
 }
 
+void sfh_set_emp2(struct amd_mp2_dev *mp2)
+{
+	emp2 = mp2;
+}
+
 void sfh_interface_init(struct amd_mp2_dev *mp2)
 {
 	mp2->mp2_ops = &amd_sfh_ops;
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
+				   : amd_sfh_op_idx_enabled(emp2);
+	if (!present)
+		return -ENODEV;
+
+	mode.val = readl(emp2->mmio + amd_get_c2p_val(emp2, 3));
+	dev_dbg(&emp2->pdev->dev,
+		"op-mode: raw=0x%08x mode=%u lid=%u angle=%u ontable=%u devmode=%u\n",
+		mode.val, mode.op_mode.mode, mode.op_mode.lidstatus,
+		mode.op_mode.angle, mode.op_mode.ontablestate,
+		mode.op_mode.devicemode);
+	*op_mode = mode.op_mode.mode;
+
+	return 0;
+}
+
 static int amd_sfh_mode_info(u32 *platform_type, u32 *laptop_placement)
 {
 	struct sfh_op_mode mode;
@@ -169,6 +200,8 @@ int amd_get_sfh_info(struct amd_sfh_info *sfh_info, enum sfh_message_type op)
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

