Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8494248DC
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779595; cv=fail; b=mHnEmm9ryUA9+xTQ62qnLHHRnTj3sj9X38J7mqsK9ltff4P10f5nanr3MGAFSyR2rZrgExIGKDrjJqCpNcfaHPQ8f79dqWZq94Itk0/t5OTA7royNO8u41TXAkD/iUb4773ctGjS/DKx7bvSO6RmPn5eF3wwK+krrWsvLKqU6XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779595; c=relaxed/simple;
	bh=HTgFWKVaoOOWOgE7qf3jB1Q92VfhmSnaBaAd7JWF7KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OA46VgtpocuHONSE+wdRYO2aDVBIZqLY9mjmvfgkoi9HFjTnbkxHc2Psw0AsEsaPS8PSpOkrY+h0ZwnGTBuFxpK0WC8tcBo0WyrEN9xgM7/CdBlgEYFWaXEwF3RVcv+sff5dK7Sg7uGYiZHE86VrGaQbAl7fpNRbjFP4P+e3rJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBUe1JVt; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBUe1JVt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBhtFaFf8WlDljXf3L6cUsSA6M3Xp/4xTCGwbbjTTf6ITdXnmZj5Iw6asj/qZKysA3+SA/sT1C3V+EKU5iwLVz9TO1oRPxE2lBG0IA2wDeZCY3XgnKjF2CHXpG1lovrKYp3onooqoawuIdFvC4P4Kg7HfyLfV6JYp25887axyUd513Cz0fyVzLOMVSQXWAKr2BpMT9p0XWn3uqDKcApU08TdBUV737I+zB9Mgyizmg4+5j6gf4lAk7TpLyduhhWiS4dG7WGLvBcgynJOck0imFV5+mZ0hoFzF/UUpi4s0tdppvJTO2DgRySRCdkEpYFlrPf/JVd0l3VdnFkPVQ1z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc2LVpxKslCavFco8vvmVcDOdyaVTxqo3JxghfgU4NE=;
 b=UX89YOdInPDWa432SyYq814BXckgztpDOgwCmB6tOgXrBfaRlIxwtrc7huXTHyh2BahQWnpOilktHeh1ximOdqhfULZt82s0RNQ8dAwKl4A5akOirsftkoZLvNppQ7f8DYDDfJ+WRnAgDtnrMzwtZMjHPcQiX1w+bcnMD8/cYn5MiiVKoooX7QjRFid9FbAeXf4iR4pkb7h+Lk7LYXP46tw2nZkmKkbf0v4vPCSJjgdGN30zYhxxx66tVJMTWEUqi9LvGeRqXOVstu19Ti16bKpstZP8DYz5bLLvPRFvghg7owpjAecmMXg6eIbDsdChiJyIY2pJmtGSectnK9snSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc2LVpxKslCavFco8vvmVcDOdyaVTxqo3JxghfgU4NE=;
 b=hBUe1JVtTn8l6z2w972UedSsPau6HNWSQ2IbcZpeG5jk4HwBF6YXIPZEZKCVeird+PlBDVEgynJTmyf/WJoGON7dyM2nqR288XjIzXn8D850yvjx+OjnyLB/D3LUREi6WyBMu6QIUx1glF80dFI2vWQ497pINmXLuQnctDhvS5g=
Received: from PH8PR02CA0041.namprd02.prod.outlook.com (2603:10b6:510:2da::23)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 17:53:03 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::13) by PH8PR02CA0041.outlook.office365.com
 (2603:10b6:510:2da::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 17:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:53:03 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:53:01 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 1/5] HID: amd_sfh: Track MP2 version explicitly
