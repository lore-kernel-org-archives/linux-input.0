Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4064A091F
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356723; cv=fail; b=Fi7AEPUB1z3Wo6uqlemmOl1LdIkQ4uyZV5t/cdkq0Fu8rL0/gllm9KZtgqFguKwy+GdCTuei0mRJv2k/Bk8tjilDwRAnVJSEyC5VEgUbDWFF87VfBe8d65+ksqODsc0HQIHrzc5wugirYWCgBUgNLQNYIKtqED4D4cqefWJByyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356723; c=relaxed/simple;
	bh=NrHH9A8ewGVzI75O+czF0h7AX2H7pUKQvcBPb0pDcQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/EK98O4judxKjl9C0Y1RdwA32lxVhGNLLBwcTTOMONc/98Rm6tvRW80z9DMgN5qbz6DcbxSYElPniWYum1cV6A24YxT4s8UndN3+hO99SVyzKNw0oTJV1OFWclEN8EPVQfwVuTOfanYxD3bNMRae8MhP1/d61LDOMlgoXWTm04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HH8J0I5/; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HH8J0I5/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmfdi14jJbWTme6ahanPJfd+1WSok5IOuEhXMr0kCjTxm2aidA7e1su9S1TrI5VxNoUy5/oBLDqpU/45njcHMk63Pd/JgMT6+qhRpSX/hVVe9j/kPenPFQa7Cqy62Fqr3Je4DLk+tPGjTyzgUXh37rwRtGwKcuvBjg8kkgvSmtt0Q4zOUcXoysQebkXxVZLDJQ7aU/A77N1HxzSLtPLfyaQ5it6HRvHmiBDecqtz8PxOc7hA5Xvcz+kvnjSPmrVjs9KEaJ8BA08H+5Aj2nkuI6nzhDF4ngCCI6TriIwsC7esKHtC3E+e+6S03xBevWSVp/Ddo1LzBQfWF/GO3ljwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIqZHpaVULd486TvZFPNh/Zgp/wDbRukgqQTOzNtWsQ=;
 b=TtQtPfEA0PuSQ1Vq1KjIPiA5GPJ6PUGuvH/uy5iW5fahbI4CjiMh40y02dL3NAZRo9+ADnOoxoBERfl6dMdDQ1dkFXVNlV22FYzbP5QcrDoQKJdqeX7qB6ja/socUbTgYtjWDuordWTRvovYtKvtI9k5dzGqsu87L8T2IlQYJn1E6KgvOxGvlJ4cpi1eQOAQc/zwDyQ9LyGIOvGCMjtC8pici+RvucQm/hsGs4IHux0WOFcTs45Cp78UXrd+3Veg8oP+JHjoA9apGHIZMZJTIffetebo6Lji2GFleQI/R0k22opmZs0jcbIhaXvbvkd5J/CL2uO1GRiizlIXeyC5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIqZHpaVULd486TvZFPNh/Zgp/wDbRukgqQTOzNtWsQ=;
 b=HH8J0I5/fC0ylwOqFPdJzTNq368H5HHeoNVdR5H8+NIQZQTdsjc8YTxx1vg+sX6qQPSFE7RuqJDUZ0JszBffvXj/4yoZ+qZAxuwq9x2X0/uN6NRY+YkObbb4OYWGvqIgeqvLUZg36XeTcwHtEcYd5AU7PGeBvKQfcfni3rFpwDM=
Received: from CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::29)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Wed, 2 Sep
 2026 13:45:11 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::95) by CH5P222CA0018.outlook.office365.com
 (2603:10b6:610:1ee::29) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 08:44:50 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Guruvendra Punugupati
	<Guruvendra.Punugupati@amd.com>
