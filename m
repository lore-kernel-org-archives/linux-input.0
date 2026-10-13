Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC890429CDA
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888040; cv=none; b=AStsnwJmALQbPlBA6DKklVIeCavBK8YKzobvYp8/6eB5uApHN/IvL0YUWXRic4yBmHBypSnfOhBl9Fqfaq+YSHQGlP73mh6UomfbQXFW8MYHilZ+3kG6vrEgwbwEFWFqv//xDUX7q7/reHt3IaAQ8F0di+6AAqxQ6Byx8IMISaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888040; c=relaxed/simple;
	bh=wNq8OCW5DDjfghpOmb/RQMgU7aAnMknzkZTzLIjJOH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZLJRkYTpQMclCWJyvFlGox71SmyUZIS5WI/0v/LRGyDl+GL7POSX6PbIzYe8iUp/yrH9SRiJYpi8HcveiX8ef0IeqIk9COkjbQA+u/Ury1kvxRXzq9H042NeQdjZtSLJaPvxkiUunz3ujoMV++T3j0b/mIzFy1pZdAA82dEcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSrDUPPF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSrDUPPF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso25456565e9.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791888037; x=1792492837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k61/sCIWgJWFdXTCqSl5VQGLQJqZ8KGaN5eUIZ8iPhg=;
        b=VSrDUPPF2Mol1cxwpP5ZdlEIPxN3UyELurT2yPYenMqNFNuolu3fbZnKTXBr5gVfst
         l905ZVzQOcgHB8O3r330waKHIX+0QLNGU5897c+6WB0myx1S96mQ79K5mONPxxprUQ+S
         JIAz3LDsp+/7cEcaLaRbYUAosJGcO48Sp2CiGkvhJCv33C1JObPzGzDdzjDE8OBZru/a
         hhwCTEmqQh4OKxz4Ko/CHyEl4WrQcoNrhjoQhc8dle12bDzKNC4LdC8Tdlxw9Es25Hg3
         OVKVZJRa8QS/zRyMbGY2/HBfgfvT6PdNMYOWZhO8oLGksLL4acAYzMXodtXzihXAajL2
         ZX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888037; x=1792492837;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k61/sCIWgJWFdXTCqSl5VQGLQJqZ8KGaN5eUIZ8iPhg=;
        b=sHGM4u1ztAeMN7kM3cDEVlNDnQy7G4vgt4t2ZO+lT87tjMHvTl5qR4q00S4O1aR0vn
         Kdn8PUVGESR69hiE3e3dxh0yfdk7+urP/kY+rV07UtlBSLBAywZ4GrTs58F7aZ0KLCn6
         xCVip1Heaf0YjvwVspJhhBdLastCSViukvMhJlGjoCHPMc5ondypeI2LpSKef9boXd4h
         27yF56+lyG1x8RefW77+yRrkq5rdprFPSlivUeWy0gCyBDlVRMSh4WH7brSEp53jHAVL
         sldoiBs4AxzO0CGc/9FEjAgAbvEExTG5QNAMy4wSm9pSAzzsA8Q3tPzewUUB2J7b2A5q
         KFZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGXXUE7msWcKP7spKGrGn8KO6hRtoUh9PVIo5OzjIi50Zb9D9zs4mgBqLTVi67OSCWNkWpERsjnNRfxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJot/pVVSEVfY8Xyl7dwVZKGnKV3p0cxwODib+OvVZSbskNFflr
	p0S7bhBXTu5UB35lh2hb+50p4GpRYEeToUoWgLggnjywlcHJonBGZRzU
