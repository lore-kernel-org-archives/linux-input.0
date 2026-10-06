Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFAC38F935
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283109; cv=fail; b=c3WNz9rZ3NDKEiyIqoe83zyUsYrraBjGoHPQA3CGa1cK1+G1gHGGwRwBOXX5FvTRELUxnfUYqwBWr2N9X9tQ439USh4HPZ/GxgmzvZJqrIvdtaw3/pKiEodZMtXgeXUGqk9ca0z1nQ95OMhTiAWQ3yyK21k4V3sRsRdJzd3QeWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283109; c=relaxed/simple;
	bh=9CoLWtVaB3+y+CFyg2qfhAMSbKdI0lCDid37s72Bwq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3tZiLk7GoQ2U9WSg7394NBklXtvTjlLE5xggyPgWMCzm3jDBsvHYLq+klB6dRa8vCfH3d6dIMFmzYmH0bDQbS9vEv7oN33MhNtMioFaaPC3ZhkizIS3Z1wNGHBbzOd7SJ58BKiiXjrXXY1jWQE+eRmo2XpoTZhiaEvhRvTpTFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pZ2w8zSe; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pZ2w8zSe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slwIpz3KfBx33+jliPWknFTBgnSi8fJ3f2KnUkYz5ampYDXMRIZbchHzpZtWgbWlFfs//zKBlMCNxxOB6DiJg3mVVh8ZGc33llbiNy6qAS6eDFnCFNM0p2qRXWRzixK547V9tkyrPcdXRmG4qOI/fjiQQ93xX0JPq1ahGk2e5NEYI4bTx1UVtdWRGJkKmE15/IGQYQUwNX43MUfK2JxMmc+WWhtlR79nQiU1qAJlUxGpKLuRXS709spF1JQLmDX960+LpmaWyzU/ChK3U/tNcVbh6w9FtKGRammc53kwXqVaFwPD6XSAQIXME/B0BxKrsU7e0pGSUQx3XLQTwyCz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH2yr08O6cvrTQDRsguIYZ3s1c3Rl5drelNkojYO398=;
 b=PqT+pz01Sz7dr3x68MuyRQ4EBC2hf6h39Gj1Bjfc2Ms1Oz05WRdwQqQclT3Av/MRv3k0DN7wL6mgPExeguZOiBzJAwebQ1fMhQ/UKTUwTr1BEQJojj4jNX0543AWbxYem1TeR1qqwANvNbKa7XywH+Yl6AYOP1Kt+xZM+XoGBitdrsgaZr3tVKw1ngo8m4smFzRbhDhlUWqE6bidkd+nTEaoHX7PWNUMgg9eJsxrzHjvT9leia9Qhxnug9cyEE2wGVWHRMm9EsPl9w8i3pLjE9x9/+WZatNVFT2E3r2Ib0T6AQIHrPixHUGazLuE5cm7QLkLK7tnOJyBSOY7i1Zw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2yr08O6cvrTQDRsguIYZ3s1c3Rl5drelNkojYO398=;
 b=pZ2w8zSeh5HV+lS/kzmjjHVpjRiao1x3ZdqOKH0YsM1GMwXjM456nVujcWMm7hh45Q9Hl1/IZ3LJAMryWB1pzdv8S75+JaUt2ZbNg07Td1BDrfi38rcBxdBSdAnsHBOkz1V3OVLmbDTGqpmGya8D0cigZCR+0zVi+0wOpr3SS+0=
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 10:38:23 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::44) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 10:38:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 10:38:18 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 05:38:16 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH -next v2 1/4] HID: amd_sfh: Move sysfs attributes to a separate file
Date: Tue, 6 Oct 2026 16:07:51 +0530
Message-ID: <20261006103754.3614316-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
References: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: d43c4293-93d5-48b4-9165-08df2395efc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9Ff9QvFXPiI7iJsVAwAWvzXBynA96V4IZb0UGQOtU+AsjXLeweZDHeAmpezusU7p7jgXZlmYcnW5OhhqQ0rzeba+w/M37Al0IX+0nRnnaYk0DybkXlscXuMHPOCvVY66l13JSNmFKOSf0QlxUh14OH6CFUbhHdGF96NvW/oNIZaIj6mej/WqauTSZPyyWt3gZwtckYXpper8TFJFKSEk6cwnC5JP0ADkY22JOiLOqN/xZ6ilpn4RZNKGgDUwG9wM3Ez9OR5nWu0BVrLx7SXhW1BW1lvzTE7BmF4hSCYm/tEQSo/UGNa/BHlk/v/JA2RBUU58rEENW5GzcUhWEM+/mrCES4rerEhfbx7Xye+GaUkfANypjN7GdAUCwnCcK6Q9/bzuMRJIX9pfGBJ7XbaR51OECxxqGxfLtIonIkttB7S7FX95j7T/WeeJvpM+I50SN4Kv6YK+/LKBNQYejRwGTXumIrnFOfeCnJVOPs7WHSoKn7RVIemqWf1ZW0q38pHfmzyEqS71t9yMSo6WsR5bus+/01VAzR7zFYvm2Y2Sibd0zyUF2xQOeivl2gyWTd0R3wer41+m6lPc5UM2IbfvD2hvK1JG2JJz1C76L7CC0srGzMElIommoy8CxXsJe0DM/AS6vrfhSsM8EKhG7mpcFGPvDnAEcNP1q0MI4FctdJ2gBUn0V28+Jgi+l+bYzeyK8PclX7AXlTpH4XNxC0hbsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rf+XV7zWcr9GI0i8WOKlP68U0WZVRYeb6P2bNiBAQTqF1/rnNREeZpc+0dPfbhnhGmC4Yp7p9vxtR3IwC1CHQeCFNp8tnNj5I+SV0IWCMvN/WjUp3M/X8mMm2hYhknxZTTEqSBEsLUJo9jhO5D3hOcclinNWMJYJrFWWivG8SZbhAao5WkXfyDTQnQvbT+rDkza3F+/QdDzqcZW0h5NpXTXYWy3zeGUHwoFHSWkITj2mWsBfGlWmysIVNv1GDHH1JreL9I+pKWYqh4DjE3xzm06gwBhdzGdA0GC1lGGZo302k/u1DtCpWbuBfTeb9juGO16Wn2fHL2lR4A9qCau/RLxVI8KPlMsGBdX7aby7G6uIIkQb8NjtCFVbyyNIlwXbLq/VEDyV/V6XqWgyk9THMsoRB3hH32656FmjRAsxnKJMSWJJuQ6pl8pmdcP2ndRd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:38:18.9591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d43c4293-93d5-48b4-9165-08df2395efc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599

