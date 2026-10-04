Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454522E06EF
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129620; cv=fail; b=aDv7CXKtGpnS1Td2qkYV7kSE3JBE7I3EadrBvZ6y2GX4nQYEoUlHTPGp2UakqlkjIspwj7Jh/+8PHqc6mWw3/SZcqsVqUSTgiqDvSlUS760ZIOtXCDgASJ88UzOShcXZwY67ijNf0Zx373XNgV4ImRYdcPQ/S2OL2B59tohdkNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129620; c=relaxed/simple;
	bh=9CoLWtVaB3+y+CFyg2qfhAMSbKdI0lCDid37s72Bwq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ih+Ii1qZMxGgfbkmI7TnaIajZwOIrjsZjfwwvI2edyjF5zmMOQGzvGKoAO0oJxcS5egvz6q/MO2itHMr6uC7KdmCmssYN+k3rKnzzyBDcn+k0Ih2HVzFhknMHa52wTf3rDO3s1DutaAQTRbP3MqVDS5tCmhEZ6vcZwTGekib94c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QNRVPYlE; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QNRVPYlE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBBMwwCoiJztI8y3dfeD9g06GjZ3W6pPf1i/oyCyjA2fPBmENnWmD1Sj3RBSe/gAKqOk01F0ETqXWIp8zQ3WX7hHxj5LcgjucRmkAq7llyDx2ZOd4xFfeVKC63MMcgBr98EnhZaS+mmsfVm3RjveNiG+cbEN+uu3yTgBSbSrp1syg/SnNQ6VTg6CG/M0WraUdnR4wgcrWl0NH6o5pKBwD61FqFfDMEjngOEy0uFFIP1YQRKVxQ/TBOZW+SlPZmVdgnXpfYzZuL4S7WeJ6utTuC7e0hxyZnEActSqBbJr6jPzyT6AlCm1LNKg5yXDFYrcclrX1wAdOyHgg9TyUv5vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH2yr08O6cvrTQDRsguIYZ3s1c3Rl5drelNkojYO398=;
 b=TJDW1Kdb7vEyIn0qs3vx3Zjqu/YsS8+YHvBtbgRwxy2qN6NL/GdDruc7tfYWeSy5gTNMconnIB5FcNpYV0oruOHqV7BGFKwsfWWTU89kIROtKFjvt0dtPvxWktVFRi5Qg/uvriBDbHcCxkuIfLVnKKxD2GLksZ1CpAoE83EdaB7VNvY9KVb9EkKWgZd3KWi9j92laXh5H7uiD3d08rT4zcWKKmKz3iTEMLxSKWHR4eI2lWPaKXyCVVvDhHdREyEQe0o0rSXtR11ZVrUpzcQeAN1oH4qFusJHpZYMTRqe202AFnIoBPTv5QrHK/EE5sz6t2u1Exf2uqBSxDWq7/urow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2yr08O6cvrTQDRsguIYZ3s1c3Rl5drelNkojYO398=;
 b=QNRVPYlErp3c3sWumfVgoqeKAlVohCazLlpkmYKqRM6hUyIV27TwukphFQ4sTBWz14gCxMIYcGfESBYEeIskzG5DeXwoYQtft+Pse73KarCxpS9l2cqTWhrl6ACQDpNtvPg71tW4vSx6YZBceAKxaSpvf6WNMQwhK3LGMhnR1W4=
Received: from BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 16:00:11 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::2f) by BLAPR03CA0072.outlook.office365.com
 (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 16:00:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 16:00:11 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 11:00:07 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH -next 1/3] HID: amd_sfh: Move sysfs attributes to a separate file
Date: Sun, 4 Oct 2026 21:29:17 +0530
Message-ID: <20261004155919.726226-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004155919.726226-1-Basavaraj.Natikar@amd.com>
References: <20261004155919.726226-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: fcaa1b21-6e6a-4233-fc0f-08df22309232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1ADxf67QIRx+FIQgY8cmj45slSrsHGFgHGVyz+QzwzleurZ0ddPMauXtgQNnVaAHCIYV5Mh899URZSOl07eWomtBHhoRx4K6H2NAfgXVfjGrZduSLW2X1qe5CW9U+IuUN8p1G9zC7SpRIoPVAlyWfw4/Wre6TMMHqEx6aVhBdoALmoBQB21YKa6lAznwazV/DD1Wv8sZARU/DExh7RqAGtye56fxVXAkhMCgRFd29XgJdiFnslbmMYMFxyLXwUgOHdHUrF1q1hIzjTHUNYamhGDBOZ0pylBGkAdo7NlPiUjLIRyNm+W5j4lhSe3wPNTg+PWUywsz24TGRVkaGtJwamDCGrY/STxLVlffLJrl2UPCq/31S3rTALUMhlJooPSmVg+RKTGpbdRlI6eLJ4mysAt/RiCNO0N9tLmMR3BuSp6l8JbkxtzkBjhT3o20/l1zlqyLSEgx53bEAO7Pstt1fYA0m0kEq5/bKamHIwKrK276C7BwAgauled8h0M4ijbv86RJINrI3mwVCIP8o/zuFOzA019jbB4RZhm4kFDbx4yE3ZkiU3/sHrCSQ/mWHfQVSlUSlC1+aNorc2PaKbAX3Va4ycZ1uk9e1blnuYaRaIRn1OSaoYjmL4qS/4C/lvowAf1Z9+vqE/RBnasBZGU29Ga9erMXKublR8SpcGHHWtuIsweOy5hUmy8fjB4jPR2j5awz57LQdEQaknaCwFCWWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xHEWJEZVV0fZMPOJttxpMVOc25VxJifPH0lupm7NjZnuaqwhKfMDqkHxd9VqqKfxyKe/4M4pF282MM3jZQo+x2WPdCJDd6KcAI/1Obg75sm/vx6AckNfkLQmsiev9roWo3cG5byWddAboqOU3osWEYXgdAeD92Al5gNySF9Wb+eH/mjT2GcOhB/zaMI7aum9S/0kj3l3D6eRBPJz5OYSirjaEM8xuDjoZCHlfcrrjoE5yp7KyLpKnSN1/Jtd+gkZJCyhUK5V1E/ud6Zus9svGQcR2w4Su6dBCa6pxwZDbaENmaac8wJg7J4sG5kkAdSnaAmXqSIHttCt46eHHHGRiMldHdu7ffh/OZiKj/iccKPyJoz2FnGDjIq/VUk7ovoBRDHtGdAxYdPrPH1mPJ/30MSoNYDYQBVaGz4wAgLCL2OWhY4+GOvbWzFPeDQhQ9r3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:00:11.6058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaa1b21-6e6a-4233-fc0f-08df22309232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919

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

