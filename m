Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0844A0921
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356719; cv=fail; b=Bagm4vCB0KUF4Uy0iP3HZkmxZbJ9bMXFI2PSlSiX9Q8kqvlEy6uyF0zg4+DpbMA0CFcgx170oVEvD9n1MbbYB48nzvTsUUNZQzS9YWOF2+nuAPRYLQBrTLIwQYiXIvzWfE6eUXPQOHifxfBekPG1t5Mvi5E9wxy4IUzJkAjjj28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356719; c=relaxed/simple;
	bh=0d5vTXJSX2boNue8LJ3zDAIFWzQpIy+RWfp5BztQeRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6j/BQUxmtqI8p/X9xSsFFNmDBiTVoe5cIKsa7yJzNvP+5TVRs0j6e1AOk+J0KbSoxYN9q1e+KOKxhXck1SrX3pscG1BNRZD1pk7GFxkdYbbF8hX/E+4biobqtC8t6RLD8iT/ZcOwUB5pdPZT/IbUl4F5kACUZpHeEyBhUzGvnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nSiWBg70; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nSiWBg70"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUkRR5aqM9jeoP5jHC1e+IlvTKn2PuQmlpum7+P8vBhc18E0Mng/OqmCZoFNEa2DCAyKM3aPeXOianzmZJc8wxhAzKE99B7u6jh5fc9k1whEAXfHOlE75fdNNgUWQcqHn9xlS7q1mKug3k0diDAe/hSZOlhj4Dz1gOEnhbX4To8tNRyoNCOpQ7tYKWMKavYVtP/DGjFXz3XAbgVoNGUa17iGUkehPPbUL+g9IW510hSepTNfW1o/XBV1QCc/SfWJih2P9aGgOc8qkJu968iKGIaBbegzJO8hkZIeSOT2GTUQIV6Hx1bAwrqA2EvsC9Le2ZcRJ+xNvV3X3aJcDEwoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqG1XmEq7qVO293lgWItw+d3bERpdeld67eVc7cIEnU=;
 b=CxYC+61LDEb4odIh8gcAkI+Td2qiC8zFy6ztSEYQlJtYEkzpBaSlwBKsd0+Aq8fnjjGUY8DJ3cstSvuQvRNUdm8k4307M0q6ULY/szXuGbMh3zDNI3mpSJS+Utv33MAtk4VNbXb3vvmPrmt5IvuWVpZo9M4945Na0eyU9dTeS6pTqE1P9Z6gYaqtF/DllTqanHy3OQ+MF0ncfadPFwQUqwuxt19wUYd3PAHWvfV4f4zDkTq3GYBJsCuPBITt5eE6QFF9Er9Pg2MyDb9rSMcd8DGRsAIKgpYP7SKW5MX5gkW/G9ESLQdiXOuXZD5X64Dm9xj0QHv+J+jyt1sM0efwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqG1XmEq7qVO293lgWItw+d3bERpdeld67eVc7cIEnU=;
 b=nSiWBg70kTSzgMrL9LJlABOS8/Rr+kKt4oAAW9G55hQxO4bBxadzioZ2LzPNuYFgywjl6SMlL5f+qIH8nnNgNwMONxhqCrHTenDT+d+q0GJNtlllshvi1SV7ndvbRWDu849FIaYAaPHr0jphy9MXqOU7XDxr4rLt8acU/z9pO+4=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:45:11 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::14) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 08:44:52 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Guruvendra Punugupati
	<Guruvendra.Punugupati@amd.com>
