Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA8282F36
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093560; cv=none; b=HgJ7m6DprBSq/tIIiUTtlzgionYMvrP+9qE8tD9GQEJkdhgEXx3ARZQtfxlrrmSGRrmvh2KauZJjOazPGiQ4p+C7hAoRKU2R96cfRfwFRPbt6Jee5os1RN0+q1d0RqAN9UHpewHD2FAKzSTYDC5puZes+Abuopza9hniVkdZ4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093560; c=relaxed/simple;
	bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXYYJQCoSquyzFhUDXA6+i8hlkMQxE/YMi1hvjNc7ISCTbHdphPPNur1tdr4tHdyXZTn7iFTXSAR4C8RFG/+H1xbApt+Ir+SMgdHKt+XxAH4W+9wawypox33lsdrReirTmK8ktQRZYKRR9U7CgBatYRtba53iEUX2jCIaVN4KVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ru91m2IR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru91m2IR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so185515e9.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783093557; x=1783698357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=ru91m2IRhGkOxm5BcF56WiepPZbH6mtnBpaLvKhD48dS9L6+KbC/EknwwI20WDeO5J
         ahA9KVe2VFhImKyZ+8sGsp9CSD8icHKUfWT56FLz2Zdi2tRka+L326C47zcP2PPz33mb
         jFHfyXcsvQXEeTwZP+WPGA4xrkHqwYBEBFAAwRJKt8uu5bVuIS96h9vNfOe74yhKKKUv
         FlP5f0//mFsuuDf4KJUL1bcTUX6suPbFbctLMhw2ZlzfmMDBuuZmxrseb93ks4fDJd3B
         7S984HxtgzRoUoilaqWtoeV986yW7J1/IiT5P+XAJ4dy1VHhkhgTK3sSKUmpKDDsmcmJ
         nhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093557; x=1783698357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=SmqD2I7AqsZ3/MkHo/WfXD9gtdkQxGkb8UVxz6ytHA17fcUe85Evce+4IpoK0VfjTe
         L83SP1m+DCm/4A+CickrzHlI4+QnhMfP3nSEL3Qdo1lJwOCtJCrn055bLI2XY0GuL61A
         vDEcCclwtpz4nHzYdm7+xNQ8YeGnFzVA+b55ka12poOtsGs+odjUHQtfy3N5VEPLwl39
         Bp/RZ99wyxX1R8Alf6PNJQcYQON+DzIYf0ytuB+t4hp4Ir4NkO9U/MoLfYKHh+Ut4XA3
         ywni+Qn+DPi1rgf3HORrq9HT6AZfpYPvWsdTkMKgDqiqGLUdLOusm5JhcQiF3uW7pd/d
         EXKw==
X-Forwarded-Encrypted: i=1; AFNElJ9qN415Y+TK/32Og6hsBm4a0xk7xIUezh33LAYRteKXco/ytcc6A8z69+OcwrgWznRGAMPBMPwMp1jGEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PsjrVXhgGqAAwYL9GVAt0B8ToL8sYjjJ+OZH0zFseQ9RcxYF
	8F7w5YxqErHmUPja0V4c/26yWVgTrUEO+GbWthjuvy/m5Zz2+vTYNLy0AM4TRFj8fw==
X-Gm-Gg: AfdE7cmk8ufYisfbrOETdICdiqPZdg1dBfnp3lMgZBx8Wr5FuY+qbNk0O4yPfYuXRlH
	quggat8YIiGrRa+Q2udqwC6XpxYG0wSGNyzHmhh2bVa0mypQ4Y50Sa2y5KsVpZ0c9+sCiia+cDv
	38GshxA0+lpOV4Y8yLOfPdz5hhTmw3phwzhS4xqOiIyNVn39+4/UMPJ3l+yEoXrAl2Rsr7g86ya
	JhexvPew7VcnBWDNO4anlM0IG5xpBIk7vQtMGcovBjiQrNOnYm+5cVbhegx8LTKkDrSbgy9Csmk
	HnsgQIEWOg3JfGaxO8dHvwo747gJdk1xvnl11cSI/5HfC+4Q2KMAm2DXSbjnn9UsDHic7yS9HCJ
	v8IBaaPMXyd3hxNWHFcXewKUW+x/LCQ100YXyfAHod+PALeIs2oI+8ht60YWxv+H8/hOGcO68ld
	GS1XEgTIlPOClkfduz3azJRJ4fskyoY9XFCBXwHoC5AHnwxJHWafKfVtXE3B/1fD0QPopyiOM=
X-Received: by 2002:a7b:cb93:0:b0:490:b2ae:44e1 with SMTP id 5b1f17b1804b1-493d10297camr51985e9.5.1783093556676;
        Fri, 03 Jul 2026 08:45:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm227111205e9.7.2026.07.03.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:45:56 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:45:52 +0200
Subject: [PATCH v2 1/3] HID: asus: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v2-1-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
In-Reply-To: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783093554; l=1171;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
 b=JrTtpyE5L5uoy3JxJ2tMU5gceaV3QRRv3ixIM8KEQnx4O1fJ0ZGTknzPYnp4Tlo6HiMPKmP40
 opA98pft3h0CTw3Aev/nQ+xb34+mH8F/eSjuF9fugqAUv0PuoYMabt3
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..befa990b3210 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,

-- 
2.55.0.rc0.799.gd6f94ed593-goog

