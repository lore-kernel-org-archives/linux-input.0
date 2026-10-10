Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF65364E96
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655237; cv=none; b=h10PFz036KDXmHFj5vxYrhvaSkqhOGnB/YCcBvOWh5w1I3IODgMv0XRzTen7hUuJzWYzUca2bbdyt8DZIBfQtbvsuyaY6igdCls+u4XNJgx/4lNt/z/42O7LxuteE7ckCLtqGqhq1jx5Gk38A6wV3JAimjFODs8ymloatQW5Bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655237; c=relaxed/simple;
	bh=HKNFGbq4hl6l1XCi+rbyPW4Y1sM4o0fwhPUb0NjJSmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su7YoDuPoGQLrJYjmOmPdzlh/PPmm3Mw0RYq5+3Bdp+dVXR60Ba8sfuzlHW7YSuicZA6geKT1vHbxLicqaHd2YDRuuqIYdZerUoN8Pgky0gEwTbb+h0Xkz75MBUb1MWrZXw7c3N9dXnS5SzhZSYReq1KEaWMfvaGuAL4TxoIK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=oLjWxJ8P; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="oLjWxJ8P"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93cbc3ab2fdso26680185a.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791655235; x=1792260035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rhyWv1q8Cylrw41L9C5HKTLmJIGVyEWTeHoTYQ/THAY=;
        b=oLjWxJ8P8qPf/rGidOVX//Sa5cIdAu4Ikjq2AT6L0VmqTR/kxEczwKShH5xdLNBuW1
         lQ6VcoURxkjSmgw9dxEoXW3lFfbrcBHQSbkUIqf+u2UiSybR9gt53WxgIHscQEyInhcx
         E1ZoI5yHm1k966549oDmUQSmo1l36l8/PFpps0ux9Mbg1hDdSvrvX/43WuMOTlZmJ4Cp
         /jyWfTEMyz41mJNO7CJdIuwmhEQ6/lLNaZqnzZDfQ/CxaD1PHMc/RvhByaToH3D5RRrl
         rR0Gak5tIFiffhMmuDakHpimz1HED9XGDGc97YsA/6iusNtRDiS/CAt0Q+ZsLUN1Nsaf
         CoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655235; x=1792260035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rhyWv1q8Cylrw41L9C5HKTLmJIGVyEWTeHoTYQ/THAY=;
        b=fhZ1fHSOuZK37qblNTnoi34u5D/q1efEkLz1Q71DtJQHPRct9guh5whGP57ZiKMWJ6
         SymI7ecF2DoLb0wuCu7zDpynDVaIWgAWOET+LH3E9zUYvKZy3NXemRSYRBaCWrAeO5dI
         liDM11LtJKvYZqpPYbN592A7EmwFroQoC6EmIM4SzhILCUry1a1kHs1i1kdgFjOaCdcL
         T/xUTwpX9nVU+uqgY50MZy+JM0kHadCQp04j8jyJzNOkTI6HyyOfrRzxVWGfOqJyp6KP
         SR4BGsICFOLRZpsQeTQ5cvPW3bJHcUM2Po6j/wECTWUlI9qUYfZL/3izlfSOt3X65Nht
         wPlA==
X-Gm-Message-State: AFq9FYJgrmYhVWVc0IW9DYjJ/nYVHiEUpfLDSLMMrn8hMpWtvdjbxjJw
	J/Smmggbib3/4OTjqpWGYRybWtJAqEX+QPCdUvyD27xn2dhwRgFCGGCxW/7+xZxB6Mg=
X-Gm-Gg: AYBFou08/FbBOYEbuBFWJcfxc6qL6QkmwcUw6iJtOp0VjBPFCoEsTS3QCAOob7MtOYk
	+Qr8XIUbXpK4BVGShwh/bEYRW0JTqpVPl7gh8ppLou1iktA7mUlS5e4kBQ3tdujXdSFqa8KsMzj
	FpIdWIOsay5SnLn9zpmq4/PEsrIEBnBXFw7J80DrdQ5hlf+/2LzUSM+zl7Gk6uRba9qEsF3wcZm
	V3zmYMq/WeK4cKCJqflJ1RpjcDget0SAeYDDK0ikFKNAHUBqHIOf7LfGnRCY+4woWaXWALepriJ
	oNF9q9JryxJ1u18fppuYuWpzw4eZb1zAdaifkXm/8Fzy4V/ob6hrYVdLFpZyyPouHGv1p3wQo6+
	JFrZhR0X9l4E4KRpBElehWu7MR/rHjB8WoqvC3R7/+TOVJdp/GX/7rfi4YRO87SEI70bjgGX5CH
	6u5w1nys5f5z8WgmRxz227HQxBgFpjnPKG07jqYmXXd4fuEapzUS7yg28vEPnqLMXG9qsqFLLVs
	gDRH4HXh8Yy3v/NAGI7u4eX3MXz4x0Achk0ggPr
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id af79cd13be357-93ebd29a3b1mr859393885a.64.1791655235084;
        Sat, 10 Oct 2026 11:00:35 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550175e3sm50339326d6.11.2026.10.10.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 11:00:34 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: test state seeding across device registration
