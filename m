Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361C3B2FD4;
	Mon, 14 Sep 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429084; cv=none; b=FX8HUKUkUlWV885YTDV4F5bGPdJGD9JNHGDWSFO8eeLN2SnVVdyTIq3nbOYL/Gqv1zlL9HlPIHLJxC12SYHhxZKksRl3GhAeIo3OHht2RwtMWx+n8HC6aPZaj88pqeaXKBJ7B86PXjMSbll84Bj2vu4RBUoo8jfgXCPfccoMe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429084; c=relaxed/simple;
	bh=+3l6/hAEENAGMfP0VLMsxBy7amHlxZeguhGYIxUPpQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xe+jI6UGIpiD03uNcMY19zkRKixMwzykZ7uNX0ogq1dNdaSu6Ai9O/KlfDWvcRI6ufqK48i4UJKm+hQd12F17yRsAGI9sWnZwtQzXaT/y5/RlbCrfyYK5P7ygq54IV5fvqRbF42ME3xzPo1NUtwMYaz3NOKkHYGt0r4TByWwuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=nTa40stb; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="nTa40stb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789429074; x=1789688274;
	bh=DXm57IH84I+Z/2Zqi7VYiba7Lxjq0R6Hm6M0atmougI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nTa40stbC9pZ4JqmpArr/raEydGcvDhQugLHNtBZU3YLTbF1aPG+gswXAFciA4OHd
	 l7D25nbDdnttwDCQtDJHOWldSvFm/2OmVTdOLfERG13qHCOTqS2m2nkjDrEG6OVFSH
	 pTTCBhYRhgSdAMbOKbTg5uGajJx/uXYNju/7HXwglB48uqzHVKEO+MjMCxJglzuBg9
	 XQx2u6SbdbnKv1B24PpqLtAHODJxn6zkSfbggTHcFIu/B/dmDhlnD4TER34kiZ+Kv4
	 w7akFmzO+3IIJNkBqyJRnAtthBG1Vejxs1atdTyoMHy0970MvfNJZ2sge9VaEm1TaK
	 bxlj5OAhRSUPA==
X-Pm-Submission-Id: 4hkM5X2cdLz1DDX8
From: Vas Zayarskiy <contact@vasily.cc>
To: linux@roeck-us.net,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 4/4] hwmon: (aquacomputer_d5next) Add AMPINEL support
Date: Tue, 15 Sep 2026 02:37:28 +0300
Message-ID: <20260914233728.22725-5-contact@vasily.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914233728.22725-1-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read-only total power, total current, input voltage, hotspot
temperature and six channel currents for the Aquacomputer AMPINEL.

Decode its 544-byte input report through the existing serial-number,
temperature and update path, with power, current and voltage handled in
the device-specific switch. Store all readings in hwmon units.

Match only the USB telemetry interface, leaving the separate keyboard
interface to hid-generic. Validate the telemetry collection and report
size before opening the device. Channel labels follow report order;
configuration and alarms are not supported.

Assisted-by: LLM sparse
Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  11 ++
 drivers/hwmon/Kconfig                       |   4 +-
 drivers/hwmon/aquacomputer_d5next.c         | 107 +++++++++++++++++++-
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 49163f387..faf1c51c1 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -13,6 +13,7 @@ Supported devices:
 * Aquacomputer Quadro fan controller
 * Aquacomputer High Flow Next sensor
 * Aquacomputer Leakshield leak prevention system
+* Aquacomputer AMPINEL power monitor
 * Aquacomputer Aquastream XT watercooling pump
 * Aquacomputer Aquastream Ultimate watercooling pump
 * Aquacomputer Poweradjust 3 fan controller
@@ -69,6 +70,16 @@ The Aquastream XT pump exposes temperature readings for the coolant, external se
 and fan IC. It also exposes pump and fan speeds (in RPM), voltages, as well as pump
 current.
 
+The AMPINEL exposes total power, total current, input voltage, hotspot
+temperature and six channel currents. Channel numbers follow report order;
+their mapping to physical connector pins has not been verified. The readings
+are received approximately twice per second. Only sensor reads are supported;
+the driver does not configure protection settings or report alarms.
+
+For AMPINEL, ``power1_input`` is total power, ``in0_input`` is input voltage,
+``temp1_input`` is hotspot temperature, ``curr1_input`` is total current, and
+``curr[2-7]_input`` are the six channel currents.
+
 The Aquastream Ultimate pump exposes coolant temp and an external temp sensor, along
 with speed, power, voltage and current of both the pump and optionally connected fan.
 It also exposes pressure and flow speed readings.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 3d8b2c958..06cb246ff 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -257,14 +257,14 @@ config SENSORS_AHT10
 	  will be called aht10.
 
 config SENSORS_AQUACOMPUTER_D5NEXT
