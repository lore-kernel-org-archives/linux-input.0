Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA93F12CE
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655894; cv=fail; b=H2FV5s7lvso6+dX8GHDp+LckHhCEMkhLz+u60VGjZpIuBxAtj8aSLyP50FoV+9X32m1d79qekdoaJpVuQZlzr0Nw0Zqhtk3wG/i3hkFy8A9Q/gQ6ztsH0b/4MYQJsEM9+1+hNTtXUmfTDaO6B2X1j6tBncHwB8ffF1QSvsjjm6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655894; c=relaxed/simple;
	bh=7ACGPH5I6cnG+cNhw+Rlq7gcOJg58ukZKHFGdUffXQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgn/WRXfOJznZRJeIm3x1OigWxDOUi9thI+ODHUWZ836TReRTmVpyRnH7Lc/bqC1XPSAjShWL8TQ2H6N7NPwXT2lRq4dbhlephK33lR+iK6jzI7nRP9/hcR5U8Pjov1yTkt9GjQgboK5fFQs+4+el5snDfKlC8CZGRo4zBjMGkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KeqoYZ0o; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KeqoYZ0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdNiCWvXfDFTMmQpyPwTcAkGF2nBKY6o93TpTiAc3E/EccpZXtFNZhxl6g8kxm9pjHGUJQGaMHh9HwK3Evxz0E0ds7DI7qF/SaCVGoB8cyALufsYK0Xsa30MP6MntJivw24qmXNg4xl23WL/ljSAV2nDBGPbWm/vBvsb9MJcFLDKeMVi/ic+wqwJkkK+PuVsd/Pna2bNgCI1rG2izMTcr1JGUYstUGrpC860fpTFX9GztzV6O04dzxEmVDZKHCQgUcAxFBBSriFdbMZ/TXcKHJ9WM08OzSkBXVMTjgvtZUNLiSz5eftsxhTOurX88h5hIFS9ICWNAMjVuLyTpqbuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCeobUDcbfskVtECydUrgmUuzfAwRPmJtYEcOGBpeaw=;
 b=CdQfKHh2kQ52RS04TnJpc/Z9GWrB0lcF83sCy8GgxKE+SK6EErVtZfmJbYi4+Ph71EyHnhqNZlmWpsO8Fr3rD92inKxUiLhUhK9Ru3Xl4Kws3sJPanqYvPHmXtfNp0MqSlg+yepsBE36a1YF9JdVgTt8AI75f/YmcRhl8ybTL7faDLRm6qmlOlSa14JNSOQ5b81dSaLYQabicp/rtxVHbqz0ulWSr8toNhzgroyXvoSlNU91Bi1YZVucH/IzDpZFa0LTS60/qLnAEGJzv21u8Z2sSoQsbmgYZpN0Fx5WVtvVtdp1LImHwBrPmPAFgVaior2dN45E40gvIAeQnuaTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCeobUDcbfskVtECydUrgmUuzfAwRPmJtYEcOGBpeaw=;
 b=KeqoYZ0osH6N9j1386BAMY6PlhtIl/c2aqmJ8ELbKVAFyHLcxPsR1I8SxyzM3ItD+qVbDTYMH7WXOpy9VO2gEUcTxp5ufmWqbLww8PN4pVXQEK6PxPlBG+XyeVMCMZeNbWmnUP+p8h9CpbC0ww4xAImNt4cIaOHMjxIs+k0stRg=
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by PHXPR12MB999256.namprd12.prod.outlook.com (2603:10b6:510:3ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 17:44:50 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::64) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:44:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 12:44:48 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH 2/3] HID: amd_sfh: Register tablet-mode auxiliary device
Date: Tue, 21 Jul 2026 23:14:21 +0530
Message-ID: <20260721174422.3109166-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PHXPR12MB999256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7dc395-0eb1-4b8d-a58d-08dee74fc3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	NF+yWvFs7OrlgRFiFL4IhYuaOhtk3Ga8pjeDQiXY3PK1fdB2xUV7BYsZdgjmftvhupfivYxkDlOwkPXQHfnGnacHF+Qs2Z1EYkwR3Q17m5zBGwvItAgoY0uTwBGCDTU03HJbW55xJqtC0022r3feWs6oTnycEO3+gmow2wQ8s3wVVo7bu3zNj34SbfUdneOLGKURg2QB2rhtLryF7JGGMW/mJQ1FXfaEo1LNtzLwaHgs/cL7/AD9ldcBGOvBRwHErBn4yjh1Yq24h1GX2JnJbmnWYtqsm1ZY9z5tzsGk6EHLsggQ0HrNLdWONsSpC3IXGVUEz2Yc+PuvmMyOIpeRk6p/UOdjVw6pDMc8R28Dq9I8SzUuvyVAwzvIGXY6a21snzJLd+EqdZg4Nb012189nihYK0SApi4j/Y2Ft8m55MfYKw/4DLBBa9WJTt65OsA4NNA+iarxIkWalM0jbi6ABba0nNopx808Fn6SKMJsh7bQXcsPuRoDVcFI/S8eh618JIOrSP3cNH2JkAJoitiT47l64r7MVEfsWyWFEVli4PKm+NrVYw8d8e2jUxHorYWV9PAQcbp5zAv6ccW2Yl8w3vKZNh9ydbwfymZFMjWZFxhqMI5CBP0eGHdOFMQYep6ytFzop1yGhfP79at8dk/4HjWpNnW0m3xdSrbBOQ/aUypur5Bk2AKqrvxxF8aVTLOK+jhft300dwhPKf3km6a+2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	USd/ZIUTPcJ7bB8zvOOz7+r7RRHMHmbvSiqn12X5XAU5PMx94tHyFVmB5YnSBYxyiGa4ljRXJMjMd83unfhedZNEvEsKqDYxwPeFJVJYGcFLs9KjyMd5Uy2xh6jwevfFvRjj75LZfcf5djAmtaiLpqQ5/tUZdVFcfYa/Llo+qU9wRuCrvnmx/HCDTnmwlR5qSm/B9RVtLsERevIgSu/KPSmMr3VeQukeF8Jj5MpZ8WO4ottHgsNOWdy7pGvuqkPVLLi/YfS48qLSd9JAy7qAZFaN+BVxeqFQpBeArjmvdjBktG+/fQjICgf/JecnX1HPIa63X1nwBeyZapv6q0VbQ97UEpBzZAji9rvJCS4B/K2ma3zr1aHOvGg7HYxHhWcwoNH4WC69IjWOzZUrEza6ZmbUQEY+OO4iLikvNWkQ6irzB1SsLYMezZLvuh4gf75b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:44:50.4438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7dc395-0eb1-4b8d-a58d-08dee74fc3b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999256

