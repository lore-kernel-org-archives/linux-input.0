Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6F3644C3
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040953; cv=none; b=ZWIIovGuVHzyWApL+EOrKyoxWNvkCVkdRhHwYZ8DTlffAZb2uycSRlsymoL2W4WpG0tzbA6HOb8OZEuxykfIeuLiLXw3KP5/5jYOp0PVz3oNIDa+uA64ax8Dwe0CwUTofCszSp3jDeSCTqg/38RfuQYR4KMxcoywmgmoldFjfwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040953; c=relaxed/simple;
	bh=Fk2hYG2ZcJpnk3DXHtUKENKgb4QagO1vreaRXLuQhNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJgZ2qWNCu2TnT85NccbSvGW7oxzEJev1P07Hn5e0Q7o3ImMVMgTV4Vmr8eXpvxwdiddap2yCk5AJkYMuBHWlmH+qjAVVb+/6fBx8FpTLtLXje9FX7hW0v5j55qDVWvHmvi1MeOpyDC/+23gF3kUN/ZlOPNTDCAX+gNVmyk3vdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NweztaNZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NweztaNZ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8573e75425so2320933a12.2
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781040950; x=1781645750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B58pHiXetkybKB6YBr1hbWy0KTCPhTnSt5GkHYgx6m8=;
        b=NweztaNZ1FxUHWfMmr+FWw98osBknNr1iVE3Cya+IjdauIQ8EVlc8IEoTqzTzTctyK
         mxCn44U003/gfgoH1EHvnp7vzwSwENdj3N5rvv8M+vLtb0wo7FJ/B7yDivvphxwLrE0I
         5Em3G5grqnJaTDc0w19o1bQSWM4NqVmXVJ0Wx0iPfJTzbAum7m61BHIrjt6IFH9y3pUD
         qXfiKvHP5bcl0KWV8wlNve5z3tTGV8AZ8i7c3puOhyj2+GQ63s75yTdZ1Ih357bTsCME
         /zS80t5Khk4oFzMvz90NTBYi91mVe051b3gxOPyGEcwJEq7FqKYFEBGXGkV6ztItWpyd
         tBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040950; x=1781645750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B58pHiXetkybKB6YBr1hbWy0KTCPhTnSt5GkHYgx6m8=;
        b=ZwlcwV/t4RlY6kEOdHuPETlayX8ZAp6TV4rNZ307wpGCOXu/NpjDI34XkWoLXvuPds
         iWYzwd5hA1o38lYZCXNERD6mM3xQ0YkTiJNa0AlCjwRBhMDJbwiMU9MhqAAQm/1jSHbf
         /mmRkt6dLCXESr7XV1lqNN7PM3In3fMrEJzN3WUO+tF+oJtBfjvzw6Vhqd0aKpOYBfUZ
         698sDYmVs7oeqlkKk/urUucrXu7x2H8Z4dStn6uq5KGV4ftUVb/gJKcKEjsJDoC/UaZH
         K7XxEOCtnNKqeeXUMwDfuVMCCrFPWOQl5GBA5f077s4MmPVnaDao5mE291sy9SjwyaDU
         Zsfg==
X-Gm-Message-State: AOJu0Yx2zT9opA+gZgExl84twjsdjJzb6qomgonHY7Xgp538spd6PPiy
	vED52D7J/L4vJDsSZfIZYhCR3jkZEWVbXGQJu2YrRCLSn2s/RN2St+EZ/iUiY0Xk
X-Gm-Gg: Acq92OHrc3aLDPFKS+c5Ury1Jc2hK45R0XaOlUAHBaeNoiEqdPFij11B8d7lxDyjqbb
	RRub6+ltHgXWRN/m76JhD0jc5p2GBL/6I40B4ggKOIKba7EraEvanZXDpmEwap1+olbxNm5yQgA
	i20DVwIZSUfLEpUP9GToO/kfHkGWR8ICfLl7j1GtOGpSro892UPeeVolFifxw1dy1b+iGcfbQ+n
	GkmbmPMfjLxwx60uezk7A1E7+JVNY3FDwurAwkkQzLhZoc6SuG3uO0pezm2cF9qNWpGSc6suph6
	gl93jw1uUqvMMlPeeO+yGs0O34ZtBPCIe7zH2IwzXFlCo7IkTG9dY/g+qOCdU40OhbMWkh7QfFA
	QCUL7z13u7/KBBgCHuHA9OVxu7DI5xXzfzdT8valJs2aQ1A1+/NFkLGkCZAD9t9OB2adCczVfBF
	rhZJuFiaQDLO9GrMl0cESNHdQHlEc+AI1ZQCeWTeTB6HYNehrbz2LeRyCyDWt/JhmhvtlJnNT9K
	BI7qdkh2zaG9px7BrO666nnU6N9fRtzNgb0gReT1GRbkw==
X-Received: by 2002:a05:6a21:3945:b0:3b3:be21:e363 with SMTP id adf61e73a8af0-3b4ccd4b8d5mr27546627637.14.1781040950440;
        Tue, 09 Jun 2026 14:35:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0341f6sm19626851a12.7.2026.06.09.14.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:35:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] input: ipaq-micro-keys: simplify allocation
Date: Tue,  9 Jun 2026 14:35:32 -0700
Message-ID: <20260609213532.25181-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed the keycode array in the struct to have a single allocation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use regular array instead of flexible array member.
 drivers/input/keyboard/ipaq-micro-keys.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index ca7ec054b1ce..695ef3c2081a 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -20,12 +20,6 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/ipaq-micro.h>

-struct ipaq_micro_keys {
-	struct ipaq_micro *micro;
-	struct input_dev *input;
-	u16 *codes;
-};
-
 static const u16 micro_keycodes[] = {
 	KEY_RECORD,		/* 1:  Record button			*/
 	KEY_CALENDAR,		/* 2:  Calendar				*/
@@ -38,6 +32,12 @@ static const u16 micro_keycodes[] = {
 	KEY_DOWN,		/* 9:  Down				*/
 };

+struct ipaq_micro_keys {
+	struct ipaq_micro *micro;
+	struct input_dev *input;
+	u16 codes[ARRAY_SIZE(micro_keycodes)];
+};
+
 static void micro_key_receive(void *data, int len, unsigned char *msg)
 {
 	struct ipaq_micro_keys *keys = data;
@@ -102,10 +102,7 @@ static int micro_key_probe(struct platform_device *pdev)

 	keys->input->keycodesize = sizeof(micro_keycodes[0]);
 	keys->input->keycodemax = ARRAY_SIZE(micro_keycodes);
-	keys->codes = devm_kmemdup_array(&pdev->dev, micro_keycodes, keys->input->keycodemax,
-					 keys->input->keycodesize, GFP_KERNEL);
-	if (!keys->codes)
-		return -ENOMEM;
+	memcpy(keys->codes, micro_keycodes, sizeof(keys->codes));

 	keys->input->keycode = keys->codes;

--
2.54.0

