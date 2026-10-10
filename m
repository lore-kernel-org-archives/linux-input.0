Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296623D891B
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604478; cv=none; b=f2CK9CXxUZIjT38dqm97MtF/DJnEIzqnJCQIVL+4QmTw7xUNOcXg75hVLiOzBbc6QI2X1XxPiTtVdFhu5VehjjtNKYkfCsVrmxJDQG+MGDS05byK7v2q/Nl8T+nQjMfxmwLBHA94lbeUc6bLHqHs3G5Yy9T+HJKaxTrqleBw0pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604478; c=relaxed/simple;
	bh=E3OfWjKgzWyDeHmbfWxXxs2nHwltc6oMVbabWzulk3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ftyFqKc08CvEHs4DbDkmxe/UlnR2v4HWekAYKBzaLV/i/jZBgSzD5lT5Ay86i2+nnEQ7yEETWLV5jdB0MEw6BfHFNSm80MMrqw4YIu1KGJaYt8vP3FXOSKxXsTKyE+MHnz6q5R+5MrH/LW+7JQ5mEeBkAu381t7vPMEjoL8r8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvbBv8GY; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvbBv8GY"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-150f88d22aeso897776c88.0
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 20:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604472; x=1792209272; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBTVSE4A44sNti8mHWZCj/98x3Vgj4Pdkek4UKjOJg0=;
        b=EvbBv8GYgPwVDk9LU6NbZF1GTnfgNGB+sNr8ANrlopAqklyYbGRTj09I9GheojwWHu
         niA/k2kfn9cOX+64OVNjwl+wnETLBygSDpGXEt1QR6MSkD/zQqnTJWKotFA7SsczXEhd
         J4HgtgSsPpaUoB8PIplsfeRS/IspR8zKB7Poyx1cmpxjJTHORSlSJrM5mGJuSWHBAqgg
         fBS6oKVvj5QBnIwCdSTQcjyouLim0QxXcb16n3zt6SiR4E+JTghpw4WpyYMO+oOkYanc
         1d/Vic6930ZfVaPCPLjVmA+Zt/ddEcahdQOYakD2TRuhGcZfkXRmnfsWaYEKU/uaxxPP
         cl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604472; x=1792209272;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBTVSE4A44sNti8mHWZCj/98x3Vgj4Pdkek4UKjOJg0=;
        b=nQdL46cLcvk5HQwoc/zFk6hNJ2oShSM3+mhGUYheZxiJNiv26xe5iZRjQZUzasrSMA
         OunPjZuv4JxRE/0lbHSdkWzQN/m+JArgoHWcc0xkefS+QRdRt7ANTVxT5lgvM495xEGi
         Zx5GnZPULFB5WPuRhtnj32d8TirBPCvlavcc8rn7r1vFp9WGOGi1hNPYPySOVNiED5yo
         no/QWVFU7S2J3nDjWHwnBP6JwDcANZ2nIwBelYehMdsNrRWbPQ/zMgboIthdLGua4iIl
         cZDmnox3FvPx1VDgr41dbB0HzQQbXBpEjAqDcgO4xoUH6b5cGnlv4D4yidul3tuXqxQw
         lWsw==
X-Gm-Message-State: AFq9FYL/quinTK++8+QOyVYmHe+tKBwt6EpD1DEWbEtagHgvIF7JKi4R
	Dn2aGdAQgjtojuX0xzP1uw2XeE8j/YlQj0iiUYcid6pMM6jX6q8UH0sycqge83zn
X-Gm-Gg: AYBFou1WLr+haG8OwYKR7jWISIozDR5/mFTN23Ii2YsYF/iX0KTabNyS/qJbeBlMUNs
	g0eppeB3XyQSM/YStuMUx+Lmm1vpcPH9uijClmwkXO8dp2E6mvk6ammGJEO41FFJsOGdO/hQLju
	NIIv9AaCcV95vJ+5dm7xfbNwJeqamP2C7TH8OkrxjVtugr0zCZ2pEeTkUKNDU54nwFISuaIJDjb
	3tsQXXop8IjPok1ctgkAzi1Y1C7xXIxAhmsU1lC0GE10y3wF8hV7tJYHgJSZFMlWPt79V/wjJk0
	mey52a572B+UfiZtqL14XNtwy49ItK6umZ8tD6pg6wIFhN6de958vxVgC3vaLQRH3zZhXNqr5La
	4DdIbCxCtBoQzQJTIAjzJ3iwP2X3GPVXynm63hyirZfqufgwsPeGA0z8N796RhZtBa6X+nE4N8Y
	JBoxBjxpu50uSw9fa0m/+6kksHsy86jHPCIvRB77haaCciMZPCpa3Xd0uzWg/SodqzjZhwUGl5V
	Vva1h3qmKHRo0LhnEW/2Mw7K1ie8bPn/g0S8oV8
