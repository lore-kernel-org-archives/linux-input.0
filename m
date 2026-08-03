Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023F427F84
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779591; cv=fail; b=WGGgEhHBw0Fpm/+irtX0f2A5LrIzVNawvtsbOZPVxl8CpL/Ut+/kHHlswS9PCwtwop06cxpokQbXMn5DaIf+pR+WtWj7yFCzQLWTSfPfjWx3eFdTLguHefWdKUja27xZKfmM1gZmjva4Bvb1Vj1Ifw2K9eb3xTDgMig8DjoDLTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779591; c=relaxed/simple;
	bh=zdy2u3GrJDW/bxalnq6YfYdLnmfE/E2xLEoNggY+lPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCeTOTeWh9RxgOozibOf+BnQ/9EbB19iYf2PdFgchxeP/+aJVD/GN+pzm74EywqVSqxqfGyZL6IExgxCfJfiLT4C8V0mVYsHe7D17G1wWs2KtiPt00ng+5SmqutQARak6Na9vv3aRkej8B+TEFDxCx0H7s6XaAZPBlAxl0TMDoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gdx2HRdR; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gdx2HRdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvG6h20yCNrlWwxErCvFQLZ8BNyEXzAf92CLX1ONCFvCobM2g+6lc5IEka9N2Y5DiS003WEPVq1M7kCWeOlfSmYPFJRApDXJiV1mSb+l1tWO87DJ3VAe0rnKZHQzrNFwlJeX3hweneRufPRWLmo8zL0iANX4tvzWa9sAbYCTxJ7gdq9krj1jYBDm/rOj112bMMDpzu0FZHn+HYnOIDAlZQQutvFYbZ5U9/gqVcJ4AQ3x1Z2jnmk7azIyQsm3rXVeFYGfDzrMzyHKmCgU/8EKbH3vWw0WsHXvM5WPMNXcXe1NoSW4nwRjC4mMI3MfQ/vpnlv9a9aZce4/gA71t8h+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpajeRF344hEdprRCxOJ6AxYrpagNIYYiV5+lsLZt84=;
 b=SbctPH2ZdWzyFh3DmpSu5OnBu8BiVr+VOwAJoKJs3sfxD/Mm903a16rt2I5WeEKrsDN/wu5YHEcqJNE+4GcI5JtRVY5Eta3AhPaET3CUJByI5fWb/PU6QyBRiaPjVTVuHOD9MwI/bUrn0J/ErjIuHYcQXIc8yP51cOjfUmSwQHBS+44RJa5WMrPiYaEN6MO/wWAMXSxnpOuz3Pf9c7OMx6oyO6bd4cFqDDwbf7BSkPBS9ciRyW/EiBC4WijFRmAb36P6Zm8A1h8/PUacQXfp7cuz3u8GQK9ro9RAmIySBFtsxtx2ix6z7txSOQ2wH0VeyK0zkGH3sfsJiz/sJP8UeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpajeRF344hEdprRCxOJ6AxYrpagNIYYiV5+lsLZt84=;
 b=gdx2HRdRjx5wAvMMQ8ZyZpx3Vt7WGx1OZWraLx51B2ahn3MTSfxg2SZ9S4Xg0heQZ89KN+JiGbKNHPlOwkzt/j4XP8OX7MrSO30zvr7RO3YNcUX4IG2E5aaZ0ZkOP65zSHbAME5153MXxEeoii8yO7+rMtCtSfY4A9hr3Op4Vps=
Received: from DS7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::12) by
 DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Mon, 3 Aug 2026 17:53:01 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:8:259:cafe::56) by DS7P220CA0078.outlook.office365.com
 (2603:10b6:8:259::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 17:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:53:01 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:52:59 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 0/5] Add SW_TABLET_MODE support for AMD SFH convertibles
