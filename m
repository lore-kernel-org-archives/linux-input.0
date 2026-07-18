Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5F370AD6
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377347; cv=none; b=La1EShRyNV6qTbGNwYRKlSoqrar8Tc0y+AIYum51IMCpTgzlFujNH2WkpyANCdnDYtpWbKd0sbIwLBNus0fvODpIslCTpaW0YulhSUaMnzNMMwL6vVyU3j7Zp4H4k04YKU4RT51C3q/kO0lVy6fSxJX6IJSFL0qu3Ri6HhBBESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377347; c=relaxed/simple;
	bh=tpSjyINPsAwF8cGIa+uG6NUQ9FopxvV+OTe8N6K0izs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN0fdZac0ryNd8oNXzKM+L7J1a04ER3on8tw1yaBaNeAtHQGWVlZMJ9TRCGJbklWU6NCd0FkOrixKr7xguP1psLxqVC0MWFUNfpppfK6s477JhTJYbk+2jxX/Smk/Xggj9mLCY99Lw0sA9MEdkndDGFlBUlIVnt8o7vPb8kzOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=l0VPHrF/; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="l0VPHrF/"
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1784376941;
	bh=tpSjyINPsAwF8cGIa+uG6NUQ9FopxvV+OTe8N6K0izs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0VPHrF/vRekqQHytyTVIZ+6kWB/g2XWhwTTK5eavCg5JMAhWCJ3wWf/NoCzyC39K
	 A1heEUULUxlCQrrPSyf1BAIl/6DYJ+fYPigA2lwy6Vwk0iNJkgswqMzWZ0S/U2hnXs
	 EbFx4qnBksGiYcFH3pHG8+aynOGYuLifm1Cg7l9e97oYVeLwdCIe1csUvHFEEf8jFF
	 6DnFTAwGQNpEF4DFbf2wMGQcSWVqfbtEldTy4FkS4E1WSCDTOSNs5xqr0NH3QvjpeN
	 oOIVyEint2oB+K/ktLoc76aNLRlkf91Fjoitk8A5JAc8XkGpcvGFB8KDAsFeoJ15x8
	 K8k9pMMxl4Reg==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Aditya Garg <gargaditya08@live.com>,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH 2/2] HID: apple: use the standard keyboard backlight LED name
Date: Sat, 18 Jul 2026 14:15:27 +0200
Message-ID: <20260718121527.15924-2-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718121527.15924-1-dev@deq.rocks>
References: <20260718121527.15924-1-dev@deq.rocks>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T2-attached butterfly keyboard backlight is exposed as
apple::kbd_backlight. This leaves the color field empty and gives
userspace a model-specific name for the same white keyboard-backlight
function exposed by Magic Keyboards.

Magic Keyboard backlight support was added later and already follows the
current LED naming convention. As a result, userspace has to handle two
different names for the same function.

We should use :white:kbd_backlight for both implementations. This follows
the LED color and function naming convention and lets userspace discover
either keyboard generation without a special case for the butterfly
models.

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/hid/hid-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index a5f232cc2b66..0f30cf4670ce 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -861,7 +861,7 @@ static int apple_backlight_init(struct hid_device *hdev)
 	}
 
 	asc->backlight->hdev = hdev;
-	asc->backlight->cdev.name = "apple::kbd_backlight";
+	asc->backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;
 	asc->backlight->cdev.max_brightness = rep->backlight_on_max;
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
 	/* VHCI re-enumeration restores the cached brightness in the next probe. */
-- 
2.55.0

