Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681236;
	b=jxe2szh7fXNfXFh6Q+4Hgy3jopLEp38Bi7JU8P0vqUK/LWBxdQIQbCQ7YOCb4d0nnRba
	 ius9rWqkowSFtHAGV7UV0vLHzrkqzWC74PBVAx5qkH0W6AQrWns0ZHCqNVF3M4crR0j5I
	 Uwhi1FApgUH8KZL6cLtFfJTFtNfMP//BMnjGzy/26FE9ttqghjGVC3zI4ioBJpQH744eH
	 qXiP2DHFsShF3Qfygis4I25dkMG1vkVB5D86QyUjqbczx6ctJtbsZtcu6jxvs0/e/RywI
	 bxsozCSu3Ks54GP9DPvM73X7m/HXx+Z1WMmh6Nq70IdAnhKLKAfgxKtE8qTgYVzlnEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NHDV0dfETVzr0Td0ndrjnRkd4XpFGPgc0UC2tibzLAw=;
	b=ekm9Omq4RnYIlhUaIjSi9U/Non7vPUGXa7078/Oe9q1DiajLg+DkCHSAk17sF6XFa4Fn
	 YAl0IcbLpAxPExmdarnIIw3x+QDVUekpyYSZlRIeVfEbERz7LOKnsi+fBSzh8IfmmiusY
	 3TwrXRGwaHcUh7uT+0Mj9+SsLVV0owO2dLhmm5+cXaHopGa08aRfHYdH1fVjzyodsFAJM
	 igpdn8RNCWu2k2OFYkN01G0vLpjO3MVrUaNEaV0lRM/M2ECDpIjmjqEKi21QcPcrZSVtK
	 3mBPUD6OnD0CWJ216WGCldTd3oNEHRER37C5VoinXlgxDaiymKtmNVlWHRMILQY91LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PrsakT07;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3715606A334
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3715606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PrsakT07
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3514b90bb89so7794402eec.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793681235; x=1794286035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHDV0dfETVzr0Td0ndrjnRkd4XpFGPgc0UC2tibzLAw=;
        b=PrsakT07XcYgmLFxgW01fAQjPwC0fknJKdLkeToBwVQiuuCE4te9rRxrVQz5S3Ey4+
         zkrmSbMw1y6FCRHhc2bgrAJ0gNeDshcue0ODdQpXedr7bgrXfkOGMSOVmXEyZ+cME1gp
         69knzzcR3eSvx2gKpwGi7uoi1bOpzHf3TpGADNTlS8ge/LcaXZEFQ8nMskDGmmnZkjEA
         jx2TzXRBZ1F93q5zbpFZUjdmSCnJfNybOZFQFW4sU622sccZawxdux0Rxng2si5viPFu
         JsTa+pnI7XfF/qqZl3IJX0PU/IobWMGXOxPCpMxoVlf0WVaJnktdKiW0NMM3fY0Tx8fu
         UVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793681235; x=1794286035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHDV0dfETVzr0Td0ndrjnRkd4XpFGPgc0UC2tibzLAw=;
        b=zPIb5wbvwB1tI3dm3yil9SkAjrohhNUYdqyjCbTsNlDhljpPshpB154ZT5Lu3QQibN
         e+77HVHFHYxdnzLtVAuRHVHui/wg7AQScPM+vl3GT1En4vmRSpC/25YmdQYK30LdgQLT
         PUpsbwB/cMHhp2UBLEYqhqRNCoEcEsHRnMRX4kOPX/8sPtad1p3BhBHBkMcLfhrKATtC
         nUvDm2bsJ9dxAxce3tnJImaVsxY+4NZZykGXE4uG9DV6WPZHJHhuskvt1n8/LiVr7YYS
         jrH8vwBwDvZHmCpkQih7fo/r4gb7aieHgW9talk+59y7ifHTAQRo6PWWjizpYVeh6097
         viUA==
X-Forwarded-Encrypted: i=1; AKwUvBz3MMdWJsOPU/rZwx2i1n0z9qqjbQ79cNj/lSqTM/VzA9knD5jyX/+y90hBfNnH8+3bYv1pQHNQYPSEoA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Do8tbpPXo3hyHX/fgYp9YD25U4FsKh+VjAlLtGsyY3eqSqIDW
	q4W9f6MHmLvrz9umfoD4nK8fYTRY2u8K4Ledhu86334oZxP6u9wQmv7r
