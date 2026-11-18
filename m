Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012390;
	b=VkUdl2Yi1AVz6VqC1NvbL23aQo4hzEp7xGjxyK8jnWSXy+rSwV2GInpMu8sE+2Ye3XJR
	 H2AfmcJyNd1HnY6OUBKNGSfNpJkFVXgfJinQkmFxZsEyqwXTfG3VNAgoTAqt/L31QvFol
	 kZ0MVzzs9aPLWYR7tTb9VkLD4hOedRl3U9y5xyxBIz6g9sqq7yeg2wf/HnFb8yA0gKj2L
	 hGcahDiJDatPu0Jj7pdXfwC2ZTi4dHiDWQKRaFzUsev9L+kLbk/iiE2qn+hCg3qSqDA6s
	 U2qFJ3jPKMKQ6sSkozk00BWGYscYDCDMM6CKLu5wHrRjkrMppoVGQxjN+jRJqNSwu1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EoOYpwXa3FwcofkB3w93rNoXlsDX4Ki1d9gUL32/mLo=;
	b=v11au9JNOqCRMpCKDdY3LXiNZ9vGK/3SdYyArrPd2DE8qQ02CxEKY1UBhQCtreSBIptG
	 gSDrbm0fh5dGgfculg6NCPqqzqsxPWTUSTpy/aI0904gT2GtdKB7PoXdQkXk8KAO+Dyhw
	 4t8WAIAZUTU5fYuMX6Tb326eMILfJqWHl0/3E2P5N2a3pYkMXFdt5uPoappkmFj8Jg381
	 o3K9eLUSnvRVSC1p2HOPXpeBDEnyl+fe09ihqYBYfVx1Br4LlJNzaLj5/UkKokjVEzPra
	 gd5otQlW1MysP3v7/rSlvJeNY0Id6ilSeYMBlchEe5ZgAGJkFfsuY28jgoNWWDrCEhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/3xigK0";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE21606A335
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 14:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE21606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/3xigK0
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so11237205e9.2
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795012388; x=1795617188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoOYpwXa3FwcofkB3w93rNoXlsDX4Ki1d9gUL32/mLo=;
        b=l/3xigK0pcV0rpkfZpt9/JakEufW/L/1yiRP0ejf7oOOPqd6jmejFWGLGm5s5uA+Cb
         pIoaL7H8ERq+A9I8esI3GFasIae0x2Jg2F+2lOTAcxisGOIv5OSuiC27w0wHcs6sbo4t
         lKStbblosvwB2G7b1O1WUrd90JBN3r+XLm/FHQkJ5D79217ah1j6pZ15yChi3WC+iYXy
         1GiYodP6q15FM7jHu33kDEFbxqCKRKYcjZ0B8HkoV6Bkh34URQJp95AHue8pFkT0K/RV
         m6zqv0CdVxDA9Dr+PhI0vl6eILm7CezVhb9KLeb1fvLhK4x/gEPE1W31I6sSSCmqu4Vq
         YBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012388; x=1795617188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoOYpwXa3FwcofkB3w93rNoXlsDX4Ki1d9gUL32/mLo=;
        b=NC+gfO0ABED3Sbhqf7wwArb+N0b0PCY1UvhrKr5d5sv9dUbkY3fNaIbHmPGrXJ5kdK
         bnNfX/LC+OV4CqAeSCjgLpa4GxVMehD/mRYhpgd2HA16/KZ7Xqgh92ZFc8aTE5bnkl9Y
         e0gRZC/hWzKGcqeNl9HSA2rJMh5MOZtB9JtOPVJAYV323MzKXWTzLxvCue5B2/Z6bekU
         yMKI1m47lcjl8x9yoHk3koBiJRz6Mw0QzqbDMAWgPybc7io0wDa87EuXzj58t3W2zMqH
         wRFjfZpJI2MP1+bCa7t8dx30dsLqyX5HmR78ANOIKEV8dcKEjlTazQhaPnBEYbdl5kAQ
         IuQQ==
