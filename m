Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF634E777
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673094; cv=none; b=V0fjfAmtzVnaN5GIoR4prV3Eq+svsg1bSxiRm/oerSlHk8JDbijFLNG+bedcG93HuVJbNBCtpVKDpD5ICP+ysBZ2Jq38cLxGsUV57/XcbQaO5Qn0GKMEY6gY15jBnewwlofAbjvW5YU1jVmCz/vsbGrbDh7PlfP99EcQwOO15P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673094; c=relaxed/simple;
	bh=jwbxYj6n7+DjCN34IcgtsswOQMKMadLoao08qekHJv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzS2T9k+d1Cx043ETFIXtNmQsdNiewPW5+2Awko0PPPDBu5xQ7Y0fEkO0AXsPksdtaQHEXU1KAyhOnJw4Zq/pZ+X2oGt9zPufP7Qy29+7iT9cZB0aBfa8l6p3Zd/ZsKlowpf5I53ttSp+yHPG36kS6HgejlO8aoGp4P6QVsZZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=Xwj/LH8u; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="Xwj/LH8u"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-9144e8021d3so13144196d6.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 15:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791673092; x=1792277892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLAb4kAPuhnWOnja9uy9LTtNmvQ77jTETJ/932SVf/c=;
        b=Xwj/LH8uG4wB9xjHnppGyLXoen24UnZrvdFs07+9lEZWUNozzHpU/ND3IlTwNfPmfR
         jDiGkTPGshmJUYudOkGTPokoho3ZUNUqmnizve0aeAqR7xh6M3/N/DmAqpMrkNT5eC/J
         TQ3srQpAPsdr7ng0QnCnHKxScSaxjXl9QNoZvd6R//EcuH/v7SBgzGmYeT1pc9OEQxNr
         myEZqoNZS0gxw4TbsmLdtBE2WDZa69d2J/+m56SX52NkKRZ4XVy1wCfd29jIx+UL3kej
         qRRxKINwJXRkaRab/mDndILC7N0HZBgzo9sTAavzpQIK+cTcUuCV5+1zUWYUQ4DT6C+a
         vPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673092; x=1792277892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLAb4kAPuhnWOnja9uy9LTtNmvQ77jTETJ/932SVf/c=;
        b=B+mD4GBRl2p29fvjM4S2O2n83Q30Ve7BQf5VsmIAbjcJruXlh6jXWtVE85CMrgW1BP
         7soiipVH3VZCC42htHdGU1ocj20pA22D2OluqMYI5GLve8dtqG+NjcuDStZy9oXMjFo7
         mqMwDGYsAhJrPJAANmh5lJun1CNdZs99/mtJSgoyU+sRCW/3DQHxImkynx3+Tf9fTNXJ
         eS8Pe4Rl2LkxFhcYMZiyHlWHokV+/A2lGB48TDt7NpyZAGC793MIkw8yxrLCoV89odRX
         gQ+0pryAW/8DVig4aBww2rQNTLelTJiiBPyDJ4HGTp9FEMNNV1E8zas4/DpemkwEFrkQ
         cn/A==
X-Gm-Message-State: AFq9FYIXEmwwG2MYqjA4Y39WBaDscdT2+wyeExYDOgcR2mmz838A/OKg
	8DSoPt24UyJrv5IyQqBRYC0kXvM/psHj+8cYXEEj3yKplU5dVWrPpBXdc77iCj9bug9ULDfSB57
	DfPEYyCs=
X-Gm-Gg: AYBFou2rIvPPQmXSZdPxouO2FQGaUARDnznCoVL790oyz+bvdaAoLyrr7iOYYkSWObX
	0L9jcUVKvYbhAWyyO6WdPsRoUXsSVn05+yEYgozFCtAH0Iq38fe0+GNJQ8ZGGXhlR1yqlEtWaoE
	xijH+j2o02bQz6JMq4Ejga9f1lfdxtnaVnNcW7c2ElCRpH4TBvUXMO9x69T6Zf9vYr/XFstpG5d
	9a6TiLev+EgPIO5mS1j+KUYUKefxKCYSF4g4+mdat9Fz7yaKatBSKip7vCC7yt/koadi/0T0cKn
	gySmOviROWUUj1OsUZElDvZV/bhFicLXgQGddKtIVfBCocjl5RjtTHHXZsA/NKjSxXv0nJw1Sva
	7furkfbKNCsVe9/RNtx1cgJVgn2DW4TGcrbL+3xbXhjmD91FLHehstwH+pFE6E1iqPiIKYY6TrC
	cU+OLngtYvspdWLVZDn0FibGSZPK6dwzjyXTFyIoJMpoWt/beIcYBElwEe1JWBE7gjM8cLFhIRv
	c7bp7d5N6yySIzk+4kMMrshN5rT23uHTBRjMz07mA==
X-Received: by 2002:a05:6214:ca4:b0:91b:5d3b:7ab8 with SMTP id 6a1803df08f44-91b5d3b8021mr90818976d6.52.1791673092053;
        Sat, 10 Oct 2026 15:58:12 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55092ca8sm55498256d6.37.2026.10.10.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:58:11 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v3 2/2] Input: test state seeding across device registration
Date: Sat, 10 Oct 2026 18:58:08 -0400
Message-ID: <20261010225808.36404-3-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010225808.36404-1-kabel@voidship.net>
References: <20261010225808.36404-1-kabel@voidship.net>
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