X-Gm-Gg: AYBFou1dWh8wqgBRFIrBf0WiRmtSCHrYzLcmcZdwI/2SsNLEHL4/mUMsLTTGkI6+U45
	YJwLKWhYjqt3L0Zog8FhMLDLbAIyyRf7+vjaYr1u9vNUCpGlS/t3xlSFhu34wnIHuukBKne4lP9
	AH226b6/UaKo9BhXdxTDJaR/KLGmAYDeD0Ll7jg8UkY4+kyKKOyhxoKqyugOlsshPN55T/Ki6u7
	QqLpiiHX3bTlxw/GQoXwNoWxNImqpww4i7vKWxuvT6M9sUO5oH15fgE2xkNhkyJISXntYBxBCgj
	pt7a+lNz8RZRzpirRBRQVtDrcMSR9tneZOO7tlpFlWTY59tCcN5GTL76wxPZ5VDHdEvpcBA3N8E
	L4RJVhad71ZrDhM8E3C88f21vJKFZKt7xq3ViLoj/6n7ctokYT/puV3x0VtUdWY1eGy3FDH1Jlr
	44jWVjmv967u67QNOJSgDAlE8nuOdyUnnWJEN1skGqPeZpGiDyKr79UBaZuUSlciwMz4Sp+M4+D
	EPqdIeKf+e/xZjNY+3K2xyDYxpfKHA6WuckHDPzcTfM5+ofMxL2FAgBZA==
X-Received: by 2002:a05:600c:4688:b0:4a1:8d46:6228 with SMTP id 5b1f17b1804b1-4a18e4a9ba5mr251041705e9.14.1791888036739;
        Tue, 13 Oct 2026 03:40:36 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:e22b:cb88:4091:8aab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ae0c9fadsm50439075e9.4.2026.10.13.03.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:36 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>,
	Ivan Levchenko <me@livan.pro>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 2/7] HID: asus: Add missing Zenbook Duo hotkeys
Date: Tue, 13 Oct 2026 12:39:59 +0200
Message-ID: <20261013104033.36079-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013104033.36079-1-p.pisati@gmail.com>
References: <20261013104033.36079-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

Map the Zenbook Duo "screen swap" hotkey (vendor usage 0x9c) to
KEY_F19, like the other ASUS vendor keys that have no dedicated
keycode, so that userspace can bind it.

The mappings from the ROG Ally onwards belong to devices with built-in
keyboards and can share keycodes freely. The Zenbook Duo keyboard
cannot: it is a standard USB/Bluetooth device and can be connected to
another ASUS machine handled by this driver. Document that above the
ROG Ally mappings.

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
[pisati: drop the MyASUS key (0x86) mapping, 2061075360182 ("HID:
 asus: support the Zenbook A16 (UX3607OA) keyboard") maps it to
 KEY_PROG1 like asus-nb-wmi does]
Assisted-by: LLM
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
---
 drivers/hid/hid-asus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 34739198d90e..242e273e4cb3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1264,6 +1264,19 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xb3: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Left next aura */
 		case 0x6a: asus_map_key_clear(KEY_F13);		break; /* Screenpad toggle */
 		case 0x4b: asus_map_key_clear(KEY_F14);		break; /* Arrows/Pg-Up/Dn toggle */
+		case 0x9c: asus_map_key_clear(KEY_F19);		break; /* Screen swap */
+
+		/*
+		 * Mutually exclusive section: Special keys from different devices
+		 * can bind to the same keycodes without concern, as they will never
+		 * conflict.
+		 *
+		 * Note that devices with removable keyboards that connect over a
+		 * standard interface (e.g. Zenbook Duo UX8406 with USB/Bluetooth) do
+		 * not belong in this section, as such keyboards can be connected to
+		 * another ASUS device that also uses this driver for its own keyboard.
+		 */
+		/* ROG Ally */
 		case 0xa5: asus_map_key_clear(KEY_F15);		break; /* ROG Ally left back */
 		case 0xa6: asus_map_key_clear(KEY_F16);		break; /* ROG Ally QAM button */
 		case 0xa7: asus_map_key_clear(KEY_F17);		break; /* ROG Ally ROG long-press */
-- 
2.43.0

