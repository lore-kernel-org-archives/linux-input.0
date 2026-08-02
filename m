Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24C37C926
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672150; cv=none; b=r30wvcKSEOs2geyhnzXEy/vKfHM1R1Zv9ucTL0HpQLq5gUlWCgBjZzfeNFvqcSRgNCk1lrVjzysygZvgIqRAaHhCYVlEoBDXwjLk7oqQsnl35ViLC+29GaVHXt9N1udNTUYvbZcDO1LcWVlfp43HHdodxMq13urnKE8TBMzFrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672150; c=relaxed/simple;
	bh=cb8I7HXAYGmi29OtfdP/Eog/0jmpLHgSJ3yBeQRCH6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hcdl9ScOg2gJOwZXZRgxdwJVec/b4jI2yA/elwCZzzABZNS3U9gkd9BmeGpz6DLpkSj3PWkXbQA4pkkYlWS6irTcRKX1gQS5VVwR8xHXMnWfS92n+FVsisFzAMzJhpgDZTd/kg/XyY0eDcVon3XXPHQRJm/Jdz0aeifX/lLIUqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHhxMf2a; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHhxMf2a"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso6775585e9.1
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785672145; x=1786276945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gx6LFdYhmii9fI75I+TkR18ZaGJs3N3Msfa+ONNcTTU=;
        b=hHhxMf2aoJpHKNvn1fnVq0ZvLMU4RANmEbL6xJNukxQDTo9B0rhEHDaFgJ1dRL6uS1
         wcKwlWnnpuQnmKn+v+yXZtZ/4EHrAK2RzdZ4NCisEec131UxlROo9qWQ1dDbJ+0YMhXh
         w5hGPR9b8rPq0Lzljm4SIUjct+8Skox+JqXFjeX3Xx0jAtKK/EAFIaP5SQjFDXEkijZ8
         zYAhFE5r287MKe/+CAsgeTY/AMfa5C2VF3vD8W1fLJuqHuCwYeQydeL+tbm6fketW5fn
         msmXnWh0yawgxivbFuoBUYbyV/WNnlL6ugpnMTHt6m5VgXx+Tpiogzg76LmCZp+7kMiX
         EuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785672145; x=1786276945;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gx6LFdYhmii9fI75I+TkR18ZaGJs3N3Msfa+ONNcTTU=;
        b=FkVEj78sAYlUQSRNGBlIBzbYKCu5HMUMYomcIFqP7gxQwpwX1p01MQm35VBBkmJqk5
         3BarIBWRQk+DmyhkgRRJmpax2NwpIgqN1IMw1gIBCpYDWjceXfS4iZ1GUzIW0e3WRUqu
         uFjfQrE2CRxhdhZDbSaB4W6cwbFscIxLMdCaFtwgrxELcy8RGRd0ZRLFJEqAiAjzPBiL
         ec3w8dWYPFGEjahNes+VNy6jqoO8y09M53jjNf5Zm1KiSljANvwiiaRymqcsfMUU5GpG
         Y/6KupWY9HY8KB08NMELdoHjbmck7KIFoPFcQ5mBFwh7GpCmlmfAcTappZumb9f5xEon
         nu7g==
X-Forwarded-Encrypted: i=1; AHgh+RpuleQjW4FhKVZaI7T4AN3Oan4foojKMlqffMpFp0G9bW3gLf1CrL5L+gbkINqn1eHCGq7rwHe1r4GkbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ4x1iFf/fKSY4mARwqr0JX8HNR0Na171qNHqmgL6raB/lejw
	cSp2TD6BbuZBiw+LysdNQkyh4GUryPW0OvJtdG2UuzVVmw+q68Wh0D0R
