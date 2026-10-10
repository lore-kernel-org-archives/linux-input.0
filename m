Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F84A2A48
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659438; cv=none; b=RnlZAxHXAASXr0PF9KX3nZtpviKdC6BHu4Dke02qf3YpVIbwWQdNHtTSIJw7TxoEKM/+HyfF7y7yduqYTRsm2YZIaW+0HV3J/tsOQCztZKMn1YHTwze6MzXqfjVtxV9FM1T7uyIMeK0GTwnvvMS12WTnE95G+DNuJCDWwqnF150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659438; c=relaxed/simple;
	bh=jwbxYj6n7+DjCN34IcgtsswOQMKMadLoao08qekHJv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U51sTQoViciutuqd2wc5pE82bX1GDJkwUE+9GjJq9Mr6Bc1XIVDE/T9pOfbuyR+e0ha9xpo2ZlOpln4SJAmzf94SsCZ+XksUcrdTUw0BTIABc59OMtZsQa5WayQBG/W4cCGA5vu1GQ30mZkbUJqvyVhy0TIdKxCRHJBO8geFUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=tQeQuYaK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="tQeQuYaK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93ece7a73b9so75591585a.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791659436; x=1792264236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLAb4kAPuhnWOnja9uy9LTtNmvQ77jTETJ/932SVf/c=;
        b=tQeQuYaK5JSRpEXWhzbotE3VVW3osAaGAed9xidn8EWqUtggvwB/Zi5jgsxgF7QWsS
         hr9lQSFWsaEyeV4Ud80p1kdLeXciz59TaovcvzROSJqs8BQrRPZRC+r6U3RX/GMiOqPe
         ZpTF0jjDguQtCWfRICHtR5mTpAEnU9DOvYsG5/jm06xD9lSVLNBSDzOOrQwL4yWhGOJr
         ZG7W0AGYhihPsAJhFW2TJU6s0Kd3gwH/4bf+FRcKGblH+B/7RUgKCzU0hgyeLAnYuB2l
         nGM1blb2jp7/QZ1q3i4KYBaai+euYtdiPD7fWYmwEZonC97koQ/OMU3hyF68VX0wQtRs
         9oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791659436; x=1792264236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLAb4kAPuhnWOnja9uy9LTtNmvQ77jTETJ/932SVf/c=;
        b=wwsIWUy2NRkOCS3FJkZ7LGPoThZ3kSuUnmVXDGS60LC4fHsU5ssaMXNK32UBtSbNWT
         NUs0AUFqbTreEcysSYsupglG6HPxUqzgKGXFJ4F0tuWp/YS63atQj0666o2QvZCxP5PJ
         EQuw+OZMLQ+79+LWfqlN2T0xg5GU4JLz90/6fnZwXI1TYrt5eFlHjpjybJzoRbo9SVmH
         p14rRE7ar8craOpPQQ9Gac21ABNg4qI829Vs74HthfCa/A9YoVfT0w+QBV/hMgKSfgJO
         5fsg17hgqVYthjmhka/Z1dm5P7pXI8sB0GDyIUIt/2EqEBo5dgqEEnS2oHFHnFM2N59F
         L4KA==
X-Gm-Message-State: AFq9FYIcllD6uf+WhQnWn//nFabCUdz1A/ooSTiMgdetBqJaCnqXUUQV
	BrU0/J7dXRr3+8nnBo8x9L2h+CZ+nDXuMeWSX+oNDMofsOwJCgQKGGnz1IT/HkiadqA=
X-Gm-Gg: AYBFou2adImAJf6/egwMjVP8bGv8Unfy0rp2D/pJBDK9J2n0Y+lWAipbhjOACifS/qr
	6teL447a6AcTRxJcp0XPIfdkV8/ptt3gst7S8q7pSIkSh+jFknzsQ6lxejZc35WyzGzmFSdVd4D
	YwATjKMOuDK7gGa3yUjdufcrh/OQkn07z11YSRg5z8XkCAA6jDVyImmOW8D0od4RiHgrgpkgyhk
	INqKQT57hbLLilRYHMjlJNvt8owhrMGkffV1LH1txqk1R4jcYdQeLSiDaEmnlkWPWb1fEyQmyvQ
	N0koVamCoxAKx8JBOC2YqAMJAwRYUU3YP7lPZS5Y10/4dwFQkCrYFCvAG0pqpbGw+TKqdOdF34C
	exwUzrXm8ocR6qQ87It2ipCl0p6Vv2ycHqZWar+zI/+hwB+77zil4TxlEZBZ4JWPgVG6Re2/U9d
	/Rf9+eJame0Ebx59moV8cSiEVWDiNWt7ROkKiFcHlt3j48tfhdtO+taREzMcoHzuqT6OtqHenAd
	QeyTGZQYCYjJc/Fq4RPlVDvhnhCl7CcTiSIPocswVs=
X-Received: by 2002:a05:620a:a2cf:10b0:93e:c12c:f142 with SMTP id af79cd13be357-93ec12d0865mr594387485a.76.1791659436074;
        Sat, 10 Oct 2026 12:10:36 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0cfsm489355685a.19.2026.10.10.12.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:10:35 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v2 2/2] Input: test state seeding across device registration
Date: Sat, 10 Oct 2026 15:10:33 -0400
Message-ID: <20261010191033.23577-3-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010191033.23577-1-kabel@voidship.net>
References: <20261010191033.23577-1-kabel@voidship.net>
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
Changes in v2:
 - Check absinfo allocation before seeding ABS_X and free the test device
   if allocation failed.
 - Unregister the test handler before unregistering the device, so its
   pointer matcher cannot bind to a replacement at the freed address.

 drivers/input/tests/input_test.c | 171 +++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index e105ce71a..fe4beec8e 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -161,11 +161,182 @@ static void input_test_grab(struct kunit *test)
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
+		KUNIT_EXPECT_NOT_NULL(test, seed->dev->absinfo);
+		if (!seed->dev->absinfo)
+			goto free_device;
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
+	input_unregister_handler(&seed->handler);
+	input_unregister_device(seed->dev);
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
 
-- 
2.56.0