Date: Sat, 10 Oct 2026 14:00:31 -0400
Message-ID: <20261010180031.7-3-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010180031.7-1-kabel@voidship.net>
References: <20261010180031.7-1-kabel@voidship.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add KUnit coverage for input events used to initialize device state before
registration. Register a handler for a virtual switch/LED device, seed a
switch before input_register_device(), and inject a later LED update and
SYN_REPORT. Verify that the initial state is retained without replaying
its event or reusing its timestamp, and that a real later change arrives.

Exercise both the original event buffer and registration with a larger
buffer. Also verify preservation and subsequent delivery of absolute-axis
state in the resizing case. Use SW_DOCK to avoid real radio operations.

These tests depend on the preceding pre-registration event fix. Against
the unpatched input core, the non-resizing case delivers one stale switch
event and both cases retain the initialization timestamp. Both tests pass
with the fix, together with the four existing input-core tests.

Assisted-by: LLM
Signed-off-by: Karlos Abel <kabel@voidship.net>
---
 drivers/input/tests/input_test.c | 168 +++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index e105ce71a..889d9e7ec 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -161,11 +161,179 @@ static void input_test_grab(struct kunit *test)
 	input_put_device(input_dev);
 }
 
+struct input_seed_test {
+	struct input_dev *dev;
+	struct input_handler handler;
+	struct input_handle handle;
+	unsigned int switch_events;
+	unsigned int abs_events;
+	ktime_t led_timestamp;
+	bool connected;
+};
+
+static void input_seed_event(struct input_handle *handle, unsigned int type,
+			     unsigned int code, int value)
+{
+	struct input_seed_test *seed = handle->private;
+
+	if (type == EV_SW && code == SW_DOCK)
+		seed->switch_events++;
+	if (type == EV_ABS && code == ABS_X)
+		seed->abs_events++;
+	if (type == EV_LED && code == LED_NUML)
+		seed->led_timestamp = input_get_timestamp(handle->dev)[INPUT_CLK_MONO];
+}
+
+static bool input_seed_match(struct input_handler *handler,
+			     struct input_dev *dev)
+{
+	struct input_seed_test *seed = container_of(handler, struct input_seed_test,
+						  handler);
+
+	return seed->dev == dev;
+}
+
+static int input_seed_connect(struct input_handler *handler,
+			      struct input_dev *dev,
+			      const struct input_device_id *id)
+{
+	struct input_seed_test *seed = container_of(handler, struct input_seed_test,
+						  handler);
+	int error;
+
+	seed->handle.dev = dev;
+	seed->handle.handler = handler;
+	seed->handle.name = "input-seed-test";
+	seed->handle.private = seed;
+	error = input_register_handle(&seed->handle);
+	if (error)
+		return error;
+
+	error = input_open_device(&seed->handle);
+	if (error) {
+		input_unregister_handle(&seed->handle);
+		return error;
+	}
+
+	seed->connected = true;
+	return 0;
+}
+
+static void input_seed_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+}
+
+static const struct input_device_id input_seed_ids[] = {
+	{ .flags = INPUT_DEVICE_ID_MATCH_BUS, .bustype = BUS_VIRTUAL },
+	{ }
+};
+
+static void input_test_seed_events(struct kunit *test, bool resize)
+{
+	const ktime_t seed_timestamp = ktime_set(123456, 789);
+	struct input_seed_test *seed;
+	int error;
+
+	seed = kunit_kzalloc(test, sizeof(*seed), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, seed);
+	seed->dev = input_allocate_device();
+	KUNIT_ASSERT_NOT_NULL(test, seed->dev);
+
+	seed->dev->name = "Input pre-registration events";
+	seed->dev->id.bustype = BUS_VIRTUAL;
+	input_set_capability(seed->dev, EV_SW, SW_DOCK);
+	input_set_capability(seed->dev, EV_LED, LED_NUML);
+	/* An ABS axis also raises the estimated event-buffer size. */
+	if (resize) {
+		input_set_abs_params(seed->dev, ABS_X, 0, 100, 0, 0);
+		seed->dev->hint_events_per_packet = 128;
+	}
+
+	seed->handler.event = input_seed_event;
+	seed->handler.match = input_seed_match;
+	seed->handler.connect = input_seed_connect;
+	seed->handler.disconnect = input_seed_disconnect;
+	seed->handler.name = "input-seed-test";
+	seed->handler.id_table = input_seed_ids;
+	error = input_register_handler(&seed->handler);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	if (error)
+		goto free_device;
+
+	/* Initialize state before registration, without a SYN_REPORT. */
+	input_set_timestamp(seed->dev, seed_timestamp);
+	input_report_switch(seed->dev, SW_DOCK, 1);
+	if (resize)
+		input_report_abs(seed->dev, ABS_X, 42);
+	error = input_register_device(seed->dev);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	if (error)
+		goto unregister_handler;
+
+	KUNIT_EXPECT_TRUE(test, seed->connected);
+	if (!seed->connected)
+		goto unregister_device;
+
+	KUNIT_EXPECT_TRUE(test, test_bit(SW_DOCK, seed->dev->sw));
+	if (resize)
+		KUNIT_EXPECT_EQ(test, input_abs_get_val(seed->dev, ABS_X), 42);
+	KUNIT_EXPECT_EQ(test, seed->switch_events, 0);
+	KUNIT_EXPECT_EQ(test, seed->abs_events, 0);
+
+	/* A later LED write must not replay the initialization events. */
+	input_inject_event(&seed->handle, EV_LED, LED_NUML, 1);
+	input_inject_event(&seed->handle, EV_SYN, SYN_REPORT, 0);
+	KUNIT_EXPECT_EQ(test, seed->switch_events, 0);
+	KUNIT_EXPECT_EQ(test, seed->abs_events, 0);
+	KUNIT_EXPECT_NE(test, seed->led_timestamp, seed_timestamp);
+	KUNIT_EXPECT_NE(test, seed->led_timestamp, ktime_set(0, 0));
+
+	/* Genuine post-registration state changes must still be delivered. */
+	seed->switch_events = 0;
+	seed->abs_events = 0;
+	input_report_switch(seed->dev, SW_DOCK, 0);
+	if (resize)
+		input_report_abs(seed->dev, ABS_X, 77);
+	input_sync(seed->dev);
+	KUNIT_EXPECT_EQ(test, seed->switch_events, 1);
+	KUNIT_EXPECT_EQ(test, seed->abs_events, resize ? 1 : 0);
+	KUNIT_EXPECT_FALSE(test, test_bit(SW_DOCK, seed->dev->sw));
+	if (resize)
+		KUNIT_EXPECT_EQ(test, input_abs_get_val(seed->dev, ABS_X), 77);
+	input_inject_event(&seed->handle, EV_SYN, SYN_REPORT, 0);
+	KUNIT_EXPECT_EQ(test, seed->switch_events, 1);
+	KUNIT_EXPECT_EQ(test, seed->abs_events, resize ? 1 : 0);
+
+unregister_device:
+	input_unregister_device(seed->dev);
+	input_unregister_handler(&seed->handler);
+	return;
+
+unregister_handler:
+	input_unregister_handler(&seed->handler);
+free_device:
+	input_free_device(seed->dev);
+}
+
+static void input_test_seed(struct kunit *test)
+{
+	input_test_seed_events(test, false);
+}
+
+static void input_test_seed_resize(struct kunit *test)
+{
+	input_test_seed_events(test, true);
+}
+
 static struct kunit_case input_tests[] = {
 	KUNIT_CASE(input_test_polling),
 	KUNIT_CASE(input_test_timestamp),
 	KUNIT_CASE(input_test_match_device_id),
 	KUNIT_CASE(input_test_grab),
+	KUNIT_CASE(input_test_seed),
+	KUNIT_CASE(input_test_seed_resize),
 	{ /* sentinel */ }
 };
 
