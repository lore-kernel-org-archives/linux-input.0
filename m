Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3047CA7D
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356763; cv=fail; b=tj7rEu3MH5Z3BIWgZvDRda6+eDG3pjBagL/gLpgD2rVuUBt6CSjCUeOmWhz+JgqcwqYBWkCi6UIxdA33/GQGcnXZcDHzIUQX6ikbZO+hbWoSBRBlCS9EgNYrv2SYofXC6a1k0mAhrDck0P43sz7lHET/2UCdqYaDqtS0DELRr0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356763; c=relaxed/simple;
	bh=clKWR++S9muc9Laxixb89lMo2BqQWlwp86yUIL5+KnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQrpnGKZZhou4FjYPYvCH4IpfNJmEdkG0cSAGLqz3JD3qkFTP1h9FNQlOwhJbKnTX77vRvNeIdcJwOyRF0ea2c5WXg1iC2rtHnumnu4IVMh0dOtJwn8VPPVSBdfAcoYRPZtq/UvB5zMY1EK+dt6OzOb0th8+6A1o8pFStf0AY+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ffNqO4oR; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ffNqO4oR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0dJ9AVidkozVkggbOsrk8DLkyQR8mGSolh4nCaXHEfUvy7lgtVmkXHLqMFHzXYOiiU6WpPgsQ+0GlAaIrrK8zi/hxd0LyihlBFWLv3Sm0eeVeoKraTfzTqRbcraGu2WzXy5oHeFg+pcjfUmK4SoJCXKsMMl1MRxcqw+pbQW5pubble1BSFOTMMeQqGVFRqebp+1OEmeW6WLUWSGDSg3GWohfYrfbFFO68ydj0Z9+9GtQwXe1xaBNG74q18PYWcixfn1rdcocscFl9uJhAAcOeav8sj3qyLt4u0ii77HrL+U+N5gIFWzOi4AYO7MeZT1Ua1Qo5sTVPiUUAJXIQlMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkgpeEvd/z+BEyQ8YTSk0JaPOZwpLO4mN51iS8v7H5s=;
 b=Wm7edRG3dPvHSch7OIxNgGBVIWwGL5ayfgpZ7x+w+EU7R0sDUbIRWCG50dQymGLoIooahO2nC+12kQoELClbL/VwnGlMZgGo2DVDK0BE3/0mPbEH0Z00FkApWVpBgSfJu9IXqywvQNhtwhAbgIcxW959Qr11LP9Y/heGGsLXwfILK1K+pFgBZC5D+GlvHCL77pPisVy21E67pBC/l6d5UXFK/1D8aJyYpC32UBBfyTuinE9v3nbj/DwrcqXnBKGvGDGDQuJUgVXlXSehHzJaMZ/LfKrRVy2B2QmdRJWsGdUp9M5ElzOmUtoHIWMtOWoQ2SHlZA2VUauh+9hMYhm/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkgpeEvd/z+BEyQ8YTSk0JaPOZwpLO4mN51iS8v7H5s=;
 b=ffNqO4oRBQ2ZNOH41PUbanB+8euKfkDkDRHm2UOIMdVKNIWTle09xQ1iQ2AzpGnAoJEy2DGlKrv9exLLToqmZdvdXHnHoBh0xCArqAZp++GQIeLHR+BLLfOREmHpMtH3CwqaHUU940qIV7B6USwdNS6IfCU5iD5VQNb+mnHaHt0=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:45:10 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::8) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 08:44:48 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Helge Bahmann <hcb@chaoticmind.net>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/4] HID: amd_sfh: Add DMI quirk and module param to disable interrupts
Date: Wed, 2 Sep 2026 19:14:28 +0530
Message-ID: <20260902134431.3146117-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1a52c3-d500-4f15-26cf-08df08f8682d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o9EFhw/eO7MwAx29tAeAt7jbJh6X+YEXhvVixKcqgVbUha4BGRgJqZY0cmyFdpwBMGY5Oa7xwP1VqEW/GdSUUGqHF4V9EwBF4kEvuMP84zuXU5Qf5A7jQKb6PKCHiyyu+sTjbYYkyKZW9ZV0jJ/BrVXJJXRk62C9Wg3FlpBMHvolQCPQMMcJyVMSnj5CXW0vLRLiDFBRha4JdvhaSfrUkiAmmuNP1XnievdI7R6dykG19Gly2iBGN0plY4zXXPq9SH55mMPmjVsUSpn+Bb0t4MoPEApYFJdruT21BCsKbZqjsPIOsPOCFxkAgVz3z4CxFUQHJ14NZ2JdRDx74nOcHZ49RSHpqxbpDvQ+5kIQsC7LPr4a73dt9kBXfpH3MddveOuxtCYj1yhRnp0QIbkZm119DmT7YZqKQNtDudGqG1kyZsTHoLJs3UbHv1jGR17wXoV76Ufl1gqq8dtldr+TvQlu9OqIhBeYayLOk4GNaZnbO8xnrnCI+kTZTV0Yd+AcazU2Gn6nQMBjb1TEe2nnXLQ5B9s9oqbEznGskt8t6JBdBrBE60agQ77IXqI97mMc7/pR15LGHRSmNr1cu4LVoeCvzNalSYTooZVsdzC2QTO2jTkP9BmI28/wDxq6l0m2c8zUuAPBtnVbkGKK3pwYpes+g+ONQ/HJr3lyUjwMAZlntCs+BcGg85WlQ9uHH3tay7jb26rG0OZ4iakTmYfJXA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O3BTnFcSd3hQxi1WWAz+Vvfu4UqkSMHADBkLDLOB5vI1xmQmUsEzvFdPTW6tH6DYMbWm4+0ViQJ4nxE7zggxTk/eXSqPXMVucOh+eSYrdsVgWgzemn39gR4GrpXZSosrdYfHTi9414ab1OC9Fnxngt/u2B4zOfHLslwcNB6aBwaZXQfXAT5kAoY0ixiktXxAVIBFxzoo/LQEsaAn795zboakQTVjeaUoW0yju+2x6pDQit2eI2FkXDdLFxOBZGcy8iVilquLgZlJQLYoHKm3xELqF8+8JD+XzVnWN2pRl8pReYiN9DIgYVqJ8kQbViETHCBIPw6Bgubx26nYOpc3OJSwHXdnBf2MgQ/LlTsvLOFThGx8IHF90bJbu0Ts5CI/gPxq2yurM/Fy0HDrDGjWgozDll+9ZEmTLeunTnPKmBtVwfK/6DGTrrXPx9ysyifV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:45:10.2167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1a52c3-d500-4f15-26cf-08df08f8682d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

From: Helge Bahmann <hcb@chaoticmind.net>

Expose intr_disable as a module parameter to allow runtime override.
Add DMI quirk for ASUSTeK VivoBook TP420UA/TM420UA which requires
interrupts disabled for correct sensor operation.

Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index eda26a094d3f..92486f25460b 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -41,6 +41,8 @@ module_param_named(sensor_mask, sensor_mask_override, int, 0444);
 MODULE_PARM_DESC(sensor_mask, "override the detected sensors mask");
 
 static bool intr_disable = true;
+module_param_named(intr_disable, intr_disable, bool, 0444);
+MODULE_PARM_DESC(intr_disable, "override the interrupt disable sensor bit");
 
 static int amd_sfh_wait_response_v2(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts)
 {
@@ -313,6 +315,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 435 G7"),
 		},
 	},
+	{
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420UA_TM420UA"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

