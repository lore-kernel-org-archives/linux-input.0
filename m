Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFED305680
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769134; cv=fail; b=dbfHDUUOA5l25vp6+5cy1UOqB8WCRxLh6xzrJXzAtOUGecmBcZ5siFNpjgSgF6vEOFos8kgc3M94XOtoqaXf6lDiKnntHqhWJcV3bdHwYv4UFyHnrIFiNb3GNAJQysn939CeeJPFS4BNBTvipVkyqWDIsmVdcgU9q2JfT6J0I3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769134; c=relaxed/simple;
	bh=rvjBUzPVrx5frsItOAMN0CKeRUcYnbqlh/EfRYC5y6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOoPom8g2blX+zJK1rc/iAqI+V1IUgCHuS8TrU5we2Zbt6bH+9afDv6zT0YKkQ3IpCJsn8dV4SOh1q+Qp3auPchPPNyKCaMfyUUL1OfyFUN5Qi9qfpcW/cZuEtCqdN4ZsGBAcBrHQG5RDHG15MkFOLF7ky8zzGIOROCcqqqLMU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Odr04k+s; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Odr04k+s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLUmpcyQ/YWNhOpcCZZy25D0K7LP6Oz9hu/+FdSybRc3k+y1t0d3pfCBOqEjD3QO6de7+AOW56EBEwFORDPcTgC4XIm77uTdXES1XeXi7IigYHo2yrbACK84x4vq8fOMjr6S4/dXzeXCFBnQBE+6WT+X5LI+LQVhkmTACQaoh1+iblx2K5IbjiExZ9CeZQxuI+ZzehkjTLH2hMcsf7IMgESgYpUY6RynVqJQr/qZuJT1UGB/mtrIWpn9+6SgJQXPB5gjG0hhBm1FmBzABWTwX7c5xp3BaO2YUwzpwjD0S2Xgg0fkinI20GPU0FtI57k9AZS0BOWmdiSnBgHzW8xcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya58nLtv7qkpjMlYpTnRcqHBkFsLDYT8uswYkD+wQew=;
 b=N9B0Q0ZSUguki2sbfAhL9rWPysgvDdCYNBvWBvkqAQVOzkvM4LiszaWEVSigaYQ3FLKgSBQf4H4Yz/LrcbYWKVozlsZqOkmRMd/pS3akaPjWSGZeuNkHtlCNdtEe8MUM2MeoSbWdMo066CHUGELHydRkcqjPe8NjKu3XjFeUqnvcxn2TBzssa0M0775P4aujvs/4W8fsIK9DBnvJTFMXqhT8qy/iMtTQNDZfLgY5/wAstnugcqO2l7dxUgakfGuwZZwFiRQViOgq1LsX1UuF8As0DNrHAo73tho3kkOu1T/oq1U2wz9llTYUlVzhsUMpf9RHmOuSRLAfR838o5ca5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya58nLtv7qkpjMlYpTnRcqHBkFsLDYT8uswYkD+wQew=;
 b=Odr04k+szMMWnOvsxl83lZhic5IV6LbGzerKVNEnpXKe5m7p/8lx/i/0e3WZqTs34QupovpAf+9vNAFqh0mbYA4yFdR0lbTsddGJFfDTrKauMdSFRYZBD7qHToDpWEAG+6xdxYvluNOqJns4DoazZC3VfJvCuqxquY/8AZStm7c=
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:58:45 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::73) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 14:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:58:45 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 09:58:41 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Helge Bahmann <hcb@chaoticmind.net>
Subject: [PATCH v2 5/5] Input: misc: Add AMD SFH tablet-mode switch driver
Date: Mon, 3 Aug 2026 20:28:01 +0530
Message-ID: <20260803145801.3801862-6-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
References: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: c88264bf-1014-4472-f942-08def16fb763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7fJ2mbJu+GpJuE9wYtHdc5n93EBspLvfLoTAN16run9mjubNX+MDYlJyl9Le37zdURYZUJA/hX1wx74Rvfd314RDm1VFPwfbFYQQobJQCZZ06W1vtNjo9PMNF/bEtMYkMNPbzqeBPYVfZfM7zYmSxu94r0uDhIWCYQ6kKgFba0N43m45mx3btg2MBQdQ7Nd7AdIS9T2hXj0X3AAVIdqF65jAs7jZwibkW0wEvre6zoB8reCfZyrgumbgUWGKtRdjgiEi/L3wX//0tfKW0BKdtpmdDhzF5X6iY4ijd+8LrkPQ7UtsQj+rh9S7yted0aK1/Kqo2iYn4VIGwoJZDHQgxPOfggFJHFFE9jpmHrlkg+nH6rM/GfjCsW0OUUwbKxuiM+eR5Xozg2NWZFoJ2bp8dK4Pwzak3OSt15X4jEuda4GoQUX5Xy4iQuPs4PZeLGUgvXraoLG74VZr4VBEnRntRPZkjJBozSNWzhEDe/B+gT6gLMKFewgXSBvYmKutn8+fV2hjR4npWF7NPVjxReet6rpuFlwR42usvRNSxml40Afd+j61xg5pPUR7FPNy0sR/Pewz5XjZ6XVGUirqKS3J0ZvLBNzW0WOHeAdqpfFlqvrPFqQ8rW3Uzqh+iWG3ejAbFkrGmYSBZtb6sLTZutD/8rJVFQTNxMtyMKV50wBRACijM/1zp5CBiiflYIjS/j4Bxzh/PptDwSkXFl+/vN73ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AmrMSt76JZ3B3KSuChqmNVCzryJM7u6AqFmiDbOdxwHdrgmFgP5gRtPECEsCCxIt0H1GgH4xld+MxSVSb1J5ub2LGcjCRIQSYppLWXa1gs2K1Xz72w/aEAYQ1/SiIlhGLfGG8eh0ihmj+utVa1db43ucW8/EH6kxlqTYKkKL+2FMWsKqea5psKNlegzp/98XaoiGz2feykwzip8Wppv9nOavrN0dJCI6hd+ROffz31o8kJXXPWGLHg+4TGyrr+XAmS5q/Lq8e+axNhQzLe2EKGJk+d9NGqo0QHbyTh+PmhyJhcmmGf+/dcXqmMwIDIpwBczM5iJeJS1ciPBVOm/Cbj3n3SrBG8jTztasooZ5ysl0eQTd8DZ3Id7lVloBN4zGjHgwd8JpCOKd+gRof++eetCz26n7lt3wNpnOBM6C7J5rHX+1HccRzfhmlcKgfReA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:58:45.3098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88264bf-1014-4472-f942-08def16fb763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721

