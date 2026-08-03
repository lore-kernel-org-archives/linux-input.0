Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B52A426ED3
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779601; cv=fail; b=XT+vR4QTpg2QgSoI6z+pwCVEuSg46K9PjfDSYv1ovEz1IpKPeoF/EBKGEjUoXL8YVfbGMjRZlUGyNsy5gz/AkOwHNa4OC893MC6tB4JByBhQqQTXXIPLr36RjEujT8yjcOxE+tBDQcQZL7frd/oLVpmHlHHKx7uRm4A7c54rJZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779601; c=relaxed/simple;
	bh=U8sl0KCOwHXnWkDu8z6+jZ2Q2MfQ7Ur81Yys6UELu/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMuxOCq0bdda7srpUfrnnaWCrB2z5pXCB8dt9aDNHqNgpWzqcpQKkEVjdEimK5wb9+5BaYxRJUiZGjNJDyOSqj4/yu6t7Nd1AUlP1ySPUdtSxVNSWRthBgv6TqT09WXalVhP5NXLOB7l56+B/5dVjHgepEmoBm5eoRPLQmWDGyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=okNBB/ea; arc=fail smtp.client-ip=40.107.209.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="okNBB/ea"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdt9qhTSu4w6NiY49aemxY5uM4da3hx2jFyjgdJFSlGdUrIgF8TMZepw+5alho/bESq5zB9zx2JShYZ/EPttCJ7m+0UcHfSrkANOo/q3ZhdmlPE1l5BwB7R0HrM1MAO/bDZebLM6ijR2giIMCFJyZWUGUYoD0Gy61l2GnRmxnusPRSjhNNHEhzv7i3l3MK18bXc69wBT4GpiakzKHzlOXTcIEMisRBXwIRKHOXzPqH52o3bYJfZYIeLB4Kc/PujyhhJtCah2DBCgIKyfuXHrSkYVCleB9Gbni3VDTw1OAFKyUGOTvLbMlgfplIV65nkOl6TNuQZpcfhZ2UrMBk5yGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooICZmSs6YLwB35F3Gb9561GbtDhePW9n9fMp0DtQFg=;
 b=ESUc6Bkf4FXRnamG4YcC13E7TMGiMw8lJ5Kyme25UHPHWlSqy94B9L1TanGfUJnd5X1+Mqc6nxC0ZzPIGyWTrlEOUMAZahY2yZ4wTp4Um1C2dp+AZiU5y7AAdCiMtp3WII3Kk7GPLrHK+yf4/jtrTfrTTdnJihbqL/0ncIxTK0Y8TVT9ZwDakfsiJCaXuQ0wNk/Je6vj/lskkT2WyzH3KdUO/wqMEcCEu4lgadHPwRXJp6QfdufaKYvDlybF24NrvS6WAex0iY1smKnaGECDReDHkDW9E/z94Dd7WBz6TI6E8Wu7aAJodsAwvcIqkMRqPaJUeXEjb8op/Pznlot6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooICZmSs6YLwB35F3Gb9561GbtDhePW9n9fMp0DtQFg=;
 b=okNBB/ea7dppz/1JN41BETX3ab9ojsmrk0qVQVP/WEuL54Cx9XNjQ0ywOrBhagya8pJBwh/KeQS58SDxFxjsi8C6jK6wPwkpnZ/ldaQsBBdPY8lzp9Yx/5CxbW93VBrLuDa16RKX4wzMhHmdeRpHyadAcDIOaeAPAi6VOUY2Dew=
