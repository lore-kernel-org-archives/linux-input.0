Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183734A78E
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789274851; cv=none; b=Jnmwf8el7UtBA+ls6KhkSU3E2tcycGPF8phHyOvljt8+24aiJ/yAbn2NeNMY/YsiLL6x9f/BSmm6HZB+3Fn5qFjrZjp1amF7q7nh16PfUfNshjV9lWynPnb6kFVNhmpzhmttBq8CxhCU+KLw2vBnuNCr2rjgnwHlfrhe8AAPbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789274851; c=relaxed/simple;
	bh=seDxOVLndyD6pkkjsad7WDeD0JlEJPqXaQImFXut0sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRHDd9NActBvu1mqQ8y3lOhwmEPCZJDUPgyfyFMnEIMvHKM8urHJLdpgLszX2v1xQAx6HPCMiVXrbAYsQUPAXuPyfZ5+y/EZhUqrieyFCx9nrN38mMqMVGjqCxUgX3Q7BOzR2Z/ghHPDiGUgiNY7r8w6guIOF10WfmYcS0XyX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk+VCWYb; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk+VCWYb"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso10426895e9.0
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789274847; x=1789879647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eG7RCP9TvSi57Pm2MJh073NJCQsgyUE2LItgP7IlDKQ=;
        b=Hk+VCWYbTM0ZAad1ayMBDMiZmfIF4Mzgi0sov+vujiDrjhsm0m0HLGo9NPwZXG26NC
         rOW5ubISqGSGlTQ7zcYSxZ++s8izin/EKsFRfFAo5MYvJ//gIJpZOjp1JB2gEo786jwJ
         dEdFq5YLnCMp55f7CGKBUtAV43XhI4g5q2Xj3fwS0WPvEYJFJAZ9ke/Bi7Z35yn+Owz2
         HIrWcxF7+aqhwH0USQVQ1Ex+yrkD5IzIjpAzXfxbI8rlP2nug8mIRXd9gdPLEqAz5dmy
         Az+I2dpIfjiD9Qo47xI6cXSpWCxsnfCFB02hehzOJqDJ7t80ZQIQNpJ07Z28n+l2EMId
         ccxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789274847; x=1789879647;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eG7RCP9TvSi57Pm2MJh073NJCQsgyUE2LItgP7IlDKQ=;
        b=tYkxg9SR52ITgPcDkxY5XuW5ullZU0ccd2egiIiOqa0LNDuK4ULFbGvSxck1E7TN1B
         38x70TCpMsHZgl/iVXhg8trrre/+eloZ0K4zWU8b2q91u0kZ/6JDYzjMuxuZcv/YSuP0
         i8JMucvLBm1qjePNLSjgWxMaTeK345tkvHlaMTZp+xRZQ8R8GCGRpOOwTJGlZ5fqeVPS
         zjEu2B16j8HXFC1SxHxb4+49JD5V15ne02cuhNcpSfCUBqQgFRx7jBVU1XzCJBdSDI/J
         a3HPrFvdHTqyEIF8ZMoU1LJn+pJNYxSPW9lvIHz2cd2uctrcgnStN183Fvv5mPzFYKGW
         pg+Q==
X-Forwarded-Encrypted: i=1; AKwUvByPTWXO2G22mUwaPY4dx5IO8WC1jXJugXi/HqK435+vTZ9/R17ANresbn6CCff+kspfeMV9qOJtA37kdg==@vger.kernel.org
X-Gm-Message-State: AFuF++l4SkN7GR/Z50OKwiYsIFHcw98a9IrekybWA8ZyRDUdPbyhrQyg
	0EriausJeY8z+9NmuyUe3lnPTtQh8DGuNTTLJz0hXUHpmeneLUGaizNq
