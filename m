Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A209247291
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129615; cv=fail; b=Wy7WRDbKTXvk+GBHoMzDmfYuAuVff9EGVqzDO6wRJkq1pFAaq2aSoogJKKy4jGvjuw7MKh0qhx9Ej0e+SKzxHwmrtGsknW1kr5cLeZuV5e6t7WJpqGqLNZK3EPqsdyFROsREvgYBUStTrlcuqSo072/2mtHZyU/9/m8MMZceTYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129615; c=relaxed/simple;
	bh=4tmd8BPWHCtfoPLimmBQ6HCag84fRqxf+jK1drSwf0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GNCqA9L1eKanPwcJvutUPj8Kbbl7zSfm7FKyl/YJ2BAl721zbk603ynPCTeN2uSgK0Kxk/e0VTWOS7zsB+9DUbqQorD75CQvPfGLx0W3KKN2wqPr/SXfxn1IZzk5zf1BTcpANSBU2b5ZilQIQ9MDtxRYeRkjzAqWID0pR7Y1+NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=au1AE9yd; arc=fail smtp.client-ip=52.101.52.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="au1AE9yd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R92qOiQnKlfd5eJLTfgtHVzxv74mq5nqemA+J0EE7ScvGO6NvpWR6yI0KX/pD169pjLo9TJDqHMbGrU6vrzadf2p0YtUqqj0PieN82AUL5k1RtY0HJd3f84vHgsU6a/+o9Ctf5CazmfFDq/dHB6bFQem0Ua1/iIV3xCmQu8YPn0g++MVWkBAlYQ35LF8GfAK9kNiftE75QfIxwewvMH8HjuU1ymq3d+3DYLA7mGvRkjW14Ol8sHOr/0kO1R8DT7C5DQmzgHJ2zUTsbUbfWAJyYN6LurKcye0rmfhyO2bDIhO1esUm+JMzfwi3y2stq4cQ6xZ6Gak9/kPmx/954BYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1KP7BXs5YSaRMDgY41jB3wVR7meKRi4yVSYigqFwAA=;
 b=yDv1bdKKpKaJ3bz6lCsYLGLBJtyb+dirXOMtpRcFudQfDetugFaiu47i5/pxw4U1BUDnu7vuCdGTMngUlfxRaiZCJkodM/rEheHcuxWXY1PO1TxFShYIKcKraofOjAtSFJGTTQPJTyEBncAqKivpWfI7zV1kFw/jvL5Z5MyI2vau2NrWUTtg15nqBJqtLyRNfzwmVx9+Yz6qxrSzwfeo/I13GSGUGIx7xJNeCr9hz0f9aAH5WUqiSGa1YNiZcV+w+lEd5mix8wxGMumENcBRe/jtDNo6I8HecpRyDhHfUUUYjF7O/TnMlxCcJdxc+mxjAKsRjU0I+RiNZhJf0pKgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1KP7BXs5YSaRMDgY41jB3wVR7meKRi4yVSYigqFwAA=;
 b=au1AE9yd90j7FKNdq9oVIZBkGNsnH/KxwaMBeQZIuGQRV946Ahnw9rREUpGhQMs6hqnK3SW/C3Q4FebdS/iiOR6COaZU1BxBTngo3UikVtDRSbkboIYmafyWxLzXfOR0+hkUjUI30YwSuTqVkNYDgG4mIvflDLOBBeI2PnD7QRg=
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by CH9PR12MB070576.namprd12.prod.outlook.com (2603:10b6:610:353::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 16:00:09 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::76) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 16:00:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 16:00:09 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 11:00:05 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH -next 0/3] HID: amd_sfh: operating-mode telemetry sysfs and accel report fix
Date: Sun, 4 Oct 2026 21:29:16 +0530
Message-ID: <20261004155919.726226-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|CH9PR12MB070576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1364b855-698b-4ec1-dd9c-08df223090bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	74z7+Cpd+4xJEyCcZD0s76tMfWzxMGbhHXQBpQus9QVRHGtvjhjAhasu5qXKJqJegf5Cm2OTey1pJ53SSRA1aU05Av6K4apPO4li7dr0wSq3RHofKltDiDEsjHQ7SQiYGTl/Di6WWX8JQcS4OM1vYP1rZ1ZWooeFsVtv12+B8O3i73I5MSV1V5TA1Ges5igMhAWMZY//HUjgf0Cye3qBv+El45KnlV+qABdyhrtSODRKsyOIDvmoutW4+0epmpAgW3Z42gY751gwE2aqC38g7WSqDyVBAgFDWw/G6sj/Ai/NSpVM/RfZBM5LhGxWmC6gPr8LU894NbFTPEuD01kTmb/MOozLOFow+puw6aj8p/WogGJslvyR1xVR/A6mAs3BkePRiCDCX28ojkUZL6xECdd6AZUlUNlo/TBOu+dZauGtVyxTnM9dAs0PTJ8/h9/0RiMpRYQS+MBHxKYOWGFqZiAhPwtpyNvIyRMlGkzv9aVZNf4Awa9xTFzhBrA4SNNRKPkcgSopFlibVs9n49smI3wItcNWIKf+2xBWdy8aYCwGv9kr/IdqhzHTMK9Px8kH7YNuIhyvSAHBqryXwK5ly88mquQfJrvoy1IGZga9/i/kGJKZWmAVacVOqQpfMY9hjahVQfTPYdCYBYGFlRpvo4P0wQ+SpIiZFPXpWLW2brkgq4EhqfC2oyBluwkLrdKfNRj58eU8Rdv3WNrrjzngUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X8H3gRQ2jqCI8oc94TezxKj+j50idPCvnZHghG9CoxCzoCFHZ6COaj+VcFpG2ZCOCenSe7kvQ0TSH13kAAZ+OttTSOww3aHmE6Ee/5DOA48XqL9OR7GPCMMcLkf2KE5dGOY5Q8a+zVYHwfdcGhSJw5sDUoM2ZoHLJZsrZ0gM6dLprB0OxypEPWfgiihgOXfaV+5Jo0SrjT+XaeXTKawj4lpuUHh9wPg6eRVTC/HccxFImAnd8WLVHDAd3GXO69tNLW3s85w6f4RFOvr/SfZxwtsKNPT3o3O7sN7WlQHvGGtYKHIZjrYIAdGQZDnfEjrqVgTDy8qWKenu5+/AaAvJDkevP57sLdQaPD+hUlBWSsz9wmUD4kX2GZI4XGnwlZ9xqyKfEOMwur1lIPe9yapBOgO8M2qw2AhEyw4HDqCn4AAiIFx4yJA9CesPMZX1/Rhd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:00:09.1597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1364b855-698b-4ec1-dd9c-08df223090bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB070576

This series extends the amd-sfh sysfs interface with operating-mode
telemetry and fixes an accelerometer report-descriptor mismatch.

Patch 1 moves the existing sysfs attribute handling into a dedicated file
in preparation for adding more attributes (no functional change).

Patch 2 exposes the operating-mode telemetry reported by the SRA sensor
(in-bag, out-of-bag, on-table, hinge angle, lid status and device mode)
as read-only sysfs attributes.

Patch 3 removes an unsupported motion-state field from the accelerometer
HID report descriptor that the hardware never populates, which caused
hid-core to drop every accelerometer input report.

Basavaraj Natikar (3):
  HID: amd_sfh: Move sysfs attributes to a separate file
  HID: amd_sfh: Add operating-mode telemetry sysfs attributes
  HID: amd_sfh: Remove unsupported motion-state field from accelerometer
    report

 .../ABI/testing/sysfs-driver-amd-sfh          |  60 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/hid/amd-sfh-hid/Makefile              |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  55 +------
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c       | 134 ++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h       |  19 +++
 .../hid_descriptor/amd_sfh_hid_desc.h         |   2 -
 .../hid_descriptor/amd_sfh_hid_report_desc.h  |   7 -
 8 files changed, 217 insertions(+), 62 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h

-- 
2.34.1