X-Received: by 2002:a05:701b:4306:20b0:154:e9d2:d741 with SMTP id a92af1059eb24-16a6187e53bmr4626341c88.8.1791604471593;
        Fri, 09 Oct 2026 20:54:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7ea:19aa:c6f7:8c02])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1dd57d0sm10171926c88.8.2026.10.09.20.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:54:30 -0700 (PDT)
Date: Fri, 9 Oct 2026 20:54:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH] Input: reject parent overrides on managed input devices
Message-ID: <asmCc1VxVPLIMgY6@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When an input device is allocated with devm_input_allocate_device(), the
owner struct device is set as dev->dev.parent and holds the
devm_input_device_release resource. Later, input_register_device()
attaches the devm_input_device_unregister resource to dev->dev.parent.

Clearing or overriding dev->dev.parent before registration splits devres
ownership across different devices, which breaks managed lifetime
assumptions.

Verify via devres_find() that dev->dev.parent is non-NULL and still
holds the matching devm_input_device_release entry before registering a
managed input device, rejecting registration with -EINVAL otherwise.

Also add KUnit test coverage in input_test.c verifying that reparented
and NULL-parent managed input devices are rejected while preserving the
owner parent succeeds.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c            |  8 ++++++++
 drivers/input/tests/input_test.c | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ac0369414687..76ed9ff40584 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2417,6 +2417,14 @@ int input_register_device(struct input_dev *dev)
 	}
 
 	if (dev->devres_managed) {
+		if (!dev->dev.parent ||
+		    !devres_find(dev->dev.parent, devm_input_device_release,
+				 devm_input_device_match, dev)) {
+			dev_err(&dev->dev,
+				"Parent of managed input device was overridden, refusing to register\n");
+			return -EINVAL;
+		}
+
 		devres = devres_alloc(devm_input_device_unregister,
 				      sizeof(*devres), GFP_KERNEL);
 		if (!devres)
diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index e105ce71a920..b8c8f04c041b 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/input.h>
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 
 #define POLL_INTERVAL 100
@@ -161,11 +162,44 @@ static void input_test_grab(struct kunit *test)
 	input_put_device(input_dev);
 }
 
+static void input_test_managed_parent_override(struct kunit *test)
+{
+	struct device *owner, *other_dev;
+	struct input_dev *input_dev;
+
+	owner = kunit_device_register(test, "input-test-owner");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, owner);
+
+	other_dev = kunit_device_register(test, "input-test-other");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, other_dev);
+
+	/* Overriding dev.parent to another device must be rejected */
+	input_dev = devm_input_allocate_device(owner);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, input_dev);
+	input_dev->name = "Managed input device (reparented)";
+	input_dev->dev.parent = other_dev;
+	KUNIT_EXPECT_EQ(test, input_register_device(input_dev), -EINVAL);
+
+	/* Clearing dev.parent to NULL must be rejected */
+	input_dev = devm_input_allocate_device(owner);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, input_dev);
+	input_dev->name = "Managed input device (null parent)";
+	input_dev->dev.parent = NULL;
+	KUNIT_EXPECT_EQ(test, input_register_device(input_dev), -EINVAL);
+
+	/* Preserving original owner as dev.parent succeeds */
+	input_dev = devm_input_allocate_device(owner);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, input_dev);
+	input_dev->name = "Managed input device (valid parent)";
+	KUNIT_EXPECT_EQ(test, input_register_device(input_dev), 0);
+}
+
 static struct kunit_case input_tests[] = {
 	KUNIT_CASE(input_test_polling),
 	KUNIT_CASE(input_test_timestamp),
 	KUNIT_CASE(input_test_match_device_id),
 	KUNIT_CASE(input_test_grab),
+	KUNIT_CASE(input_test_managed_parent_override),
 	{ /* sentinel */ }
 };
 
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
