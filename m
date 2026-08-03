Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900E2836F
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769123; cv=fail; b=Nv6g9dUcdMnQXcigw6nwey+rSNUJvgXq19XTTjfNJNMG07eo9lUHHp8ODtvikOv4hDLL8Vc51QFSv2DobuY5sI07Jk28ky8xtbdGfYS2j9Fo+lqUEg50DcaNeKC9Z1xF+qFHq/hQTg7I7y1218f5dYbRRQbleRwcNCXC00heYpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769123; c=relaxed/simple;
	bh=EBjHeeFnaJNn5UtbOx7fRtjyjiwzhZEKERW07Q3R4Yo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQJZQlSuM2ynXeEwGKNiUYczTTvVOpAUMezaPfVXoVJmolq9gwt1JCaeoyOZxGk61eBm5G1KTR5REgVlC6lKOVI7MFjevtQAwvPMIXb/MluvR60WD1hf8gFH8JAWl1tvRBjH3BzV8VgnOFXxIeIef6I6/B6eec4oyUr+mzTbQOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CAscxmhC; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CAscxmhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok5re03hvtz8KvxagGx6ZS1D1zojQd524VaHBxFXZapD9t2dZsaW4kyWhlSpt4ArNSQSgGdWfqCN9vE8gyEaQnUpT0khLLu7+17+IrVmLj2mMhhhh18hU56pkf7MoZNyuttkzXDNJcPf6yeiIAXl3dnBr1hXsrrGPgHExYNqodP7QzRCU0zeTUWAMoEToWCHKK/BQQxEgomJCbd5/9IPeyQuh/dHfMpDSBfxZypFwHarq2VnpD1+blSHMQNX0HdgFfoG31DOmowRYHmvOAijXaKyAS0wFxK9jfMq2KTJpe/VlnG+IzcBd6j/8d01S6/vkQBr1ON+0acEPwGGq3iAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCLHv9VrLNe0JYwB6swLusqRf4HL0i/RvxFQPNdqHqk=;
 b=auH4oFDOCNTQ7CGP0gMm3nkiWM23lGN38aqntG8LG/xVuLx+SVg8Fs27/xPCkFIgMHq1+H0OdEm+lSaJTkaQFdgaM8athtJsIrS9fRjnPj6Tb+SB4JK8LXzZbWv2OMCi7qdCbcoxQS4nUPM0iloNfS19QUwtCEqw0OODBiQ5LrvzNUSbXezjpC5ZSaTHXgDIF3rOWZoPHUSjkwi6QkBFm5v7xvqsvKFoo3lcXUIN82SSTm/67gmNJvCGm7aACNc42xlD5BQMqdsF8O1SgtqcYAOa4GAiAdWsf90HwRixD4Qvc3fqgET93QJGW8drrvFpR155ZvTdm01wgjcs+YiPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCLHv9VrLNe0JYwB6swLusqRf4HL0i/RvxFQPNdqHqk=;
 b=CAscxmhCaLkAUW6SV5TNsX3bhTK+jmZ+pGzV5owm6gk7ikAb1T1uELtRCx0QLmjuOTbuwtNVbZU78MmgAHZRRmenkI5ZTAHA8BcGj6t0KV8eU/Dv7+hEjRX198FFB6bbK6V0lnHpTiQOiYp/eoazewsU0wvtB4eGqpNk30tJEE4=
Received: from CH2PR07CA0056.namprd07.prod.outlook.com (2603:10b6:610:5b::30)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:58:34 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::45) by CH2PR07CA0056.outlook.office365.com
 (2603:10b6:610:5b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:58:33 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:58:31 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 0/5] Add SW_TABLET_MODE support for AMD SFH convertibles
Date: Mon, 3 Aug 2026 20:27:56 +0530
Message-ID: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: c51bcff6-9c4a-4f59-8f6a-08def16fb085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IWnH+5g/NKU6aL25+bjm0BMonObUGCobeLjhgQls6N+sjchh4miZiSh4h6B2CBLPMAuy6msrVheJnb5x0zGyIpcww/zx2FcsNlavdP3nABuYphsl5aBWfJKIdgL1uEHD3X2yaB/8CX44a5lWhEHBdX5mfS7CpyZwe79Dw0hIMBCoqO/AwsmqftD1EIufvQ6XaIL609TmgbhnELp6ZIrmTWRw1D90sEyNxTaiVZr9uKEiJQo6l15OD7U2GFPqNKIx8IuvxEr74EOs89naB/X+j5tHBt8tKmtaLVVVjbCN/htO107XVv/66Mp2u5Zf9OdUBjqPUqYAaqnIIA/cyRj9tFXhaB6Iqsa0GAdPCWK/QIrb/ZNGySSOQKO0hqZvIHMH6qsqTQwgLgpaGRn0LpQAGVwhWyUFWy6LOjXc1XflZwMrsvnAterCinxs/mqkQd/DmpDjw1i48HEHO91rfC8M4uSvDGDCUYE8OzVk0xbO7E/Uhcp3eZpAZ8whx7YSeWiF8/rmtncFpRzeeAoWME7jI5JTk1kUh2d4oK0PYfc61VYdDTp6AiYfaTRvnM4dfte+/LmnEnJs0m9C/fYacSQa/gyH3SEn7yrLMEj2RWQ3aKLaFxSQY6elbuPOWp8jEvFLrH57Z80IxJLJP27MCesO+KEszP28s8GgdIT+6PgLaXNSvwMc0E79TmiNETVxrcxKDQk/0XQ2EbyK0pIRlWIHyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/dywwT3DfgHW6O6SV5TfVE56XoWxWkrCVQp45ARN/Uhr+fk64HyFXZjDYbk1KgU4mPwEroRx7ri/VDG/YUNtxCg+B0cpKTh2qDJxGnj5HDZoRYzb9wSCnjh1YLVIF4nQk32SN8QEBrznYGx2oS+5jpWH3JG/g78KgD7YLPKjxyIQc4s68yVLAAATJ78r10UqKe+J/7Lb0eSpVyW+lSwh5aF/A3BTZMiYFjnYbazgLd9zO08qylRmTqxmpE1jP9sls4yLXrgXF3/dy7XbUh6ZM1ZOBzsidDBNImJdukgTSc3MQndyQxszwEh5xmfuW4F/d8Ala9v2leou5N+MnwOZox4lGcwHTfoy2wDU8R/F4lCkXYlfnKXy8NU+pGPpAzaoKygstsALaIw5EW/efVCbc23Rs5KvsmKn6yeYgahjTSF7gLvgP0DP1SPRaog7c6aL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:58:33.7854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51bcff6-9c4a-4f59-8f6a-08def16fb085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

Add SW_TABLET_MODE support for AMD convertibles whose operating mode
(laptop or tablet) is reported by the Sensor Fusion Hub.

Patches 1 and 2 are preparation: the first tracks the MP2 version
explicitly and the second serializes access to the shared emp2 pointer.
The third adds a way to read the operating mode. The fourth registers an
auxiliary device when the sensor is present, and the fifth is a small
input driver that binds to it and reports the posture to userspace.
Keeping the input handling in its own driver avoids pulling input/evdev
into the sensor transport driver.

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
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 61 +++++++++++++-
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 39 +++++++++
 .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  1 -
 drivers/input/misc/Kconfig                    | 15 ++++
 drivers/input/misc/Makefile                   |  1 +
 drivers/input/misc/amd_sfh_tabletmode.c       | 81 +++++++++++++++++++
 include/linux/amd-pmf-io.h                    | 14 ++++
 11 files changed, 238 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/misc/amd_sfh_tabletmode.c

-- 
2.34.1