Received: from DS1PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:458::14)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 17:53:14 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:8:458:cafe::29) by DS1PR06CA0012.outlook.office365.com
 (2603:10b6:8:458::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 17:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 17:53:11 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 12:53:09 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Helge Bahmann <hcb@chaoticmind.net>
Subject: [PATCH v3 5/5] Input: misc: Add AMD SFH tablet-mode switch driver
Date: Mon, 3 Aug 2026 23:22:30 +0530
Message-ID: <20260803175230.3839752-6-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
References: <20260803175230.3839752-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 342bbc9c-b2ad-4454-d01b-08def18815f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P4UPVPaE6DEvd5JJuaG26IW0KKat1Qphaej5phT7gs8KGGDzrtb1NRYnH2ZNT5xaEZ9c1I1NOoWUlKWEIdXtnsm/U1KHM5XMqCuR+4WCIPf1pwETPkl0qZXqRz7rq/dQQnbD977Wlb+VwZaySiHboVQ9CxBqPDTo4SWxTFL9cnSqgtZ9B8S6ydZw80nndho7Ko3yRXL39joTkfCHGGFb9Rmp36JodNYeL/VcEYPnSU+eyAeGDkT8IgayFQtLIZWVun+kJKcspjgjruSf8YVP2rRl3fxHgB/URNjxZo8Rqm8XzgdZJbHwwzdR8LX/kmtuf4r4GQhKKqKsiEcKwcdhIfv6wSmHZvBVNORsdM8X11xQIP3XamXH28mx34XzbqpwzcKq4OJsJv1y6EbAgmlx0N8RsZn5tgK1eWprp8Ii3RGltJnMVn2Q4bFtfW8L3QlqPDit4UhDt+JHCSv3bMg/3GmeujWbZZrEQgE07ooM2HQS0gVm98o37gSzNUnyPur4q9j+iR2sGZooDuazkgeLsaa0l7+m1s0pWkrnkkp66k/HfAdwuzlpwchwiTN/jBmfge5xvURU22q1RJ2rkQXZ5tTG1/yFi1GPJr8Rcj8WJ+EkhuR+aB34RV0oNjkQQAURDirXNuE/9fZaJ5VI6X2YUfR1Tqm/AYvDYFYGpvZz+FhyRgNrtB+YO44eI6sWkdZP4/aDjM/1C6rVLaqlBQIrOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	34QnlyDLwkoCxAmniPM9uY1+h+xknQeQgDWgJJsdUzo/fz5R0k5Z+l23KvsyeRthwq0CbWf9/EAXuZr0SwEsEsIqcWzbQkkA71YTiB3+qw5BUAvRipgurFWmswJ8zoO5oVNUrkE3/Vkqf15Kf8U/C2WsDhkUdyw/TKl6fv5GR9oowMp5e3FI4yLdwsJ1bn/zpvZIpaii9F2x+euwoKsUTHxQylBenabxb8ZxILH1+qVD8is9WCxFVDj7Z61e3KUsJJuewqXDb+2nd5hBmX8fHTITDqvFd6636voC+Qb5hw/cLDZ4IquEKRngZ5Q2pdnUlpig/MIGOnAUWPM9XI5939kSqNzqb3rQMU241gSb+VZs2V10MSbgPw8os5sl7xwtCb1RFX4rMNdS2rBVPw0nRywJEU4gtAjWaY7+KyXwSHb0TKjQx51AA/psn5YPB1jk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:53:11.9079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 342bbc9c-b2ad-4454-d01b-08def18815f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

Report whether an AMD convertible is in laptop or tablet mode using the
operating-mode sensor provided by the Sensor Fusion Hub, and expose it
to userspace as SW_TABLET_MODE, so userspace can react to the device
being folded into tablet posture.

Cc: Helge Bahmann <hcb@chaoticmind.net>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
index 2281d6803fce..6fab9acf3de3 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_INPUT_AD714X_SPI)		+= ad714x-spi.o
 obj-$(CONFIG_INPUT_ADXL34X)		+= adxl34x.o
 obj-$(CONFIG_INPUT_ADXL34X_I2C)		+= adxl34x-i2c.o
 obj-$(CONFIG_INPUT_ADXL34X_SPI)		+= adxl34x-spi.o
+obj-$(CONFIG_INPUT_AMD_SFH_TABLETMODE)	+= amd_sfh_tabletmode.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_ARIEL_PWRBUTTON)	+= ariel-pwrbutton.o
 obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
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

