Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077D30E0D5;
	Thu, 10 Sep 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059814; cv=fail; b=SylI9q5B1cfjnT27bhjQmAo/Zv/CPKHSqB/qXtnwhPOkHEtcSLEsGqqnV+a6ORb+q8C7GochY8bXKfvnKfRMDJsz6NJ7yWEiBgIOP/70sdUc1h5x9rFQiqJ9t6cX9/eSHuIeBOHtCZxEbkH28A97LZQb7Cc2ZqfkM4oAMPDqmSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059814; c=relaxed/simple;
	bh=PvU3swJcmuXHKbQi1dzPwW4sfeYFJskaBq9yzF/QWiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xgl6yQ1mP5l8Fri5KucY1xYsii3rd6qiHERj6PKfzEqzUPau8pHrMpHabwp8Um4HfTayEr1HQOcvOXBKCFj5J+ZYJ3fTwcVDZfP0vfDSnDG5dR7SBfsEdN+uSAYvr8mm68Ab1Vkd/yLLsYKmr/sedgERBF62w9gHjCvlyYR0X3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SOCMH0EF; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOCMH0EF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdczc96jJ7YxBjT8XNCnHzZ62xTpyudhfL7XCmfDOV6xsePdzNXjf49HSemdFQyCSmrxCHtkoZrCNWnJI7mxg4G6wQcOtN7pItnDbbtloMFjlBAM2VxUDJJdGKMjHyRc4JEEThgqlmj8dzDb5jEdarKqhZW0cZQpQv0rpual9Nc0L3/eziFJ4yYudEnPYapUSgHXkLedteKs7e+1J6Ijlc6NJbmhGPW5V4tKFoqm0JEMfQjDWKnegcsFbwSVVFl/kW2htvIPyh7vamYjHBDZxd/cKyxDfeCESJUficeSqlDwXkS/lZF4kkUdl+8usrr5dGVQBviaZ+CixM9ePV7iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoFl+yEPjOtiOZj0jJPNVHMhBjxOfEhSkc6eZlC6kyc=;
 b=dwOknPw2GT+pWAo1RfYBb9iXgUCdhwTF2sGyeqbzcxq/kMTxuXJiC0wmjfhp8P+4bwN3BBlnWfaVAhboaGwzPGKm9RHQ159ymg2GsmbMgdFZ/xvhy/fhRQStKUnOMQcRKzQQtHK2NIka7/fxsarvVjCvS/rNkNxoS+4ax18cNCtLv83NhT4Jqta7aBD6UF8tE0t4uw30D3eRH+HwI7r0E9c3Z8LuSji3FTaS+N50Bya9qJneN1M1j36lpGtmLYyMXn4YtE/Zn78R67i+kBDfvpFnOtWhmzWskWgst9F3zMWiKyzvELLIvsjY/tDMtKu8QGujvmBK5xnQA5iXZVEtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoFl+yEPjOtiOZj0jJPNVHMhBjxOfEhSkc6eZlC6kyc=;
 b=SOCMH0EFTZgTZi4kp5wiFhg34B55DT/WMICqWZPcnZJnyAAWhGD6749E6NAdKESLIz+6UieSrpxGQq+yHwzTrCNy8afUGFqKhWYOsWCxy1GSTgpzzdVgOP8CFmQf/l0Faf+S9orVVZMxLlUBPXS3eZt40Ll8u68gLZrgkHyAfg8=