Date: Mon, 3 Aug 2026 23:22:26 +0530
Message-ID: <20260803175230.3839752-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ceb1e1-1205-445a-f67b-08def18810f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5vpIkrLBmfdwgeOLriLo6D38sGHvVsgqsmXPmZVZzLjtLL018g/UY8DmB7FZlGcghrQ+7joaQrhH0d/HdXEVlMYLCDz83F9Y5tJAwWAWpvpSvh1edFBWSwK2mGhboMubFNfNN3wcI+RIhmHRoChy21R57qwb/knHIAw1BE0FAvsTKZu4O1OojN1A3lubwuM/R/rQtjoHfPOfLPWpstR21KkhSfGQ2pu2HXSibqng5OjtFLwxEmMoSO+bP/sXarR6fCo4RsUSfE/IR44tS14qtbHlxs6v0wOD077BYfzJnq7gvbWsXOvCj3vHEBIv1Ttnri7giXgkYjoQ5fEabuSKSIcH2FdecditAChBTpFZQPKa8J6lGHKZVdwTFn6nIz0izJMkRG+WXKiEytjUAr+E0lwbC4/8Vexgq3ZApjq67v/4vggc+epEq/p6J73Yg0MPuME+eNjAPZdzJnZ2y36P4ViKOQL1rU5hOQfBUY4t2RJOi38TH7qbqMNVqVo5190AhqULo+DKD/ckxqzKYZLKIPnqTIOlLqin5lEgGsnVKivPFt5I0tag4N6Q+SO1+2oGtW0lNQL7ZYJ6HBLizfcUwaiF7O5xhAyQp4Dck6ccsDVoZEoLEJ9nnbJ9Tj+yXVsq+pMmidWh0qwu/ORcrua28+2Dh3nyDMFdZpn8hup0rr0uBeOmKV84OF8i714/TtBnF1fjZ2Qh/sw717HmE7ei2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aZY6T78MKFk4/++UvKJVDvG/eBKKTlLyZlLctER2K6DHRoJoRfuz54U8tCnOHDRh1owwhtiCc5gxQScgL1An3DCuym8DIMbj/mjHS4t5R5RgtUgwfNxhgvciFDF12O/nUqU+Q0CLNp1Xh/LM3g7sAFb7M1rzyBuTIIJrbblN5NThjczNjihTe7ROKsjJPaGrCEkPXl/kAFT5Xfv5iIp384m2Ir39QL0F6v9gNwXsgEqOy2stxTbUzBcGIQyTTIoaxiiYgdUj3x6wgyy61c3rRmI58Ocsu6xNaKCQ9E5fVN2pOXpVBwgZHNbY7ryLlxoK17CHgu2RoYXuTEMUz8+VL1vFSbhpyWVeMt1hhA3IDPgS2qvGU4+1KlDcqnW7nuHkufP6PfBk4t4xuyZxmpD5PGzSxC1Uu3o/7wqu3NA50IPINGoQV5le5RxEMtLf5euS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:53:03.5217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ceb1e1-1205-445a-f67b-08def18810f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831

The MP2 version is currently known only implicitly, from whether an ops
pointer was stored in the PCI driver_data. Subsequent changes need to
act on the MP2 version directly, for example to read the operating-mode
register only on confirmed MP2 v2.

Track the MP2 version explicitly so that version-specific behaviour can
be gated on it, and leave it unset for generations that do not require
such handling.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h | 6 ++++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 9 +++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index 78f830c133e5..68586f08ab23 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -35,6 +35,11 @@ enum cmd_id {
 	STOP_ALL_SENSORS = 8,
 };
 
+enum amd_mp2_version {
+	MP2_VER_V2 = 1,
+	MP2_VER_1_1 = 2,
+};
+
 struct amd_mp2_sensor_info {
 	u8 sensor_idx;
 	u32 period;
@@ -64,6 +69,7 @@ struct amd_mp2_dev {
 	struct mutex lock;
 	u8 init_done;
 	u8 rver;
+	u8 mp2_ver;
 };
 
 struct amd_mp2_ops {
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b81cebdc335..92801ca38957 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -285,6 +285,7 @@ static void mp2_select_ops(struct amd_mp2_dev *privdata)
 	switch (acs) {
 	case V2_STATUS:
 		privdata->mp2_ops = &amd_sfh_ops_v2;
+		privdata->mp2_ver = MP2_VER_V2;
 		break;
 	default:
 		privdata->mp2_ops = &amd_sfh_ops;
@@ -471,8 +472,9 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (rc)
 		return rc;
 
-	privdata->sfh1_1_ops = (const struct amd_sfh1_1_ops *)id->driver_data;
-	if (privdata->sfh1_1_ops) {
+	privdata->mp2_ver = (enum amd_mp2_version)id->driver_data;
+	if (privdata->mp2_ver >= MP2_VER_1_1) {
+		privdata->sfh1_1_ops = &sfh1_1_ops;
 		if (boot_cpu_data.x86 >= 0x1A)
 			privdata->rver = 1;
 
@@ -540,8 +542,7 @@ static SIMPLE_DEV_PM_OPS(amd_mp2_pm_ops, amd_mp2_pci_suspend,
 
 static const struct pci_device_id amd_mp2_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2_1_1),
-	  .driver_data = (kernel_ulong_t)&sfh1_1_ops },
+	{ PCI_DEVICE_DATA(AMD, MP2_1_1, MP2_VER_1_1) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
-- 
2.34.1

