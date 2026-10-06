Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F0213E89
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283101; cv=fail; b=QiYA5fjBt25uPinra3UNVJUe/MeFj1AJyAequw7NvtWLBqEm4I693JnFhqW4CDAUCDNc9WVZx6VsMvp0vAbiUzn75epM3gWBqxcOKFYl7r5XDuw1J8jHJ0TzEuo29RN7i7EMq18I8SPcpiEkH02SN8zrrplerMQW5km2Jzh5v4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283101; c=relaxed/simple;
	bh=8t3JQwGu19sq+HMiLingVkDcGjSAmpfS8Ro2RHjixQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bqxCIcSCmyWvnFsFUFLn0fHSMJ8AbuuAnluZ1EW4zYMEhQ+Hp+/LHKGeU/TaRvdtDuuI9F4x7RwofZ3rVKjwVXVDffkj6gLpPAY6VrVdId0wcW25tFIgn4Js7tC56m+A7TKwWSBwaBqpQWSJmI/7HtHkofefK9n1oz0RJc4wLAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAI7oOL+; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAI7oOL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QajGVG74aUe/406/9oqc67o835vVp3hzgpHivBSWJZFNwUH6SrvVxWMNCKScyx757MkgDD5uYImIvxr5Pl0nCCelgVkZKCJeh/jmZjoSrcEB8uXiGDYF9KZzOTSh540Q1r/ILZjNNxzozWVyyyaDP3pREtRbt89n3ZGhBmlld2dXesBQwfM1oCBbLMGbv/bk+YizGgt2Uum5CPW3FsnCvMs/tw1iEtHBivSIC5neCy53rJtLUG8nREbEmfZXFaOp7aAgiCbH1e/LrIwfmi6Fs+tv/AQ+wFu/pQL6H0Z5PcL582DsqIheAzWu8DY6uT6xxMRZJZgg+fHqZyT1dCWLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvM6RgCmFHh2sBUdKsieN0Nb1imoA7JBKk4Ork6LV14=;
 b=vL3PNBurUJlaxeZw/1Y9vXCPK6gURZm/PH1kIcaL9smaO6hsv0nP7T2PVVM8G8LDAEaoswj1q3lK+lkcQImztnXI64Xo6WKVn8ewrcBEwGWVC9U8SuPPebldaZEOlUfKZCZR65b+IrTnzkYBYemnXX4SZFzh33oWdANo5f/PyrmoZzVbfzBEOV4p+eZ88XV6BKRBnG8Iotl5gbWfD688LKW13lTjgluLpJEp7I7f31mVuw+MorXGdP5QgpTJu91NnlSN9yFMFhcRQBZ7X9+qFl2fVT986X+dlfscGu7rAXBFgMvNJJ+Ntuh5TltuiVxwjJtDWUI3VjMofxcqJADuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvM6RgCmFHh2sBUdKsieN0Nb1imoA7JBKk4Ork6LV14=;
 b=WAI7oOL+vRZqlP5gDDl0qWa2caLJnyQl/QntzNZabjFj4LQnKLQCxcwBW9SoTKXiSdmZ0Z7D60EvjfzGDQgK5f+PDRO9q6dZV4pugbe9FImBwk6QMR2k8nTYTqAgoKusuGBcGlwrc+E32SpJo3twI3fxAfzHGU/wCScYluvRZWk=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 10:38:17 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::8c) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 10:38:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 10:38:17 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 05:38:14 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH -next v2 0/4] HID: amd_sfh: operating-mode telemetry sysfs and report fixes
