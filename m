Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05C366576
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595207; cv=none; b=bdH9IQ8jXrY/HhbsdZ9SCi1fDB5paosLSlNyF8FUON4Ztvw31B+OGVKuoauLe7+P63WmbW/Axl6aV/BZn8+ztdSD6L1If+WffoYxZfHkMsJEeu7MTc7wdpU4rQKWHAe667BpIGoDOpC1phVARALPm8eeLsXiMvjBLsriZ9M42PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595207; c=relaxed/simple;
	bh=USlOh/kID5IW9rS+Av5xW9X6muP5kzYO3dLWbFbs5o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUF/6yIdtx05GObRTHBIy0ASW7+yPkl1LNe24lnc7ONMERWLt0AE8cb8odWbdyPwPowFnEZQmUcbNkkYc46eXkJxn0qPt/DEeamW1L28U00rcSid3Ljla6Gul3BxtzOn+rqSpSMYzR8cVmk/BEhtY62YtAQumqxZrGtDgTkL/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev; spf=pass smtp.mailfrom=60228.dev; dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b=BeXGXzNs; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=60228.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=60228.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=60228.dev header.i=@60228.dev header.b="BeXGXzNs"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca2b32f46so4787606d50.3
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=60228.dev; s=google; t=1772595205; x=1773200005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfCf1mm36XK9Ege88JokoogsfKzYFc+JW2IeO4o7W8U=;
        b=BeXGXzNs23x28Kbfz9XInQH/jvEJ3Zo3aTHi4wvMcn1kRJLwoLKbV8+nUIQk6FYJhj
         fb1TbrQagZedRPygRDr7+vDZMTH+4AXSaxpxv79SnYY63rvs+Uv4WM/zkMnS+xBSDVIZ
         SHxfUXegvWQPYrF+RgJ3nMBkezJSLvJSch+LcSoBrwh0xQ8ChRmAX71Di5ckDHVaiM5U
         g/7fdOZNhc5F1do2Ep10FJbrVuCqwUosP1RdZIOkiteanchBtMsQUHAhcC0zbAJ0Qebq
         Z3qa6y5oUvny5N3PHWVpUp0PvI880aquC2BtFcK+uzOX9IYoQdRg0+3WBzxsTT2eK5FS
         SCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595205; x=1773200005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfCf1mm36XK9Ege88JokoogsfKzYFc+JW2IeO4o7W8U=;
        b=YSMZRckkaJbC+l+t9QVsb8dY/Y2Iz47RYymyRGhCF+P9APPhie1GrTRk17il+8GQ3g
         y8IQoMVGPmEwuKlzTWXi94azO4g3D1r1Mn28vX+piLakH1M6KqNwjevlZMLiswcGEfmP
         Ll1BbLs1cAecn/H/H1P3KXHpPDWXShmqhxRhGvqop17dVvASvefgtWt7H3IRx9HI2/Ow
         1pj+lTrG4/GfHpP3SLFuR2SMTlx6fJeGgmX7Dq9pjoMQiMP0UywR+JLipeyjXiTipHGL
         3eDvZNUPk6xWS1xoL262ip8IAqroOKDT+ZvS1EZWyUmeRVmK6fslBvgC/QQY9Y1jXiic
         oChw==
X-Gm-Message-State: AOJu0Yyid8STm/nXencGSmLuUUx8pdL9WwhzS4W5jf60zMZj+7aBDtoH
	26/JqxeCMLQN2of2YsKNmq+ceN6faI5h4eZTHZ0Pl0+89SPbRwgWHacSK4gIVssnUtpxL1BBtLg
	02Mm1w0qkCEka
