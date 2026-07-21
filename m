Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB54405845
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655900; cv=fail; b=McKpVGCoa6RuWAOhEhpALQXJMXBJvtI6aoMQYP5vaHCVjjQy+NGf4yHJPrlfYzvTYpjscqPGYxnHuNhBBLklVPRp9TnpMNEOpfxaY9Wf7ERJcoVjQmlKq2JcKLmHL1cRP8ImJH9uhDn8yQt9W8IiW8+326kTpDXkmCDQ8NfWM00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655900; c=relaxed/simple;
	bh=WMrfJyK3Xfs+c5DYEXyhWw0A+mn0hU+CWmjL8hAdxO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPL2orywBATMPXLC7B8+QTmsVQYx0TzIkfjig8zcg9Ak0h2V5FJrxCGZ3rXeny1faUySro30sL6jnTOix4EVKtSv6f35/Vr+Ii9INpfut+5TLUjmOCM6QvQ4TeaMP60ptFmsrUHJh2zY+U9/Ar6W4d4JlClhfN8QKRkjOfYDQJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSttngAc; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSttngAc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRcGABOCcsiWODAQ73FebWbzb+cBK6xlthlSlPKy80jqCBWBE757vRJ8cASyvXFeNuJ/n8GZupeP16yMP9wkLdO+HLdVplWjNE3LVkNbOx52zrc/zymMa2r2Pj1nRmXMHu1Sn6D7nsqOCAtZVz+QI9bFEpJbfHgrBk3wPg+xf+CDAL2j6ujU1Xh/8jXKZ003SeK7XR9E1qJQRwaaPk4301dFdz+HDnoriitA0tsg5PhnLUcJRu6QYRcOomkPRC2F44XrhVead2Hvgwo9QyJQDS6RD0FsYQTG3qFXWXNQx7B+9dneXeiL6XEEzDjVjsrY6cOtpOAGcIC2c767AvB8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lggIHE47Y00UCDtvWAmbSFthD5IaiW9x9C4ez3QVtA=;
 b=yVGcDvDiH/hIHwavewz6yXOsRFILMyMRILdtjE7bC0EvEIlnXupv6qz+wj7lRHYD3uuM+MFDCNoYN25iN1mgMEwI22jrmwDsvL5Chi0rmlgacedmLuBnfhFtX6IhsmJpb/vYqvsC3D+a5Sa52u7To5gxv5BL+20qRYJsrtv9txr4UNC7mbY0CV/VfBT7cAWNyGM0YOUYqxknAfI224thndpudekyC2wa0CUzD+BeGthWfCJU3iUM3v30wW9Zso+5JX/eqmPZ0NwrgWGlBf+wQkMBtUcunfjQHsMdrpkUIUG97e1ex8x75r9jq/NWr1ZCxC+IL3BBWl35cUqEwWT5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lggIHE47Y00UCDtvWAmbSFthD5IaiW9x9C4ez3QVtA=;
 b=NSttngAcpqPsqUS0VohLSS164lEJ1ocrVUBHJk2cDuW7i8aQD/VMySvrjCr2XOfin6ynQpz6q2SJbviTtdW3HegGUiEaqSPV/AfpDgoSviXppg93y0TjpssS7i/R0gH+2GrxsjZVqtVUWa2EDde8+z1M3fiX2/2Nx/mgCxziTI4=
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 17:44:53 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::b) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 17:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:44:52 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 12:44:50 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>, <dmitry.torokhov@gmail.com>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Helge Bahmann <hcb@chaoticmind.net>
Subject: [PATCH 3/3] Input: misc: Add AMD SFH tablet-mode switch driver
Date: Tue, 21 Jul 2026 23:14:22 +0530
Message-ID: <20260721174422.3109166-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
References: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 421ca4f8-21a7-4b08-0327-08dee74fc526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Zy3kh0nF4f7e1keOUHXFx4pVdiz7n/rQ88cbowN3fTWVBOiGaTi04NuG0DT5AtiG+WDfMDxFsr3Ap94v8ISvfPw1O1AO6DBvHouip98r3TXDvC9DiZUJ9tbiaG+TkA/3HcUwfKHPILwPLyQL5xyzJwAqLl0tBGicwch8Mly4ctfjFIQ8sNm0vGkPWxb8PQUsh5CSx3SAZ+L8DRfim6BHWFlpurx2Kq0jpRvIr1oVFr1zsnp6jFWx512FJPqesvvdMioqjQAfSuwJAzA7MP1G65RyAaeCU1LZF0cHRpbqgeGobQ2Xx9H+TgI8vqcWbga4A7MeQL/LYiNN2FoSi6iRy43Up1JWeQVEMwkVVQvVeorVg1nNStVhMyBN0MyxFEsZ3+TILzI97P+lujLVcmoSWzeiN/eF9X+RguPd/QhfuCWyVwcilCyO7R7/n1nhFQSLS9SaFbyygpz7D4gjVNJaQIU+OgQ7QMo9NbNBI+fvGMeBSE6W+4WKzquINc2W9k1zx5aVSYkVbv9nMiZTRseNCnotcvbm49souJfj1AuqwzYz6lMPSGbU0OElPivXlSM/x+/0sz8Rs0XbBgkBmomigmriMwZVwEJ4ONC0R6ImdT+3izDfvxnKTjVRZOpxgIYi28hMhTt/OW+a+YNT5TySka8B/HRZdj/9VZQVX1k0QwE4rNJR6O3bh6u3PIhwtUZq618H+Qa7yjPaY3mXGniOaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sNcmupNCUI0PN/uaSSAzzhIcsPgDCdOFVT6fLXduFdyqj71In4AdoQJ0HXCzXIDGE2ULaYJUyb001FNbRRmQuF9fR89jEVr8fBcmqU40ZkPDyTRGwWqy/SrCZEsTM4VTL9izDhwUnaqQr3CHellbn4DXBbXy3PtTRsqH933GLzEeXih6eJVuhWS3DLEt6MW1fX06xN85z/u8AreZArrwLHbuibQxpWXO5Ax5lW+TrljYxAmwDi0rk58fgqBh5tn3JShPc2wSFudr7LT98Pkq7E+u+jDpvxy+FDsnTZLmaXdzuSfjAcfCtBenmtttvm1b8TWLFxvYTUwfl1C6B482MJ9F7wq6NuDxXiBbyVxo9W2Wd7OcepHDVhgQTTbK5SnwmQP/i3HJGRtVE3MZgP/9vH6HXlnA4e75cb8QS80jhsfQklW3EfD8rxWyagtdQnSL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:44:52.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421ca4f8-21a7-4b08-0327-08dee74fc526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181

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
index 1ab8736850ea..30cd879e4a3e 100644
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
index 000000000000..f88edebbf35d
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
+	struct amd_sfh_info info = {};
+	struct device *dev = &auxdev->dev;
+	struct input_dev *input;
+	int rc;
+
+	rc = amd_get_sfh_info(&info, MT_OP_MODE);
+	if (rc)
+		return rc == -EINVAL ? -ENODEV : rc;
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
+	rc = input_setup_polling(input, sfh_tm_poll);
+	if (rc)
+		return rc;
+	input_set_poll_interval(input, POLL_INTERVAL_MS);
+
+	rc = input_register_device(input);
+	if (rc)
+		return rc;
+
+	sfh_tm_poll(input);
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

