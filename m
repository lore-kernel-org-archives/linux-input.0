Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3535335B4;
	Thu, 10 Sep 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059820; cv=fail; b=cJo7OrLtqkJp8mX8UHYLBjn66+tZw+TUQyjA/SCMST+5RcVa0MGhlCucVL2rMf2TRZZj54e+b5KfAPDSPYUak4Aqc2/8ViJhRyECS3PBF6U8kWYDkrLLEFAVCcwSCPlXzIH51sdpKysdGkhnxoV2n5y6H6SsQcYa/P7bxUl3WcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059820; c=relaxed/simple;
	bh=P/kZhoaW4B+Vb4tYSXyPVjh9QCdtESqdc5agU73dpOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7rJJoJKxvtjQp8XZbDomoUzXbWux25MFZtDAtFST9yczVGtLT6mdWEdHz1rtFIrMSs8HjtS/d3mPBBpHBDGVqt3iiCW1n6+8Yr+7oHh/fISfvd9jk6PhMxxi/d3Q9VgxtNy68DRM8k/5TTsAI1oDncDq8Why86MDZdHgfRvNzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=op3YoTBQ; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="op3YoTBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaHREHSmXidG4dG3EGDFO9nsVT9lS/M12BcqVuKlmNUIsZJzKLLLcH/q5rI8G99KwQy2V+2z3ow/PJiQLceeDQ7Yk3aVJicVkymDMV2BAjut9/nVbsMH4MRGFn3L7vlSEQr3LPXnS0SALzP01ndSMzoZcUXs8GlwdCebKrX03p+aPqu58VzF8Id5HBlX1ZadhI0PXZ/v4L4Qv3MNo2Cx+EYlb60/R6I1wmUYHt0+uAFQ2Ifs1iM6zS9FAu5GU0/Ihx1OAbsjj5TAobUmTWBa+QLjGZFs/V29Q5JQ4/289foSY8hQgqiSOw+rgZdMPSqj15zNrgJJ8oi0JERMVqQ0Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXGnD71+ZmzvAQrL5HcEtwuhWbweiN6C2slVimsvaIY=;
 b=stTaDNeUi6M+2QmoTzidGpAUZXRzenHT71dDi4k5et1wrnV9L7xURrktdcLCpGyzUalfufsY8FBA93dVa+PQoPN1uaBr6umHxPNFXLWIONJuPrfSxWyPC97+tDfVa622R5tFsIdTuxYyeWcmyfAlRhBM7yo8Ab1zR4+X7GiHAIy+iIkFC6DG1NrNmS7rGKP0g1gON8b6/WasvEq/0c8Epeg5I2fpxKRp2x3AVtLSMiSKiwi1+QOsqMHDH2I27kZ0hFe/J+rf/64jXD0RJvL4zMtRqKci72GD5yYfF81gT7BITlHmBLnjmlwMF7hYBelw5IaqzkHM144lpjdUgwUUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXGnD71+ZmzvAQrL5HcEtwuhWbweiN6C2slVimsvaIY=;
 b=op3YoTBQiNCq6lmj0TCfgjSCRQZIJTrPw4OXVtG5i5tqpT5vDmBZScZnAwlfxtqIuXfA8iMJdu2DMNb4BB3y41kcJ34hd5eENibIYYi+K8Ko0SynpaPcivTbPJy1Yw5mKsYET7PpWf+cAYmrLN7hudLqTTg+uGudVYEnneBfP8U=
Received: from PH7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::12)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 17:03:16 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::97) by PH7P220CA0006.outlook.office365.com
 (2603:10b6:510:326::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 17:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 17:03:15 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 12:03:11 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Pierre-Loup Griffais <pgriffais@valvesoftware.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER"
	<linux-input@vger.kernel.org>, "open list:USB SUBSYSTEM"
	<linux-usb@vger.kernel.org>, Curtis Vogt <curtis.vogt@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/3] HID: valve-index: Reboot headset on system power transitions