Date: Mon, 3 Aug 2026 23:22:25 +0530
Message-ID: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: baf97583-55b7-4a51-de23-08def1880fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|13003099007|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	S/uQ/iS4lz5mT0ACszSj6ajIA+c22LtgtaVCOLNt4nytD+i8Ee3qW/KcuzubuSBmp6L/DrANm+0Ze6WY23QHMPHt9em2l1h8gZzj3CPb4oGoHE76EbgYWoKzm9Qox0M/9vpkKzjQJ+Y1uO3rDadFogf2UtNFDYp2hKP0/Q20pFBDo/Twr+xw8W6i4Nv4dd+9qJBrXOM7nOI74Lu7gMrXe+lyExs/2/dIUb/aVseo5Vd5D16NYsE+0iX8bCB5oncitAHBFPIEN0tA0ryJkKiTCZO5SJ6/WhCYWApyMzY9l9p0avc6zP2boSWN1JVEQe6iRFQmo54m5jAtIPU1fI6ESsk+dutyTB9oRe3J3or0g1e4Lsma2V1zlPq1LpEto4QNVKO/5RnX2Gt8upd9m/fCJWoqX1ODe4chcdbfM1nvnznJZIBTXRy3YN48CGIWRy76A37FtHCZD4Z1Mq+P2TftO3C/mr6kju0tpKUJ01kX7ivJSEyx15UNxHpK1olFBMTojF1VijqdAIsM0oDzetAdZMVGP+oRVawNtClMy7g7A2EkF2ND1CbWPgPb4qAi+50DUXX3J8F4lV9YSm4KjIqq5RnMMUrbj98CBb+HiHkwMDJ6aV5frun+GcTLiz2z7QG6SDvRzJ4rBip3QaT3t8GvCEaf9MN7nzZWn+dy1C7G0eEtwPXxVvULW9NXBict4RmbFbOGcqmB/T8GriHyKvhNEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DSHxmUJe2qpAg5Z/ojxEx26o854cfFgXC3JRdHLRC0Z1ZVk3TlnrmcKE+OFLXUpG1Ux+45bfTasGkRZIji5YT22VmjIZk3wXb8Ehgy9wvCT8Q36kDezEL5ZnGSm5oDmEWOOUo/9tpZ+Gv42qdKNgr+R4j/Z8YryPhfkc6BEsNzD8vL05FJj6vXXVM80CwLbLTp8Mugvk77IwZcYStWppD2Id9BVjVb3cxY3X4eOBcfnYEe5KF01+dOsygm+whacP0ehQp+FmYQOnjl8lkfKnRRp5WHaPn65tN82ZB1dRxuWaGTOIb7/XGl0mCpIaileH5JEgSJu1JBmpB4/wp2+iqNm6Pgl029aykPvAllp0ES7MmLxc0Odski2VYKiLJJuyzqmUJ1t7feZrHsRjefyiPSg1XXH91p6cn89tCYwdaJZ0IF8a2g/BXf/NVN5GQSVS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:53:01.4912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf97583-55b7-4a51-de23-08def1880fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550

Add SW_TABLET_MODE support for AMD convertibles whose operating mode
(laptop or tablet) is reported by the Sensor Fusion Hub.

Patches 1 and 2 are preparation: the first tracks the MP2 version
explicitly and the second serializes access to the shared emp2 pointer.
The third adds a way to read the operating mode. The fourth registers an
auxiliary device when the sensor is present, and the fifth is a small
input driver that binds to it and reports the posture to userspace.
Keeping the input handling in its own driver avoids pulling input/evdev
into the sensor transport driver.

Changes in v3:
- Destroy the tablet-mode auxiliary device before the hardware teardown
  in .remove(), instead of from a devres action that runs afterwards,
  closing a use-after-teardown window (Sashiko review).
- Move the Makefile entry to its correct alphabetical position
  (Dmitry Torokhov).

Changes in v2 (address the Sashiko review of v1):
- Read the operating-mode register only on confirmed MP2 v2, by tracking
  the MP2 version explicitly. On v1.0 that register overlaps the 64-bit
  DMA address programmed through C2P, so the earlier unconditional read
  could return DMA bits instead of the operating mode.
- Serialize the shared emp2 pointer and all exported readers under a
  mutex, so a concurrent unbind can no longer free the device while a
  reader is still dereferencing it.
- Publish emp2 only after initialization has populated the client data,
  and clear it early on the MP2 v2 remove path instead of from a
  prematurely registered devres action; this removes both the
  publish-before-init data race and the unconditional global clear on a
  probe failure.
- Destroy the tablet-mode auxiliary device and release its id on removal,
  and allocate the id dynamically so multiple instances cannot collide.
- Report the initial tablet-mode state before registering the input
  device, so userspace never observes a stale default posture.
- Rename the error variable from 'rc' to 'error' to follow the
  input-subsystem convention.

v2: https://lore.kernel.org/all/20260803145801.3801862-1-Basavaraj.Natikar@amd.com/
v1: https://lore.kernel.org/all/20260721174422.3109166-1-Basavaraj.Natikar@amd.com/

Basavaraj Natikar (5):
  HID: amd_sfh: Track MP2 version explicitly
  HID: amd_sfh: Serialize access to the shared emp2 pointer
  HID: amd_sfh: Add accessor to read the operating-mode sensor
  HID: amd_sfh: Register tablet-mode auxiliary device
  Input: misc: Add AMD SFH tablet-mode switch driver

 MAINTAINERS                                   |  1 +
 drivers/hid/amd-sfh-hid/Kconfig               |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c      | 16 ++++
 drivers/hid/amd-sfh-hid/amd_sfh_common.h      | 13 +++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 63 ++++++++++++++-
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 39 +++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 -
 drivers/input/misc/Kconfig                    | 15 ++++
 drivers/input/misc/Makefile                   |  1 +
 drivers/input/misc/amd_sfh_tabletmode.c       | 81 +++++++++++++++++++
 include/linux/amd-pmf-io.h                    | 14 ++++
 11 files changed, 240 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/misc/amd_sfh_tabletmode.c

-- 
2.34.1

