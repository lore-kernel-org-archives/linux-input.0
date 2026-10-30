Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394052;
	b=4mOmLyj+t2KMFVt3LWDiXOS6fw6ZdwWfV2EtfEEkXQiz6KhprXt4No6Fb54Z8wHJG3CL
	 015RTLOf7hGXLe/7tbSx+s6Y8o8cKP3f5iIxhOCutmvP96InEf7/KCcOIkQLd2fgVG6eF
	 h7FP4wuHwjQB4wCsLCpvRO/gMi/rpE3UUBDZf2YguIA/U6K8rVIOAV+ROteG3QXpC9S8H
	 O5pMffb8finUr+I8DkHGeRIuyH9Z+Ahvv+fCC41q2+/rti3nb8pbLppblw3Z41UWHiy88
	 F04xG/KSTouZGBl3ZNrY/hxja6Mn0yYSqlrB6kOCQUbKP9EFQFadyJCDWwUZf6YloCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NtwG53TQ5F87dBAdZYDpDCeqhBAdqeJCq1GWNAqGhsU=;
	b=I7CICvmoejEbdUWfmcgZm3A3kS/1nxKakS7Platy/Y4JHyf/KF2IjtSP8roKgYjytvzV
	 8/r5r1A4cK7IV7gAKr9MCy3zqvoAdf4OiQqtL2SAsWmL1wneWfqV5tkZ7H+DFHNjTfN4P
	 N97C9Am3EiEEGXi4+33rugxnHNTFOXvZ5sn3eSYoe9vX8hnJo8mwzzgeiGHwTtCO1gBcK
	 ZudYf6c/0S9YvtCpURFKBNyqf+Y8DrpaAatgMWUeUrdrDEXxAYlIJLnbhrZF6Qg6SaIxM
	 GwRxJ/V/U1AMv5R3uqBOZEOtUfN7JQt/GynKmFQPFFBosV+QlAjgStHPelG8NEvujuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZBn9+IA;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F860A2606
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 21:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 328F860A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZBn9+IA
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2af4c8d00so171891c88.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394050; x=1793998850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtwG53TQ5F87dBAdZYDpDCeqhBAdqeJCq1GWNAqGhsU=;
        b=NZBn9+IAhxnj1gilo2uCER5PABOBVXeDBmHGLADWMvKU+HhJYEE+ppK8BBB51bOHZQ
         oQcPbyNItzghqTPgmLX7vOEIzHmGBFMMbxbbvjMR8rGjb3qrZ21zLhkh9GHdwWusY2x8
         zXJFoWPYbldQdfMgImAYE2xz5tcsXDNwxeRZe2nfx/Gnr2itgcCVSR0nNhfDpMyT191U
         vNqDiU9I+l0QXg4/5+Ix+HmD5Gci/HyjG8iNl3MxYu12fPpAI7GbiNXQ7Z/8DlL+eTVP
         qbLrx6QZbLAwrgDfoDwx4KuqjEPS3bGRSd1teG2QAYVYt+I2aRAoDbXCZzdJCKJ4n1ow
         00fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394050; x=1793998850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NtwG53TQ5F87dBAdZYDpDCeqhBAdqeJCq1GWNAqGhsU=;
        b=i+oI7HzNmc6DblnnAb1l8Bm7hgpoRjq8wgN5KyPATD+ILSg5NxywVoeW0dvZKXaCUj
         7wgCGvvXZVfEMiMe9/vcf7soYm4ZXSfZu1tgI1faBm98vTwjfG1q/ZbhQxzjbgfl8SyB
         4h26O3Ea56IDAvxeahn30iTITQ5FQYcZox7PbxrR8Ox2nP9c87EWuJBiksEDgExEOTyH
         7ctsFmQdmHlISIPnngjGPPwEnq+5f1ssdZ1Q5i6ID+3uvr5ngKHNMjJ4hsPntzoTikin
         P3KMT2fSX1RQsWpg6bVLEeLCl6btnT+YehkMiQMHhZTYD4U5m/OtiNnOnSFhPVY76SPp
         Qbjg==