Register an auxiliary device when the operating-mode sensor is present,
so a dedicated input driver can bind to it and report the device
posture. This keeps the input handling out of the sensor transport
driver.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/Kconfig          |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_common.h |  2 ++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 30 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

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
index cad7d5f8fd4d..34270ad95cf0 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -10,6 +10,7 @@
 #ifndef AMD_SFH_COMMON_H
 #define AMD_SFH_COMMON_H
 
+#include <linux/auxiliary_bus.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include "amd_sfh_hid.h"
@@ -64,6 +65,7 @@ struct amd_mp2_dev {
 	struct mutex lock;
 	u8 init_done;
 	u8 rver;
+	struct auxiliary_device *tm_auxdev;
 };
 
 struct amd_mp2_ops {
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index a3672a9302c5..826fd762514f 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -8,6 +8,7 @@
  *	    Basavaraj Natikar <Basavaraj.Natikar@amd.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/devm-helpers.h>
@@ -391,6 +392,32 @@ static const struct attribute_group *amd_sfh_groups[] = {
 	NULL,
 };
 
+static void amd_sfh_maybe_register_tm(struct amd_mp2_dev *mp2)
+{
+	bool present;
+
+	if (mp2->tm_auxdev)
+		return;
+
+	present = mp2->sfh1_1_ops ? mp2->dev_en.is_sra_present
+				  : amd_sfh_op_idx_enabled(mp2);
+	if (!present)
+		return;
+
+	mp2->tm_auxdev = auxiliary_device_create(&mp2->pdev->dev, KBUILD_MODNAME,
+						 "tabletmode", NULL, 0);
+	if (!mp2->tm_auxdev)
+		dev_warn(&mp2->pdev->dev, "tabletmode auxdev create failed\n");
+}
+
+static void amd_sfh_unregister_tm(struct amd_mp2_dev *mp2)
+{
+	if (mp2->tm_auxdev) {
+		auxiliary_device_destroy(mp2->tm_auxdev);
+		mp2->tm_auxdev = NULL;
+	}
+}
+
 static void sfh1_1_init_work(struct work_struct *work)
 {
 	struct amd_mp2_dev *mp2 = container_of(work, struct amd_mp2_dev, work);
@@ -407,6 +434,7 @@ static void sfh1_1_init_work(struct work_struct *work)
 	if (rc)
 		dev_warn(&mp2->pdev->dev, "failed to update sysfs group\n");
 
+	amd_sfh_maybe_register_tm(mp2);
 }
 
 static void sfh_init_work(struct work_struct *work)
@@ -425,6 +453,7 @@ static void sfh_init_work(struct work_struct *work)
 
 	amd_sfh_clear_intr(mp2);
 	mp2->init_done = 1;
+	amd_sfh_maybe_register_tm(mp2);
 }
 
 static void amd_sfh_remove(struct pci_dev *pdev)
@@ -432,6 +461,7 @@ static void amd_sfh_remove(struct pci_dev *pdev)
 	struct amd_mp2_dev *mp2 = pci_get_drvdata(pdev);
 
 	flush_work(&mp2->work);
+	amd_sfh_unregister_tm(mp2);
 	if (mp2->init_done)
 		mp2->mp2_ops->remove(mp2);
 }
-- 
2.34.1

