Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06444247291
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129624; cv=fail; b=NA9ILfx2Br4RvCvCclQI02F0+a1ZAc99ky14qBNMyz4ZAtnHFqpUBj6yAOKcDgeShxO3nsSkiRJnhQB9jVJTGyRX9j8D88ddtdPFCEVaM6ZPvfJkIzKrV4FdwUJ3erH340vTtAp63a8hGwtin8cQZBnP8H6wj8rNj+AWrZPv/lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129624; c=relaxed/simple;
	bh=ZSC8tv4YkzazDKEkrDelwCUAc3EqJiiW7EC/5XqrLwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9NrI+I8TBbMzMj6Ee5vJZi0Thj3W3uykaA5jJWIVD012huiSgBNmcOY84ANh6XlEL1n550Ncf499LC4n5QIXcLZHwcU7NLiRgHJ7/5/0nwcP7SqQChP2ru8MTyMptOdLdHMzdoc6HHmix9VGlAII2mnvYFLZGT6ZEIjd709WYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EaBzquxm; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EaBzquxm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soTcqyTO1jt7H/xvwrS1FfpldNxnonCOARfVleQ4AvXKz4JP/MlzDWf/kcIGJoDVq28Hir3eYPhw0yCuTbGnbet6esYbi/3lauBrjUgDbvK9OnNF8XpcuQp1gX6QBlIbjH1GUikye7IS77HMlLSwCLxMDwbTYgLkwiaHot09Ucbz3A1/L1xBN5rx7RM0IF7vezgYMMtI4HMjVHLwi74FbU00R0Du4Y+JwzS//pGRcbWVYgzw+z0nldczDNHS1wFbJvv9hKkjMrQDkmn+JrBhWhiPTEO4HF+1aoww7hwvWvhZaq/QONYphqQOr3kVKMuvC3+1KcThHrCpSY2o3pRh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLpNIbRB67CJ9oUuB+xiuxBOexLwXbq2pirbLI7lC/Q=;
 b=crbMjlxHk5HMC08CphIA+ts1EPs9WXVsRFiV4jnqWxCutk2XQ71kzKSvFyjM2lNSfPdE5zCh9Lvm1oAtHzxfmtyCWqZPgZ0s71Jc9GWI9pQJD8wOWA2mzDdvE0bfIu46I7Ge5lm9aagq6fVfmMooPaotjIk1j1lynDIPqIVDrnVl3sNbjHnF5U3O75MJxJVx7z+WvV8Yunp61ZMNacu+fvTUVcsO1yLKQnS9xXpGHnhJ4Y2U0gy+qpe7KYgr4nLc1nvU4K3xFpqCVpZX9UAyFNfdVNNCKPol2OUNYiJ7TLOVlbWioRPtQtN3rPBeUqsljluMQhVHrm1yaCWh8H0Onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLpNIbRB67CJ9oUuB+xiuxBOexLwXbq2pirbLI7lC/Q=;
 b=EaBzquxm+9CX6rtKU8WzFFL23CwpK51ywQ8Ak1T4k5z+X3+HlHL9FvuesHElCdqHJil0wy4AjsrKW/+pAirXucGkik8524LSXy6DB8eNsWdJzn/cB9iYPtonBregsXOfvj6e2sVsePqeo+x0ayrNEzY7YLDtttoPP4G3Mv/56zU=
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 4 Oct
 2026 16:00:12 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::12) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 16:00:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 16:00:12 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 11:00:08 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH -next 2/3] HID: amd_sfh: Add operating-mode telemetry sysfs attributes