The sysfs attribute handling is defined in amd_sfh_pcie.c along with the
PCIe transport code. More attributes will be added and the same handling
is useful across SFH versions.

Therefore, move the attribute definitions, the visibility callback and
the group update helper into a dedicated amd_sfh_sysfs.c file.

No functional change intended.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/Makefile        |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c  | 55 +------------------
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c | 73 +++++++++++++++++++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h | 19 +++++++
 4 files changed, 95 insertions(+), 53 deletions(-)
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h

diff --git a/drivers/hid/amd-sfh-hid/Makefile b/drivers/hid/amd-sfh-hid/Makefile
index 106514b54d16..a0e4113c94cb 100644
--- a/drivers/hid/amd-sfh-hid/Makefile
+++ b/drivers/hid/amd-sfh-hid/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AMD_SFH_HID) += amd_sfh.o
 amd_sfh-objs := amd_sfh_hid.o
 amd_sfh-objs += amd_sfh_client.o
 amd_sfh-objs += amd_sfh_pcie.o
+amd_sfh-objs += amd_sfh_sysfs.o
 amd_sfh-objs += hid_descriptor/amd_sfh_hid_desc.o
 amd_sfh-objs += sfh1_1/amd_sfh_init.o
 amd_sfh-objs += sfh1_1/amd_sfh_interface.o
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index aa09a9538f4f..b3cb13b8c5e8 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -20,9 +20,9 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/string_choices.h>
 
 #include "amd_sfh_pcie.h"