X-Gm-Gg: AYBFou0LlM5SA9P9OO0CQq3H1Q9g/kJlPLZwgzLtXG3YxUvi2cxlSB+DFOzNW7WlkAo
	+3XTACIMHROH0OcJ+XeA0DbARwWhAHCppyLScS9mfre9CpeSCd0medqQIGl7HEqzyfsML5Fo7C7
	/KlXCQscp8nplGhuMs94bcPHBPXNbKAxSvfpzR0w9eN3TwLVf3Bh59nidIG5Cv6vcFVXo/zuG0f
	UKw5Jspkcm4CaQPb2jSD+u1e4Nzk5CatvFC2tgTBXDJqNH2Y3mm3klvJyTDhEl1w1jcddFG9oLG
	5YCpnrUeRdg5Sm5iS+T32iXPhOkATectR8hGpgnV6Eyp531wVXcIXRqaVP0RkKNcL5ao828u7N2
	+zCiKYWG4SrLYlirn6VfVUxGGnqs1KhnExbyXdPlqTrmv3ffrihVHUTcSNSoW7n02jK1NTT+Tns
	GEN838Vh5UXQcy99suUnTsR0rGvAH5veRkSqy0e/xDCJtbd3u8xYwdlGAQJn3AyHlUOfUHKDNyN
	o9S4nAqSGYwq0UHxnlWZZomOA==
X-Received: by 2002:a05:600c:4f8e:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49e619a1c3bmr249184625e9.1.1789274845691;
        Sat, 12 Sep 2026 21:47:25 -0700 (PDT)