Subject: [PATCH 3/4] HID: amd_sfh: Add HPD support for new AMD SOC
Date: Wed, 2 Sep 2026 19:14:30 +0530
Message-ID: <20260902134431.3146117-4-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 2469f0b0-0303-4f13-4524-08df08f868dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bLFvcZsu2Gj+lYlt9RCxMuj2AnJf3ZXvpWCsgFvVZ8dq6PuGuvsG+0Y6GWKsjKlL8gWGdIptcqA2Y09rXoGt5O6CJshDd8f8KdEoQkzMiCfzUn8MdMAKPfpkmI9/p8WtUv62LQA4bPUkDs8yYAs2k5XhTkW63sZVr4WrZKRKj3Pws4swyetm6RqBm9/vxoT25TQ6Y8gqP7V8gjZ1YC95IsgBG0zIX38lCdhz6RAOHUEavTcdty9rPzeHG6eCS6dtxA3Jv5ItODYqLMT8UC2kcnc+rkKBIHU4kuDrvI2n79bCHcOo6QKzbG0LfojSzI2F/QRqMx7rORqDRTwLHfTFDIArJxUHo0jbcUWKIaiS1YHGCBbTq6er0XAPPWSbof4lbV7UoJBkveG6iZIouuvbtMwnha1e4pD6V+WqUpRuTL+n+Wza1RY14OdJgwA1L8DEV31EjSzxu9g9Jn/PrztqUYM5PCkPFCocE6C1/miXfJx24TzIa80TPnzS+yBrrsl7UhSeua4aSoVMHPVlg1Bq2L8P+NrU7KDrHpMH6z2NEkHnK7mp5S/FVOk5eH7GzYizhPXlNh6E4TicHtaLqJgIUbcde0HQya6P3MIxqP89UUyuPokOYquzultPrEUdaqmAJCYE+rG14ZRF6n5IgDw9NfdrSIgYOzu/l0wo7tlODgD3uTXhjdKU35x9uUGnjo1la2bGvjotLrJm1AJfGxPo7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HoH7ZPrg/fwOU7AOGK/mU+MRzRTQ8qyx/rlIxa8V8R0sGZiG6OAN1/2cUMar89C9AHzSuj+vkitalAxZhU+D3qqUJJTv1qKblWDAO+s8EQKFbtx6NL43KykeykxjjPSYB+ezNQ40bF3CFPG81V+nrTMtml59X58WZrlgHsVOco1cybLjeNWUXuERvu01ult/KhLSP2sZA9v/PInEMrIQs13kKhQ2AlYibvrgdARHTTIOUfVLS6IiPc/iiQqXfQCGKzXJBL+/rKCjMgqCNQXThIG2BY6RwzC8quX125eubnqkzfdraC7p0giFo193jbAQTPigAmfuiO9OeNfnrUW3Ljvm5BIiWDGgJsB9xRiE1ZoGywd1+jlVI3B0K3nTdwaUyLBM/+cUX4swix48x63c7+YD5LhBTyXug9wZF3+b69XeClqTBpcbvvlmmgRrJhE0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:45:11.3695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2469f0b0-0303-4f13-4524-08df08f868dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

Use HPD data from DRAM instead of reading from the C2P4 register
path in latest AMD SOC.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      | 13 +++++++++++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c | 14 ++++++++++++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h |  6 ++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index c8916afefa62..b81a97dbb1b0 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -187,6 +187,7 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 	struct sfh_gyro_data gyro_data;
 	struct sfh_mag_data mag_data;
 	struct sfh_als_data als_data;
+	struct sfh_hpd_data hpd_data;
 	struct hpd_status hpdstatus;
 	struct sfh_base_info binfo;
 	void __iomem *sensoraddr;
@@ -251,8 +252,16 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
 		break;
 	case HPD_IDX:
 		get_common_inputs(&hpd_input.common_property, report_id);
-		hpdstatus.val = readl(mp2->mmio + amd_get_c2p_val(mp2, 4));
-		hpd_input.human_presence = hpdstatus.shpd.presence;
+		if (mp2->mp2_ver >= MP2_VER_1_2) {
+			sensoraddr = mp2->vsbase +
+				(HPD_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
+				OFFSET_SENSOR_DATA_DEFAULT;
+			memcpy_fromio(&hpd_data, sensoraddr, sizeof(struct sfh_hpd_data));
+			hpd_input.human_presence = hpd_data.status.shpd.presence;
+		} else {
+			hpdstatus.val = readl(mp2->mmio + amd_get_c2p_val(mp2, 4));
+			hpd_input.human_presence = hpdstatus.shpd.presence;
+		}
 		report_size = sizeof(hpd_input);
 		memcpy(input_report, &hpd_input, sizeof(hpd_input));
 		break;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 60c185a9cd50..034ec237659a 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -160,7 +160,9 @@ static int amd_sfh_mode_info(u32 *platform_type, u32 *laptop_placement)
 
 static int amd_sfh_hpd_info(u8 *user_present)
 {
+	struct sfh_hpd_data hpd_data;
 	struct hpd_status hpdstatus;
+	void __iomem *sensoraddr;
 
 	if (!user_present)
 		return -EINVAL;
@@ -168,8 +170,16 @@ static int amd_sfh_hpd_info(u8 *user_present)
 	if (!emp2 || !emp2->dev_en.is_hpd_present || !emp2->dev_en.is_hpd_enabled)
 		return -ENODEV;
 
-	hpdstatus.val = readl(emp2->mmio + amd_get_c2p_val(emp2, 4));
-	*user_present = hpdstatus.shpd.presence;
+	if (emp2->mp2_ver >= MP2_VER_1_2) {
+		sensoraddr = emp2->vsbase +
+			(HPD_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
+			OFFSET_SENSOR_DATA_DEFAULT;
+		memcpy_fromio(&hpd_data, sensoraddr, sizeof(struct sfh_hpd_data));
+		*user_present = hpd_data.status.shpd.presence;
+	} else {
+		hpdstatus.val = readl(emp2->mmio + amd_get_c2p_val(emp2, 4));
+		*user_present = hpdstatus.shpd.presence;
+	}
 
 	return 0;
 }
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index 56258c4d1b3a..11c7a86ac52e 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -165,6 +165,12 @@ struct hpd_status {
 	};
 };
 
+struct sfh_hpd_data {
+	struct sfh_common_data commondata;
+	u32 reserved;
+	struct hpd_status status;
+};
+
 struct sfh_op_mode {
 	union {
 		u32 val;
-- 
2.34.1

