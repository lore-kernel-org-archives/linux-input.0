Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFEB30C174
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769131; cv=fail; b=lEp3zEdCTCwGVtjTG5shrojVsgt7hPkCWYCVEy3XsHyoWBUJiT/TkHMHLHiVTNSMVzpx1TfAWAdcolqxnm/uI9hAAAeezedzfhFKbtqKgqcykCJkcFHY4LZlUVp+CaOFug9CT1Ue8Zkonto30wE6VGHoU029LEurx4Xga6HmUpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769131; c=relaxed/simple;
	bh=/k9Q7/pLNi0lgdvA3beIyEHY5hcGXItIhDweX+jJXnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfY1lNsJ+9oCuQW+LWqeLbRzVP/hIRGF8bHHZOoxSWzruag5DAn63moDUWP5wAqWX4WVAOVeuDTNIhFbAm19DI3d19vZgp9zuhmRY9afLgnSeNRHGK2AamAr22Ydh5zP0MTR3m3QTtrg1TxU4Tnqcoce2avE+wrqc3XkxZB3Vak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=12HdVlfo; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="12HdVlfo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3n0KMVQnuKV8l+jOKM5cTJlaBwSCdyKJK5nh/Jucj+VDWbcbOs8IcGm58tcvvtNx89XXAQA6zWtVSdULnJVjBZnwWvIrK4+6mJ4g1xnYYHCB3gx513ps1TtKDIvXMkBO4/qXELlobV1WDnYV8KuKxaHAzj5IUzMtVhtXXnyfTACXIFl2kExQ8TzHmGvBelqyzGX6BMxweEZf7wdlxL6hH6HHmw4Z1u3iF5th/tAj+Dc9E9IZP+yuw5A9jsIhT8zKoOnab14Mflmg6vtQ4J/6vrf7c29W9twipAeUIp/bLpKRmCsUG8ub8Dh4xxXBb68yfxI1dlJzfiCnWG0SsST6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXIQKPRSJuTqNLb3mh3ndW5wAE61ekq56JVlsqruvqU=;
 b=jUmQXJhxvG0dMoCMDpraVouRz1WhUUlTAuL57lTgKDLpkmwgak18WLSal61cOle0/8OFiz6b2eVC8T8P3bMfFN/p4qd4SfvvrSet3CbBdgmgi1Ndd2kOs95J4RHQiWjTn+QuZIY82vGlhcfe35zoMNp7dTfoPOZFpyVVgHfiHdcqWy153vis3UUh5XfVRW0dqhWT4hzkx/2NBr2iaPUx/aKQclY8ELS84YASgy7FP1P0g5v2CYN28tBCHBOHQK32xrPHsFqePl9chOVHPYn833Rx0QjeBoNpNqPZpZd8JUEyj3ajpN3dXIjDBiyA3Jjc4DahhKwWeE3VBGqjTxOf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXIQKPRSJuTqNLb3mh3ndW5wAE61ekq56JVlsqruvqU=;
 b=12HdVlfo+cy84hOcHjs9+/qdJ7zS7KnJVZfb6i23kjcgAz9N4T9tw/ryrsFzkL57uQN/YQ3ndEUAzrMJTXHV16gLPpmQJPKyNSBs9CBF5WVf+o84BdkGlhlThzOa6YzidAmMqdQhl3+fLyvvz0oXZLKjbrFSgORnHMdJjctagj8=
Received: from CH5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::20)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:58:45 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::39) by CH5P221CA0004.outlook.office365.com
 (2603:10b6:610:1f2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:58:44 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:58:39 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 4/5] HID: amd_sfh: Register tablet-mode auxiliary device
Date: Mon, 3 Aug 2026 20:28:00 +0530
Message-ID: <20260803145801.3801862-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
References: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8dc78d-2ae5-4c42-d41f-08def16fb6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IRPZcW+26dVa4xwO9TgRQM2p4HGNZbP0HVKrBAtgV9taML8S9gXH3p8iYCsS6T3PjvL8lfUyHWZ+6YWdOIpSR0xO1M5v8cTfY7hLktWgJSp2agDkXMO6mffjZ/3K4rOAhqdnUZWHDwrDRUg6B32upi5vaPkZRN+8gnNnSHILOVZe+R0yvZwuuME6cxgBMKLsIBHxSmNlAQkD0VmDdNQFLxAB2f8q0WzlZXeJzDlVEUb8u/FLyOMkQ6V+gXfHLjWwtFVmxWFaB/aL4eDj+l0VL2ZHqbPaupreSNqQ2koTq5PPnSkWaPRFAFR24gaW9y03AKTzId+9H/D8nhh89dYthrsJE4z1IbmlMWSwDIfrRW1Kx3aD/D0D+w3Lv3Z/FmND/kasPrKcQt2FnPANBtk+5D38hanWZ9FZfEgz4g4z6qb6fQA4/XlpHc9KpNKwHoPL6jyJdE9HAxsWKMi1WeGXqxn/A78qHJGyVR4fyeO+zU5JxWEwZc7eHT6CLMqd1C8+03Vn5anhajkplpWvz45FM0AKLz3rRLhKhvg1HdAQGQF/qpqD+RmjQKXiDfDEMLE4Z/wuLkSLHQCT25VQDhy5mOzOU3BJVoC2/kp3AyP/7qm1spX+3Ng4eZzWdj30qnYjsFRhdSXlmy4idBAiMrSZbRmHbl9W2kvP0eptDl0kJ3FdQSzHyN46Zcf3pJJnSvByLFjRPcNzi4XhuXYtVSzdng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/3EWZ9zzjOQcO71sYnu8uc7TX+uMGYIscNQq/LtRFULYOzeBHNQYCnNAapYoFSb7O2qozoGP03x1sz9f1e2nm1JUk752QJmRxG+LE4FmENgR4vWy9i1k7ghmtdpyh9g+6PcJKhi9g+AU/MZgdEcZza2K6YiUWF5+49lFhRj+wOA44eyUQJcO8mWz/idc4sRoySC8TAVGc+OmtXBcrscDSOlTzflQfANnAMgaNra8NTXRXBt3genmi2jtcxX+y7GGNe9KC1BJzNkL8MUIKX8nB1xTNyxANhxburHknJuKYD1ORIMZNWsXS8/oMmOhmEdVUWK+knEUnXW1hyEYWRgL6Mh7MjjstWXrDMfC/lLSep69aUtxXRz74eY26Kb9xn0PunvtvIPuV58WG1l36ZwRWjA9H9FbUl4zVm8GIlN3hgMIQZV/MFV/vcwlRrukBjZW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:58:44.3774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8dc78d-2ae5-4c42-d41f-08def16fb6d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086