X-Gm-Gg: AR+sD1265wEqSF+saEnbCyrAZnBiXTPDAJGP8mlav+D5KhHArECgVu82YPlDkYoIqXD
	EOwGZLeGk9o/fqTRVRhczocq3DQrvymLtzGZ/+dLThThaZ6O4QdpaDE+HE0EapmFHcEm1rX/5xQ
	1yNq4h9E1HQKSVKJnnvL6u70jo48jkBsg4viFr8PQOmlhfGBGzH6Vwv6vZwJeVKH3Mg++p6X1oW
	C71QIPMehNTDI7a19NCfhTq2DBlRMQCfnCtyQMVZwFkXDst3CDaExc27zFvzSZ2H2XUWI2AgM6H
	eTmjX3vRpVll7rUyOvIKo/8opdemappqGShIcey0rW2IGZdWKtvj1fIkFBTVP70enRppj/f3nWu
	K557lC764ZTMQuFolyLjVnooDXK1xWUS0iYi4xEDK2Z9zirZmL4OekDSZ964oq5RNTO8eu2TaS2
	QgT9c35wBH2j21l45dinGQAcq4h+kNPIDMzMvWzALMwKR1KI7Epm9cYtM3tivDKHFvyurj2LKLW
	og/mhK0DVYxlao=
X-Received: by 2002:a05:600c:34d1:b0:495:7561:a9ed with SMTP id 5b1f17b1804b1-4980c679d9dmr139529035e9.17.1785672144153;
        Sun, 02 Aug 2026 05:02:24 -0700 (PDT)
Received: from baraa-atta.local ([176.65.31.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a5csm186801345e9.4.2026.08.02.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 05:02:23 -0700 (PDT)
From: DevExalt <exalt.dev.team@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sari.kreitem@exalt.corp-partner.google.com,
	hbarnor@google.com,
	"Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
Subject: [PATCH v7] HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)
Date: Sun,  2 Aug 2026 15:01:56 +0300
Message-Id: <20260802120156.93801-1-exalt.dev.team@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625080807.74157-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>

Add support in the Logitech HID++ driver for the HID++ Multi-Platform
feature (0x4531), which enables HID++ devices to adjust their behavior
based on the host operating system.

This patch:
 * Introduces the per-device sysfs attribute "platform" to allow selecting
   a target platform.
 * Detects whether a device implements feature 0x4531.
 * Validates that the requested platform is supported by the device.
 * Applies the selected platform when valid.
 * Leaves the device unchanged when an unsupported platform is requested.

Supported values for the platform sysfs attribute:

 windows, winemb, linux, chrome, android,
 macos, ios, webos, tizen

TEST=Pair MX Keys S and Casa Keys over Bluetooth and verify:
 * Feature 0x4531 is detected.
 * Valid platform values written through sysfs are accepted and applied.
 * Invalid platform values result in no update.
 * Devices without 0x4531 retain default behavior.
 * Platform-specific key behavior is observed once applied.

Signed-off-by: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
---
Changes in v2:
  * Replace the global hidpp_platform module parameter with a per-device
    sysfs attribute
  * Expose all platforms  supported by the HID++ Multi-Platform feature
  * Update documentation and testing description

Changes in v3:
  * Address Sashiko review comments.
  * Switch to devm_mutex_init() to handle mutex lifecycle management
    automatically.
  * Move hidpp_multiplatform_init() to the end of hidpp_probe() after
    hid_device_io_start() to guarantee that the hardware I/O loop is fully
    active when the sysfs attribute becomes visible.

Changes in v4:
  * Address Sashiko review comments.
  * Fix a potential use-after-destroy race condition during device unbind
    by replacing devm_device_add_group() with manual sysfs_create_group()
    management, ensuring the sysfs attribute is removed before the
    associated device resources and send_mutex are destroyed.

Changes in v5:
  * Address Sashiko review comments.
  * Fix a sub system design violation by removing the hardcoded 0xF client
    ID from the lower nibble of the FAP command macros.

Changes in V6:
  * Address Bastien review comments.
  * Index platform names by their platform mask values instead of maintaining
    parallel mask and name arrays.
  * Remove the Casa Keys and MX Keys S keyboard entries from hid-quirks.c
  * Make the platform sysfs attribute read/write, with the read operation
    exposing the operating systems corresponding to the device's current
    platform index for easier verification and testing.
    
Changes in V7:
  * Address Sashiko review comments.
  * Update the commit message.

 .../testing/sysfs-driver-hid-logitech-hidpp   |  36 ++
 drivers/hid/hid-logitech-hidpp.c              | 579 ++++++++++++++++++
 2 files changed, 615 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
index d8f831f2d6b5..3263d8473993 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
@@ -17,3 +17,39 @@ Description:
 		handling battery properties in the kernel. This way, upower can
 		add a udev rule to decide whether or not it should use the
 		internal unifying support or the generic kernel one.
+
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/platform
+Date:		Aug, 2026
+KernelVersion:	7.2
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) This attribute is present only on Logitech HID++ 2.0 devices
+		that implement feature 0x4531 (Multi-Platform). It allows the host
+		to select which operating-system platform the device should emulate,
+		altering its key mapping and behaviour accordingly.
+
+		Reading it returns the platform the device is currently configured
+		with for this host. A platform may cover several operating systems,
+		in which case all of their names are listed, separated by spaces
+		(for example "windows linux android").
+
+		Writing one of the following platform names programs the device:
+
+		  ===========  ======================================================
+		  windows       Standard Windows key layout
+		  winemb        Windows Embedded key layout
+		  linux         Linux key layout
+		  chrome        ChromeOS key layout
+		  android       Android key layout
+		  macos         macOS key layout
+		  ios           iOS key layout
+		  webos         webOS key layout
+		  tizen         Tizen key layout
+		  ===========  ======================================================
+
+		Only platforms advertised by the device's own descriptors are
+		accepted. The input is case-insensitive. Writing an unknown
+		platform name returns -EINVAL; writing a valid name that the
+		device does not expose in its descriptors returns -EOPNOTSUPP.
+		Reading returns -ENODATA when the device reports no platform
+		configured for this host.
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..7f4bbb6b62ca 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -209,6 +209,9 @@ struct hidpp_device {
 	int hires_wheel_multiplier;
 	u8 hires_wheel_feature_index;
 
+	u8 multiplatform_feature_index;
+	struct mutex multiplatform_lock;
+
 	bool connected_once;
 };
 