X-Gm-Gg: ATEYQzzsmwsbWFU40ILTVuyY7o3V5RTV+teZPUHYhrp+rpBe08CLsuGESb0fOHBEWuo
	SEuiR5pWUB2HJxyBeh01jE3cQqO0fNjg6S1w3QlQ4EWFnEruwn8BwwcmgMMnP/KqK5Jz4QoK3et
	aJcXYeLtiX1Kej29oZ5jrpB6KE7CopMugo0bpN0I+UEAKG7zSVHYa3eNWumYvMYet49vw5Keunr
	I0M0nReGxzW4wFO6K1oaFkN+d35+QD8Jl3ruzu15NJx3CsArL8mp2GJJxoy9Es5RY7IbnSk+w8i
	A3vcqM4iRsku6/KP9/iiugGtNEgAziVUCuduOcsMUFh1sSlrKvzNV+1hKBayE81V4seWgtq/peE
	H2cUyZvAPda8xwcQOE8LZ5X6xU73E73Td0mSKeHDjjwv/m8cYlxQ3pSSN3RYP/WfHd5hq+xZMwh
	l9GKERdZklAX2dAypV
X-Received: by 2002:a05:690e:bc6:b0:649:ba41:dd6a with SMTP id 956f58d0204a3-64cfa00f3f2mr616324d50.73.1772595204891;
        Tue, 03 Mar 2026 19:33:24 -0800 (PST)
Received: from localhost ([2600:1700:2760:3c1f:566d:338c:4cb1:510e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb74b985asm7440855d50.0.2026.03.03.19.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:33:23 -0800 (PST)
From: leo vriska <leo@60228.dev>
To: linux-input@vger.kernel.org
Cc: leo vriska <leo@60228.dev>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: quirks: add quirk to always keep device open
Date: Tue,  3 Mar 2026 22:32:38 -0500
Message-ID: <20260304033245.445671-1-leo@60228.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices expect the host to open the device shortly after it is
connected. If this does not occur, they may freeze or disconnect. A
quirk allows these devices to function properly without userspace hacks.

The existing hid-axff driver solves this problem for some generic
controllers. This implementation is modelled after that driver, which
still needs to exist for force feedback on the controllers that use it.

Signed-off-by: leo vriska <leo@60228.dev>
---
 drivers/hid/hid-generic.c | 23 ++++++++++++++++++++++-
 include/linux/hid.h       |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
index c2de916747de..0595e653b7e7 100644
--- a/drivers/hid/hid-generic.c
+++ b/drivers/hid/hid-generic.c
@@ -67,7 +67,27 @@ static int hid_generic_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		return ret;
+
+	if (hdev->quirks & HID_QUIRK_KEEP_OPEN) {
+		ret = hid_hw_open(hdev);
+		if (ret) {
+			hid_hw_stop(hdev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void hid_generic_remove(struct hid_device *hdev)
+{
+	if (hdev->quirks & HID_QUIRK_KEEP_OPEN)
+		hid_hw_close(hdev);
+
+	hid_hw_stop(hdev);
 }
 
 static int hid_generic_reset_resume(struct hid_device *hdev)
@@ -89,6 +109,7 @@ static struct hid_driver hid_generic = {
 	.id_table = hid_table,
 	.match = hid_generic_match,
 	.probe = hid_generic_probe,
+	.remove = hid_generic_remove,
 	.reset_resume = hid_generic_reset_resume,
 };
 module_hid_driver(hid_generic);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2990b9f94cb5..9d0ab7c217f3 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -388,6 +388,7 @@ struct hid_item {
  * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
  * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
  * | @HID_QUIRK_POWER_ON_AFTER_BACKLIGHT
+ * | @HID_QUIRK_KEEP_OPEN:
  * | @HID_QUIRK_FULLSPEED_INTERVAL:
  * | @HID_QUIRK_NO_INIT_REPORTS:
  * | @HID_QUIRK_NO_IGNORE:
@@ -416,6 +417,7 @@ struct hid_item {
 #define HID_QUIRK_NOINVERT			BIT(21)
 #define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
 #define HID_QUIRK_POWER_ON_AFTER_BACKLIGHT	BIT(23)
+#define HID_QUIRK_KEEP_OPEN			BIT(24)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)
-- 
2.53.0