Received: from CH0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:610:11a::24)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 17:03:13 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::17) by CH0PR03CA0350.outlook.office365.com
 (2603:10b6:610:11a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 17:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 17:03:13 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 12:03:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pierre-Loup Griffais <pgriffais@valvesoftware.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER"
	<linux-input@vger.kernel.org>, "open list:USB SUBSYSTEM"
	<linux-usb@vger.kernel.org>, Curtis Vogt <curtis.vogt@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Add 'hid-valve-index' reset driver
Date: Thu, 10 Sep 2026 12:02:51 -0500
Message-ID: <20260910170254.833871-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e8255e-3ae0-451f-9ed0-08df0f5d6698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	toqErvMT495gTotCbcP6jMFtPYNkpJ4AcO2IGs8gFczrjCoY0MbYs2pBIgWZoW6f4T5+vwDh53jPHd8hZVk/wGlvHdBkKElBfm2oZQ2BIJuCovj+6NEdKbUgx8FgIjPuIDxyWFxOxxRZ6awz1mu5cYhWHuw08j2Df6+yB0LEEI8xqyVtKTz7Meh/HCKJqXzbZUPwwdFrSw62gWiTgYsEsi4gpWCiCsDr2AOLnIYC8IfLtoDWd4aWuHmOEjEXOJaD40KdbRxxbzJ3HK1SA2s9Qn2wQpgBvlZtQzkLcPS6GLmbb9+5x7QurYmStbod4Zo5xmkJWPvgnSJjRQ+/a/eerGAvpTWF73/aCYLca9W9u0E4/IF0WwL4VFN10X5HiaBSRwa+tNg7p5CqRPYRfv0OwKZ3jyJ7IjsrtkOWJu4pOHaCIjqZpHZK0EJVku8XY70Vin/dlmj4lZvgiwJvKS6NWGgelfKR+F4goIb0PLFP19asF3fjyL8WEkmc9T6vZHbYIvsQADglXPW5tu1DuIeVz0L2lepS7n/1pYOEiImCrfSf1Z4376AVqT8fwxTFexjL2baSllZmEmQgdSy3btnu95UtFeuo/nobPsPRvong+h1S/VgvV3JWsiRMg4yDVeXlZd7XqVdX9/KYVWO0Gtk06IZ3eK7lCT1poT4T0DzEPqqjow19+yMcQwXTqxscAkiwqGSIpaQbam19GomB5xVZxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KKKWboDqz2Fbcu0t+8m0aAIeIRlSZXvkRPMaKlq7uMRe2D6oJo7QN9gu3m9lKUiPsxAmKf2XVPp2NT1NY3GDT2g+LyfT24v7jdw7rSk0LzYeB8EZcs0xQ9eLW7BzNw09twJYKMUougvxuBSFKbx9Fk/N9+R/FkngzlTs8ir2XNBS5w/lm17jjJznDdip0POt0if0/xZ6ni7bWyKTUl9n7d5hwejKu41jArB097TTZHNfDG5tvXcz8pnXI4f2cy4EJuozOrumx3obJbq9P0X671PGofjmKowxMNbJ21m2znTlDPSnRSil+yehi1t3oeHrz2gIZaj0FSXNkqFoc278hlxvLoDpjhLrK623so9J0gGuawX+sE3H/DEiU5/XhsK8g5z9hqpH1cajaTwQGeAKQAP6NFiFlgtPrAHGrMbwmkiqq2X0UC9WOPj4QuFCEpkw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:03:13.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e8255e-3ae0-451f-9ed0-08df0f5d6698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

The Valve Index has a problem that when the DP link is torn down
(such as a power state transition) the device stops responding to EDID
requests the next time it goes up.  Either manually resetting the device
or hotplugging it brings it back to normal behavior.

Introduce a driver that during a power state transition will reset the
device.  This helps most cases, but if the system crashes the device
can still be in a bad state.  So also export a sysfs file that userspace
could potentially use to trigger a reset on demand while in this circumstance.
Curtis Vogt (1):
  USB: quirks: Ignore remote wakeup from the Valve Index breakout box
    hub

Mario Limonciello (2):
  HID: Add shutdown callback for device drivers
  HID: valve-index: Reboot headset on system power transitions

 .../ABI/testing/sysfs-driver-hid-valve-index  |  12 ++
 drivers/hid/Kconfig                           |  11 ++
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-core.c                        |  13 ++
 drivers/hid/hid-ids.h                         |   1 +
 drivers/hid/hid-valve-index.c                 | 142 ++++++++++++++++++
 drivers/usb/core/quirks.c                     |   4 +
 include/linux/hid.h                           |   2 +
 8 files changed, 186 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-valve-index
 create mode 100644 drivers/hid/hid-valve-index.c

-- 
2.43.0