X-Gm-Gg: AYBFou3u8vtOtw/K10KsUOjqr8FP0Z20g7LJrdLIUlhRJWMEKQKuWW0Tf/Gnogm2kwO
	05UwSdF1p4DzqaKMNNewa4oDHH2ntEOukznyAq+8CKA4F44nTEOZGhTPiQq78AUIJyfQU7EUGpG
	ppkqWtQAejt7wJArDi26LbU41fJXCiYO0E8aMZ5Ez6gvSyDYxiM6w8ociFY5N/x+Pg36W1kJX5p
	JUzLOzA1j3MkUuA8pQgpgkbFeqAnPwH5KcxN+2/K3kXIONoW/zlTt4OYadVRo2t9ZBRkglaQFSV
	w6nRXPsas+pKDV81D3xuyQh98NO72oEOgfExG51BNDCNyCtPFgLGD6B+kemS8DcR1uBk6ZaI/NL
	WsB91E46vLERRgrmIbtnndlRxYkxVk0JmWjO7bkmcK4oZ/DA2i3DhyopNN/XX7Pq/cyUybusQtI
	E4seoQJ3s6dNGLOP+tV1L3CK2zJlxX9zN52r5d1W5hObpoaKjZ9i3NVdf9GkHPSS5bvWDW47YGH
	iVP64j7mfvSuVjZcCQ6qS8LVsAiA0lQt/YioQm985GVPVOyTixuFwwORaqFezrs4STpCEg219JW
	hGJ1uxa/W2HgPiBo15l94ZmbejosS4PzeF/+YeEc8aEtiawla+CuMJbJ2KRVLzrf6IiS7FxkES6
	Q+q68OTYN3sOI9e1R
X-Received: by 2002:a05:7300:c730:b0:36a:43d9:f2a5 with SMTP id 5a478bee46e88-36a43da454emr17661523eec.32.1793681234531;
        Mon, 02 Nov 2026 20:47:14 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm48385807eec.11.2026.11.02.20.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:47:13 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Val Packett <val@packett.cool>,
	Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Jeff LaBundy <jeff@labundy.com>,
	linux-input@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Input: touchscreen - parse touchscreen-x-mm and touchscreen-y-mm
Date: Mon,  2 Nov 2026 20:47:04 -0800
Message-ID: <20261103044708.2461481-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
References: <20261103044708.2461481-1-dmitry.torokhov@gmail.com>
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

The touchscreen device tree bindings define common touchscreen-x-mm and
touchscreen-y-mm properties specifying the physical dimensions of the
touchscreen in millimeters. However, touchscreen_parse_properties() does
not parse these properties, forcing individual drivers to parse them
manually or fall back to arbitrary resolution values.

Parse touchscreen-x-mm and touchscreen-y-mm in
touchscreen_parse_properties() and calculate axis resolution in units
per millimeter as the coordinate count (maximum - minimum + 1) divided
by the physical dimension, rounded to the nearest integer. Guard against
zero physical size or invalid axis ranges, and preserve pre-existing
resolution settings when the properties are omitted. Apply resolution
before early exit so callers passing a NULL properties pointer still
get axes configured and so coordinate inversion and axis swapping
continue to work seamlessly. Also add KUnit test coverage for resolution
calculation.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/tests/Makefile           |   1 +
 drivers/input/tests/touchscreen_test.c | 209 +++++++++++++++++++++++++
 drivers/input/touchscreen.c            |  18 ++-
 3 files changed, 223 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/tests/touchscreen_test.c

