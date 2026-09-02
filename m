Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28814A015B
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356720; cv=fail; b=XzkH4BU3LaB2x1g60DfmstFlLiC4u9Jv0qFpffsOhZcRXOjF958+GvPNxKRTVUNKDVk5j422D8MIctfDDY4kB4/iOct2XmPLMNfSFCHl7s5ijk3i0nUw0TqO4sgfi6iMoKcEvup5l/bwRO5pK6UrzPO8zqvO7qqs4t9yx2Q7leU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356720; c=relaxed/simple;
	bh=KZbsCUZnVBNNXeKbQFqKsoQKbxsDa5hS+/zO3nEaJ1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SOQRcDRVS9hrc1EhpFQZGTZyz5uLEAeanJhUokdO+ZGWN1xWTXpgCze4l2JpUttYE0dYR1hgq5I009/UEWdqa2kOFYwXi3PjUuK/VKwcqGHXEeC2hmSgkEWuAWtvZycHNpW0f6OcfxaSL4aE5zEzgOEYpY+PjkSHVZAtBF538jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pKaEkSIr; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pKaEkSIr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIJgdpm/nmte7EKiXKqzmQ+SildqwoSjAF2n0scIe13z3AV7HxYeZboZBLH2XsLWYjigMpXWusRei31MutBf4uEmPo7oKZ09BE5xZeNILYjrmpdVxYPACXypY6NT1kkvryQyExRmiwVdNfMs+7DnrKL8F0sH0lJ97u4Cbrea7GU83GHsSxYsP9/9TYVbOO3YC6sWoL60mvH+uO13Mo+8KwVeV3kTHsBIjt0Gr8H2wAffzXXeWOGQWqn5eKfqpgSwpbRB9vBoN4JaP6FALw90T0aas+7ILLdQMnrs8JVbCs+96y4OtzPo3uywl1Mr8a5j3gXgD8gB9fw4GgE6Xkr4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkuN7eUn01AFV8DcuLtv2LZp6y5KlH4dKJ8D0PnxuwA=;
 b=vUwrTf311Z2zELDOW2jAb+P2U3BYhBRZHn5FPVs7vgBW99T3GH3atdVaonlJ9wPEm0metiR8A1O+jpgZrj2Aq79OpbAgfdyVKSndBDnHrzn80rF5JszHJws5KCYqMyjHCZREqlkx8rzLrL/pqwsC8AOxAvwV151eN5NRhD8KlzBB69iQL2PnmT1c5y4gZhs5orAWcbJdCby/nsFMT+eHylfR/WC8VBLGZoMkhKw3I0iV1sWXRGbfrJ+mJpVNlM2rJ5u52fIIsnSYCwkXeU/yW07ZoZVDn859vWvJ5tp442BvkljPbc0NNIwj1dVcM8/TDMJUoYQhQSIgxmFhc976FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkuN7eUn01AFV8DcuLtv2LZp6y5KlH4dKJ8D0PnxuwA=;
 b=pKaEkSIreJT9s8hIywYviJOOOzJzk5K6XZKNNj3WzrGoT8JEOn271u9Ld4mO0E345uN/KCQtOX6KF5MxntZ5SmZf0/tUH2enY0p8tT2FfP3C7IL9Osg5MMtbJ/pTJgFqxOupVMlLffT3Nku5xf9GH5/X5jD02q9IZ3i5Ar80NqA=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 2 Sep
 2026 13:45:10 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3b) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:45:10 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:44:47 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/4] HID: amd_sfh: Add DMI quirk and support for new AMD SoCs