X-Forwarded-Encrypted: i=1; AKwUvBzG2HJFpRfyoKaSD7VBEtZjHpd54Ez4q8N7DCJkNMq4j0Y1i+cTf/EIdZrg8h0WpBN8vE4mxv1z4HH5ig==@vger.kernel.org
X-Gm-Message-State: AFq9FYIMLwAOXhV+8yw+EGm+DZ5mvjiJurROUVGEROpKL2gvlIfl4E6C
	ATpvHXCfoXym1RIMoi4KrbQSH0+Ui693VK2A2M309XjPgNtr6pKKN7y6
X-Gm-Gg: AYBFou3MreSPw4BpGCtWnYxjj2KE6Cke3qzB/cSHFvPmHOzJE2aAI0OIugzEZZ4wmC0
	fTFcaoUY21pX1fM9zbOLKGd12GlsllyMU8G+R1GtyPfQzy30zU+ZZQA5LxlehK1j1ESEJuMWJfi
	PiAsBIpI9J/ghFQzrsteVOe1UZNzAiP3tb/pswGAVddGb58q5NN0zC4nI85OULvd+dEJaiT6nv6
	CP5XIsegQxHCEhOT6uMY7B0FqU2pyGt44Q+7tq/XK+2Y+VD+wdi8WtWgUfdKkBWlYh80lpuBy4H
	hI6spnYq9sHEa5zKKRashmY2a4+LC4qpR5ufqIrE1+xtgiCr1JDhqcLinn8Qzxh4Wx/mnd8RIHV
	F40IcUuaaQef1Ks+4+O321BvJ2C/kmbEP4yybPpEWkGyhctWi5lUi/SuvY/uGcLlR5DcmIA22kq
	IVwTPgjan5PxX7cpjXxaCzJ53k01N38oj+MtvMShK/rbnkmedsmrEDgsMUjjZBcEaM+giyMRuV2
	BqYi/ATRNUAdO6tpqjDR0Nvdh3o6TQPXuVTzPkoWuXYG0owik1J8yRLtc7j4FPFJ+HVIXGW3Wel
	WlR8mAlm3AdhDiHQye1DJa+pbtmkfenMLCZeq2dUYcP1peWVdaRyqG29rQ3j6nYx4JSmMkKgee+
	OsueykrrRJ2InLOzBBHahx2DQP7cM8mCT8j6E4lcEABh4dm4hnFa0bLtU5QGGSHR4qa4/I9lnB7
	6Ong4CoRAhK+6z7Zdbd1GEVFEU7SjByBFOMp6RmxpaXC4IG2hG6gzhCuhEpBzPU1JdzQeWek3bP
	whSVdL2BCzYKFsqfjkPHe8wst87DH5jQXxqPQ==
X-Received: by 2002:a05:7022:f106:b0:163:bee9:b250 with SMTP id a92af1059eb24-1ac5ac4f047mr4518326c88.22.1793394049943;
        Fri, 30 Oct 2026 14:00:49 -0700 (PDT)