Report whether an AMD convertible is in laptop or tablet mode using the
operating-mode sensor provided by the Sensor Fusion Hub, and expose it
to userspace as SW_TABLET_MODE, so userspace can react to the device
being folded into tablet posture.

Cc: Helge Bahmann <hcb@chaoticmind.net>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS                             |  1 +
 drivers/input/misc/Kconfig              | 15 +++++
 drivers/input/misc/Makefile             |  1 +
 drivers/input/misc/amd_sfh_tabletmode.c | 81 +++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 drivers/input/misc/amd_sfh_tabletmode.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..30b429eb9286 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1301,6 +1301,7 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
+F:	drivers/input/misc/amd_sfh_tabletmode.c
 
 AMD SPI DRIVER
 M:	Raju Rangoju <Raju.Rangoju@amd.com>
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1f6c57dba030..5b76be31f687 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -899,6 +899,21 @@ config INPUT_SOC_BUTTON_ARRAY
 	  To compile this driver as a module, choose M here: the
 	  module will be called soc_button_array.
 
+config INPUT_AMD_SFH_TABLETMODE
+	tristate "AMD SFH tablet-mode switch"
+	depends on AMD_SFH_HID
+	select AUXILIARY_BUS
+	help
+	  Expose SW_TABLET_MODE for AMD convertible laptops whose
+	  operation-mode sensor is provided by the AMD Sensor Fusion Hub.
+
+	  Userspace components such as systemd-logind and modern desktop
+	  environments react to SW_TABLET_MODE when the device is folded
+	  into tablet posture.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called amd_sfh_tabletmode.
+
 config INPUT_DRV260X_HAPTICS
 	tristate "TI DRV260X haptics support"
 	depends on INPUT && I2C
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 2281d6803fce..72aa0658ebb3 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
 obj-$(CONFIG_INPUT_SC27XX_VIBRA)	+= sc27xx-vibra.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
+obj-$(CONFIG_INPUT_AMD_SFH_TABLETMODE)	+= amd_sfh_tabletmode.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
diff --git a/drivers/input/misc/amd_sfh_tabletmode.c b/drivers/input/misc/amd_sfh_tabletmode.c
new file mode 100644
index 000000000000..3931a1c6eb74
--- /dev/null
+++ b/drivers/input/misc/amd_sfh_tabletmode.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD SFH tablet-mode switch driver
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+
+#include <linux/amd-pmf-io.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/pci_ids.h>
+
+#define POLL_INTERVAL_MS	200
+
+static void sfh_tm_poll(struct input_dev *input)
+{
+	struct amd_sfh_info info = {};
+
+	if (amd_get_sfh_info(&info, MT_OP_MODE))
+		return;
+
+	input_report_switch(input, SW_TABLET_MODE,
+			    info.op_mode == SFH_MODE_TABLET);
+	input_sync(input);
+}
+
+static int sfh_tm_probe(struct auxiliary_device *auxdev,
+			const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct amd_sfh_info info = {};
+	struct input_dev *input;
+	int error;
+
+	error = amd_get_sfh_info(&info, MT_OP_MODE);
+	if (error)
+		return error == -EINVAL ? -ENODEV : error;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name		= "AMD SFH tablet mode switch";
+	input->phys		= "amd-sfh/tabletmode";
+	input->id.bustype	= BUS_HOST;
+	input->id.vendor	= PCI_VENDOR_ID_AMD;
+	input_set_capability(input, EV_SW, SW_TABLET_MODE);
+
+	error = input_setup_polling(input, sfh_tm_poll);
+	if (error)
+		return error;
+	input_set_poll_interval(input, POLL_INTERVAL_MS);
+
+	sfh_tm_poll(input);
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct auxiliary_device_id sfh_tm_id_table[] = {
+	{ .name = "amd_sfh.tabletmode" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, sfh_tm_id_table);
+
+static struct auxiliary_driver sfh_tm_driver = {
+	.name		= "tabletmode",
+	.id_table	= sfh_tm_id_table,
+	.probe		= sfh_tm_probe,
+};
+module_auxiliary_driver(sfh_tm_driver);
+
+MODULE_DESCRIPTION("AMD SFH tablet mode switch");
+MODULE_LICENSE("GPL");
-- 
2.34.1

