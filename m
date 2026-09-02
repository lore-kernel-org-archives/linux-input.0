Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3447CA7D
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356717; cv=fail; b=sCl3w6w8kEaF4PhnyyrvRXtqyoHIDdh9C6mRrmuDNnLrYgPT9b9swF6uWtd0WccaLEMhs9zUGhXYASdznqCB/vmKO/sW4WTSVQEokh3mR7zKB2jVxALC5MYxt45J6hv5KP78X2y52V7zttnG6Mu9FlhUJI0QGPWXXBc4H+sNbLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356717; c=relaxed/simple;
	bh=wYbQ3Cql9cMx/Ivx28M3xxOvtFYEmst/1G5GNj0fi7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRbqN5IPUgARdbGZXhKVFlZdvcqcnH2keAXKWF8k36eFvEANol6rogjyJd6HKDPkJWP6FTtoiNa5nGoygkVMAshejH2lUy+l2b5VUzbF5Y4fOXDrum3mX0/JnrYX3d0e7G/apZ9QtMdafruVe0T1DPF77Sikv3dRafgMsbZ6x+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XpGtt1IP; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XpGtt1IP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwNmd8J3meNU8K4Xd+QVBJFi3JiwGF4smGWN5LVgUarcMT6mAg9CwQp6FunLcDHWV4VO0JVBeobTGd4Ib3XSam5dZsgefHnbDx8rCPNoumLr09RrwRYm/v0QI1UmOxBFeuGO/+HkodslT5LNXDU+nHBO5jEk4KIkFEYOPraD6cuNdoSjhpnc+T4DDmXstXHj6ZVKpTigRvkpvWrJeKyK/nV1hkdqsqciVx+9mk4DIewiMDTC4T3VsGJyynOc+5WA2nLcq9wX73iK9dJKP57xKuAXEgQCB2l9g7e5P8zJG/fnwNoUfOwFEwiL2WDipjTZuCUbvr5QfO51qtP+8Xe5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQWGqWsoY5LQRy+YivVPrt/FVl5/6AQ7yfkSPDvngdE=;
 b=Okj3UYD6wMBasywCG9UNHc06+3jeE/bn6oCCwgogr5UwAlGMLgZCmnqcVoI1SN2Wn0bZSffCuhiLLKfwd2x4GUk2AM1ioaNrMSWl8+eXN+Y9FqCYsXGDZnxgoLIlN/G6fevDb9Lcbvvt0r9PJvUP8gHvmga9KaRpqDeC5GNdIEq8M5Gewk6TmD3eiQrNCllO9jeELwdFz+sJsP52WuQdqyHLBEOygJ/VRXyr//r3gKu2B36SLtIIRippPEvT+IJ5uB7PG7ciBfb+Q/E8AMZNsqWfwTzXwkY6/Wp7M5vMNUSsIM/5+Y6AQZ60B/ojAvXmnyWN3G1Hl+i9AsGldNgd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQWGqWsoY5LQRy+YivVPrt/FVl5/6AQ7yfkSPDvngdE=;
 b=XpGtt1IPmM9Xln2Z541VD8xrh32Q/EFQV4HvxKG6aBKlOIo2A2/WPf4VMzezHuY2gyRKHRWcGqPAGTw74nC5Qgy8KFV1TCWfskeEraO081eItOiCyaxkpuGfn+RLl1OsPdB5oxPcgq86rlp7edhUwTtT3Nf6xi+wBQsQj8OhxJs=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:45:12 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::58) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:45:11 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:44:54 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Guruvendra Punugupati
	<Guruvendra.Punugupati@amd.com>