@@ -4423,6 +4426,578 @@ static bool hidpp_application_equals(struct hid_device *hdev,
 	return report && report->application == application;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x4531: Multi-Platform Support                                             */
+/* -------------------------------------------------------------------------- */
+
+/*
+ * Some Logitech devices expose the HID++ feature 0x4531 (Multi-Platform) allowing
+ * the host to specify which operating system platform to use on the device. Changing device's
+ * platform may alter the behavior of the device to match the specified platform.
+ *
+ * Devices that implement this feature expose a per-device sysfs attribute
+ * "platform". Writing one of (windows|winemb|linux|chrome|android|
+ * macos|ios|webos|tizen) selects the matching platform descriptor on the device.
+ * Reading it reports the platform currently selected by the device as the
+ * space separated list of the platform names the selected platform descriptor covers.
+ */
+
+#define HIDPP_MULTIPLATFORM_FEAT_ID			0x4531
+#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO		0x00
+#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR	0x10
+#define HIDPP_MULTIPLATFORM_GET_CURRENT_PLATFORM	0x20
+#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM	0x30
+
+/* Host index selecting the host the device is currently connected to. */
+#define HIDPP_MULTIPLATFORM_HOST_CURRENT		0xFF
+
+/* Platform index reported for a host that has no platform configured. */
+#define HIDPP_MULTIPLATFORM_PLAT_IDX_UNDEFINED		0xFF
+
+/*
+ * Bit positions of the platforms within the 16-bit platform mask reported by
+ * the platform descriptors. The mask of a given platform is BIT(value).
+ */
+enum hidpp_multiplatform_platform {
+	HIDPP_MULTIPLATFORM_PLATFORM_TIZEN	= 0,
+	HIDPP_MULTIPLATFORM_PLATFORM_WINDOWS	= 8,
+	HIDPP_MULTIPLATFORM_PLATFORM_WINEMB	= 9,
+	HIDPP_MULTIPLATFORM_PLATFORM_LINUX	= 10,
+	HIDPP_MULTIPLATFORM_PLATFORM_CHROME	= 11,
+	HIDPP_MULTIPLATFORM_PLATFORM_ANDROID	= 12,
+	HIDPP_MULTIPLATFORM_PLATFORM_MACOS	= 13,
+	HIDPP_MULTIPLATFORM_PLATFORM_IOS	= 14,
+	HIDPP_MULTIPLATFORM_PLATFORM_WEBOS	= 15,
+};
+
+struct hidpp_platform_desc {
+	u8 plat_idx;
+	u8 desc_idx;
+	u16 plat_mask;
+};
+
+/*
+ * Platform names exposed through the "platform" sysfs attribute, indexed by
+ * their bit position in the platform mask. Bit positions the specification
+ * does not assign a platform to are left as NULL holes and must be skipped
+ * when walking the array.
+ */
+static const char * const multiplatform_names[] = {
+	[HIDPP_MULTIPLATFORM_PLATFORM_TIZEN]	= "tizen",
+	[HIDPP_MULTIPLATFORM_PLATFORM_WINDOWS]	= "windows",
+	[HIDPP_MULTIPLATFORM_PLATFORM_WINEMB]	= "winemb",
+	[HIDPP_MULTIPLATFORM_PLATFORM_LINUX]	= "linux",
+	[HIDPP_MULTIPLATFORM_PLATFORM_CHROME]	= "chrome",
+	[HIDPP_MULTIPLATFORM_PLATFORM_ANDROID]	= "android",
+	[HIDPP_MULTIPLATFORM_PLATFORM_MACOS]	= "macos",
+	[HIDPP_MULTIPLATFORM_PLATFORM_IOS]	= "ios",
+	[HIDPP_MULTIPLATFORM_PLATFORM_WEBOS]	= "webos",
+};
+
+/**
+ * hidpp_multiplatform_errno() - Convert HID++ protocol error codes to Linux errno
+ * @err: HID++ protocol error code (positive) or Linux errno (negative or zero)
+ *
+ * Converts a HID++ protocol error code to the corresponding Linux errno. If @err is
+ * already a negative or zero Linux errno, it is returned unchanged. Otherwise, if @err
+ * is a positive HID++ error code, it is mapped to the appropriate negative Linux errno
+ * based on the HID++ specification error codes.
+ *
+ * This is used to ensure that functions interacting with the Multi-Platform feature can
+ * return consistent Linux error codes even when they encounter errors defined by the HID++
+ * protocol when the platform is set from the sysfs attribute.
+ *
+ * Return: Negative Linux errno corresponding to the HID++ error code, or @err if it is
+ * already a Linux errno.
+ */
+static int hidpp_multiplatform_errno(int err)
+{
+	if (err <= 0)
+		return err;
+
+	switch (err) {
+	case HIDPP20_ERROR_INVALID_ARGS:
+	case HIDPP20_ERROR_OUT_OF_RANGE:
+	case HIDPP20_ERROR_INVALID_FEATURE_INDEX:
+	case HIDPP20_ERROR_INVALID_FUNCTION_ID:
+		return -EINVAL;
+	case HIDPP20_ERROR_NOT_ALLOWED:
+		return -EPERM;
+	case HIDPP20_ERROR_BUSY:
+		return -EBUSY;
+	case HIDPP20_ERROR_UNSUPPORTED:
+		return -EOPNOTSUPP;
+	case HIDPP20_ERROR_HW_ERROR:
+	case HIDPP20_ERROR_UNKNOWN:
+	default:
+		return -EIO;
+	}
+}
+
+/**
+ * hidpp_multiplatform_get_num_pdesc() - Retrieve number of platform descriptors
+ * @hidpp: Pointer to the hidpp_device instance
+ * @feat_index: Feature index of the Multi-Platform feature
+ * @num_desc: Pointer to store the number of platform descriptors
+ *
+ * Retrieves the number of platform descriptors supported by the device through
+ * the Multi-Platform feature and stores it in @num_desc.
+ *
+ * Return: 0 on success, or a negative Linux errno on failure.
+ */
+static int hidpp_multiplatform_get_num_pdesc(struct hidpp_device *hidpp,
+					     u8 feat_index, u8 *num_desc)
+{
+	int ret;
+	struct hidpp_report response;
+	struct hid_device *hdev = hidpp->hid_dev;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feat_index,
+					  HIDPP_MULTIPLATFORM_GET_FEATURE_INFO,
+					  NULL, 0, &response);
+	if (ret) {
+		hid_warn(hdev, "Multiplatform: GET_FEATURE_INFO failed (err=%d)", ret);
+		return hidpp_multiplatform_errno(ret);
+	}
+
+	*num_desc = response.fap.params[3];
+	hid_dbg(hdev, "Multiplatform: Device supports %d platform descriptors", *num_desc);
+
+	return 0;
+}
+
+/**
+ * hidpp_multiplatform_get_platform_desc() - Retrieve a platform descriptor entry
+ * @hidpp: Pointer to the hidpp_device instance
+ * @feat_index: Feature index of the Multi-Platform feature
+ * @platform_idx: Index of the platform descriptor to retrieve
+ * @pdesc: Pointer to store the retrieved platform descriptor
+ *
+ * Retrieves a single platform descriptor identified by @platform_idx from the
+ * device and stores the parsed descriptor fields in @pdesc.
+ *
+ * Return: 0 on success, or a negative Linux errno on failure.
+ */
+static int hidpp_multiplatform_get_platform_desc(struct hidpp_device *hidpp, u8 feat_index,
+						 u8 platform_idx, struct hidpp_platform_desc *pdesc)
+{
+	int ret;
+	struct hidpp_report response;
+	u8 params[1] = { platform_idx };
+	struct hid_device *hdev = hidpp->hid_dev;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feat_index,
+					  HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR,
+					  params, sizeof(params), &response);
+
+	if (ret) {
+		hid_warn(hdev,
+			 "Multiplatform: GET_PLATFORM_DESCRIPTOR failed for index %d (err=%d)",
+			 platform_idx, ret);
+		return hidpp_multiplatform_errno(ret);
+	}
+
+	pdesc->plat_idx = response.fap.params[0];
+	pdesc->desc_idx = response.fap.params[1];
+	pdesc->plat_mask = get_unaligned_be16(&response.fap.params[2]);
+
+	hid_dbg(hdev,
+		"Multiplatform: descriptor %d: plat_idx=%d, desc_idx=%d, plat_mask=0x%04x",
+		platform_idx, pdesc->plat_idx, pdesc->desc_idx, pdesc->plat_mask);
+
+	return 0;
+}
+
+/**
+ * hidpp_multiplatform_get_platform_index() - Find platform index for a mask
+ * @hidpp: Pointer to the hidpp_device instance
+ * @feat_index: Feature index of the Multi-Platform feature
+ * @plat_mask: Platform mask to search for
+ * @plat_index: Pointer to store the matched platform index
+ *
+ * Iterates through all platform descriptors exposed by the device via the
+ * Multi-Platform feature, retrieving each descriptor and comparing its
+ * platform mask to @plat_mask. A descriptor matches if its mask overlaps with
+ * the requested @plat_mask (i.e. (pdesc.plat_mask & plat_mask) is non-zero).
+ *
+ * When a matching descriptor is found, its platform index (plat_idx) is
+ * written to @plat_index and the function returns success.
+ *
+ * Return: 0 on success; -EOPNOTSUPP if the device exposes no descriptor
+ *         matching @plat_mask; or another negative Linux errno on transport
+ *         failure.
+ */
+static int hidpp_multiplatform_get_platform_index(struct hidpp_device *hidpp,
+						  u8 feat_index, u16 plat_mask,
+						  u8 *plat_index)
+{
+	int i;
+	int ret;
+	u8 num_desc;
+	struct hidpp_platform_desc pdesc;
+	struct hid_device *hdev = hidpp->hid_dev;
+
+	ret = hidpp_multiplatform_get_num_pdesc(hidpp, feat_index, &num_desc);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_desc; i++) {
+		ret = hidpp_multiplatform_get_platform_desc(hidpp, feat_index, i, &pdesc);
+		if (ret)
+			return ret;
+
+		if (pdesc.plat_mask & plat_mask) {
+			*plat_index = pdesc.plat_idx;
+			hid_dbg(hdev,
+				"Multiplatform: Selected platform index %d for mask 0x%04x",
+				*plat_index, plat_mask);
+			return 0;
+		}
+	}
+
+	hid_dbg(hdev,
+		"Multiplatform: No matching platform descriptor for mask 0x%04x",
+		plat_mask);
+	return -EOPNOTSUPP;
+}
+
+/**
+ * hidpp_multiplatform_get_platform_mask() - Find the platform mask for a platform index
+ * @hidpp: Pointer to the hidpp_device instance
+ * @feat_index: Feature index of the Multi-Platform feature
+ * @plat_index: Platform index to find the platform mask of
+ * @plat_mask: Pointer to store the found platform mask
+ *
+ * A platform is the union of one or more platform descriptors, each covering
+ * its own set of operating systems. This walks all platform descriptors exposed
+ * by the device and accumulates the platform masks of every descriptor
+ * belonging to @plat_index, yielding the full set of platforms covered by it.
+ *
+ * Return: 0 on success; -EOPNOTSUPP if the device exposes no descriptor
+ *         belonging to @plat_index; or another negative Linux errno on
+ *         transport failure.
+ */
+static int hidpp_multiplatform_get_platform_mask(struct hidpp_device *hidpp,
+						 u8 feat_index, u8 plat_index,
+						 u16 *plat_mask)
+{
+	int i;
+	int ret;
+	u8 num_desc;
+	u16 mask = 0;
+	struct hidpp_platform_desc pdesc;
+	struct hid_device *hdev = hidpp->hid_dev;
+
+	ret = hidpp_multiplatform_get_num_pdesc(hidpp, feat_index, &num_desc);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_desc; i++) {
+		ret = hidpp_multiplatform_get_platform_desc(hidpp, feat_index, i, &pdesc);
+		if (ret)
+			return ret;
+
+		if (pdesc.plat_idx == plat_index)
+			mask |= pdesc.plat_mask;
+	}
+
+	if (!mask) {
+		hid_dbg(hdev,
+			"Multiplatform: No platform descriptor for platform index %d",
+			plat_index);
+		return -EOPNOTSUPP;
+	}
+
+	hid_dbg(hdev, "Multiplatform: Platform index %d covers mask 0x%04x",
+		plat_index, mask);
+	*plat_mask = mask;
+
+	return 0;
+}
+
+/**
+ * hidpp_multiplatform_get_current_platform_index() - Query the device current platform index
+ * @hidpp: Pointer to the hidpp_device instance
+ * @feat_index: Feature index of the Multi-Platform feature
+ * @plat_index: Pointer to store the platform index reported by the device
+ *
+ * Sends the HID++ Multi-Platform 'GET_CURRENT_PLATFORM' command for the host
+ * the device is currently connected to and stores the platform index it reports
+ * in @plat_index.
+ *
+ * Return: 0 on success; -ENODATA if the host has no platform configured; or
+ *         another negative Linux errno on failure.
+ */
+static int hidpp_multiplatform_get_current_platform_index(struct hidpp_device *hidpp,
+						    u8 feat_index, u8 *plat_index)
+{
+	int ret;
+	struct hidpp_report response;
+	u8 params[1] = { HIDPP_MULTIPLATFORM_HOST_CURRENT };
+	struct hid_device *hdev = hidpp->hid_dev;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feat_index,
+					  HIDPP_MULTIPLATFORM_GET_CURRENT_PLATFORM,
+					  params, sizeof(params), &response);
+	if (ret) {
+		hid_warn(hdev, "Multiplatform: GET_CURRENT_PLATFORM failed (err=%d)", ret);
+		return hidpp_multiplatform_errno(ret);
+	}
+
+	if (response.fap.params[2] == HIDPP_MULTIPLATFORM_PLAT_IDX_UNDEFINED) {
+		hid_dbg(hdev, "Multiplatform: Current host has no platform configured");
+		return -ENODATA;
+	}
+
+	*plat_index = response.fap.params[2];
+	hid_dbg(hdev, "Multiplatform: Current platform index is %d", *plat_index);
+
+	return 0;
+}
+
+/**
+ * hidpp_multiplatform_update_device_platform() - Update the device platform
+ * @hidpp: Pointer to the hidpp_device instance
+ * @feat_index: Feature index of the Multi-Platform feature
+ * @plat_index: Platform index to set on the device
+ *
+ * Sends the HID++ Multi-Platform 'SET_CURRENT_PLATFORM' command to the device to
+ * update its platform index to @plat_index.
+ *
+ * Return: 0 on success, or a negative Linux errno on failure.
+ */
+static int hidpp_multiplatform_update_device_platform(struct hidpp_device *hidpp,
+						      u8 feat_index, u8 plat_index)
+{
+	int ret;
+	struct hidpp_report response;
+	u8 params[2] = { HIDPP_MULTIPLATFORM_HOST_CURRENT, plat_index };
+
+	ret = hidpp_send_fap_command_sync(hidpp, feat_index,
+					  HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM,
+					  params, sizeof(params), &response);
+
+	if (ret)
+		hid_warn(hidpp->hid_dev,
+			 "Multiplatform: SET_CURRENT_PLATFORM failed for index %d (err=%d)",
+			 plat_index, ret);
+
+	return hidpp_multiplatform_errno(ret);
+}
+
+/**
+ * hidpp_multiplatform_set_platform() - Apply a platform to the device
+ * @hidpp: Pointer to the hidpp_device instance
+ * @mask: A single BIT(HIDPP_MULTIPLATFORM_PLATFORM_*) mask to apply
+ *
+ * Looks up the device's platform descriptor whose platform mask matches @mask
+ * and instructs the device to switch to it via SET_CURRENT_PLATFORM.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device does not implement feature
+ *         0x4531 or exposes no descriptor matching @mask, or another negative
+ *         Linux errno from the underlying HID++ command.
+ */
+static int hidpp_multiplatform_set_platform(struct hidpp_device *hidpp, u16 mask)
+{
+	u8 plat_index;
+	int ret;
+
+	if (!hidpp->multiplatform_feature_index)
+		return -EOPNOTSUPP;
+
+	ret = hidpp_multiplatform_get_platform_index(hidpp,
+			hidpp->multiplatform_feature_index, mask, &plat_index);
+	if (ret)
+		return ret;
+
+	ret = hidpp_multiplatform_update_device_platform(hidpp,
+			hidpp->multiplatform_feature_index, plat_index);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * hidpp_multiplatform_get_current_platform_mask() - Query the device current platform mask
+ * @hidpp: Pointer to the hidpp_device instance
+ * @mask: Pointer to store the device platform mask in use
+ *
+ * Asks the device which platform is configured for the current host and
+ * resolves it into the mask of operating systems that platform covers.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device does not implement feature
+ *         0x4531 or exposes no descriptor for its current platform, or another
+ *         negative Linux errno from the underlying HID++ command.
+ */
+static int hidpp_multiplatform_get_current_platform_mask(struct hidpp_device *hidpp, u16 *mask)
+{
+	u8 plat_index;
+	int ret;
+
+	if (!hidpp->multiplatform_feature_index)
+		return -EOPNOTSUPP;
+
+	ret = hidpp_multiplatform_get_current_platform_index(hidpp,
+			hidpp->multiplatform_feature_index, &plat_index);
+	if (ret)
+		return ret;
+
+	return hidpp_multiplatform_get_platform_mask(hidpp,
+			hidpp->multiplatform_feature_index, plat_index, mask);
+}
+
+/**
+ * platform_show() - Report the device's current platform
+ * @dev: Pointer to the device instance
+ * @attr: Pointer to the device attribute
+ * @buf: Buffer to store the platform names in
+ *
+ * Queries the platform mask the device is configured with for the current host and
+ * emits the names of all the platforms it covers as a space separated list.
+ *
+ * Return: Number of bytes written to @buf on success, or a negative Linux errno
+ * on failure.
+ */
+static ssize_t platform_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	unsigned long mask;
+	unsigned int idx;
+	int len = 0;
+	u16 plat_mask;
+	int ret;
+
+	mutex_lock(&hidpp->multiplatform_lock);
+	ret = hidpp_multiplatform_get_current_platform_mask(hidpp, &plat_mask);
+	mutex_unlock(&hidpp->multiplatform_lock);
+	if (ret)
+		return ret;
+
+	/* Mask bits the specification assigns no platform to are skipped. */
+	mask = plat_mask;
+	for_each_set_bit(idx, &mask, ARRAY_SIZE(multiplatform_names))
+		if (multiplatform_names[idx])
+			len += sysfs_emit_at(buf, len, "%s%s",
+					     len ? " " : "", multiplatform_names[idx]);
+
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+
+/**
+ * platform_store() - Set the device platform based on user input
+ * @dev: Pointer to the device instance
+ * @attr: Pointer to the device attribute
+ * @buf: Buffer containing the platform name string
+ * @count: Size of the input buffer
+ *
+ * Parses the platform name from the input buffer, converts it to a platform mask,
+ * and applies it to the device using the HID++ Multi-Platform feature. The function
+ * handles errors gracefully, returning appropriate Linux errno values if the input
+ * is invalid or if the device does not support the requested platform.
+ *
+ * Return: Number of bytes consumed from the input buffer on success, or a negative
+ * Linux errno on failure.
+ */
+static ssize_t platform_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	char platform[16];
+	unsigned int idx;
+	int ret;
+
+	strscpy(platform, buf, sizeof(platform));
+	string_lower(platform, platform);
+
+	/*
+	 * multiplatform_names[] contains NULL holes, so sysfs_match_string()
+	 * cannot be used here: it stops at the first NULL entry.
+	 */
+	for (idx = 0; idx < ARRAY_SIZE(multiplatform_names); idx++)
+		if (multiplatform_names[idx] &&
+		    sysfs_streq(multiplatform_names[idx], platform))
+			break;
+
+	if (idx == ARRAY_SIZE(multiplatform_names))
+		return -EINVAL;
+
+	mutex_lock(&hidpp->multiplatform_lock);
+	ret = hidpp_multiplatform_set_platform(hidpp, BIT(idx));
+	mutex_unlock(&hidpp->multiplatform_lock);
+	if (ret)
+		return ret;
+
+	hid_dbg(hdev, "Multiplatform: Device platform set to '%s'\n",
+		multiplatform_names[idx]);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(platform);
+
+static struct attribute *multiplatform_attrs[] = {
+	&dev_attr_platform.attr,
+	NULL
+};
+
+static const struct attribute_group multiplatform_attribute_group = {
+	.attrs = multiplatform_attrs,
+};
+
+/**
+ * hidpp_multiplatform_init() - Initialize HID++ Multi-Platform support
+ * @hidpp: Pointer to the hidpp_device instance
+ *
+ * Checks if the device supports the HID++ Multi-Platform feature (0x4531) and, if so,
+ * initializes the hidpp_device structure to track the feature index and creates the
+ * corresponding sysfs attribute group for platform selection.
+ */
+static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	u8 feat_index;
+	int ret;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_MULTIPLATFORM_FEAT_ID, &feat_index);
+	if (ret)
+		return;
+
+	hidpp->multiplatform_feature_index = feat_index;
+
+	mutex_init(&hidpp->multiplatform_lock);
+
+	ret = sysfs_create_group(&hdev->dev.kobj, &multiplatform_attribute_group);
+	if (ret) {
+		hid_warn(hdev,
+			 "Multiplatform: Failed to create sysfs group (err=%d)\n", ret);
+		mutex_destroy(&hidpp->multiplatform_lock);
+		hidpp->multiplatform_feature_index = 0;
+	}
+}
+
+/**
+ * hidpp_multiplatform_cleanup() - Cleanup HID++ Multi-Platform support
+ * @hidpp: Pointer to the hidpp_device instance
+ *
+ * Removes the sysfs attribute group for platform selection and destroys the mutex
+ * used for synchronizing access to the Multi-Platform feature.
+ * This function should be called during device removal or driver cleanup to ensure
+ * proper resource management.
+ */
+static void hidpp_multiplatform_cleanup(struct hidpp_device *hidpp)
+{
+	if (!hidpp->multiplatform_feature_index)
+		return;
+
+	sysfs_remove_group(&hidpp->hid_dev->dev.kobj, &multiplatform_attribute_group);
+	mutex_destroy(&hidpp->multiplatform_lock);
+}
+
 static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
@@ -4545,6 +5120,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	hidpp_multiplatform_init(hidpp);
+
 	/*
 	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
 	 * events will still be received.
@@ -4557,6 +5134,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
+	hidpp_multiplatform_cleanup(hidpp);
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -4570,6 +5148,7 @@ static void hidpp_remove(struct hid_device *hdev)
 	if (!hidpp)
 		return hid_hw_stop(hdev);
 
+	hidpp_multiplatform_cleanup(hidpp);
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
 	hid_hw_stop(hdev);
-- 
2.34.1

