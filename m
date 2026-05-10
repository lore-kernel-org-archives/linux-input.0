Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28C372B50
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778415840; cv=none; b=aiOPTnHAaC9Ggmbb9Xe1carjwTNF9uG04giBN7qbnR5YColfUbjfXV+1nFxAWKQbEaWo4u23f1Ouoaa4V1l8u+/0P9nAz9RKWw9+z02iCo9wy9Mf8cv8bFj2TamnKqolW1u8euNj6nODHVCcO2rtFg3hyoWHPOnPzfwcHpJM35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778415840; c=relaxed/simple;
	bh=hkAEcL6nfvQODU2P0IFadfabnehkvacnCGHyVpjrIGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C+P3VqJpY4L7lwsBTOohrcKXDW3Wfetydi5CDl4g+2Sm59lQ0vqQEwf9A/jy2F1vPeArYX0otujEtYWvpcze3pU1IVYPQwR3hkLd92BA3MvFCxK+o1LNdTdeuu+1HVkub6JvE6wu11I3dq1lh31a0gpDFyvsp/nFBXi2a2/zyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axlC8UC5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axlC8UC5"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bcbf867a77eso17219766b.3
        for <linux-input@vger.kernel.org>; Sun, 10 May 2026 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778415836; x=1779020636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AtQVnnlrxzq6LC48B19jdYIcKO6FStZOhWhuwmTDN4=;
        b=axlC8UC5U1u6nE2hoPg9XQCWls8NeZw1vPQekRWilTfkqt4+LxddMkmEUYKWnG+hy0
         y280iZ8BTY4Lal/TVSy0v+3cXbeeizmJBVvNJ8EZboYUt9KEGfZPkV6KvREwHsRX9J7A
         BglcvuwCuKyaVdrHs9zIDJ5pjwA3wRc1docp3BZlirdHNeSnoyvnGZx8uBFo1clz20xN
         jz7VU+eX7/7ISZ8jn8/AMiseMJvtTWh5dhvB1ngNhr70b/fb00ubDiHWSk3lgDxoh/yo
         nKGkPk6AS4+/32ULsPHTBUWoxXP3gLXj9cxfi7M7yUo2GCLy+fKn82MkA2qkUkBf1Rds
         lqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778415836; x=1779020636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AtQVnnlrxzq6LC48B19jdYIcKO6FStZOhWhuwmTDN4=;
        b=VPYg30DBT0ODdpNtsXzNDIY//3l68MPWFh2MwbXHjf1tp+BDnYBqfYvh2TcU/oGzAf
         9PZmT9hzcwFIzPhouNO1PUTIbDO5bP5lY56mjTiXiXAls90d6V33RBHYDo53pV/U/b+1
         Ae00x3II1StVh1RJm8UMzkmiUgoSWJoJPjAenF5oBlXOH9VxqWB37auMlcWegdyBZPUT
         SJnnrCN2jiw6yYwozYXjlTPbAfZxvgfwA5r4YIxbUN18faCIchOg1vIMfEyYSpJf7H61
         3yw6awFf1KIE9esn1nX5Mv54TLjZY4J3R6N1wUVMDD88eBMpe5AHnUlVOIhpb7OV2Tne
         vh8A==
X-Forwarded-Encrypted: i=1; AFNElJ+Gyt6VIgTJ9VgD1WnzvHcxb57NEFaU8Y4IBp5UDdO5xyJwJGy0ENiH7NXDtPtXb+JEzJSfA4VLSqo+Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgSAVwbhqeR5UY2T0tAAJ5+zw5wdckA6R9EMAyp3psVpNj0Lg
	VZF7BO/7jb1aH9d819ZzH87DhH42SI9dsEpa7+gfzYUnAbLKnXXeSf+1wxkN3w==
X-Gm-Gg: Acq92OEAZLRKinsxDTvP7eJjzCvJKIpA4VTBUJR5pr9Do7EQuf5+9zsEWa2MAU1mDQf
	WTZ++naRw6xQ1+/KBVc8VUgwd7YYgemRuNEKRtObzseyW7ymxrsatxfLq+loA4yKBGunGI72698
	rwZkWVhRRX6SQ5ImTDGe5vtiAUEtc2GYAFTmJaLiVx+QZT4fz+s38QnKHUgi64xOWe4PtgJJkGd
	zD2dBtim2Ku5JgbvDCGkagMTYdnLNrOQ5iQuxpmntibc4q70mtD0QaeSVBBCWt1FCtRJbtzprI+
	8L5kb1kZ2I1+C4V1ym4mbz4/rGZ/H5mtjLBjoFPdjTaUb/Xf+WMwYrhWxLFM7qSXo+3NzyzBD2b
	tNwSDHfWez7ZHnoPnWZTLJV/nIXLsJHpTCxlk0OVD0euUdySqwkIpqKUfV1IpJahyZHEQS+7grW
	XcYjft1bt/DNLQi0coglcGOFXVKEGSlJz0MEjaC/B9W6ugtNlPKpJTrbLCtxH2hszeFx8v5YVFR
	zYf3tEhFFayRJE=
X-Received: by 2002:a17:907:3f1b:b0:bcc:9150:213d with SMTP id a640c23a62f3a-bcc91502b69mr101154166b.4.1778415835290;
        Sun, 10 May 2026 05:23:55 -0700 (PDT)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcabd5cef81sm350990266b.0.2026.05.10.05.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:23:55 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH v2] HID: pidff: Fix integer overflow in pidff_rescale
Date: Sun, 10 May 2026 14:23:52 +0200
Message-ID: <20260510122352.1161826-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rescaling values close to the max (U16_MAX) temporarily creates values
that exceed the s32 range. This caused value overflow in case when, for
example, a periodic effect phase was higer than 180 degrees. In turn,
rescale function could return values outised of the logical range of the
HID field.

Fix by using 64 bit signed integer to store the value during calculation
but still return only 32 bit integer.

Closes: https://github.com/JacKeTUs/universal-pidff/issues/116
Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
For inclusion in 7.1 RC period.

v2: use div_s64() instead of plain division

 drivers/hid/usbhid/hid-pidff.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index aee8a4443305..c45f182d0448 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -11,6 +11,7 @@
 #include "hid-pidff.h"
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/stringify.h>
@@ -326,8 +327,10 @@ static s32 pidff_clamp(s32 i, struct hid_field *field)
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
-	return i * (field->logical_maximum - field->logical_minimum) / max +
-	       field->logical_minimum;
+	/* 64 bits needed for big values during rescale */
+	s64 result = field->logical_maximum - field->logical_minimum;
+
+	return div_s64(result * i, max) + field->logical_minimum;
 }
 
 /*
-- 
2.54.0