diff --git a/drivers/input/tests/Makefile b/drivers/input/tests/Makefile
index 90cf954181bc..b5e769d9f8cc 100644
--- a/drivers/input/tests/Makefile
+++ b/drivers/input/tests/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_INPUT_KUNIT_TEST) += input_test.o
+obj-$(CONFIG_INPUT_KUNIT_TEST) += touchscreen_test.o
diff --git a/drivers/input/tests/touchscreen_test.c b/drivers/input/tests/touchscreen_test.c
new file mode 100644
index 000000000000..f8661c349fcc
--- /dev/null
+++ b/drivers/input/tests/touchscreen_test.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for touchscreen property parsing.
+ */
+
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/property.h>
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+static struct input_dev *
+touchscreen_test_create_device(struct kunit *test,
+			       const struct property_entry *props)
+{
+	struct input_dev *input_dev;
+	struct device *dev;
+
+	dev = kunit_device_register(test, "touchscreen-test-dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	if (props)
+		KUNIT_ASSERT_EQ(test,
+				device_create_managed_software_node(dev, props, NULL),
+				0);
+
+	input_dev = devm_input_allocate_device(dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, input_dev);
+
+	return input_dev;
+}
+
+static void touchscreen_test_resolution_single(struct kunit *test)
+{
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_U32("touchscreen-x-mm", 100),
+		PROPERTY_ENTRY_U32("touchscreen-y-mm", 200),
+		{ }
+	};
+	struct touchscreen_properties prop;
+	struct input_dev *input_dev;
+
+	input_dev = touchscreen_test_create_device(test, props);
+
+	/* Driver-supplied ranges: 0..999 (1000 units), 0..1999 (2000 units) */
+	input_set_abs_params(input_dev, ABS_X, 0, 999, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, 1999, 0, 0);
+
+	touchscreen_parse_properties(input_dev, false, &prop);
+
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_X), 10);
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_Y), 10);
+}
+
+static void touchscreen_test_resolution_multitouch(struct kunit *test)
+{
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_U32("touchscreen-min-x", 10),
+		PROPERTY_ENTRY_U32("touchscreen-size-x", 1010),
+		PROPERTY_ENTRY_U32("touchscreen-x-mm", 50),
+		PROPERTY_ENTRY_U32("touchscreen-min-y", 20),
+		PROPERTY_ENTRY_U32("touchscreen-size-y", 2020),
+		PROPERTY_ENTRY_U32("touchscreen-y-mm", 100),
+		{ }
+	};
+	struct touchscreen_properties prop;
+	struct input_dev *input_dev;
+
+	input_dev = touchscreen_test_create_device(test, props);
+
+	/* Multitouch axes setup */
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 1, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 1, 0, 0);
+
+	touchscreen_parse_properties(input_dev, true, &prop);
+
+	/* min=10, max=1009, count=1000, 1000 / 50 = 20 */
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_X), 20);
+	/* min=20, max=2019, count=2000, 2000 / 100 = 20 */
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_Y), 20);
+}
+
+static void touchscreen_test_resolution_rounding(struct kunit *test)
+{
+	const struct property_entry props[] = {
+		/* 1951 / 100 = 19.51 -> rounds to 20 */
+		PROPERTY_ENTRY_U32("touchscreen-size-x", 1951),
+		PROPERTY_ENTRY_U32("touchscreen-x-mm", 100),
+		/* 1949 / 100 = 19.49 -> rounds to 19 */
+		PROPERTY_ENTRY_U32("touchscreen-size-y", 1949),
+		PROPERTY_ENTRY_U32("touchscreen-y-mm", 100),
+		{ }
+	};
+	struct touchscreen_properties prop;
+	struct input_dev *input_dev;
+
+	input_dev = touchscreen_test_create_device(test, props);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 1, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 1, 0, 0);
+
+	touchscreen_parse_properties(input_dev, true, &prop);
+
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_X), 20);
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_Y), 19);
+}
+
+static void touchscreen_test_resolution_swap_invert(struct kunit *test)
+{
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_U32("touchscreen-x-mm", 50),
+		PROPERTY_ENTRY_U32("touchscreen-y-mm", 200),
+		PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+		PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+		{ }
+	};
+	struct touchscreen_properties prop;
+	struct input_dev *input_dev;
+
+	input_dev = touchscreen_test_create_device(test, props);
+
+	/* X count = 1000, Y count = 2000 */
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 999, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 1999, 0, 0);
+
+	touchscreen_parse_properties(input_dev, true, &prop);
+
+	/*
+	 * Before swap: X res = 1000/50 = 20, Y res = 2000/200 = 10.
+	 * After swap: X absinfo receives Y absinfo, Y absinfo receives X absinfo.
+	 */
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_X), 10);
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_Y), 20);
+	KUNIT_EXPECT_TRUE(test, prop.invert_x);
+	KUNIT_EXPECT_TRUE(test, prop.swap_x_y);
+}
+
+static void touchscreen_test_resolution_edge_cases(struct kunit *test)
+{
+	const struct property_entry props[] = {
+		/* Zero x-mm */
+		PROPERTY_ENTRY_U32("touchscreen-x-mm", 0),
+		/* y-mm omitted */
+		{ }
+	};
+	struct touchscreen_properties prop;
+	struct input_dev *input_dev;
+
+	input_dev = touchscreen_test_create_device(test, props);
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 999, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, 1999, 0, 0);
+
+	/* Pre-configure resolutions */
+	input_abs_set_res(input_dev, ABS_MT_POSITION_X, 15);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, 25);
+
+	touchscreen_parse_properties(input_dev, true, &prop);
+
+	/* Zero size and omitted property must preserve pre-existing resolutions */
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_X), 15);
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_Y), 25);
+}
+
+static void touchscreen_test_resolution_invalid_range_and_null_prop(struct kunit *test)
+{
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_U32("touchscreen-x-mm", 50),
+		PROPERTY_ENTRY_U32("touchscreen-y-mm", 50),
+		{ }
+	};
+	struct input_dev *input_dev;
+
+	input_dev = touchscreen_test_create_device(test, props);
+
+	/* X has valid range 0..999 (1000 units), Y has invalid range 500..500 */
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, 999, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 500, 500, 0, 0);
+	input_abs_set_res(input_dev, ABS_MT_POSITION_Y, 42);
+
+	/* NULL prop pointer */
+	touchscreen_parse_properties(input_dev, true, NULL);
+
+	/* Valid X gets resolution computed even with prop == NULL */
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_X), 20);
+	/* Invalid Y range (max <= min) preserves pre-configured resolution */
+	KUNIT_EXPECT_EQ(test, input_abs_get_res(input_dev, ABS_MT_POSITION_Y), 42);
+}
+
+static struct kunit_case touchscreen_tests[] = {
+	KUNIT_CASE(touchscreen_test_resolution_single),
+	KUNIT_CASE(touchscreen_test_resolution_multitouch),
+	KUNIT_CASE(touchscreen_test_resolution_rounding),
+	KUNIT_CASE(touchscreen_test_resolution_swap_invert),
+	KUNIT_CASE(touchscreen_test_resolution_edge_cases),
+	KUNIT_CASE(touchscreen_test_resolution_invalid_range_and_null_prop),
+	{ /* sentinel */ }
+};
+
+static struct kunit_suite touchscreen_test_suite = {
+	.name = "touchscreen",
+	.test_cases = touchscreen_tests,
+};
+
+kunit_test_suite(touchscreen_test_suite);
+
+MODULE_DESCRIPTION("KUnit test for touchscreen property parsing");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen.c b/drivers/input/touchscreen.c
index d699b24bb548..05ddb2ea7c66 100644
--- a/drivers/input/touchscreen.c
+++ b/drivers/input/touchscreen.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/math.h>
 #include <linux/property.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
