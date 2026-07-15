Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8339CCED
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093781; cv=none; b=frK6NxETriyUhNMT3dxbInf/3NaXcUFehW5H0MiHiXkW2OFb9tBInu5NL6MYOV8bLHmCus8Ox8ZljXaAgUaRC999x9kb/aX0z3x0aDAfq9TWDdLXOipaKaAjemyKfESiedDNHIgn2ld4VGXYFWLn1VXaPhjzcL/l5bxQSSvIbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093781; c=relaxed/simple;
	bh=TJRVnTObx5VfHyXxkOWndVTFWFppLO7ckvrK1vsLwSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e48I9dAaAD3e4IN6FLSzYzlGDt24Sq/2b0C2qtK32pBucSHGeoVehTm66RvlKGJIn9i5sscZHM7FOh3mr//BNyaVjYXTxPWxna3M+lcRwgTSYOipPteDdcEtsfC51Y9iT+ETpS/T+mIY1TuGYkUpm2jdTo8703Y1MUEXfiJ2Fuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHc/bD1J; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHc/bD1J"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a376ad8fc0so1706538eaf.0
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784093778; x=1784698578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GhOZyFX7X6sxn9hMIG/RdOSM4KmInQG6rZiqUHkcnsI=;
        b=NHc/bD1JQESgPrhBp7qK0FqknopVqxqOO+G/KyCIR/OoQSSIiHo2APDpS3BBqT+yd2
         DX9b9qZAzxzE/oyHPjbawxr5OBQXD0/PxQJIiZn8fzkk4YGo9DvP4ts75ksuMgOFueI2
         8Ou+sTh4cgc+OQ80j3T8+Z45mTcXvPEVV8qztOBalbvGgH3jWkfxV1nHvqXq9h06oVO+
         AskGHHPfc+jtY7TzGoGrrCIIOHJOKMU8beK+ZPxUlRoEIsMt1l4yyjZEOA5ZM9R66a1n
         SKFUXNGHRqdztA8Xr6bi8gxn3Qf7iw1R4JdSvZwiN0KpQh3LH2Pp8HxlQcN/Am7oFDs4
         4W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784093778; x=1784698578;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GhOZyFX7X6sxn9hMIG/RdOSM4KmInQG6rZiqUHkcnsI=;
        b=fPWKuGzs7DiVR3w+jy2/qpec5h3kwghRVAU0m/EZLCHQW/abyoQpBwKGEMtiVAG2To
         +WYMJ6sSU+fw81CiOcMsYG3EeKNARJQO+4hwLYsupsYSkGGY36/ohT40oOjEb3oP/2px
         KSkM+K/FbfVbo8/v0L0nvNUxB2c4DaN/gLTf9DkyFVl0bj+5LgQeF5SAeVII8E9Jmi+A
         VU2L+0kzfsjSqKA2fDkLXqlFPwOQ76EW1x3ImYUg97QRAlwg43+A2rAeTVcRR5dYFUsO
         6YKToDLw3+3llxi9qR0cfkC1WxUmHkDm70HlSByR9MW8TeSE/iBOgURxDRwXw1FPfG1N
         jdHg==
X-Gm-Message-State: AOJu0Yz2WlUlPNGVdgRygJlv8NmjXhF2bItt4ZKfJ8KCPFtjXTEstkQR
	Wai2EudY+Hm6gxbMG8LIMw14asSaQ54VuA54WXV4dlDfMlKbvT6NrFD/
