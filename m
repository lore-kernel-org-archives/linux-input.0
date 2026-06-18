Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94F315D33
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751645; cv=none; b=c8fUZG6nwPoLw6BMYqtma/EqwotZNHGIOzMEn5NbDBfHSaaKmgcuGSjxMkh6EbxI7gAT6VBJdNxmYPfvjqUwNLb8RWQR2orGu4VJ9+HOhlTY4pka9FkNWPYF61+3/2NBZdwO0zTVeQHXsn+CnMc+bK23VHkkuj5UBUwBqo0nULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751645; c=relaxed/simple;
	bh=l2cRomZoLge6LONBE2yLvSqlJwS+4ckX58gy33uNLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZYCHEKGgt0yd/9Ws8Th6CC1oviwoKmCuZ/HlithexKUp4J0eUjatrj53T7sX7FSMx2NkvoIzMaG6yodzEaMfeP21T0zxgo9mFIuDqCxL9O2KhhIx/GSzAphIBVaodwFUiDgCxKD2qXSAZ/EzdCBuMnsFTM1G9C4SDT+1E+psxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnqoe8IN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnqoe8IN"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51775f2473aso3593291cf.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781751643; x=1782356443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FAMmyEIrLheJfaZS0/7dZjAIyQHnQpsSZ6TXs7Q7Jg=;
        b=Dnqoe8INV+LnMcLn4WQiNeDfGEz76V+CUMxNmGK4V1wV0DJm4W2tp33L3uyTW0xHJu
         i+y6bepOMweTMLI5+3l9LOV3+cLEsYOOGByudWUTXnCphrmMHYVBGYh3YSdFVRF1DgdY
         STDhPAOxrU9dzYKIakXe2jda793IQOif0GTOaTyDDUfFXjNAlnJty32CVqhc17O29ifH
         CA45GN4uBDqx/hBR6BWolQQRxDgoRgm6aGxx2JLgWfOU3zk1VvtFC9GPNDybd0nXwox/
         1lNUkaQwyibBnkr8QOUyitu6BIj3FeGB6nPDZew5JV1mXxNLuAs7UJY3KpwRMsOkvWvx
         dRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781751643; x=1782356443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FAMmyEIrLheJfaZS0/7dZjAIyQHnQpsSZ6TXs7Q7Jg=;
        b=GnVssOGSgfJZOrcjrFfloEeiPoi8it4dkGyVYqkVm2wyUbegbqCXeIGx6Avi4y8A/4
         ietrG/xGeHVBLkaddx+8Liyl1z90j6TVC0BuW/UCi0+LBMEc/4zYcb71kSDiFUiR2kZi
         CZTe4Cfw1dlrMYJI7tU0G89WOV1EoMdPS2HthyqikWXJUn65vUvZdQHD7rTt9S1v3337
         UaGf+JneKsd5AMkj5EQ5jUE38vgZ0RwYB/TsibUbw5VOmDL8mo1skjmHsQ0XQH+ZBaXS
         Tx60NRKhiONkpuLt4gh6rE0P/bwhRGIbCXojw+jWsH3gUkYMYWaTUtpIyeF3KU6qa7p/
         L8AA==
X-Gm-Message-State: AOJu0YzS+F6yaOcbwHTe1VuriINoucMgWnBBkgyg5ndZC3diwvwpFR6a
	quy99m9NM3MInazJtZQSIdaOhAozuPWgeeLZMGK6tFSSHRP9SyixO/TTZ+fUtMI7vCk=
X-Gm-Gg: Acq92OHoidU5AaIIOilziewxCMfjoOmoL4XUWYQm957pMk1Y7YiLb0li2IHPLyva67W
	QnQW/y66kO4cdILix89ZxQAAO74FtB45Wt0lLUFFox8iKJeb248CvBnJ1UQNPqYP7vr+sGNob0Z
	IPL0+jonnxCOwf7np7/fXoCY+qJHBHmzH6Dxl6EvSgQ1D/g8AFU8/mRf3gdiDUDEb3pO5dhXcKQ
	egJFytDlrntaWCOh+CznPfCzhlgVunvqqtswlA1JDdsQK7ObA5WJxFy1yHFVGywurlZuJxBLC6S
	1WfTrQCRm+AKr1LiAuxexA0TihMx/4du0F0ka+d8N3Fcg0Op8t9DA71LIKHmNbKTBAj15YGpUAW
	9ElG+JCewuU5/6rsto9VoWkO35PuKhuvjALabSJP+9ay306A0aNAVtEsJn/eyU9YX9ho6a2YL1y
	UV4PwLwLzjPsUq2XrGsW5jd9AbZ9TQK849TQ5j4fibf2jWD//1KJzdPlp4SNccfWHj/6UU063xr
	AOSsUjk5WKe35D9Cs4MSuJjMzeMSfXq
