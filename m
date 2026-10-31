Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468820;
	b=NqH5eRBYHTCDI4fRo5wlPm7l4Xpm3M+zwZoVDdK8kFpRr0VxE+Bd6apTLwoA+aNUu0TK
	 oWnhKBPlvu36CMWc7fInMffDu1szuN4DJ5JB8ylZFM8n+tpI6PDFAbAqqQSvQfBn4eQxX
	 /jQ3PNeI0B+mlJR6L/uR+RfLVRctSidQ+fJ+Uc92Dg4Xp3PGtnrRj5AqHp3rJijpBWmw3
	 ZEoOcUQuywZl7vaSKTUR1s4I38AsGWcQW+osX5v4387U3dgP8uiZbjShlgE4A1ppACX/P
	 ZpftmSRJA/9FBxs/8Ef36vhOWuSZtgCVwPSMNbO1eEsmUj87g4dlcUYJXwdhXxGDWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R28DQO/6JotghrXwsPG7S/gWS1AxIABuyk+yKRwzDrQ=;
	b=3TYjFsRw/1ybXKMDP8udr6psaePDZCFauudGDntQB5SCU8Ym+X+bHwArrq2Wix65L+Wp
	 kWASh+dLwZ8IFCR1GU9t64hV/4PbulMKIwld1Pwe3zaUGHGhjs7T1cTYsEppxdxpou2GJ
	 0IkZDImIhGll0sCxjXRAk80HkIbb2FQ3lRb94Y7Hu74hfnBNBllKkDM4pQWnSE/5z1NIl
	 T10upy8MrtIsc4AdLmU45UQ+BFh7hTmnd/uMVek0NAQdBJYDiCXs4yp/IOESFvPC3iDic
	 lDD8fOOjA77DpKHIwFsxvhE8rcb+rttsiq+UCIAh8mbF23xaLA17AbYlWXPRL21db1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEuGtKWA;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E782606A329
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E782606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEuGtKWA
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so1726187eec.1
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793468819; x=1794073619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R28DQO/6JotghrXwsPG7S/gWS1AxIABuyk+yKRwzDrQ=;
        b=SEuGtKWA9JjAu5lqh7nAjglIh5Ku7F8U4o8+tioxcGOGdWGrztlez6W3Cl4YCj4sWm
         mflvLZrUoJ9gv5U8VrjOVBr7P688xSsTmyK80w2Vxun8HsIunWc6Egn/9G12+bQQAqWL
         Ln2uDbphE/OVyBW5CisHMmMPTjT89EO+GIFFzpNTbg0MOvNy2aQMgmG3NTLP40P79N8b
         m3Ggb2O6Y+DsmqrR/sP+kiX0flI9Qe/8nvhluBV7sotyuUQLyK4MsWFF0aacaHuifmcX
         bsS4vkYICNqgjTyMikyxXIwPVRKwDLR8Mf2loGAO7Fw7a1hdkH3Ca6RTSf2uHWR7JHkB
         U/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468819; x=1794073619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R28DQO/6JotghrXwsPG7S/gWS1AxIABuyk+yKRwzDrQ=;
        b=kTkRsNFRRslOrETN3hWJty+B5cDdR9wo6MEyczJW1jSldJs8J6uIFmgbpFzxyKSfin
         XVY9d3XBnQgIPZShgJnTPceNEBTEaTxq8eR6VMO8I9RIyNiuXeeP7na15vPqwOrv28vh
         QH9HqOpx/uO1L6Ouxpbki/bQUpQAynyjX66faqIGTqtxNbCSTV3KZmkbAToFXwzReJLn
         3BusEQc9FFkdwvNWrNkGaa8PpvIlcUhs1yIyRWHDrsScae7PEUR73bC0GZPfUaqiv4hn
         JS+2Tyv3+dpC/ixnvzcTN7Ur5MgeH3gR+wLCkuaambajv1wSZl9VfBF3M5zVQPfLrhVf
         SztQ==
X-Forwarded-Encrypted: i=1; AKwUvBym4bQ2Eiq7p8kc4VC5kjhYUIpxwMfXPQ7x5sjQM0lyrxdXbvjIQdKwtB3WsFBv6cXqRCsUEfWFTtapMg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7NMJCANsWWiMrbwgOUa5Eh8hmjg5/ks1MOEqzLq5DVX19Tkmc
	45U6iyabm2yqDfWGjO+hkE6+K1nPDfHyvE1QmGYJeNypNwWx9BcxPRKJmw2jce50z7Q=
