Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6035E1AE
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779600; cv=fail; b=UynjiFeAEWAcY2YlQWm9NbLxDhHpgd8syl8ZMmKPZ5zjwkMUvCjzhcAs3wwjcGmwzhhM7beMXYJl5+vfqZnq9RbJ78s2ONynDMWJU/KiB3D6S0rOCgQxo3/Yt2UhcHn31GehmlvnQmOhgq4RYedeCV26xWlrR/sNRyUU9AfJhlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779600; c=relaxed/simple;
	bh=OfJV7ysemj6p2rjQ8sec9r5QeNdvqjFHDf9fx2msjzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbKYuFarmIuTHr2nJMVPfEajrQNekmBaTIbTNy6a/UVsSACjU5756BTAY030ekrPWgYGxC8HibRXhIH/fCUY8VXZR/2vXuDc879/8xwgalwcrgUnaKqbcwoqE9gX42d8BGDcNVUPnmGnDKE0FSMeMNM4xW04HlUfB/E2Qdi7TTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vHwlmFvp; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vHwlmFvp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7DvOd8FokKvvsSQHdazU0cnO+NbD9fzKaFKOkwMXIEBZtcg/yOOiyuN6V3jeubbQjM9VKApXZTo5e0gRe9B4//cRS03xPbL1ZvKciSbyoTLEGlVcp8Ox6+w2moVhe0Z/BxApRPGNcgJqcwgkP93qRl2s0ti7t93tALA/3xdoPwuC4FLFqHBwRma6uYWShYlH6b+qzQBLEz6f0l6nDtzPsE92cb7f5KHCTMX6WO/B5UlIdFFwtELJKy/XhAT96v3Iv1+/+pS3Yh0X7orxb5DTi7II7gOfq3wpluwES3oxtd58o2NVm5dBQFrXk1srwCKfwDXafuvYTFH9fylXGaTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAb+J8xAoGWBu+6q7nCTxhzwP/jOk2d0RQtkWo3m304=;
 b=mLeITqB7dalI9cM3eQoy2VKcpvflC0lsbhMEdnRBYFGAmyBnnnFn/QlEraQHCcfQZhvznR5jPG07jiOtH/TQwPUxBqxzc9Vn8YJyqwSJJaP7Dv45qDcvhJPDY16EGC3wGx2CcwTjVsLpNgRr5IjWQBnIpH9+8SHmhLkUyMPd3KMu/4gXVhvrZuzDiiD1+agBPA0fMxS1Q5y2eRB7uqztAopV1pYJf9wSJQ64ze3SzscHffGgQSUB/OgBVK1QeCsalhwIDt+9ccsnMWAtYHx3psI17SfFvleQEC/lEL3tlT1nvky2z2Ho9v/plpG3BziIK43dh8uXVk0iUpVGKpS+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAb+J8xAoGWBu+6q7nCTxhzwP/jOk2d0RQtkWo3m304=;
 b=vHwlmFvpOnD4/WNB9yaRlzZxCh7gkSXZ9yQ6Hhojzzd/QLLf+grN6uOe59fvCBadQlsIUPKHFLAAsdgfdcx/yy2XSCAIoeDv0OifOQ6Y0sYrlBEV5pVh8nAo8q1LeB2NFwORtu4jDc19IA7psT8YQxirz1Rfiq0/d/aN9EfDdTc=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:53:10 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::27) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Mon, 3
 Aug 2026 17:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:53:10 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:53:07 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 4/5] HID: amd_sfh: Register tablet-mode auxiliary device