Received: from seppy (wsip-70-166-193-51.ph.ph.cox.net. [70.166.193.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm9157444c88.15.2026.10.30.14.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:00:49 -0700 (PDT)
From: Ethan Jimmy <duhxu0@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux@roeck-us.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Jimmy <duhxu0@gmail.com>
Subject: [PATCH v2] hwmon: (acer-aspire14-ec) Add driver for Acer Aspire 14 52MT and 52M fan
Date: Fri, 30 Oct 2026 14:00:37 -0700
Message-ID: <20261030210037.921646-1-duhxu0@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <0dee51d4-c153-457a-a3aa-ebf1177df045@roeck-us.net>
References: <0dee51d4-c153-457a-a3aa-ebf1177df045@roeck-us.net>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Aspire A14-52M and A14-52MT expose fan speed through an I2C HID
embedded controller that also serves the keyboard. The same product id
is used by other Acer keyboards, so the driver binds only when DMI
matches these two models.

Signed-off-by: Ethan Jimmy <duhxu0@gmail.com>
---
Changes in v2:
- Removed mutex.
- Probe returns the error when the fan report is missing, an
  allocation fails, or hwmon registration fails, and stops the HID
  device.
- Remove type/attr/channel checks in read() and is_visible().
  is_visible() always returns 0444.
- Reject a SET_REPORT whose transferred length is not the feature
  report length.

The keyboard path is unchanged from v1. On the Aspire A14-52M and
A14-52MT, hid_hw_start() is called with HID_CONNECT_DEFAULT |
HID_CONNECT_DRIVER, so the HID keyboard stays connected. Other machines
with product id 0x174b do not match the DMI table and stay with
hid-generic.

v1: https://lore.kernel.org/linux-hwmon/20261010041313.34153-1-duhxu0@gmail.com/

 Documentation/hwmon/acer-aspire14-ec.rst |  38 ++++
 Documentation/hwmon/index.rst            |   1 +
 MAINTAINERS                              |   8 +
 drivers/hwmon/Kconfig                    |  20 ++
 drivers/hwmon/Makefile                   |   1 +
 drivers/hwmon/acer-aspire14-ec.c         | 255 +++++++++++++++++++++++
 6 files changed, 323 insertions(+)
 create mode 100644 Documentation/hwmon/acer-aspire14-ec.rst
 create mode 100644 drivers/hwmon/acer-aspire14-ec.c

diff --git a/Documentation/hwmon/acer-aspire14-ec.rst b/Documentation/hwmon/acer-aspire14-ec.rst
new file mode 100644
index 000000000000..73acfb181c39
--- /dev/null
+++ b/Documentation/hwmon/acer-aspire14-ec.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver acer-aspire14-ec
+==============================
+
+Supported chips:
+
+  * Acer Aspire 14 AI 52MT/52M embedded controller
+
+    Prefix: 'aspire14_ec'
+
+    Addresses scanned: none
+
+    Datasheet: unavailable
+
+Author: Ethan Jimmy <duhxu0@gmail.com>
+
+Description
+-----------
+
+This driver monitors the fan on the Acer Aspire 14 AI (Aspire A14-52M
+and A14-52MT). The embedded controller is an I2C HID device (vendor
+0x1025, product 0x174b) that also provides the keyboard.
+
+The device is autodetected on those models. The same product id is used
+by other Acer keyboards; those machines stay with hid-generic. On the
+Aspire A14-52M and A14-52MT this driver provides both the keyboard and
+the fan sensor.
+
+Fan speed is reported in RPM through the standard hwmon attribute
+``fan1_input``. The driver does not change fan speed.
+
+Sysfs entries
+-------------
+
+======================= ======================================================
+fan1_input		Fan speed in RPM
+======================= ======================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 199ca79621e9..9dd16e6ddabd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -22,6 +22,7 @@ Hardware Monitoring Kernel Drivers
    abituguru
    abituguru3
    acbel-fsg032
+   acer-aspire14-ec
    acpi_power_meter
    ad7314
    adc128d818
diff --git a/MAINTAINERS b/MAINTAINERS
index 5ad12c57ca5f..b944f77c7a71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -262,6 +262,14 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-pcie-idio-24.c
 
+ACER ASPIRE 14 AI (A14-52M, A14-52MT) EC FAN DRIVER
+M:	Ethan Jimmy <duhxu0@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/acer-aspire14-ec.rst
+F:	drivers/hwmon/acer-aspire14-ec.c
+
 ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER
 M:	Peter Kaestle <peter@piie.net>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 18c682e1a475..84e9e9c115a1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -67,6 +67,26 @@ config SENSORS_ABITUGURU3
 	  This driver can also be built as a module. If so, the module
 	  will be called abituguru3.
 
+config SENSORS_ACER_ASPIRE14_EC
+	tristate "Acer Aspire 14 AI EC fan sensor"
+	depends on HID
+	depends on X86 || COMPILE_TEST
+	depends on DMI || COMPILE_TEST
+	depends on I2C_HID_ACPI || I2C_HID_OF || COMPILE_TEST
+	help
+	  If you say yes here you get support for reading the fan
+	  speed from the embedded controller on the Acer Aspire 14 AI
+	  (Aspire A14-52M and A14-52MT). The controller is an I2C HID
+	  device (vendor 0x1025, product 0x174b) that also provides the
+	  keyboard. Fan speed is read-only.
+
+	  The same product id is used by other Acer keyboards. This driver
+	  registers only on the Aspire A14-52M and A14-52MT, where it also
+	  provides the keyboard. Other machines stay with hid-generic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called acer-aspire14-ec.
+
 config SENSORS_SMPRO
 	tristate "Ampere's Altra SMpro hardware monitoring driver"
 	depends on MFD_SMPRO
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d4c345ed7261..ac5cec462c81 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
 
 obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
 obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
+obj-$(CONFIG_SENSORS_ACER_ASPIRE14_EC) += acer-aspire14-ec.o
 obj-$(CONFIG_SENSORS_AD7314)	+= ad7314.o
 obj-$(CONFIG_SENSORS_AD7414)	+= ad7414.o
 obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
diff --git a/drivers/hwmon/acer-aspire14-ec.c b/drivers/hwmon/acer-aspire14-ec.c
new file mode 100644
index 000000000000..939b048165c5
--- /dev/null
+++ b/drivers/hwmon/acer-aspire14-ec.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hwmon driver for the Acer Aspire 14 AI embedded controller.
+ *
+ * Author: Ethan Jimmy <duhxu0@gmail.com>
+ *
+ * On the Aspire A14-52M and A14-52MT the EC is an I2C HID device
+ * (vendor 0x1025, product 0x174b) that also serves the keyboard. The same
+ * product id is used by other Acer keyboards. The HID driver is registered
+ * only when DMI matches these models, so those machines stay with hid-generic.
+ *
+ * Fan speed is read with one feature report: A0 00 A0 08 00 02 02. The
+ * reply carries a little-endian status word, command id, and RPM.
+ */
+
+#include <linux/dmi.h>
+#include <linux/hid.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#define ACER_ASPIRE14_VID 0x1025
+#define ACER_ASPIRE14_PID 0x174b
+#define ACER_ASPIRE14_REPORT_ID 0xa0
+#define ACER_ASPIRE14_PREFIX 0xa0
+#define ACER_ASPIRE14_CMD_MARK 0x02
+#define ACER_ASPIRE14_RPM_OFFSET 8
+#define ACER_ASPIRE14_MIN_REPLY (ACER_ASPIRE14_RPM_OFFSET + sizeof(u16))
+#define ACER_ASPIRE14_STATUS_OK 0xe000
+#define ACER_ASPIRE14_CMD_FAN_RPM 0x0008
+
+struct acer_aspire14_data {
+	struct hid_device *hdev;
+	struct device *hwmon_dev;
+	u8 *buf;
+	u32 report_len;
+};
+
+static int acer_aspire14_fan_rpm(struct acer_aspire14_data *data, long *val)
+{
+	u16 status, command_id;
+	int ret;
+
+	memset(data->buf, 0, data->report_len);
+	data->buf[0] = ACER_ASPIRE14_REPORT_ID;
+	data->buf[2] = ACER_ASPIRE14_PREFIX;
+	put_unaligned_le16(ACER_ASPIRE14_CMD_FAN_RPM, &data->buf[3]);
+	data->buf[5] = ACER_ASPIRE14_CMD_MARK;
+	data->buf[6] = ACER_ASPIRE14_CMD_MARK;
+
+	ret = hid_hw_raw_request(data->hdev, ACER_ASPIRE14_REPORT_ID, data->buf,
+				 data->report_len, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	if (ret < 0)
+		return ret;
+	if (ret != data->report_len)
+		return -EIO;
+
+	memset(data->buf, 0, data->report_len);
+	data->buf[0] = ACER_ASPIRE14_REPORT_ID;
+	ret = hid_hw_raw_request(data->hdev, ACER_ASPIRE14_REPORT_ID, data->buf,
+				 data->report_len, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+	if (ret < 0)
+		return ret;
+	if (ret < ACER_ASPIRE14_MIN_REPLY)
+		return -EIO;
+
+	status = get_unaligned_le16(&data->buf[1]);
+	command_id = get_unaligned_le16(&data->buf[3]);
+	if (status != ACER_ASPIRE14_STATUS_OK ||
+	    command_id != ACER_ASPIRE14_CMD_FAN_RPM)
+		return -EIO;
+
+	*val = get_unaligned_le16(&data->buf[ACER_ASPIRE14_RPM_OFFSET]);
+	return 0;
+}
+
+static int acer_aspire14_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct acer_aspire14_data *data = dev_get_drvdata(dev);
+
+	return acer_aspire14_fan_rpm(data, val);
+}
+
+static umode_t acer_aspire14_is_visible(const void *drvdata,
+					enum hwmon_sensor_types type, u32 attr,
+					int channel)
+{
+	return 0444;
+}
+
+static const struct hwmon_channel_info *const acer_aspire14_info[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT), NULL
+};
+
+static const struct hwmon_ops acer_aspire14_ops = {
+	.is_visible = acer_aspire14_is_visible,
+	.read = acer_aspire14_read,
+};
+
+static const struct hwmon_chip_info acer_aspire14_chip_info = {
+	.ops = &acer_aspire14_ops,
+	.info = acer_aspire14_info,
+};
+
+static const struct dmi_system_id acer_aspire14_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Aspire A14-52M"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Aspire A14-52MT"),
+		},
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(dmi, acer_aspire14_dmi_table);
+
+static u32 acer_aspire14_fan_report_len(struct hid_device *hdev)
+{
+	struct hid_report *report;
+	u32 len;
+
+	report = hdev->report_enum[HID_FEATURE_REPORT]
+			 .report_id_hash[ACER_ASPIRE14_REPORT_ID];
+	if (!report)
+		return 0;
+
+	len = hid_report_len(report);
+	if (len < ACER_ASPIRE14_MIN_REPLY || len > HID_MAX_BUFFER_SIZE)
+		return 0;
+
+	return len;
+}
+
+static int acer_aspire14_probe(struct hid_device *hdev,
+			       const struct hid_device_id *id)
+{
+	struct acer_aspire14_data *data;
+	struct device *hwmon_dev;
+	long rpm;
+	u32 report_len;
+	int ret;
+
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER);
+	if (ret)
+		return ret;
+
+	report_len = acer_aspire14_fan_report_len(hdev);
+	if (!report_len) {
+		ret = -ENODEV;
+		goto stop;
+	}
+
+	data = devm_kzalloc(&hdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto stop;
+	}
+
+	data->buf = devm_kzalloc(&hdev->dev, report_len, GFP_KERNEL);
+	if (!data->buf) {
+		ret = -ENOMEM;
+		goto stop;
+	}
+	data->report_len = report_len;
+
+	data->hdev = hdev;
+	hid_set_drvdata(hdev, data);
+
+	ret = acer_aspire14_fan_rpm(data, &rpm);
+	if (ret)
+		hid_dbg(hdev, "fan report failed: %d\n", ret);
+	else
+		hid_dbg(hdev, "initial fan speed %ld RPM\n", rpm);
+
+	hwmon_dev =
+		hwmon_device_register_with_info(&hdev->dev, "aspire14_ec", data,
+						&acer_aspire14_chip_info, NULL);
+	if (IS_ERR(hwmon_dev)) {
+		ret = PTR_ERR(hwmon_dev);
+		hid_warn(hdev, "failed to register hwmon: %pe\n", hwmon_dev);
+		goto stop;
+	}
+	data->hwmon_dev = hwmon_dev;
+
+	return 0;
+
+stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void acer_aspire14_remove(struct hid_device *hdev)
+{
+	struct acer_aspire14_data *data = hid_get_drvdata(hdev);
+
+	if (data && data->hwmon_dev)
+		hwmon_device_unregister(data->hwmon_dev);
+	hid_hw_stop(hdev);
+}
+
+static int acer_aspire14_reset_resume(struct hid_device *hdev)
+{
+	if (hdev->claimed & HID_CLAIMED_INPUT)
+		hidinput_reset_resume(hdev);
+
+	return 0;
+}
+
+static const struct hid_device_id acer_aspire14_id_table[] = {
+	{ HID_I2C_DEVICE(ACER_ASPIRE14_VID, ACER_ASPIRE14_PID) },
+	{}
+};
+
+static struct hid_driver acer_aspire14_driver = {
+	.name = "acer-aspire14-ec",
+	.id_table = acer_aspire14_id_table,
+	.probe = acer_aspire14_probe,
+	.remove = acer_aspire14_remove,
+	.reset_resume = acer_aspire14_reset_resume,
+};
+
+static int __init acer_aspire14_init(void)
+{
+	if (!dmi_check_system(acer_aspire14_dmi_table))
+		return -ENODEV;
+
+	return hid_register_driver(&acer_aspire14_driver);
+}
+
+static void __exit acer_aspire14_exit(void)
+{
+	hid_unregister_driver(&acer_aspire14_driver);
+}
+
+module_init(acer_aspire14_init);
+module_exit(acer_aspire14_exit);
+
+MODULE_AUTHOR("Ethan Jimmy <duhxu0@gmail.com>");
+MODULE_DESCRIPTION("Acer Aspire 14 AI EC fan driver");
+MODULE_LICENSE("GPL");

base-commit: e1b3c2630d5b8bc755fe4ba86d20d08c734eb504
-- 
2.56.0