Received: from baraa-atta.local ([176.65.31.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e63c9a7c9sm324911575e9.13.2026.09.12.21.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 21:47:25 -0700 (PDT)
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
Subject: [PATCH v9] HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)
Date: Sun, 13 Sep 2026 07:46:42 +0300
Message-Id: <20260913044642.16058-1-exalt.dev.team@gmail.com>
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

How the feature works:

The HID++ 2.0 Multi-Platform feature consists of multiple
platform descriptors. Each descriptor has a platform index and
a 16-bit platform mask (`osMask`) identifying the operating
systems it supports. A descriptor may support one or more
operating systems when they share the same device behavior.

When an operating system name is written to the platform attribute,
the driver searches the device's platform descriptors for a
descriptor whose `osMask` contains the requested operating
system. The driver then selects that descriptor by its platform
index and instructs the device to switch to it.

When the platform attribute is read, the driver obtains the currently
active platform index from the device, finds the corresponding
platform descriptor, and reports all operating systems contained
in that descriptor's `osMask`.

For example, if the active descriptor supports both iOS and
macOS, reading this attribute returns: ios macos

The returned value represents the operating systems covered by
the active platform descriptor, rather than a single selected
operating system. The device reports only the active platform
index and does not report which operating system name was
originally used to select it.

Userspace can therefore determine whether its target operating
system is active by checking whether its name is present in the
space-separated list returned by reading the platform attribute.

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

Chages in V8:
  * Address Greg Comments.
  * Update the platfrom sysfs ABI documentation.
  * Make the platform sysfs attribute one of the default attributes of the
    device and using is_visible callback to enable it.
    
Changes in V9:
  * Address Greg Comments.
  * Update the commit message and the platform attribute ABI documentation.

 .../testing/sysfs-driver-hid-logitech-hidpp   |  70 ++
 drivers/hid/hid-logitech-hidpp.c              | 602 ++++++++++++++++++
 2 files changed, 672 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
index d8f831f2d6b5..14c8c5d8eff9 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
@@ -17,3 +17,73 @@ Description:
 		handling battery properties in the kernel. This way, upower can
 		add a udev rule to decide whether or not it should use the
 		internal unifying support or the generic kernel one.
+
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/platform
+Date:		Sep, 2026
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
+		is currently configured for this host.
+
+		How the feature works:
+
+		The HID++ 2.0 Multi-Platform feature consists of multiple
+		platform descriptors. Each descriptor has a platform index and
+		a 16-bit platform mask (`osMask`) identifying the operating
+		systems it supports. A descriptor may support one or more
+		operating systems when they share the same device behavior.
+
+		When an operating system name is written to this attribute, the
+		driver searches the device's platform descriptors for a
+		descriptor whose `osMask` contains the requested operating
+		system. The driver then selects that descriptor by its platform
+		index and instructs the device to switch to it.
+
+		When this attribute is read, the driver obtains the currently
+		active platform index from the device, finds the corresponding
+		platform descriptor, and reports all operating systems contained
+		in that descriptor's `osMask`.
+
+		For example, if the active descriptor supports both iOS and
+		macOS, reading this attribute returns:
+
+			ios macos
+
+		The returned value represents the operating systems covered by
+		the active platform descriptor, rather than a single selected
+		operating system. The device reports only the active platform
+		index and does not report which operating system name was
+		originally used to select it.
+
+		Userspace can therefore determine whether its target operating
+		system is active by checking whether its name is present in the
+		space-separated list returned by reading this attribute.
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..1cb78096f31c 100644
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
 
@@ -4423,6 +4426,598 @@ static bool hidpp_application_equals(struct hid_device *hdev,
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
+/**
+ * multiplatform_is_visible() - Determine whether the platform attribute should be exposed
+ * @kobj: kobject of the device the group is being evaluated for
+ * @attr: Attribute being evaluated
+ * @n: Index of the attribute within the group
+ *
+ * The "platform" attribute is only meaningful for devices that support the
+ * HID++ Multi-Platform feature (0x4531), which is only known once probe() has
+ * queried it. Hiding it via this callback, rather than creating/removing the
+ * sysfs group at runtime, lets the group be registered as one of the driver's
+ * default device attribute groups so it is added atomically by the driver
+ * core as part of binding instead of racing with userspace.
+ *
+ * Return: The attribute's mode if the attribute should be visible, or 0 to hide it.
+ */
+static umode_t multiplatform_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct hid_device *hdev = to_hid_device(kobj_to_dev(kobj));
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+
+	if (!hidpp || !hidpp->multiplatform_feature_index)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group multiplatform_attribute_group = {
+	.attrs = multiplatform_attrs,
+	.is_visible = multiplatform_is_visible,
+};
+
+static const struct attribute_group *hidpp_groups[] = {
+	&multiplatform_attribute_group,
+	NULL
+};
+
+/**
+ * hidpp_multiplatform_init() - Initialize HID++ Multi-Platform support
+ * @hidpp: Pointer to the hidpp_device instance
+ *
+ * Checks if the device supports the HID++ Multi-Platform feature (0x4531) and, if so,
+ * initializes the hidpp_device structure to track the feature index.
+ */
+static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
+{
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
+}
+
+/**
+ * hidpp_multiplatform_cleanup() - Cleanup HID++ Multi-Platform support
+ * @hidpp: Pointer to the hidpp_device instance
+ *
+ * Destroys the mutex used for synchronizing access to the Multi-Platform feature.
+ * This function should be called during device removal or driver cleanup to ensure
+ * proper resource management.
+ */
+static void hidpp_multiplatform_cleanup(struct hidpp_device *hidpp)
+{
+	if (!hidpp->multiplatform_feature_index)
+		return;
+
+	mutex_destroy(&hidpp->multiplatform_lock);
+}
+
 static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
@@ -4545,6 +5140,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	hidpp_multiplatform_init(hidpp);
+
 	/*
 	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
 	 * events will still be received.
@@ -4557,6 +5154,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
+	hidpp_multiplatform_cleanup(hidpp);
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -4570,6 +5168,7 @@ static void hidpp_remove(struct hid_device *hdev)
 	if (!hidpp)
 		return hid_hw_stop(hdev);
 
+	hidpp_multiplatform_cleanup(hidpp);
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
 	hid_hw_stop(hdev);
@@ -4782,6 +5381,9 @@ static struct hid_driver hidpp_driver = {
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
+	.driver = {
+		.dev_groups = hidpp_groups,
+	},
 };
 
 module_hid_driver(hidpp_driver);
-- 
2.34.1