Subject: [PATCH 2/4] HID: amd_sfh: Add support for newer AMD SoCs
Date: Wed, 2 Sep 2026 19:14:29 +0530
Message-ID: <20260902134431.3146117-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 682b4a12-43e9-47ec-c21f-08df08f868d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E+qT/1BvBzChh8DhFY5AoZ9Hqxr8WIBxa+5xh0T4Q49r/KnthuySAiYHka10IANk6kE+8FR/2a4se9RqNg4LhUqDPHbyupADvaIybj5XdbRVsGzhw+yhaxWbyN/1OsUhnOQLmYt3Ir7/Qss5xoaX+pQD9w4kKhsCDDs7DKlMqJ2nJb6kHKPo6bFDsZnZzv0kRI4k42NB0VgQvvS1ZLnOcjioo3HdaEJj6IgR7V58o0jPH3fU3aI2UG0zujFr8YH2cGoZB9PwIAU+sItecCncZYQNlE9eGTy8EyJUcyxnbP4GLPLitlBO+uiH9JxI4L57dmPWtqu4UXPG8XU97pg8o+kGUETRZo/6uQfsP50ZjzxvvObn9v9XKFZKUVeT+ph50PNQCPcXRClYJjFU4+g4GVEGP3anqHTkMl0Rw/71bra5SCuWXxsbPNrEsccVOGb3jE6VXawXjadMN+J8qph0QV+1rJZJHXc5xNc5QVfr9qRmPiviLGD1CYtMLAINJWUNXsgFaZKQwuUKZ52fXn9gygbZ+3EuOOyOW2WS6udvYe+JSC67+7wxgjBRD6iDpvTnEABx4c3IGESsEtQv+Ja7yL3/1mTpPiVvGo6JAasg4+dUlI9qXFvJ7KvgglmM73nkfwRtpSCYsirdwF0UB+tuijlgxUpnwfvK1aVY50AYH9ut4LSriuxw9oigyuLAWP5ED/7YCx5KnYo0IZyKxdhgbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UnsDAK40UbA81JLOWQizoEUX7qq+fbyPaujarhuSzF4hPZgtUkxCDukqukELvE3DyYr3UbUAOWRNAPy1v05keBbJXaavPW09/QSYm6nUD1jnJ4ZYV3tTp5QbCtcgdoN7/S7Hs9csB/T2ixsMbxJ33YZ8cMalrM4rlxzgP0lBHEj7H/MoyLomzfcihHv+HA0StE+4fmbqqKSse4ffHF77Neffy1e6kMDO32DSIvUsYWuW/xdU382k8PH6XVpuwhjxzrvkRnpq4/Q5wrVssldsNekyhAu+fMDJcS67/inuOvCbJs3p2R89LFVhie5fwKXr23xWk17e6Na7JxKPml2QGSUTuL2EqK3BGeCSSfo/kDawUZpz8MNAZKqmKxDJDJdLYhtfe3eIFGgz6nL8sY5o/8jinYwh7vNo7MDp+XFYxNMME4oh84pjXDjnMmK80RN+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:45:11.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682b4a12-43e9-47ec-c21f-08df08f868d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

Add PCI device ID 0x1152 for AMD Sensor Fusion Hub on newer AMD
SoCs. MP2 1.2 shares the same initialization and operations as
MP2 1.1.

Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h | 2 ++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index f8c6b7fc34fb..a455bb30fc47 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -17,6 +17,7 @@
 
 #define PCI_DEVICE_ID_AMD_MP2		0x15E4
 #define PCI_DEVICE_ID_AMD_MP2_1_1	0x164A
+#define PCI_DEVICE_ID_AMD_MP2_1_2	0x1152
 
 #define AMD_C2P_MSG(regno) (0x10500 + ((regno) * 4))
 #define AMD_P2C_MSG(regno) (0x10680 + ((regno) * 4))
@@ -39,6 +40,7 @@ enum cmd_id {
 enum amd_mp2_version {
 	MP2_VER_V2 = 1,
 	MP2_VER_1_1 = 2,
+	MP2_VER_1_2 = 3,
 };
 
 struct amd_mp2_sensor_info {
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 92486f25460b..fe4b00227eca 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -597,6 +597,7 @@ static SIMPLE_DEV_PM_OPS(amd_mp2_pm_ops, amd_mp2_pci_suspend,
 static const struct pci_device_id amd_mp2_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MP2) },
 	{ PCI_DEVICE_DATA(AMD, MP2_1_1, MP2_VER_1_1) },
+	{ PCI_DEVICE_DATA(AMD, MP2_1_2, MP2_VER_1_2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, amd_mp2_pci_tbl);
-- 
2.34.1