+#include "amd_sfh_sysfs.h"
 #include "sfh1_1/amd_sfh_init.h"
 
 #define DRIVER_NAME	"pcie_mp2_amd"
@@ -340,57 +340,6 @@ static const struct dmi_system_id dmi_nodevs[] = {
 	{ }
 };
 
-static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%s\n", str_enabled_disabled(mp2->dev_en.is_hpd_enabled));
-}
-
-static ssize_t hpd_store(struct device *dev,
-			 struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
-	bool enabled;
-	int ret;
-
-	ret = kstrtobool(buf, &enabled);
-	if (ret)
-		return ret;
-
-	mp2->sfh1_1_ops->toggle_hpd(mp2, enabled);
-
-	return count;
-}
-static DEVICE_ATTR_RW(hpd);
-
-static umode_t sfh_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
-
-	if (!mp2->sfh1_1_ops || !mp2->dev_en.is_hpd_present)
-		return 0;
-
-	return attr->mode;
-}
-
-static struct attribute *sfh_attrs[] = {
-	&dev_attr_hpd.attr,
-	NULL,
-};
-
-static struct attribute_group sfh_attr_group = {
-	.attrs = sfh_attrs,
-	.is_visible = sfh_attr_is_visible,
-};
-
-static const struct attribute_group *amd_sfh_groups[] = {
-	&sfh_attr_group,
-	NULL,
-};
-
 static DEFINE_IDA(sfh_tm_ida);
 
 static void amd_sfh_maybe_register_tm(struct amd_mp2_dev *mp2)
@@ -448,7 +397,7 @@ static void sfh1_1_init_work(struct work_struct *work)
 	amd_sfh_clear_intr(mp2);
 	mp2->init_done = 1;
 
-	rc = sysfs_update_group(&mp2->pdev->dev.kobj, &sfh_attr_group);
+	rc = amd_sfh_update_sysfs(mp2);
 	if (rc)
 		dev_warn(&mp2->pdev->dev, "failed to update sysfs group\n");
 
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
new file mode 100644
index 000000000000..db1cc205d25b
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD SFH sysfs attributes
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/string_choices.h>
+#include <linux/sysfs.h>
+
+#include "amd_sfh_common.h"
+#include "amd_sfh_sysfs.h"
+#include "sfh1_1/amd_sfh_init.h"
+
+static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(mp2->dev_en.is_hpd_enabled));
+}
+
+static ssize_t hpd_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	mp2->sfh1_1_ops->toggle_hpd(mp2, enabled);
+
+	return count;
+}
+static DEVICE_ATTR_RW(hpd);
+
+static umode_t sfh_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
+
+	if (!mp2->sfh1_1_ops || !mp2->dev_en.is_hpd_present)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *sfh_attrs[] = {
+	&dev_attr_hpd.attr,
+	NULL,
+};
+
+static struct attribute_group sfh_attr_group = {
+	.attrs = sfh_attrs,
+	.is_visible = sfh_attr_is_visible,
+};
+
+const struct attribute_group *amd_sfh_groups[] = {
+	&sfh_attr_group,
+	NULL,
+};
+
+int amd_sfh_update_sysfs(struct amd_mp2_dev *mp2)
+{
+	return sysfs_update_group(&mp2->pdev->dev.kobj, &sfh_attr_group);
+}
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h
new file mode 100644
index 000000000000..941b995e2c8f
--- /dev/null
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD SFH sysfs attributes
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
+ */
+#ifndef AMD_SFH_SYSFS_H
+#define AMD_SFH_SYSFS_H
+
+#include "amd_sfh_common.h"
+
+extern const struct attribute_group *amd_sfh_groups[];
+
+int amd_sfh_update_sysfs(struct amd_mp2_dev *mp2);
+
+#endif
-- 
2.34.1

