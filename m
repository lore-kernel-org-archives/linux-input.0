Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D13ACA5A
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283111; cv=fail; b=L5E2Do7YEERmBtrQeM5Q8Rvib9QKL5ljUW0jXfs61nm0a8UwJSUWZsOPFPBVvOgAR55BwKUWy9//8U8dRfCniAdgpZP1qtFDlvLFIRUcibC9SEOnrwPC7o9EV01pjxfvEfh/z8JNBkJAHKJWjPR5lzXGba76+Bv6oQtoPEeSjeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283111; c=relaxed/simple;
	bh=ZSC8tv4YkzazDKEkrDelwCUAc3EqJiiW7EC/5XqrLwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0x9uEiuweBZ0d9KLr9v+eFpC6oHPnRi64QSTq30laiCnaCRlpnhrOPuAe+mzJZMoEXlG/f+m3kxdk//T6ztk0RIunq/sTp8gSFpMb4RTUMxgDnCx7GBltWL1EH0Wnq25pV4onomXrkNbpr8BYDU0nmpTw6gVMTApLvMRnygv5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lazomzqh; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lazomzqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDEoa70c5Ti4nXfrbjwuQ9ezTAGaxi3P4PzEN0dbwISKrkiu0+lD8UkdzmHkV+0Ju2gk4CtNV7vJUZ8zXJgPVAPDHIUid9PwNfnBrACNsn/ruB9WQr+jqUl6awt4TtDTFn9GmDCKiNCwUicOgHp8qV1U+66BSlB7dyp44jQJsyplOt7Kyii1tYOJG2QuIYPAMCXRQQGwFXqMUj/jjXwsC6AYYQN1Z2+xjLacQ32l6/U9EXf2WmON7ptTx3dHw18TIYTYAM/qt6EAFcJ1T5fx3vhMeuuslZvQCwVAeBGDsm5C0nM53CbD+VRyDusyrQpEGx31V0idOsz5LM0UGMtu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLpNIbRB67CJ9oUuB+xiuxBOexLwXbq2pirbLI7lC/Q=;
 b=wAQ1AumxphR5ZHnCXvEfO7XLrPBJrxkXKwVGzFJJlUAcDI71lyDJO1tcxBoGXU46R1DPnWjJI4cosa824A+dOlpnYm4KXSNGZrHX+I2Cqo8GXCDhjd2tA5TK7fAt/xX0NqEzaN4NOAVhRMkKFPSKX71wt43KxXs34mwDdlj8sfqbsY3ZIWYjknoKTBv/W7Ibmmy7vzaOxGv0GQLBsx2MhDR7c11/c34nkujGWYGdyWC2IioSsvzZbHThL2gYgOYRqSO/6AFXMbhQV6ocudArDUTF4G+gbhiHzl2TkI4uilE9OIqMBl/ODbYP/NtIx71vRSISfi530+MDjHazOK9/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLpNIbRB67CJ9oUuB+xiuxBOexLwXbq2pirbLI7lC/Q=;
 b=lazomzqh+1fRSjjXrD2SrYRGnvBDgF7xk4hhhBC4tsSqp5Y2Hg3Kot+ie5cR9HX/Loa47dsTtI6DTy1cdZ5v47jdaaBtwyLH4td8vsYkUK6W3l7ax4h8z5Gc3HuiEDECevW7nXJZqPAlTlUssl1vWyvfc7gNV0Nuht/lDdbnrt8=
Received: from BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::30)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 10:38:24 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::25) by BL1P222CA0025.outlook.office365.com
 (2603:10b6:208:2c7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 10:38:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 10:38:24 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 05:38:18 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH -next v2 2/4] HID: amd_sfh: Add operating-mode telemetry sysfs attributes
Date: Tue, 6 Oct 2026 16:07:52 +0530
Message-ID: <20261006103754.3614316-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2c35ba-2f2c-425f-b9ad-08df2395f2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QEoC9HCgaYNITJ0pk/BTY6BnnOnw5ob7qYbgWbs+Vp7zK0HV+K+6M+LT8BpGc77NCzlsZNeo9MY61+L/KZxGbJvMmkMENd0JFynkqFHWe6fGX4p97bgJQetgDnROA1KSRRp1SfTTdB2i975UYMu20YFY7DGf6dSa/XQHvrEOSrjj+MsVH+9S52YjDVxgR1CbwqV1fbywQrDuXVBECtLn2jxjlA7W6cZTUAv7a5ri4ejpviseMjMXLq/EU0ao3TrH1jPJXx6f09cQi7BniAzpD04gkinDAU2k+wlW03RH8OnTcXjscIDs08pt7wcRzKENlxGK6lr+8mHpHogBgsFqq8+IrJIWZLwhl12CA2b6c6qZvwz0zxXt72eO62DAeW8h4r9PENR+tQYxQN+AnsKRKLNJsuE7k7PteLHUmDs/DKuTrOg24mvbgJV7NRdnsmSAs2wvxqlz7IuQ8325Lmre/ZNNvPMRZkGBs57OX7wzXgAehhSxd7Rn6M0w2FwmrLrxW98DVIOvteSJraAIHC74/EHMGfvOe2dz610ZcuXh5lwVYklitIx7kvM8f7NPXRuDOID09nZAuwu8ZMLFDcBc1eMb55ACffYZOPZXWW7Cgemv5j4WqfMTogZvvyq93yE2wMQzH3CKWrOVRrQBR30xGnAkDKoIFnU2vdpCmcMU2HCXdU/GThf2jO/Ns5GF7L36FIfXQrUxp+EVpap68+B+/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B+oTv/8WYwGPuifFHNYA1CjcszRSlJF6SrXd6WzKwc7Rc3SlTthVWtzge/nK4YSR07hu0Ax+gUE7o8gjMN1xjmeFA136eUkM2BcoMFyP+7KfC4qKhDKIhoPxnJpc40NJ4jdgjYZ1CoIMnA/BqmqIFdoYr4cOxxwRyBfaKY2YzdrnvnLK2LHX5ed+3l9ZgYAZtEsERA7y4CebgYlLLBnqZizTBOyi71tsumUfYl2J5T1yZ7nNsmO2jNsFS9czMHUoV7Phn4h4S9Lyskq7t7bacSYdyKZlJfzwOFYbUg+jMPkgltedn4IfP6pzrMJ99WQww44OBPN16eHzP/1whsR3aU/bLzSWoL4NszbJCX9gd308AR8PrMrB9trcvGO3fCZ1yBMPCbCCkppKYO7RLBAR1iHtBhUg2pi2/yYwgz5EuRFDELPy5GRt3EbrSJiw/nXK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:38:24.0967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2c35ba-2f2c-425f-b9ad-08df2395f2d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113

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

