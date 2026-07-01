Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDE35AC3C
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887454; cv=none; b=iCQ+V7J2WjCJ8mDv48dwcgp5bUFO6jSYs0sVw6MPaqRccP3zKQwn963if3T/TRD2MVqFNGGdNCrnU2HFQe9//5UGiQjDPoeLzt66JoWiDVmCjuKZiMakIe5Gy7WZpG0kSltOvDTHKWfN7T6ohFC6jQaoWRaManGsph4rKjLTZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887454; c=relaxed/simple;
	bh=sel4481oLZ4sLd8NjnBcrDk6b2zfaRR8YGTgP6/lKHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceuTQvn7MOpOkeI4uyHDQJisJT6mXVf56jPd7AlIC/IAw+LcnFKMBjDbdx2Eh3JwPAJ4fQZ5vqaUDzFIpikrHXiIhcPcTNuDHZpSO1Kl9CxbGCuvb6EsxdqQAhwgmm+mOmRkL9342/GI7crvIXMq/tgvtjRSqiv66i7LepFRTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/5JVsfb; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/5JVsfb"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-472365266f5so125932f8f.1
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782887450; x=1783492250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf/a1Fjyj0+fnwzWkNl3SlaT0MfLJfv8Qc5O4Kv7r0A=;
        b=K/5JVsfbi2ArwOAnhudbqjtcIDOErw2+GryD7sLQAZdhVVGIGhFWSHZBq0wR71IFs7
         M9kl/kNSjEQPn+GzEdZplcThXrSVQaRLT8DpC59Mq4V4kRWap09Jr5uOtRO7JhgMBHip
         RlYdS1MtyaGiJlMGFxil39RAwrl6R39Hb5DiMy2yoMmVHNpOlyWw2TLNJleQ16ZEPMjA
         rrcDCPSZFeuFpXh0Wn0xQ26vz4WB2UWss/pmZlysrtmm+T7HCfAUfMNWqXdu8rQOHkd+
         lv5DG4SONPSLKSGrM40CH3eC1mhSWUH+g6BnE0hzFpswbTSSCdNhMUKvLR2IGbHi+tYt
         3o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887450; x=1783492250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bf/a1Fjyj0+fnwzWkNl3SlaT0MfLJfv8Qc5O4Kv7r0A=;
        b=ZxfUVdo7V8VY81Tv9l6rhlUlr1uyix+wd1H9uhz02H6AQGE6ShNjfOe9EO21tVRBUM
         h0/KtPnG4ZSTUg7fbH7PQrvoas5aI97tTjPpcgVPH5dsDYPKSuC2myfW9ud0BskX4tNA
         XiUMBFH9QrJ8IpxGQefY9RzsYG91poEsCJl/GfbDYDeHWLlhfSW9vW9EloQLvj7uIv9/
         74SL0nfAH4/WUE2dH6B+piCaFGtcP9vPY5tBq0lGNXbGyh+OK1uZbBZlIU2Sl0+MRuZf
         C434aHrFbc9ex+VNYlHLmVRTFuMWKG5I2YZkkVQ5EKtHFIA2VsgSIK/rCWAWUk+TXrf2
         mTRw==
X-Forwarded-Encrypted: i=1; AHgh+RrODE6QRNNQUK3i+t2TKdROydIs5fGJvd5sjVqKs6cegzrCTma2CsGxB/2gBrLSwP/XdwpagvF0siAZ/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cGFz0sIx6pBfy+j/wwHn2KahwB1TJ3Oo5kp8CCaewQA5cwFu
	LOMa9YR02QEqjzrEV6cgQeJ/PZ7dipg2866zauyC2nGrz16NNk67m0ix
X-Gm-Gg: AfdE7ckDeE1uuXkxDr513qpZ9H2Nf86wWY0K0Lb40K7eHDexT8jQn3azGMr9JXODdlZ
	K/WO6smUu7KadlpNQAwujWYYITjzCEQZnO9EXyJgS/lmfrY62d4KM4qflGGVHGEfKSgXoOPtjPm
	1HLuKQ72bOwX7RQppwv3JIiQlic19y8XS8P6IHBFfWcQJBMZLIkBa9qba1m0NhbBkxPQAjSjRgK
	kWzkWbpJKxt7eBxqysZxCcS/JPAuNtQ6iOgLgVAiXxtGoJJmwyv03eIr3F75F81HsOr0SSA/ZKI
	OtrbQq39gmq1hMFz3YT4Trvgbw9tWmhhdFD38icRBZV8tafjwoT2QoqbM9pUwNTQJkAkII5dUYa
	/lO9EkYiTaLupfEC1K2y5Xc6OfbfO5FL282afXeZY3APSiK0L6Of8HsEAVgxH4U5LldjnzkGIEl
	NM7dk/sYAQ0A8MlT4gnpzegeuDDcyKzHUn8+5iWgs=