@@ -33,7 +34,8 @@ static bool touchscreen_get_prop_u32(struct device *dev,
 
 static void touchscreen_set_params(struct input_dev *dev,
 				   unsigned long axis,
-				   int min, int max, int fuzz)
+				   int min, int max, int fuzz,
+				   unsigned int size_mm)
 {
 	struct input_absinfo *absinfo;
 
@@ -48,6 +50,8 @@ static void touchscreen_set_params(struct input_dev *dev,
 	absinfo->minimum = min;
 	absinfo->maximum = max;
 	absinfo->fuzz = fuzz;
+	if (size_mm && min >= 0 && max > min)
+		absinfo->resolution = DIV_ROUND_CLOSEST(max - min + 1, size_mm);
 }
 
 /**
@@ -69,7 +73,7 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 	struct device *dev = input->dev.parent;
 	struct input_absinfo *absinfo;
 	unsigned int axis, axis_x, axis_y;
-	unsigned int minimum, maximum, fuzz;
+	unsigned int minimum, maximum, fuzz, size_mm;
 	bool data_present;
 
 	input_alloc_absinfo(input);
@@ -89,8 +93,10 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 	data_present |= touchscreen_get_prop_u32(dev, "touchscreen-fuzz-x",
 						 input_abs_get_fuzz(input, axis_x),
 						 &fuzz);
+	data_present |= touchscreen_get_prop_u32(dev, "touchscreen-x-mm", 0,
+						 &size_mm);
 	if (data_present)
-		touchscreen_set_params(input, axis_x, minimum, maximum - 1, fuzz);
+		touchscreen_set_params(input, axis_x, minimum, maximum - 1, fuzz, size_mm);
 
 	data_present = touchscreen_get_prop_u32(dev, "touchscreen-min-y",
 						input_abs_get_min(input, axis_y),
@@ -102,8 +108,10 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 	data_present |= touchscreen_get_prop_u32(dev, "touchscreen-fuzz-y",
 						 input_abs_get_fuzz(input, axis_y),
 						 &fuzz);
+	data_present |= touchscreen_get_prop_u32(dev, "touchscreen-y-mm", 0,
+						 &size_mm);
 	if (data_present)
-		touchscreen_set_params(input, axis_y, minimum, maximum - 1, fuzz);
+		touchscreen_set_params(input, axis_y, minimum, maximum - 1, fuzz, size_mm);
 
 	axis = multitouch ? ABS_MT_PRESSURE : ABS_PRESSURE;
 	data_present = touchscreen_get_prop_u32(dev,
@@ -115,7 +123,7 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 						 input_abs_get_fuzz(input, axis),
 						 &fuzz);
 	if (data_present)
-		touchscreen_set_params(input, axis, 0, maximum, fuzz);
+		touchscreen_set_params(input, axis, 0, maximum, fuzz, 0);
 
 	if (!prop)
 		return;
-- 
2.56.0.385.gac671c819a-goog