Register an auxiliary device when the operating-mode sensor is present,
so a dedicated input driver can bind to it and report the device
posture. This keeps the input handling out of the sensor transport
driver.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/Kconfig          |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_common.h |  2 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 48 ++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/Kconfig b/drivers/hid/amd-sfh-hid/Kconfig
index 3291786a5ee6..d86d83ffebd7 100644
--- a/drivers/hid/amd-sfh-hid/Kconfig
+++ b/drivers/hid/amd-sfh-hid/Kconfig
@@ -6,6 +6,7 @@ menu "AMD SFH HID Support"
 config AMD_SFH_HID
 	tristate "AMD Sensor Fusion Hub"
 	depends on X86
+	select AUXILIARY_BUS
 	help
 	  If you say yes to this option, support will be included for the
 	  AMD Sensor Fusion Hub.
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index 0ca3254151ac..f8c6b7fc34fb 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -10,6 +10,7 @@
 #ifndef AMD_SFH_COMMON_H
 #define AMD_SFH_COMMON_H
 
+#include <linux/auxiliary_bus.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include "amd_sfh_hid.h"
@@ -70,6 +71,7 @@ struct amd_mp2_dev {
 	u8 init_done;
 	u8 rver;
 	u8 mp2_ver;
+	struct auxiliary_device *tm_auxdev;
 };
 
 struct amd_mp2_ops {
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b1cd260410d..f6f016c8c678 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -8,11 +8,13 @@
  *	    Basavaraj Natikar <Basavaraj.Natikar@amd.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/devm-helpers.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmi.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
@@ -389,6 +391,50 @@ static const struct attribute_group *amd_sfh_groups[] = {
 	NULL,
 };
 
+static DEFINE_IDA(sfh_tm_ida);
+
+static void amd_sfh_tm_cleanup(void *data)
+{
+	struct amd_mp2_dev *mp2 = data;
+	int id = mp2->tm_auxdev->id;
+
+	auxiliary_device_destroy(mp2->tm_auxdev);
+	ida_free(&sfh_tm_ida, id);
+	mp2->tm_auxdev = NULL;
+}
+
+static void amd_sfh_maybe_register_tm(struct amd_mp2_dev *mp2)
+{
+	struct auxiliary_device *adev;
+	bool present;
+	int id;
+
+	if (mp2->tm_auxdev)
+		return;
+
+	present = mp2->sfh1_1_ops ? mp2->dev_en.is_sra_present
+				  : (mp2->mp2_ver == MP2_VER_V2 &&
+				     amd_sfh_op_idx_enabled(mp2));
+	if (!present)
+		return;
+
+	id = ida_alloc(&sfh_tm_ida, GFP_KERNEL);
+	if (id < 0)
+		return;
+
+	adev = auxiliary_device_create(&mp2->pdev->dev, KBUILD_MODNAME,
+				       "tabletmode", NULL, id);
+	if (!adev) {
+		ida_free(&sfh_tm_ida, id);
+		dev_warn(&mp2->pdev->dev, "tabletmode auxdev create failed\n");
+		return;
+	}
+
+	mp2->tm_auxdev = adev;
+	if (devm_add_action_or_reset(&mp2->pdev->dev, amd_sfh_tm_cleanup, mp2))
+		dev_warn(&mp2->pdev->dev, "tabletmode cleanup registration failed\n");
+}
+
 static void sfh1_1_init_work(struct work_struct *work)
 {
 	struct amd_mp2_dev *mp2 = container_of(work, struct amd_mp2_dev, work);
@@ -405,6 +451,7 @@ static void sfh1_1_init_work(struct work_struct *work)
 	if (rc)
 		dev_warn(&mp2->pdev->dev, "failed to update sysfs group\n");
 
+	amd_sfh_maybe_register_tm(mp2);
 }
 
 static void sfh_init_work(struct work_struct *work)
@@ -424,6 +471,7 @@ static void sfh_init_work(struct work_struct *work)
 	sfh_set_emp2(mp2);
 	amd_sfh_clear_intr(mp2);
 	mp2->init_done = 1;
+	amd_sfh_maybe_register_tm(mp2);
 }
 
 static void amd_sfh_remove(struct pci_dev *pdev)
-- 
2.34.1