X-Received: by 2002:a5d:58d2:0:b0:474:b9d1:3203 with SMTP id ffacd0b85a97d-47757e57b56mr320490f8f.7.1782887450084;
        Tue, 30 Jun 2026 23:30:50 -0700 (PDT)
Received: from baraa-atta.local ([176.65.31.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475671d02f5sm15073672f8f.28.2026.06.30.23.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:30:49 -0700 (PDT)
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
Subject: [PATCH v4] HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)
Date: Wed,  1 Jul 2026 09:30:22 +0300
Message-Id: <20260701063022.29547-1-exalt.dev.team@gmail.com>
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
 * Adds device IDs for MX Keys S (046d) and Casa Keys (046d).
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
 
 .../testing/sysfs-driver-hid-logitech-hidpp   |  29 ++
 drivers/hid/hid-ids.h                         |   2 +
 drivers/hid/hid-logitech-hidpp.c              | 399 ++++++++++++++++++
 drivers/hid/hid-quirks.c                      |   2 +
 4 files changed, 432 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
index d8f831f2d6b5..41f0fd8c2192 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
@@ -17,3 +17,32 @@ Description:
 		handling battery properties in the kernel. This way, upower can
 		add a udev rule to decide whether or not it should use the
 		internal unifying support or the generic kernel one.
+
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/platform
+Date:		Jul, 2026
+KernelVersion:	7.2
+Contact:	linux-input@vger.kernel.org
+Description:
+		(WO) This attribute is present only on Logitech HID++ 2.0 devices
+		that implement feature 0x4531 (Multi-Platform). It allows the host
+		to select which operating-system platform the device should emulate,
+		altering its key mapping and behaviour accordingly.
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
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..a6c2dea79397 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -913,6 +913,8 @@
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
 #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
 #define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
+#define USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD	0xb371
+#define USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD	0xb378
 #define USB_DEVICE_ID_LOGITECH_C007	0xc007
 #define USB_DEVICE_ID_LOGITECH_C077	0xc077
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..c631f5fe0153 100644
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
 
@@ -4423,6 +4426,398 @@ static bool hidpp_application_equals(struct hid_device *hdev,
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
+ */
+
+#define HIDPP_MULTIPLATFORM_FEAT_ID			0x4531
+#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO		0x0F
+#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR	0x1F
+#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM	0x3F
+
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_TIZEN		BIT(0)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS	BIT(8)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB	BIT(9)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX		BIT(10)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME	BIT(11)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID	BIT(12)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_MACOS		BIT(13)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_IOS		BIT(14)
+#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WEBOS		BIT(15)
+
+struct hidpp_platform_desc {
+	u8 plat_idx;
+	u8 desc_idx;
+	u16 plat_mask;
+};
+
+/*
+ * Platform names exposed through the "platform" sysfs attribute. The order of
+ * this array must stay in sync with multiplatform_masks[] below, as the index
+ * returned by sysfs_match_string() is used to look up the matching mask.
+ */
+static const char * const multiplatform_names[] = {
+	"windows", "winemb", "linux", "chrome",
+	"android", "macos", "ios", "webos", "tizen", NULL
+};
+
+static const u16 multiplatform_masks[] = {
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_MACOS,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_IOS,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_WEBOS,
+	HIDPP_MULTIPLATFORM_PLATFORM_MASK_TIZEN,
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
+	/* Byte 0 (hostIndex): 0xFF selects the current host. */
+	u8 params[2] = { 0xFF, plat_index };
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
+ * @mask: A single HIDPP_MULTIPLATFORM_PLATFORM_MASK_* bit to apply
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
+	int idx;
+	int ret;
+
+	strscpy(platform, buf, sizeof(platform));
+	string_lower(platform, platform);
+
+	idx = sysfs_match_string(multiplatform_names, platform);
+	if (idx < 0)
+		return idx;
+
+	mutex_lock(&hidpp->multiplatform_lock);
+	ret = hidpp_multiplatform_set_platform(hidpp, multiplatform_masks[idx]);
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
+static DEVICE_ATTR_WO(platform);
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
@@ -4545,6 +4940,8 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	hidpp_multiplatform_init(hidpp);
+
 	/*
 	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
 	 * events will still be received.
@@ -4557,6 +4954,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
+	hidpp_multiplatform_cleanup(hidpp);
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -4570,6 +4968,7 @@ static void hidpp_remove(struct hid_device *hdev)
 	if (!hidpp)
 		return hid_hw_stop(hdev);
 
+	hidpp_multiplatform_cleanup(hidpp);
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9b89..577af0075e27 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -537,6 +537,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD) },
 #endif
 #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
-- 
2.34.1