Date: Wed, 2 Sep 2026 19:14:27 +0530
Message-ID: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: f99ae9e0-a3b8-42ab-5508-08df08f8681a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|6133799003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zgLuclmxKqUAiZzpSok7q0Tb6Rdcc3J2NItECJMti+m5CdQerhuPNd6aUPiYRnl/PGdw/XgZ0QjV5dG5liqBogiFO9SKzSb58ReyR0pFj1gwv2ULe3LzPhl1cWRf5BjrFNKh592LlZKKc1vJHVqV7RdlVcv0IllHeYSup7yyKOLPD3zs9PvJPW5oeGO7pgmeRfj2FqBEb/UeTik+KgNCE1osAoeTzqcOFyqNhcOJco5IsShaA8Ic1JxJ7pnFE+s4eyj9CIBRcWtM1p/26//UBbnSg92UROUHtRePgVNBDtxOD+FKBfiDDKntjHmDZhI9iSBbrNZjKnYozhR+nmOAjmFkc0NqSWxr/c509BmgkCh+Vw9St8qUHKmX76JEAg1WL/rsXasgoGfqMJjPq8Dcqh6dCIEu4k/HWGXaEaZ+JKC6YcpFBWsrNJCNN8JybBmv/HTWFmOnnxXf10NKu0OIRmYa1SojSzv9FoRbOLErhUHrqXxWyD4+OccIt9OMa7RDLt960VHttIR5JpYiXfnlvVm/3XQJbQHupqxf+LtpiVixtXbJ1HxAHOGzEDmuhk9s1iX9CZlK4/sDqB9kw6Smo2NqX4FsjoeQ8LnJFMTpyC/om3/xr1W5SlPSsNSS7Q1On5Tg7f+NdlkOSKCS+VY1nztT9F6c6euAfOyVUZPAR/NXtd3ozLjM8b91lEDPwtLsgJ1/Z8MkH8hncLJtp0ziFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2lwIYeB4Bb3n/HIXD/vEaQC4cNuEDBesmJoZTlbXZwl9bqcEQIUFfBxOtP/7P/nfsl/aIhz/NGiWAGn5Z2dBzK1N7yd3IMEyj+WgdFui8qYpEwYd2Q0E4kAIutueXepedVNBfpSC1J85ymnDiNMmh8Mk96oxYommPqQmXqoA/zRxdt1OSNue8Cp39kdyYmZNm26QuWj8mvOt7zDfzXQlIDF5qhY2jv+O865h7TAWWgHllBhhAAlngOgfwNTM3ioLynrFTDqlJiCc06URbxjQ3AATKG8T5U1BBqsN/Ol960PHio+d3mmx4PJgm/khVVP3fN/4AxKdmL9/H5MEAweGIOLSDtQMFPWwEbXPUwfjDRguWHaooNc/zfgHYGQWCEJ6E1DN6ay1MyZW1al7X9owaJdLDcSg3r7wc6jxxl0NpWuqfjqIZHB7JL+KzNOCLpPW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:45:10.0925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99ae9e0-a3b8-42ab-5508-08df08f8681a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759

This series makes two independent improvements to the amd-sfh HID
driver: a DMI quirk for an existing platform, and Sensor Fusion Hub
(SFH) support for newer AMD SoCs (MP2 1.2).

Patch 1 exposes intr_disable as a module parameter and adds a DMI quirk
for the ASUS VivoBook TP420UA/TM420UA, which needs interrupts disabled
for correct sensor operation.

Patch 2 enables the SFH on newer SoCs by adding PCI device ID 0x1152;
MP2 1.2 reuses the MP2 1.1 initialization and operation paths.

Patches 3 and 4 switch human presence detection (HPD) and device-mode
reads to DRAM instead of the C2P registers on these newer SoCs.

Basavaraj Natikar (3):
  HID: amd_sfh: Add support for newer AMD SoCs
  HID: amd_sfh: Add HPD support for new AMD SOC
  HID: amd_sfh: Add device mode support for latest AMD SOC.

Helge Bahmann (1):
  HID: amd_sfh: Add DMI quirk and module param to disable interrupts

 drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  2 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 10 +++++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 13 ++++++-
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 37 +++++++++++++++++--
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  7 ++++
 5 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.34.1