-	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, Farbwerk 360, High Flow Next"
+	tristate "Aquacomputer D5 Next and other USB devices"
 	depends on USB_HID
 	select CRC16
 	help
 	  If you say yes here you get support for sensors and fans of
 	  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
 	  controllers, Farbwerk and Farbwerk 360 RGB controllers, High Flow
-	  Next sensor, where available.
+	  Next sensor and AMPINEL power monitor, where available.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called aquacomputer_d5next.
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index b58f5b5c9..e661c4dfa 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -2,7 +2,7 @@
 /*
  * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
  * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield,
- * High Flow USB/MPS Flow family)
+ * High Flow USB/MPS Flow family, AMPINEL)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
  * sensor values, except for devices that communicate through the
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/unaligned.h>
+#include <linux/usb.h>
 
 #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
 #define USB_PRODUCT_ID_AQUAERO		0xf001
@@ -33,6 +34,7 @@
 #define USB_PRODUCT_ID_OCTO		0xf011
 #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
 #define USB_PRODUCT_ID_LEAKSHIELD	0xf014
+#define USB_PRODUCT_ID_AMPINEL		0xf015
 #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
 #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
 #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
@@ -41,7 +43,7 @@
 enum kinds {
 	d5next, farbwerk, farbwerk360, octo, quadro,
 	highflownext, aquaero, poweradjust3, aquastreamult,
-	aquastreamxt, leakshield, highflow
+	aquastreamxt, leakshield, highflow, ampinel
 };
 
 static const char *const aqc_device_names[] = {
@@ -56,7 +58,8 @@ static const char *const aqc_device_names[] = {
 	[aquaero] = "aquaero",
 	[aquastreamult] = "aquastreamultimate",
 	[poweradjust3] = "poweradjust3",
-	[highflow] = "highflow" /* Covers MPS Flow devices */
+	[highflow] = "highflow", /* Covers MPS Flow devices */
+	[ampinel] = "ampinel"
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -111,6 +114,16 @@ static u8 aquaero_secondary_ctrl_report[] = {
 #define AQC_FAN_POWER_OFFSET		0x06
 #define AQC_FAN_SPEED_OFFSET		0x08
 
+/* AMPINEL offsets include the report ID byte. */
+#define AMPINEL_DATA_INTERFACE		1
+#define AMPINEL_STATUS_REPORT_SIZE	544
+#define AMPINEL_NUM_CHANNELS		6
+#define AMPINEL_CHANNEL_CURRENT_START	0x6f
+#define AMPINEL_POWER			0xc7
+#define AMPINEL_CURRENT			0xc9
+#define AMPINEL_VOLTAGE			0xcf
+#define AMPINEL_HOTSPOT			0xe1
+
 /* Specs of the Aquaero fan controllers */
 #define AQUAERO_SERIAL_START			0x07
 #define AQUAERO_FIRMWARE_VERSION		0x0B
@@ -516,6 +529,24 @@ static const char *const label_highflow_speeds[] = {
 	"Flow speed [dL/h]"
 };
 
+static const char *const label_ampinel_temp[] = {
+	"Hotspot"
+};
+
+static const char *const label_ampinel_power[] = {
+	"Total power"
+};
+
+static const char *const label_ampinel_voltage[] = {
+	"VCC In"
+};
+
+static const char *const label_ampinel_current[] = {
+	"Total current",
+	"Channel 1", "Channel 2", "Channel 3",
+	"Channel 4", "Channel 5", "Channel 6"
+};
+
 struct aqc_fan_structure_offsets {
 	u8 voltage;
 	u8 curr;
@@ -869,6 +900,10 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		break;
 	case hwmon_power:
 		switch (priv->kind) {
+		case ampinel:
+			if (channel == 0)
+				return 0444;
+			break;
 		case aquastreamult:
 			/* Special case to support pump and fan power */
 			if (channel < 2)
@@ -889,6 +924,10 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		break;
 	case hwmon_curr:
 		switch (priv->kind) {
+		case ampinel:
+			if (channel < AMPINEL_NUM_CHANNELS + 1)
+				return 0444;
+			break;
 		case aquastreamult:
 			/* Special case to support pump and fan current */
 			if (channel < 2)
@@ -907,6 +946,10 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		break;
 	case hwmon_in:
 		switch (priv->kind) {
+		case ampinel:
+			if (channel == 0)
+				return 0444;
+			break;
 		case d5next:
 			/* Special case to support +5V and +12V voltage sensors */
 			if (channel < priv->num_fans + 2)
@@ -1336,12 +1379,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		return 0;
 
 	priv = hid_get_drvdata(hdev);
+	if (priv->kind == ampinel &&
+	    (report->type != HID_INPUT_REPORT || size != AMPINEL_STATUS_REPORT_SIZE ||
+	     data[0] != STATUS_REPORT_ID))
+		return 0;
 
 	/* Info provided with every report */
 	priv->serial_number[0] = get_unaligned_be16(data + priv->serial_number_start_offset);
 	priv->serial_number[1] = get_unaligned_be16(data + priv->serial_number_start_offset +
 						    SERIAL_PART_OFFSET);
-	priv->firmware_version = get_unaligned_be16(data + priv->firmware_version_offset);
+	if (priv->firmware_version_offset)
+		priv->firmware_version = get_unaligned_be16(data + priv->firmware_version_offset);
 
 	/* Physical temperature sensor readings */
 	for (i = 0; i < priv->num_temp_sensors; i++) {
@@ -1394,6 +1442,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 
 	/* Special-case sensor readings */
 	switch (priv->kind) {
+	case ampinel:
+		priv->power_input[0] =
+			min_t(u64, get_unaligned_be16(data + AMPINEL_POWER) * 100000ULL,
+			      LONG_MAX);
+		priv->current_input[0] = get_unaligned_be16(data + AMPINEL_CURRENT) * 10;
+		for (i = 0; i < AMPINEL_NUM_CHANNELS; i++)
+			priv->current_input[i + 1] =
+				get_unaligned_be16(data + AMPINEL_CHANNEL_CURRENT_START +
+						   i * AQC_SENSOR_SIZE);
+		priv->voltage_input[0] = get_unaligned_be16(data + AMPINEL_VOLTAGE);
+		break;
 	case aquaero:
 		/* Read calculated virtual temp sensors */
 		i = priv->num_temp_sensors + priv->num_virtual_temp_sensors;
@@ -1519,8 +1578,26 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
 }
 
+static bool aqc_match(struct hid_device *hdev, bool ignore_special_driver)
+{
+	struct usb_interface *intf;
+
+	if (ignore_special_driver || hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER)
+		return false;
+
+	if (hdev->product != USB_PRODUCT_ID_AMPINEL)
+		return true;
+
+	if (!hid_is_usb(hdev))
+		return false;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	return intf->cur_altsetting->desc.bInterfaceNumber == AMPINEL_DATA_INTERFACE;
+}
+
 static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
+	struct hid_report *report;
 	struct aqc_data *priv;
 	int ret;
 
@@ -1537,6 +1614,14 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret)
 		return ret;
 
+	if (hdev->product == USB_PRODUCT_ID_AMPINEL) {
+		report = hdev->report_enum[HID_INPUT_REPORT].report_id_hash[STATUS_REPORT_ID];
+		if (hdev->maxcollection != 1 ||
+		    hdev->collection[0].usage != (HID_UP_MSVENDOR | 1) ||
+		    !report || report->size != (AMPINEL_STATUS_REPORT_SIZE - 1) * 8)
+			return -ENODEV;
+	}
+
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret)
 		return ret;
@@ -1546,6 +1631,15 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto fail_and_stop;
 
 	switch (hdev->product) {
+	case USB_PRODUCT_ID_AMPINEL:
+		priv->kind = ampinel;
+		priv->num_temp_sensors = 1;
+		priv->temp_sensor_start_offset = AMPINEL_HOTSPOT;
+		priv->temp_label = label_ampinel_temp;
+		priv->power_label = label_ampinel_power;
+		priv->voltage_label = label_ampinel_voltage;
+		priv->current_label = label_ampinel_current;
+		break;
 	case USB_PRODUCT_ID_AQUAERO:
 		/*
 		 * Aquaero presents itself as three HID devices under the same product ID:
@@ -1795,6 +1889,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	switch (priv->kind) {
+	case ampinel:
+		priv->serial_number_start_offset = AQC_SERIAL_START;
+		break;
 	case aquaero:
 		priv->serial_number_start_offset = AQUAERO_SERIAL_START;
 		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
@@ -1890,6 +1987,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_LEAKSHIELD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AMPINEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
@@ -1902,6 +2000,7 @@ MODULE_DEVICE_TABLE(hid, aqc_table);
 static struct hid_driver aqc_driver = {
 	.name = DRIVER_NAME,
 	.id_table = aqc_table,
+	.match = aqc_match,
 	.probe = aqc_probe,
 	.remove = aqc_remove,
 	.raw_event = aqc_raw_event,