Date: Mon, 3 Aug 2026 23:22:29 +0530
Message-ID: <20260803175230.3839752-5-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a3dce1-b604-40f5-9560-08def18814f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+TA8Hqk+gNaoHWZKBzPSZTzpb/awWHRlhGxMlk20djfgqJX2VZBjZCh+2vwIOqmIY/yoSdoyNpTwueuMsY6x6HNgl0h0mNFnShbGbUpopekcG4n4dyLZUKhaDaApiBeX168gr0EBBKqY5SHYd7r0Oiv+1w9Dm9N+6l96yXQWElBeFR8TxcIqZMIFH3VYtX5Tv1lRIx6z+aPirBmSIMnsyMEYyCAUNNycwbuRQBC3Ejg1NvNzJ9ZMXHHuzpX58MII4944aFrvDmU+7d4DOCmw+3490ChFEveLApcADsigxoRUhzHyOMR1YFwjmwQNiaOI7cz9MT+SyI8Zk0Yo7hEV1HdtjmyGulvNbeBkEgSbGDiBfs4hzEfU/QHoLIjJ9OTSIB56oPvteT9YsQd+hvaOEtlATTPJhlZkXrx1G03J1zpYP2bAZgxR9Ni4kDCG5pPNju445tA0T+fpBtLPXG5d8+51oQGCx28r0irBDoZMo2GI+tgPHjA1PuvjOJ9w4D7PCR57HFtuq2TeHSsvwikOCaK+maZCcH94tzr25ypSOg/tHeC5bhVBn2iBA6m37iVRgMHKRm+bPU1Blg2boargxUxpmRfXNbBLHKaKew1KD/WRCHO6CPzs6MkB2y4EqZYIc/DeaIVjACrxpM46VsdDmtOXPq5+Y3QAH1hyFAWqBd/4fou2ppyNWFXemNKr3ZY6xxrR/x2s8LHOi6zUiGy9lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c/dYJF0acgIE+oOwQOnq+OYzrxVpTMbEcQmmZWufwwgNG4m3+q9uZtq4kpqCSmKdtV5h+iSQxeqYV7/Gum0+tV2iATZjGiEuXJdE46ZUuo/8CsrBVUnlVqT3HPuPkl8qHJvcmaXKOWpOoxzJGpotWzip1apCXdLpetcSId1bab66vlUkJ7Cn4gQdns3HtSBSXtht9WGXDZ+3zAkdLZJgm3pHbMe0ocVvDpfb5GZQTA/GkGhLJw40ASChDMKD9ZOAXuZJY0YMEBp+9mRezUtfn9b72e02ghjT/b8aL+82SxuB+XOtYM1UcbXwlNjxQSPBgBDrHeBTlPxgboRiIf/cKBzw5xRLAdAJHnBaNW/ws0hamxgdQnTCpzvKrM4inyfvi4Dky9iSkD8hV14ZHEZ1v4weL71gR2T10MmgBA5i1OAcsFX2NBZN1yppmXm6Rde/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:53:10.2046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a3dce1-b604-40f5-9560-08def18814f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

Register an auxiliary device when the operating-mode sensor is present,
so a dedicated input driver can bind to it and report the device
posture. This keeps the input handling out of the sensor transport
driver.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/Kconfig          |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_common.h |  2 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 50 ++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

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
index 4b1cd260410d..1405167aa369 100644
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
@@ -389,6 +391,51 @@ static const struct attribute_group *amd_sfh_groups[] = {
 	NULL,
 };
 
+static DEFINE_IDA(sfh_tm_ida);
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
+}
+
+static void amd_sfh_unregister_tm(struct amd_mp2_dev *mp2)
+{
+	int id;
+
+	if (!mp2->tm_auxdev)
+		return;
+
+	id = mp2->tm_auxdev->id;
+	auxiliary_device_destroy(mp2->tm_auxdev);
+	mp2->tm_auxdev = NULL;
+	ida_free(&sfh_tm_ida, id);
+}
+
 static void sfh1_1_init_work(struct work_struct *work)
 {
 	struct amd_mp2_dev *mp2 = container_of(work, struct amd_mp2_dev, work);
@@ -405,6 +452,7 @@ static void sfh1_1_init_work(struct work_struct *work)
 	if (rc)
 		dev_warn(&mp2->pdev->dev, "failed to update sysfs group\n");
 
+	amd_sfh_maybe_register_tm(mp2);
 }
 
 static void sfh_init_work(struct work_struct *work)
@@ -424,6 +472,7 @@ static void sfh_init_work(struct work_struct *work)
 	sfh_set_emp2(mp2);
 	amd_sfh_clear_intr(mp2);
 	mp2->init_done = 1;
+	amd_sfh_maybe_register_tm(mp2);
 }
 
 static void amd_sfh_remove(struct pci_dev *pdev)
@@ -431,6 +480,7 @@ static void amd_sfh_remove(struct pci_dev *pdev)
 	struct amd_mp2_dev *mp2 = pci_get_drvdata(pdev);
 
 	flush_work(&mp2->work);
+	amd_sfh_unregister_tm(mp2);
 	if (mp2->init_done)
 		mp2->mp2_ops->remove(mp2);
 }
-- 
2.34.1

