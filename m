Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203E30C161
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769123; cv=fail; b=rMMUOL3tpYe2IAlWLc1qN3aVJ/xZ6hx58bHdkyGsyzcqixIfmGcaaZkpFxdMdkThqGCed54EEUQUNyhLd3raY/aFe6wc75L5trPEhNE9jyFAfcvQtqngSVswO58G4ab2u+ouAWjQK3uOQlTLXLVtwU56y7A/NDxkOjUvvzADaB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769123; c=relaxed/simple;
	bh=HTgFWKVaoOOWOgE7qf3jB1Q92VfhmSnaBaAd7JWF7KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnGUbUhjiAc+NLL8Vi7KNrmvSAV3ITpP03WsT0mZof3c3C3rfwKEnBuYZPIcdimO4T+sbkoH1fzJD6vr90wabVbq9ab6F4bmiNDQBBxnp9TN5QS1+ms2aZfZP4GhT/ye0xaspy63FO+wiY3jyPgxZc2GXkgRbcJwG0IOgarpTMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g0OmY6y/; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g0OmY6y/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecIIc8XGTE2T2ikq96DkJG/1KrtI4FHo4uLu1bR039t5C03LmtSzwWeXLAd25XglLKboJR9Pf9z6TLOuedDSkKIko84k9Z6iOH7PcvA7dTj/fQ4Q+kV5CQTWBgA77PLHvzvP1GbY9OITuhDdU+biQoN45jKHPlSjHDLkfcf3bm7x21BgFxNehjqSLrAK5Vgi5jqDkos2ZSDF2swJ/asS+f7NiMT3C1EUDcq+vlwu3AfxRYQPDDFu5nteJQngBU8nFqfdgp8mk4B+w2YnIInTZ+wYx180Kb25NaH0uJnV5X5n91BycBLHR6///K5DM51uqlmGbL92JbjUHaRocDJTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc2LVpxKslCavFco8vvmVcDOdyaVTxqo3JxghfgU4NE=;
 b=Oo7JZn1dwXIm8uiHf/PnvIihNkTnwibE+YzSxTWhM/1jdSm4DiZ7SHI/bLLPKZHq40Fnqbbe35bzgMCXplF21BJ0X9gZ/ytAp5aqmmlaRR9eUyOuGY6sgYDAIRihszH9ri8wmhskTZYiSj4kXhwkWXNnUDPB4f7Fyos+FM1u/OZP6De90yZf39p+ut95w8B+1F39tNBvWImPZNgIAaH/S4W5F3vpF7ilqJf+GOeX3rWEHn7KRJH4JX2NdbTVs1jq5yXeSe71b8p+Rd3ZTcVOjPg3hMAdEMxWaJhmK410JS3/L3Q3MRCwfXP5PP3s/6kbBpB3bGnnc6/1haB7IBC/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc2LVpxKslCavFco8vvmVcDOdyaVTxqo3JxghfgU4NE=;
 b=g0OmY6y/tIrEahSfl5bq6QQBL1v9ly2TDS+LRaeKYt3ET/9JrkltK/xRZvoXXhyd65uNd2zHpK8br6bA/CRnV6HTxTN29KPuyZzdPh0DLmBme2D+bUABfIJd/rk9rwqcFLBQq2qpPZW1AWhiE/bYqGJudiOLYmHbtytfwsSuF+8=
Received: from CH5P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::22)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:58:36 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::8b) by CH5P221CA0003.outlook.office365.com
 (2603:10b6:610:1f2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:58:35 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:58:33 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 1/5] HID: amd_sfh: Track MP2 version explicitly
Date: Mon, 3 Aug 2026 20:27:57 +0530
Message-ID: <20260803145801.3801862-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 648cc3cc-cdda-4d10-6efb-08def16fb1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QqZv/3s3vPtpxXjEDfLWNACMnX7Q51AVPqDw6kYGFprM61U3JjMtdkBTsJoYZ16p8MdlUWoRcgquDxtRhaKWO4nqy+I+fRvQXNVeJv9mz++WcpSEZx3ttOIaQFefKFK244B2Uy2T7C8Wl7NGS7G12YbrzFJl5L6FJaLlW0wLetm0Qw08NFEU+lkNJuL6slLxfl/FxXCKzSvQbcPeyUXUZDnENmMsm1LQFS0nz1kTH0ZsaW2SuQTbagHP1/dfBKN5A8sNYgJXICrUE/jOsOUoKnpGvm+Jy3WOpvx/AeoqhYEvKq2amXx9aKJU0/4WmdEPta9nDC65u3s/ARc/eTfLBJRU81WL5fnV9sMQMq3GPwviqQIyhoDSoCbuAMs4/6qmjHxDS+1x6241cRGSjwUEeJcY08RbeyrySB3St954PKAN+KHeHQAotnA3BrBcYbVsfEs+wUC185Mp0FztELd05zsCSxJ+mrcgK98f3GtHxkieOLAR4nVJUZNg5Wel/tadAIsqbEtTUpuofrkJufzfkhF34Q4xlS7ThI3Af6ctBuQ7e7w3co2YosaApzhL6NtwMkr3kBTJ/r2wVxCEqf6/1aY7lX5CVlYqb4XuLUqE8NwJVcyJlook73sLrBbYu0wVqyzTUtyXab+aG9R0ap2wr+Vo8KYOHKsRwSbUnnuZlxa0z5EYnfxSmuRGdaWVCPgSYzTWdFy9/OHNCooxW5PiJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6J3SzwBK/Sdjm2sbPifN7tBnS65UMSI6oLbKucawoyTxq+a5VRj/pva6rS49l4seS5b1L6gaO+XpDkIRDaDGaI3Qt74/H3mR6KCMqWAZ7syKfBUNggIM/7tBOVRWjwn1mn9iA89HMyAQDefXZBCNd1gZK8CPje0R5OL25kFW+KgtFeBh7/NGXDnD4ivJFRrPoXYtsMBWuDKzAa7KVnKMojTKOTpoeDjW+UaG9PKGQGs9KOdnoxcn4EL7RIl8N9/HEn2JCcPUhW8QsqZZKa4iWyWkudyTO9ojcFMLNk8FlKQZ6ojDbTjpveH8TJhiAwY+62W6icx/D1P7X1ZxXSHMygEQ9gu6815y2sdVJbDdRqV6kmCRLe6IfywSnxYgClYZoIXxles8LNGBma6vxM6r1E6JRHKZwdn88U3Xc0gIvPXlpoMMEXQa6mo33Dk3Oc4F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:58:35.8152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648cc3cc-cdda-4d10-6efb-08def16fb1bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32

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