X-Received: by 2002:ac8:7d16:0:b0:517:8aa7:4ab0 with SMTP id d75a77b69052e-519ac4ccec5mr82237851cf.38.1781751642599;
        Wed, 17 Jun 2026 20:00:42 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm183849021cf.4.2026.06.17.20.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:00:42 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: roccat: add KUnit test for kone profile-index bounds
Date: Wed, 17 Jun 2026 23:00:36 -0400
Message-ID: <20260618030036.1880139-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618030036.1880139-1-michael.bommarito@gmail.com>
References: <20260618030036.1880139-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Drive kone_keep_values_up_to_date() with a crafted switch-profile event;
an out-of-range value reads past profiles[] (KASAN slab-out-of-bounds on
an unpatched tree). A benign control with an in-range value exercises the
same path. The test object is sized to end at profiles[] so the over-read
lands in the KASAN redzone.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hid/Kconfig           |  9 ++++++
 drivers/hid/hid-roccat-kone.c | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index ff2f580b660ba..3c6bc918aeb54 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1057,6 +1057,15 @@ config HID_ROCCAT
 	Say Y here if you have a Roccat mouse or keyboard and want
 	support for its special functionalities.
 
+config HID_ROCCAT_KONE_KUNIT_TEST
+	bool "KUnit tests for the Roccat Kone driver" if !KUNIT_ALL_TESTS
+	depends on HID_ROCCAT=y && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Enable the KUnit regression tests for the Roccat Kone driver,
+	  covering bounds checking of device-supplied profile indices.
+	  If unsure, say N.
+
 config HID_SAITEK
 	tristate "Saitek (Mad Catz) non-fully HID-compliant devices"
 	help
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 17495fcc8b7da..3dae9eaa0b6f4 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -919,3 +919,60 @@ module_exit(kone_exit);
 MODULE_AUTHOR("Stefan Achatz");
 MODULE_DESCRIPTION("USB Roccat Kone driver");
 MODULE_LICENSE("GPL v2");
+
+#if IS_ENABLED(CONFIG_HID_ROCCAT_KONE_KUNIT_TEST)
+#include <kunit/test.h>
+
+/*
+ * Regression test for the out-of-bounds read in
+ * kone_keep_values_up_to_date(): a malicious USB device sends a
+ * "switch profile" HID event (event == kone_mouse_event_switch_profile)
+ * with an attacker-chosen value in 0..255, which is used unbounded as
+ * profiles[value - 1].  On an unpatched kernel the attack case triggers a
+ * KASAN slab-out-of-bounds read; the fix must leave actual_dpi unchanged.
+ */
+static void kone_profile_index_oob_test(struct kunit *test)
+{
+	struct kone_device *kone;
+	struct kone_mouse_event ev = {};
+	/*
+	 * Allocate only up to the end of profiles[] so that any index past
+	 * the 5-element array is IMMEDIATELY out of bounds and lands in the
+	 * KASAN redzone (a far over-read would hit unrelated valid memory and
+	 * escape KASAN).
+	 */
+	size_t sz = offsetof(struct kone_device, profiles) +
+		    sizeof(kone->profiles);
+
+	kone = kunit_kzalloc(test, sz, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, kone);
+	kone->profiles[0].startup_dpi = 0x42;
+
+	/* benign control: a valid in-range value drives the SAME path and
+	 * must succeed (proves the trigger reaches the real code).
+	 */
+	ev.event = kone_mouse_event_switch_profile;
+	ev.value = 1;
+	kone_keep_values_up_to_date(kone, &ev);
+	KUNIT_EXPECT_EQ(test, kone->actual_dpi, 0x42);
+
+	/* attack: value == ARRAY_SIZE(profiles) + 1 reads profiles[5], one
+	 * element past the array end -> KASAN slab-out-of-bounds read on an
+	 * unpatched kernel. The fix must reject it (actual_dpi unchanged).
+	 */
+	ev.value = ARRAY_SIZE(kone->profiles) + 1;
+	kone_keep_values_up_to_date(kone, &ev);
+	KUNIT_EXPECT_EQ(test, kone->actual_dpi, 0x42);
+}
+
+static struct kunit_case kone_test_cases[] = {
+	KUNIT_CASE(kone_profile_index_oob_test),
+	{}
+};
+
+static struct kunit_suite kone_test_suite = {
+	.name = "hid-roccat-kone",
+	.test_cases = kone_test_cases,
+};
+kunit_test_suite(kone_test_suite);
+#endif /* CONFIG_HID_ROCCAT_KONE_KUNIT_TEST */
-- 
2.53.0