Date: Sun, 4 Oct 2026 21:29:18 +0530
Message-ID: <20261004155919.726226-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8809958e-7599-4097-bd15-08df2230929c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	SiKJ5N/ZUwRwkVO8UiAbP8AnlTTHQhr5fMfIPsPITTX0+9UUuysl5IKSU06vcA5hevQOrrAsc+ywcOs5gP3kHo/e7BKM7fkrp3kg4JOJiWaTiLennGCrbJEkgctLT9KjYYlTBEDtkbN0H38cc6mV4Mu6cqdMo3lsRCf5F/4Qcud10Q0hRyVdmaIB5zW89bvbFHJcWOtG9HI7tVphkt3llVeI6haCXQhUVGRntjQXwT8GUg5PNvLJcN+lguOOAJkyhqZDWV67POKQnsSwuV0o2tMvVF3p6SenMXcRtPDsEOZBw0CMcpKUbDDNkqVPPJ3JQAjA9bxKqIMYnE067lTWMIj4NtCeOnDHVso/fzeaGKVzxH6CJEo83RbCJK3aS3GTpBgJ8y/9JIewYHwBJu5aIhRiC0BAsTxklQ/FjcOhCKdAtddf79zdAUMXchKPz2FLn7FtTUz9Z9KNFxZ1FtVq+o/IQ8YqAfSQd7JXVljMhx6FgJHCR4GUagplbsjyGcABgY036cmlylSbmKbapE3pTiEcZ0v2wET3LIyb8zyR02jo6w7tKQkZaY1EDJXFWFeKZlpDnHXSLuifM5E2lbhKXwykezQi5OKP+THEgjoCRVYQb1X2P2JkZT+HPckGZm37bnTRKHabngwrASTBuwrKM8OhP2glQ3qEK6QYfuD+o39/dyLx+TTJOS+sohzq/4f9lJNA3FVIHC0DP4M4L2BEjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KgfIS4fv2Qu4YkaX7kpDaHO/YqF2u0W+mgGJpmk4CtW+bQVv0BV+ZcTsIEiukWodCV0cPWEJRE1L9pxWUyvOKJZUsnICwWt8OnmpXYmBLXYpcXQiiwpaBwQ7+L0kEd+SsB84jMKA4w0+c/8deebn4id/DFUFeE30SOdIkAtY/JfQtxbuL6RnMVj+zi7flxzojuglAMd8IFhtvBNxivZWljH9UVhUegROUpa54joN2biIo68uuDEddxFowBd5yZUAgIXMbzDK9J9xCOrgLSFdMfyjLt5kfYIkim7EYEmAyYyqTT+/YVKaczsNtTMUeKZFWFUClWibN7bBpupTSQZK2fScv+Xbx/By88BZUeMVaMv/kgau6PQjmrIH+QXfe77dnJUEWw5rbA+g58v45pggS0B3uLoG6DYMMwunJGBwGL/wHrf+A9zXUTNaIw3kkeqX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:00:12.3003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8809958e-7599-4097-bd15-08df2230929c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153

The Sensor Fusion Hub reports additional operating-mode telemetry
through the SRA sensor, such as in-bag and out-of-bag detection,
on-table or on-lap placement, hinge angle, lid status and the platform
device mode.

Expose these states read-only through sysfs so that userspace can
consume them. The attributes are visible only on SFH 1.1 or greater when
the SRA sensor is present.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 .../ABI/testing/sysfs-driver-amd-sfh          | 60 ++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c       | 63 ++++++++++++++++++-
 3 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-amd-sfh b/Documentation/ABI/testing/sysfs-driver-amd-sfh
index c053126a83bb..15abd994e9ee 100644
--- a/Documentation/ABI/testing/sysfs-driver-amd-sfh
+++ b/Documentation/ABI/testing/sysfs-driver-amd-sfh
@@ -11,3 +11,63 @@ Description:
 
 		Access: Read/Write
 		Valid values: enabled/disabled
+
+What:		/sys/bus/pci/drivers/pcie_mp2_amd/*/in_bag_state
+Date:		August 2026
+Contact:	Basavaraj.Natikar@amd.com
+Description:
+		Operating-mode telemetry reported by the SRA sensor that
+		indicates whether the device is detected inside a bag.
+
+		Access: Read only
+		Valid values: unsigned integer
+
+What:		/sys/bus/pci/drivers/pcie_mp2_amd/*/out_bag_state
+Date:		August 2026
+Contact:	Basavaraj.Natikar@amd.com
+Description:
+		Operating-mode telemetry reported by the SRA sensor that
+		indicates whether the device is detected outside a bag.
+
+		Access: Read only
+		Valid values: unsigned integer
+
+What:		/sys/bus/pci/drivers/pcie_mp2_amd/*/on_table_state
+Date:		August 2026
+Contact:	Basavaraj.Natikar@amd.com
+Description:
+		Operating-mode telemetry reported by the SRA sensor that
+		indicates whether the device is placed on a table or on a lap.
+
+		Access: Read only
+		Valid values: unsigned integer
+
+What:		/sys/bus/pci/drivers/pcie_mp2_amd/*/hinge_angle
+Date:		August 2026
+Contact:	Basavaraj.Natikar@amd.com
+Description:
+		Operating-mode telemetry reported by the SRA sensor that
+		reports the hinge angle of the device in degrees.
+
+		Access: Read only
+		Valid values: unsigned integer (degrees)
+
+What:		/sys/bus/pci/drivers/pcie_mp2_amd/*/lid_status
+Date:		August 2026
+Contact:	Basavaraj.Natikar@amd.com
+Description:
+		Operating-mode telemetry reported by the SRA sensor that
+		indicates whether the device lid is open or closed.
+
+		Access: Read only
+		Valid values: unsigned integer
+
+What:		/sys/bus/pci/drivers/pcie_mp2_amd/*/device_mode
+Date:		August 2026
+Contact:	Basavaraj.Natikar@amd.com
+Description:
+		Operating-mode telemetry reported by the SRA sensor that
+		reports the platform/device mode.
+
+		Access: Read only
+		Valid values: unsigned integer
diff --git a/MAINTAINERS b/MAINTAINERS
index 5c57cbb68060..ad3477693db5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1331,6 +1331,7 @@ AMD SENSOR FUSION HUB DRIVER
 M:	Basavaraj Natikar <basavaraj.natikar@amd.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-amd-sfh
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 F:	drivers/input/misc/amd_sfh_tabletmode.c
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
index db1cc205d25b..8af4df09760f 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_sysfs.c
@@ -8,6 +8,7 @@
  * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
  */
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/string_choices.h>
 #include <linux/sysfs.h>