X-Gm-Message-State: APuU4Z+TDhi4ecFyHrwF8e9i/ps2aU8cNNAh/ooXZuHVEcDu0dQ63lD8
	VM7Rti9XMuaYJqr3qMWn9WUj/r81qn9Z7toowOy1+tpK4oZe+/Tb/ulyVQ9GOwEmvco=
X-Gm-Gg: AYBFou1DXjIVQYFr8ELjfQCvrKq3hz13q+FrPLU3g/m973QfQZ6Eku73zmSGDHOKNB8
	Lfz0RuNTSpU1OWGhj7sU2BCKv8kYoHlOgqO2WMEzn8wbUA4rGSUe0Weaa95wCMguLbWxhwNLIIm
	LS8dckkdIgatCukB4l+t/X7wD7B+HDRT0lZFytDiitbN1RQCjRE+s3LIilvl99Tr1/B3I6+HQ1n
	U9GHWV04xIWjqbL+gT8gHmTrLcgaOYgA/bNFBu1k8dhg0Py8n/dI304mhYnfBtgDrTLs/NDzOMX
	UOpI5j+GXEYPzQFR69NK+TNwVDfg/2w5Tv9gNXS9DBTsFLhQvWCi3q9peRkfGBw5dVpW0qypBj9
	SgGKLEbKh2yjJKKomTGJL10b1y0tISueGCaBr2WF7Vfun5nW65RJjMaDrZ+1fF22WdHV3lJW7vF
	SkKa6ORmxM9F0SwMz1JUHSWiiuaUVravdHviC0tDSn+omjX6aVlomhX4qRCTp8ESDFdp2cDBAPM
	H/w75+uZB4BgBG9bUMKzndxGJRkmuT4s/Qj9bMcUSsF6K5Ez8+A+LB6VPAe7z0mTLYLZgafLLq1
	ZYJMEUiTtsdfB5Y2korjd59XWiDJwPQ4F78tQGK3dtUkg0jVvhYIre+UMySCMoNpKkcEVXq9e+O
	nQ1YbPXb2TJm8jasVGfO13ghrPo8YD2ZmJ24DQTUQ17iseCBSc4wqle/awNGVfc0MUrIX1OM=
X-Received: by 2002:a05:600c:4585:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4bb7da4645fmr53971835e9.33.1795012387905;
        Wed, 18 Nov 2026 06:33:07 -0800 (PST)
Received: from localhost ([86.110.253.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2cfce7sm70917355e9.14.2026.11.18.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:33:07 -0800 (PST)
From: Jozef Riha <jose1711@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: betop: add support for SPEEDLINK TORID
Date: Wed, 18 Nov 2026 15:32:17 +0100
Message-ID: <20261118143306.75858-1-jose1711@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The SPEEDLINK TORID wireless gamepad (11c0:9105) is a Betop based
device. Its output report has the same 4 byte layout as the other
devices handled by hid-betopff, with the motors in bytes 2 and 3.

Without the device ID the gamepad is bound to hid-generic and has no
force feedback. Add it to betop_devices[].

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jozef Riha <jose1711@gmail.com>
---
v2:
 - Fix From/Signed-off-by name mismatch
 - Cc linux-input and LKML, v1 was sent to the HID maintainers only

 drivers/hid/hid-betopff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index f802046a688a..28ab0acce6ad 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -16,6 +16,9 @@
  *
  *  0x20bc:0x5500 "BTP2185 V2 BFM mode Joystick"
  *   - tested with BTP2171s.
+ *
+ *  0x11c0:0x9105 "SPEEDLINK TORID"
+ *   - tested with Speedlink TORID wireless gamepad.
  *  Copyright (c) 2014 Huang Bo <huangbobupt@163.com>
  */
 
@@ -137,6 +140,7 @@ static int betop_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static const struct hid_device_id betop_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185BFM, 0x2208) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185PC, 0x5506) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185PC, 0x9105) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185V2PC, 0x1850) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_2185V2BFM, 0x5500) },
 	{ }
-- 
2.56.1