X-Gm-Gg: AfdE7cnDP+5fWyB6xiAG4PoE98Px7PjvdJQaDhF8El9buvExXDno3cNnmokDxwPxMCN
	waZbqAB/wwdvs1zA1JezMtuPW03bv5DWOgiMEpEpFBNUeGzRyFq3rxmNurXS5egAOEpWoCG9agV
	qJf5M2KUOOJr9bVcNEgj13YOYEoTCASJInZTJAYfk9pF3ZEHbpFYYYdbPED57NifmJLyLc73CBA
	tA4F16/r414hQtm1kBkgrAiU+V2dVv7wnnof81pDxAgZEMMf0W4h9TfJHYwv6OGLWdFYuQ1oEog
	ZPiqVJHbR4gJiUmSQO9xDOaoo7v7AGinwO+JRocyI+iYNoAnPd52oboYDLG/OjHiIHcwVZ5dpke
	Nuqdz1CysIG5VZryAMmCrfMhp8QZJ1EE61ardGgKDZEn9tuVNk34iwdmnXS17yMw901ai9MTk4X
	yf2u7lcaEiXxu8
X-Received: by 2002:a05:6820:4c0c:b0:6a3:94b9:14b8 with SMTP id 006d021491bc7-6a3d9eeb5bfmr926769eaf.26.1784093778402;
        Tue, 14 Jul 2026 22:36:18 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4546f12a6casm10828526fac.8.2026.07.14.22.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:36:17 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: [PATCH] HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
Date: Tue, 14 Jul 2026 23:35:26 -0600
Message-ID: <20260715053526.574725-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

magicmouse_raw_event() handles DOUBLE_REPORT_ID (0xf7) packets, which pack
two touch reports into one, by splitting the packet and calling itself on
each half. The only guard against runaway recursion is a "size < 1" check,
which stops zero-sized calls but does not bound the recursion depth.

A malicious HID device that matches this driver can send a report starting
with DOUBLE_REPORT_ID and filled with the sequence [0xf7, 0x00]. Each level
consumes two bytes and recurses on the remainder, so an incoming report of
up to HID_MAX_BUFFER_SIZE (16 KiB) drives roughly 8000 nested calls. That
easily exhausts the 16 KiB kernel stack, leading to a stack overflow: a
panic with CONFIG_VMAP_STACK, or memory corruption without it.

A double report only ever wraps two normal reports; it is never
legitimately nested. Refuse to re-enter the DOUBLE_REPORT_ID case from a
recursive call so the recursion depth is bounded to two, while all valid
packets keep being parsed exactly as before.

Fixes: a462230e16ac ("HID: magicmouse: enable Magic Trackpad support")
Link: https://lore.kernel.org/linux-input/20260706181347.700DB1F00A3F@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
---
Noticed while reviewing hid-magicmouse.c during the discussion of the
parallel Magic Trackpad USB-C battery work [1]. The recursion issue is
independent of that series and is sent as its own fix.

I also considered refactoring the report parsing into a non-recursive
helper that dispatches the two sub-reports iteratively, which removes the
recursion entirely. That is a larger and more intrusive change; this
minimal guard keeps the diff small and is trivial to backport, so I went
with it. Happy to switch to the refactor if maintainers prefer it.

[1] https://lore.kernel.org/linux-input/20260706175507.47288-1-andfed.net@gmail.com/

 drivers/hid/hid-magicmouse.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 802a3479e..97562765a 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -383,8 +383,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
-static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int __magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size, bool nested)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
@@ -495,6 +495,15 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		 * packet.
 		 */
 
+		/*
+		 * A double report only ever wraps two normal reports, so it is
+		 * never nested. Refuse to recurse a second time; otherwise a
+		 * malicious device could chain DOUBLE_REPORT_ID packets to drive
+		 * unbounded recursion and overflow the kernel stack.
+		 */
+		if (nested)
+			return 0;
+
 		/* Ensure that we have at least 2 elements (report type and size) */
 		if (size < 2)
 			return 0;
@@ -506,9 +515,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 			return 0;
 		}
 
-		magicmouse_raw_event(hdev, report, data + 2, data[1]);
-		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+		__magicmouse_raw_event(hdev, report, data + 2, data[1], true);
+		__magicmouse_raw_event(hdev, report, data + 2 + data[1],
+			size - 2 - data[1], true);
 		return 0;
 	default:
 		return 0;
@@ -534,6 +543,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+static int magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	return __magicmouse_raw_event(hdev, report, data, size, false);
+}
+
 static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-- 
2.55.0