@@ -15,6 +16,7 @@
 #include "amd_sfh_common.h"
 #include "amd_sfh_sysfs.h"
 #include "sfh1_1/amd_sfh_init.h"
+#include "sfh1_1/amd_sfh_interface.h"
 
 static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -41,19 +43,78 @@ static ssize_t hpd_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(hpd);
 
+/* Operating-mode telemetry reported by the SRA sensor, exposed read-only. */
+static int amd_sfh_read_op_mode(struct amd_mp2_dev *mp2, struct sfh_op_mode *mode)
+{
+	struct sfh_accel_data accel_data;
+	void __iomem *sensoraddr;
+
+	if (!mp2->sfh1_1_ops || !mp2->dev_en.is_sra_present)
+		return -ENODEV;
+
+	if (mp2->mp2_ver >= MP2_VER_1_2) {
+		sensoraddr = mp2->vsbase +
+			(SRA_IDX * SENSOR_DATA_MEM_SIZE_DEFAULT) +
+			OFFSET_SENSOR_DATA_DEFAULT;
+		memcpy_fromio(&accel_data, sensoraddr, sizeof(struct sfh_accel_data));
+		mode->val = accel_data.c2p3_data;
+	} else {
+		mode->val = readl(mp2->mmio + amd_get_c2p_val(mp2, 3));
+	}
+
+	return 0;
+}
+
+#define SFH_OP_MODE_ATTR(_name, _field)					\
+static ssize_t _name##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);			\
+	struct sfh_op_mode mode;					\
+	int ret;							\
+									\
+	ret = amd_sfh_read_op_mode(mp2, &mode);				\
+	if (ret)							\
+		return ret;						\
+									\
+	return sysfs_emit(buf, "%u\n", mode.op_mode._field);		\
+}									\
+static DEVICE_ATTR_RO(_name)
+
+SFH_OP_MODE_ATTR(in_bag_state, inbagstate);
+SFH_OP_MODE_ATTR(out_bag_state, outbagstate);
+SFH_OP_MODE_ATTR(on_table_state, ontablestate);
+SFH_OP_MODE_ATTR(hinge_angle, angle);
+SFH_OP_MODE_ATTR(lid_status, lidstatus);
+SFH_OP_MODE_ATTR(device_mode, devicemode);
+
 static umode_t sfh_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
 
-	if (!mp2->sfh1_1_ops || !mp2->dev_en.is_hpd_present)
+	if (!mp2->sfh1_1_ops)
+		return 0;
+
+	if (attr == &dev_attr_hpd.attr) {
+		if (!mp2->dev_en.is_hpd_present)
+			return 0;
+	} else if (!mp2->dev_en.is_sra_present) {
+		/* operating-mode telemetry requires the SRA sensor */
 		return 0;
+	}
 
 	return attr->mode;
 }
 
 static struct attribute *sfh_attrs[] = {
 	&dev_attr_hpd.attr,
+	&dev_attr_in_bag_state.attr,
+	&dev_attr_out_bag_state.attr,
+	&dev_attr_on_table_state.attr,
+	&dev_attr_hinge_angle.attr,
+	&dev_attr_lid_status.attr,
+	&dev_attr_device_mode.attr,
 	NULL,
 };
 
-- 
2.34.1