Date: Thu, 10 Sep 2026 12:02:53 -0500
Message-ID: <20260910170254.833871-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910170254.833871-1-mario.limonciello@amd.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0479bb6c-a90b-4a71-3733-08df0f5d6807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	q39GxoTHv2IkRMr/UbtePC8BvPdjmiS51fTwS4Cz5hf1BPK+65/ERR14MClBQCrturKZZicoGDs/zvZH3aL+7ZkN3ZB4B7lkfS014Bq/wiiN/we3hJ2DGhkGeJSxc4Tswudw6O85i4GZXgNN8ZmzzSy9xcF6DJzappsZcEyN8AfxrgztPlj0TtRgt6ppJF3nz8QSQau4D+/aOEx+HL6xthLDbkx65/EHwiejqFtHRjPbLf2dOzbBCkvCIHrKSEPP/hKB1xyHF2v8mNutfeq7ZrTiDXjGnjhV9xWwE80eMPOcUTbNGJuV9Q8DqMSVuc8Kz082rsni2u4FNm1LFmlEctIFMatq6GXpuHZZYXsuBhWEqstSpPjA+jB4iE75bVmX3OW9i3YHp7sVABQSD73/YO5c5EcgnGjhNrCRGW1qcYNrI7nVRSAOmUXoqv2qZkf86IcT8Ycp3OYfdBp+cZphYC6CdNdcJopMaOisLhnrrCnSah/HJue7vKKcRROqcsj7HTxlb0gVYvyiFeVml6WH+BXWhmAXdNrhEhN0JHrLbZR7TZhijZmuPiRV82nl/6NZ9nDqr8mRC3rCpBCUptYrwQ0mIWvaJQgeavmq7c0inwVZBL+F2wI4hkFts6WzVH0fXgT5NoMwoASvydd6OPlzhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BWrlUaofT/+UKjVdROge4S4Bn3yGrlibTWAyY/t5eWmLpV6ipJHSDuBVJL0+FwPydhfSaqcLc18oJxn4zh24L0TR83QLiQwFux3dNPy51uiHtZj4qfxm9l5q1i5CGqa/wIrK/bazSDvAHwHJWM55HDUBooobuyaXKHvbhKefwefCL7+PvrTAKHOwZ4hTnswSIdelMf2YyC2O2KtMRlG0h4t20T30KUNuuYhAUSYTRZL2B5rL3Y/Gm7JAODp4FzjuKF+2576HoXnwp+9WvXNLX3IKE3t58HytZM/AvjfXxIGIZ28CKOvOs8MW4CFflSJEueN2d2mG9dpGZl+geGaxgqJMgi42WA7homNLW4OHbfY1vgg707UH+sLtrbnk3xj3WwKvyp8pTh4cBbRmBhn0KKiSJFGnfklNS3JqzVXU2R3ZVKXwj3j6TyNvYZ2UNV7m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:03:15.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0479bb6c-a90b-4a71-3733-08df0f5d6807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

The Valve Index HMD stops serving its EDID after the host disables the
DisplayPort PHY.  The headset remains powered by its breakout box across
suspend and shutdown, so the bad state survives and the next connector
detection reports "No EDID read".  The HMD then appears as a synthesized
640x480 display until it is power-cycled.

The 64-byte HID output report 0x16 with command 0x01 reboots the headset
and restores its EDID service.  Add a device-specific driver which sends
this report for system sleep transitions and orderly shutdown while leaving
runtime autosuspend alone.

Resume a runtime-suspended interface for a shutdown request and restrict
the command to the composite interface which declares report 0x16.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4333
Link: https://github.com/ValveSoftware/SteamVR-for-Linux/issues/939
Assisted-by: LLM
Co-developed-by: Curtis Vogt <curtis.vogt@gmail.com>
Signed-off-by: Curtis Vogt <curtis.vogt@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../ABI/testing/sysfs-driver-hid-valve-index  |  12 ++
 drivers/hid/Kconfig                           |  11 ++
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-ids.h                         |   1 +
 drivers/hid/hid-valve-index.c                 | 142 ++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-valve-index
 create mode 100644 drivers/hid/hid-valve-index.c

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-valve-index b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
new file mode 100644
index 0000000000000..47d8c26b1eace
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-valve-index
@@ -0,0 +1,12 @@
+What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/reboot
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Writing a boolean true value reboots the Valve Index headset to
+		recover its EDID service. Writing a boolean false value has no
+		effect. This file is write-only.
+
+		The Valve Index is a composite HID device. The reboot command is
+		only supported by the interface that provides the headset's 64-byte
+		output report. Writing true to this file on another interface fails
+		with -ENODEV.
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a81bf51cbcf10..8ea2dd570058f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -547,6 +547,17 @@ config HID_WALTOP
 	help
 	Support for Waltop tablets.
 
+config HID_VALVE_INDEX
+	tristate "Valve Index headset"
+	depends on USB_HID
+	help
+	  Support for the Valve Index headset. This driver works around the
+	  headset failing to provide its EDID after a DisplayPort link shutdown
+	  by rebooting the headset on resume from system suspend and at shutdown.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called hid-valve-index.
+
 config HID_VIEWSONIC
 	tristate "ViewSonic/Signotec"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b245eed..21f512cab6250 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -156,6 +156,7 @@ obj-$(CONFIG_HID_XIAOMI)	+= hid-xiaomi.o
 obj-$(CONFIG_HID_XINMO)		+= hid-xinmo.o
 obj-$(CONFIG_HID_ZEROPLUS)	+= hid-zpff.o
 obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
+obj-$(CONFIG_HID_VALVE_INDEX)	+= hid-valve-index.o
 obj-$(CONFIG_HID_VIEWSONIC)	+= hid-viewsonic.o
 obj-$(CONFIG_HID_VRC2)		+= hid-vrc2.o
 obj-$(CONFIG_HID_HUAWEI)	+= hid-huawei.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3aca5aa91767..15cd29a338a8d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1391,6 +1391,7 @@
 #define USB_DEVICE_ID_STEAM_CONTROLLER_IBEX_BLE	0x1303
 #define USB_DEVICE_ID_STEAM_CONTROLLER_PROTEUS	0x1304
 #define USB_DEVICE_ID_STEAM_CONTROLLER_NEREID	0x1305