X-Gm-Gg: AYBFou2JhZOju+P1YGGmo510kMNUF+zLKkUcJUQ1+FVOQIEgbjwU1G/Csf7Wexd0qUf
	A6MhbabpXJn4RObXJKQeesadaQPYS950/XvWWbDEZuCIHBaeLC5OqJaBfVu3NjxcTVNHefoMMEf
	yd+arYmgssQ4gV8S1BhBQ/cGprWi6+hWmiFND5T37AtBLzF54ujYZKMIbkkyvD4AlfOEVKqsrf2
	WlOrLl14b+sDyJ7WzSocq1K3krWUBbe+S54qp3XR7LECr2/06fvXwWUaa0E/Su/7IhC+Li+FZsa
	7f2M9ydWltSQ1oRnhmgQpoXwVHSTeqY0jEVdSkCRY2DcFVAkejeHA1OjUs/Bc1Gt+jTt+qDeugk
	Bs9pJMWxMAexgffKH0502z3Vpnol16fi3oCpn7hda9tsO+zDpb3AkyQWN+8K+LuwTX7OSq3M0bI
	drs7oHoQMNE3H9SvwGtk+d1vW7wFKZTMEZlMUJoNzAwbnnMrk5RPYPIUFR+mpdUdefHbkef6i/I
	Mv+IN2ROEffjG1Hlljn6ZV6OS17svPMnGv45P0B1DAsx0uivCfrvLI7HYq1SxtxmZRJracwtmB7
	rGUlyeGcjcZlEHD68suN8T0C4oEJ1CImlApU8/hIbstn/Xl9K32zm5jVVTK8+NwlKrRFwVN0VDj
	hB7bNWsE4xoZGP/Zp3ybCNusJtbjnb9tmVoWPgm8v6uhy1BOW7g0wtN8mzHqF2WF5ov5pY6fd3n
	Oth3cTq3D5bmfPof9rDdh4al/ip6/IsmL5fvzrpWY=
X-Received: by 2002:a05:7301:7d1a:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-36a42340bd5mr7652524eec.9.1793468818262;
        Sat, 31 Oct 2026 10:46:58 -0700 (PDT)
Received: from seppy ([2600:8800:206:8e00::7c29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm19901685eec.7.2026.10.31.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:46:57 -0700 (PDT)
From: Ethan Jimmy <duhxu0@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: linux@roeck-us.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Jimmy <duhxu0@gmail.com>
Subject: [PATCH v3] hwmon: (acer-aspire14-ec) Add driver for Acer Aspire 14 52MT and 52M fan
Date: Sat, 31 Oct 2026 10:46:51 -0700
Message-ID: <20261031174651.856627-1-duhxu0@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <388aa474-3606-4c7f-b073-224d5e0880fd@roeck-us.net>
References: <388aa474-3606-4c7f-b073-224d5e0880fd@roeck-us.net>
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
Changes in v3:
- Register with late_initcall() so a built-in driver runs after
  hid_init(). module_init() is device_initcall(), and drivers/hwmon/
  is linked before drivers/hid/, so hid_register_driver() returned
  -EINVAL when the DMI table matched.

Changes in v2:
- Removed mutex.
- Probe returns the error when the fan report is missing, an
  allocation fails, or hwmon registration fails, and stops the HID
  device.
- Remove type/attr/channel checks in read() and is_visible().
  is_visible() always returns 0444.
- Reject a SET_REPORT whose transferred length is not the feature
  report length.

On the Aspire A14-52M and A14-52MT, hid_hw_start() is called with 
HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER, so the HID keyboard stays connected. 
Other machines with product id 0x174b do not match the DMI table and stay with
hid-generic.

v2: https://lore.kernel.org/linux-hwmon/20261030210037.921646-1-duhxu0@gmail.com/
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
index 000000000000..58a60f1c6d4d
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
+late_initcall(acer_aspire14_init);
+module_exit(acer_aspire14_exit);
+
+MODULE_AUTHOR("Ethan Jimmy <duhxu0@gmail.com>");
+MODULE_DESCRIPTION("Acer Aspire 14 AI EC fan driver");
+MODULE_LICENSE("GPL");
-- 
2.56.0