Date: Tue, 6 Oct 2026 16:07:50 +0530
Message-ID: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: a25c05d7-926a-4d9b-f635-08df2395eeb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	g2sBeuDHmhky5ySai7551/x7UEqp2U0fEByHZiCa+n/xNtUOK78cYUtr3BMz8GFXRXkaC8uoAeFGHprgCzlRjy/wOCnMTL8m5dUrHwZHE16pMNDeontC1r9wvEl7t4JKFiqIj3q842noDum26fkoUPcLh3n3zzuAryTUOhLupalgEUtvFkekMQcD964wGAfVGeAuJa6H9sIy/w5/Ct/tqRwDgJ8uQ5b2rFIlu6AGGc9EzRY7AaEJHX3g13VQMyAJjm3aN4GEHqgCymoX/fwfyy37w1sM6S5hrP95Ngo/+9MaYLtm3eYGkAL27JLdYYCleSlQaKFkwdyvh30DS7CKIE/h8DWnYKDg1hKBUPgSFJZAMKmLeSdhAY5zX8T86XsH0JAp+NkQItmuVGOioXX+PqhBN3SUMSv6WnP+ZYCiIjA7mgYq9/yab2MQh37Y/ghDQRQKmkC406nzUD+qpMdn7IsHoKp3GZCICR7w9LnQ9V11MAupM+DdS6Q6juF4iBiybPk5zV23TeTjIHGuaq+K285CV36DoubkulX+xMWItCdJ4F3nWd9SyJuW2MrbzX3J1bAu67lNJhY7ED2nov7aOGa+gc056V/cwBMKPv3OB+PyZHWUKBiXpMI/1sEyeo8N+LmTZwkLvTpJfDMbcAoNs4d77FWKHK5mCcf1li7pHUWmxJehsAvMEp6Ec8shBc9fDwSes1l9rAN9HXB/BET4Ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5k75pVJQuB1WxRL/oHpvn2eMCbnh021BmDJqPhp9TiSgJ7tMsLMmGhu4t7/9jWevWqN6BG4SBB/BgTc6y/lnnfBKfadaUJcY3PGA2sif6MgKiNeoNf4YuiP28GrnRSRTcemNee5DjWmAji2ntCJpUtybHMsUy0kba4Ohhbwqw3Ez0qV43enUyLcVWaYTn7olcBt+siKQjB9CyQjuRJ9z/MH7hzDTdSxpM+Vur3cU+vGvbtOP5f3w5KgnQ0eFgnmmgwYQe1NeGsOScoIfanx4UeOpQxmyKdAxISrFlfYKwfEViNINaoEZnZMzhF5jraB6mpeTbHF6FyXqnPLSD41KKS2VfmQa2dhDGwUBsK92DPiv2kEvC/L65dn/eAbNPq9TQ7nL4X7yhcCNXBlf3eOS0M2N8lI+UbHOMmkO8yxoWmLDIoUDyd6VwbDBBga39LMD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:38:17.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c05d7-926a-4d9b-f635-08df2395eeb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

This series extends the amd-sfh sysfs interface with operating-mode
telemetry and fixes two HID report handling issues.

Patch 1 moves the existing sysfs attribute handling into a dedicated file
in preparation for adding more attributes (no functional change).

Patch 2 exposes the operating-mode telemetry reported by the SRA sensor
(in-bag, out-of-bag, on-table, hinge angle, lid status and device mode)
as read-only sysfs attributes.

Patch 3 removes an unsupported motion-state field from the accelerometer
HID report descriptor that the hardware never populates, which caused
hid-core to drop every accelerometer input report.

Patch 4 passes the requested report type to HID core. This prevents ALS
feature reports from being parsed as input reports and fixes the
"Event data for report 4 was too short (18 vs 14)" warning.

Changes in v2:
- Add a fix for feature reports being sent to HID core as input reports.


Basavaraj Natikar (4):
  HID: amd_sfh: Move sysfs attributes to a separate file
  HID: amd_sfh: Add operating-mode telemetry sysfs attributes
  HID: amd_sfh: Remove unsupported motion-state field from accelerometer
    report
  HID: amd_sfh: Use report type from request node

 .../ABI/testing/sysfs-driver-amd-sfh          |  60 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/hid/amd-sfh-hid/Makefile              |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      |   4 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  55 +------
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c       | 134 ++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h       |  19 +++
 .../hid_descriptor/amd_sfh_hid_desc.h         |   2 -
 .../hid_descriptor/amd_sfh_hid_report_desc.h  |   7 -
 9 files changed, 219 insertions(+), 64 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h

-- 
2.34.1