+#define USB_DEVICE_ID_VALVE_INDEX_HEADSET	0x2300
 
 #define USB_VENDOR_ID_STEELSERIES	0x1038
 #define USB_DEVICE_ID_STEELSERIES_SRWS1	0x1410
diff --git a/drivers/hid/hid-valve-index.c b/drivers/hid/hid-valve-index.c
new file mode 100644
index 0000000000000..43c1142b7215b
--- /dev/null
+++ b/drivers/hid/hid-valve-index.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for the Valve Index headset
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define VALVE_INDEX_REBOOT_REPORT_ID	0x16
+#define VALVE_INDEX_REBOOT_CMD		0x01
+#define VALVE_INDEX_REPORT_SIZE		64
+
+static bool valve_index_has_reboot_report(struct hid_device *hdev)
+{
+	struct hid_report *report;
+
+	/*
+	 * The reboot command is a vendor protocol carried in the unnumbered
+	 * 64-byte output report of the headset's third interface; the first
+	 * data byte is the command id.  Report 0x16 is only declared as a
+	 * feature report and is not what the command is sent as.
+	 */
+	report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[0];
+
+	return report && hid_report_len(report) == VALVE_INDEX_REPORT_SIZE;
+}
+
+static void valve_index_reboot(struct hid_device *hdev, bool wake)
+{
+	u8 *report;
+	int ret;
+
+	if (!valve_index_has_reboot_report(hdev))
+		return;
+
+	/* USB transfer buffers must be DMA-able, so not on the stack. */
+	report = kzalloc(VALVE_INDEX_REPORT_SIZE, GFP_KERNEL);
+	if (!report)
+		return;
+	report[0] = VALVE_INDEX_REBOOT_REPORT_ID;
+	report[1] = VALVE_INDEX_REBOOT_CMD;
+
+	if (wake) {
+		ret = hid_hw_power(hdev, PM_HINT_FULLON);
+		if (ret < 0) {
+			hid_warn(hdev, "failed to resume headset for reboot: %d\n",
+				 ret);
+			goto out;
+		}
+	}
+
+	/* Use the same interrupt-out then SET_REPORT fallback as hidraw. */
+	ret = hid_hw_output_report(hdev, report, VALVE_INDEX_REPORT_SIZE);
+	if (ret == -ENOSYS)
+		ret = hid_hw_raw_request(hdev, report[0], report,
+					 VALVE_INDEX_REPORT_SIZE,
+					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		hid_warn(hdev, "failed to reboot headset: %d\n", ret);
+	else if (ret != VALVE_INDEX_REPORT_SIZE)
+		hid_warn(hdev, "short headset reboot report: %d\n", ret);
+
+	if (wake)
+		hid_hw_power(hdev, PM_HINT_NORMAL);
+out:
+	kfree(report);
+}
+
+/*
+ * The suspend and shutdown hooks only cover orderly power transitions.  After
+ * a crash, a hard reset or a power cut the headset is left in the state where
+ * its EDID no longer reads, and nothing recovers it until the next orderly
+ * transition.  Expose the reboot command as a write-only "reboot" attribute
+ * on the HID device so userspace can recover it, for instance from a udev
+ * rule that fires only when the connector reports no EDID.  Writing to an
+ * interface that does not carry the reboot report returns -ENODEV.
+ */
+static ssize_t reboot_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	bool val;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+	if (!val)
+		return count;
+	if (!valve_index_has_reboot_report(hdev))
+		return -ENODEV;
+
+	valve_index_reboot(hdev, true);
+
+	return count;
+}
+static DEVICE_ATTR_WO(reboot);
+
+static struct attribute *valve_index_attrs[] = {
+	&dev_attr_reboot.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(valve_index);
+
+/*
+ * The headset's EDID service is lost when the host disables the DisplayPort
+ * PHY during system suspend, so it needs the reboot on the way out of
+ * suspend.  Doing it on the way in does not work: the headset dropping off
+ * USB is a remote-wakeup event from its hub and aborts the suspend.
+ */
+static int valve_index_resume(struct hid_device *hdev)
+{
+	valve_index_reboot(hdev, false);
+
+	return 0;
+}
+
+static void valve_index_shutdown(struct hid_device *hdev)
+{
+	valve_index_reboot(hdev, true);
+}
+
+static const struct hid_device_id valve_index_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VALVE,
+			 USB_DEVICE_ID_VALVE_INDEX_HEADSET) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, valve_index_devices);
+
+static struct hid_driver valve_index_driver = {
+	.name = "valve-index",
+	.id_table = valve_index_devices,
+	.resume = valve_index_resume,
+	.reset_resume = valve_index_resume,
+	.shutdown = valve_index_shutdown,
+	.driver.dev_groups = valve_index_groups,
+};
+module_hid_driver(valve_index_driver);
+
+MODULE_AUTHOR("Mario Limonciello <mario.limonciello@amd.com>");
+MODULE_DESCRIPTION("HID driver for Valve Index headset");
+MODULE_LICENSE("GPL");
-- 
2.43.0