Subject: [PATCH 4/4] HID: amd_sfh: Add device mode support for latest AMD SOC.
Date: Wed, 2 Sep 2026 19:14:31 +0530
Message-ID: <20260902134431.3146117-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
References: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f270c8f-f92c-4122-4314-08df08f8691e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7YbNV/iMOxJgdcHL6774lF1DXYsTlAe5fWkp6wwBc29zrFSUO31IyvN26enPm9cuPYhaRCf6HC+ywipleUEdRlp+zUO6Hlzsz9yRGKZSjEZIpMDEyZKNkQe3fA6MDW1TWR+BTg8LZrPeCFSd3E4PscvNbBQDT2fh/Ir9GVz9msgHfNYiKLB0O1GJlbn6IF0xIZH0jJ8iD5ZmEhqBf0H7a/Ha+xZxquMeoTGHDgiQQzAkrOiks/ZVKTydISJ681vrtXV7t5K6h7I6t6DX13tNSvV8ZTxN89LJhuZfHoThZdc/KQs1AO858a/R3cRMIUqvnghWQjNz1OPdyDJCTB3+8GgnmB8g3W6Tm7reQkcnLWv8Rc4crG/GJSr4K/PQvTeYfbouJmZyq5xAE0Gv3Fcv72wCIVGJ/VuTTUplRgPvrTEtqz7LijP52NRlngutekve3vB/Nydpic5g40pD0ZQWog4TlJrPJMh8ZDoz9f1ylv0EsEFfeyI5wG4CcFpIYsPMaNoSeODzPEua8pnnPTykryHr4YOgKTGmL1lnafM1kY6tZfhuzjSh5y6ag+5vutllH3vqqU/W1LNKnF3yagG8Lk8aOlXAUM1oM4Ms1rnneLrJv7bjiyrJ4kYqOfcUvs1aSJhnFRJK40Un/2r/cnHpWbHvcm788ZQoIJOzXWOldXrj8icZrjoJ/6UQMaarFa74g8M4tfMXKQxzQdU+eshFBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YCW44KaJUsmaSyKoe5Fu4TPGUYa+jWFdCTm0GD+b37R0+npN9/3vuyBwFLX1PDQYXlzHS/clhBQwy44mZmAS6JlrFOaoEP+MU2RJxFAQ/JkHyiuh01H8Xj247kz1aqHCwk+TXkFeOHa024LKTvANtzCrfVMtU+naFYJcT73mzZkOW8rGfLSqh8IlIgm2BQnvIApqPc3d/Hmx2XefvQ15ykCMej8H6AEuv4W6N5gU2LfYVdkNdK49EQkMa06peJ4Q4cv9PeqTPuCMFLO201POh0anlvLuict5s1eNar0V3Vz7Nz7PGJlB8UtQ/84hVrjgf7jW3ZG5T8qD1CQ5OHrmjy6GnOF4hMNykszVnp8AH3r437A+yzL5A6FJq7jUaSDHphfnNYffNhoSCRVlpCRMi0VpnTLp8VgeJyTDEOCKeByGrNW8MjwWMYVSEGwKK5ei
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:45:11.7969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f270c8f-f92c-4122-4314-08df08f8691e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

Use device mode data from DRAM instead of reading from the C2P
register in latest AMD SOC.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 23 +++++++++++++++++--
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 +
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 034ec237659a..bc0adb789896 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -98,6 +98,25 @@ void sfh_interface_init(struct amd_mp2_dev *mp2)
 	emp2 = mp2;
 }
 
+static unsigned int amd_sfh_read_c2p3(struct amd_mp2_dev *mp2)
+{
+	struct sfh_accel_data accel_data;
+	void __iomem *sensoraddr;
+	u32 val;
+
+	if (mp2->mp2_ver >= MP2_VER_1_2) {
+		sensoraddr = mp2->vsbase +
+			(SRA_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
+			OFFSET_SENSOR_DATA_DEFAULT;
+		memcpy_fromio(&accel_data, sensoraddr, sizeof(struct sfh_accel_data));
+		val = accel_data.c2p3_data;
+	} else {
+		val = readl(mp2->mmio + amd_get_c2p_val(mp2, 3));
+	}
+
+	return val;
+}
+
 static int amd_sfh_op_mode_info(u32 *op_mode)
 {
 	struct sfh_op_mode mode;
@@ -114,7 +133,7 @@ static int amd_sfh_op_mode_info(u32 *op_mode)
 	if (!present)
 		return -ENODEV;
 
-	mode.val = readl(emp2->mmio + amd_get_c2p_val(emp2, 3));
+	mode.val = amd_sfh_read_c2p3(emp2);
 	dev_dbg(&emp2->pdev->dev, "op-mode: %s (mode=%u)\n",
 		mode.op_mode.mode == SFH_MODE_TABLET ? "tablet" : "laptop",
 		mode.op_mode.mode);
@@ -133,7 +152,7 @@ static int amd_sfh_mode_info(u32 *platform_type, u32 *laptop_placement)
 	if (!emp2 || !emp2->dev_en.is_sra_present)
 		return -ENODEV;
 
-	mode.val = readl(emp2->mmio + amd_get_c2p_val(emp2, 3));
+	mode.val = amd_sfh_read_c2p3(emp2);
 
 	*platform_type = mode.op_mode.devicemode;
 
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 11c7a86ac52e..eaa90c689049 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -130,6 +130,7 @@ struct sfh_accel_data {
 	struct sfh_common_data commondata;
 	struct sfh_float32 acceldata;
 	u32 accelstatus;
+	u32 c2p3_data;
 };
 
 struct sfh_gyro_data {
-- 
2.34.1

