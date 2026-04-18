Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175B331A6D
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539394; cv=none; b=HeqFPCGmlk9CP9X6CZZqxmqCw6mpcKLvh7UIy+RqjqqJVRJMpWzYYmMPvv8sqBs5bkCdIUgr5SS6Cej0nLAEXKYVkSjDFh4iaV3ZkkT80mYnyCVOMTgQbWxaXgZ3AVVK44+/vnU+rYDzFqOhI1U/plp1vz+ncpW1NGYdZkHTZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539394; c=relaxed/simple;
	bh=6phJpfo1/TgeG8CqA+xEvmPHdhxQxxft5quGLReGZHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSy2dNn+FcaA26I+IYlJhNX3TpMtO7EC3uJbzQh6idO24QzvIfW87UI7jTmqSHZ4eDz1z9RbXh6yqtEfhxulqAx9mcAT/HPXMXprDO1K7ryfrg5ps5gwlEgJxdNix6LNXdSNN5fh698wmb6vsNNyW+0S5ks66iuEQ0WJU144vWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exponent.digital; spf=pass smtp.mailfrom=exponent.digital; dkim=pass (2048-bit key) header.d=exponent-digital.20251104.gappssmtp.com header.i=@exponent-digital.20251104.gappssmtp.com header.b=XkLxoPOY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exponent.digital
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exponent.digital
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exponent-digital.20251104.gappssmtp.com header.i=@exponent-digital.20251104.gappssmtp.com header.b="XkLxoPOY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so1227226a91.1
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exponent-digital.20251104.gappssmtp.com; s=20251104; t=1776539393; x=1777144193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re1Tn3EYlmJfQ0pcPCyVC6b+63SUz0TaqbSl7xgqkiY=;
        b=XkLxoPOYYMkbgFHcqqze0SaVjE04qGPrjTqyx0pHXeGY+BGlpuyNi+12ANIfxovjXk
         HFMPgf6MWMRvHR7OqToaVkdlCkRt9w8CWt4e3nIencN5ND3VvGDiID3kZ9N+ycx5CSWW
         V8s5fElOV6IsyVamRPsbtC0BeUVUIoyOdb0ApbZknuT/E9LKkfTLAApOBLBCMVDcs/Uj
         RCbt2ATm1KoF7seP2594DEfd2VfctXMu0tAykEh/wlkvtAAArZ+mifkQ6SvkhqECaRXz
         3b0XBxdVcBkxe15u4g5xfDFp3twtJUcYEnvyH0vIPfYVcAefz8nQk7C90UfqXMqDRaQW
         VKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776539393; x=1777144193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Re1Tn3EYlmJfQ0pcPCyVC6b+63SUz0TaqbSl7xgqkiY=;
        b=K8iqzGuxAazDMUOBViPTv+cfpuw4kALlNqxbMxcBWDpUJudPDubMy7Ny9aPBmd3Htd
         KrN6njGi3cP5diZ72Cm848ouc4moZEA2KXUY1bXB2Y1MWocw6t8/yr3s6yClUui47E3U
         DPKnVuT3XzWbrXiGqG4yJQFo/OxceuQeMnr7FT5XDDdsMilc6zDhT2J/LX0HG4+Pd5Py
         MD3iVQBeKCmQ/YPLbEkfQVGxEvQ6nXJZ/ZXAgjURvtwfJPW5qgYKXBL8tX2ApHegquAd
         zVjeWYdJX5nd1qMg+tFE4UpLSvu/DWq4q7aX4CHcFH939GujjQNhdfRWeKX7fXVwknR9
         7ekg==
X-Forwarded-Encrypted: i=1; AFNElJ+688Ra/6r6I2f7xeF5LSGXE0jt8dzBtbYsrzhFyWagQDPtvgtMdKXVGXEWeRzlKGH6CW9BixIoL9UbLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMAeqnIfXGXmACatyacZJKbIozwpmUKXzKsxxtBT8JRy/LmdPZ
	rYlrkU41X12RdU/z4Twki5oyMaCgOOFefj8JAFn1mP0MaaqNy2PFxPWUfpDW+8WLwkI=
X-Gm-Gg: AeBDies7qahnbyTLRwBJt1M4dRbKtXXfF0nZG4zUtibTc3rznnj5r3HlQbiXetU4Rw6
	rqdqMFLVqCdhpqbZjgflhUOyG65joonGSqof91UkK57iELy6dGkrMX6GvoFAh+H1zwmYJGnslB1
	M/K/cw+MU4eaT/a6sqZ3Dj+I/m93UjfIeXyDo2FQ2tXT9h9Rn/9lX++glsU3I4uWVc4onOG0q3H
	wJP1UDmifonZLZ7pEEm0tqL/ndrPyMlku0wC4rMqjCDwh6V6n0eE4e0algKAv5T8lmJ4tn0JjjF
	5sjguDs7gajJWvwPxg+B/IddwVdlPVYxqh912Jgl6M/WDNMwOyob0apFv937/QEc1EE9FmV4UfE
	Vx1EhAFbXmdwh7ZJuCA0akspZDRxnSgt+Yx0zf9NpF4jXNdcBmSQA5839hiviy9qZsxjbEp3o8j
	N9AXDMc+4lqHiZXNfPu5yMX1i2AHaOpqvvL1xeejimXE1hwQ5T
X-Received: by 2002:a17:90a:d09:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36145df0c75mr3987589a91.17.1776539392671;
        Sat, 18 Apr 2026 12:09:52 -0700 (PDT)
Received: from yohji.localdomain ([101.100.136.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36145fe05f4sm2043031a91.0.2026.04.18.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:09:52 -0700 (PDT)
From: Taylor Hewetson <taylor@exponent.digital>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taylor Hewetson <taylor@exponent.digital>
Subject: USB: core: sanitize string descriptors against C0 control characters
Date: Sun, 19 Apr 2026 07:08:58 +1200
Message-ID: <20260418190858.19865-1-taylor@exponent.digital>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418025823.21767-1-taylor@exponent.digital>
References: <20260418025823.21767-1-taylor@exponent.digital>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some USB devices report string descriptors with a declared length
greater than the actual string, leaving uninitialized firmware memory
- often including C0 control characters such as 0x18 - appended to
the returned string. This has been observed on the ASUS ROG Azoth
2.4GHz dongle (USB ID 0b05:1a85), where the trailing bytes make their
way into hid->uniq and then /sys/class/input/inputN/uniq.

Downstream userspace components then reject the device. systemd's
sd-device property_is_valid() treats any string property containing
control characters as invalid and refuses to set ID_SERIAL_SHORT,
which in turn prevents the device from being tagged with seat. On
GNOME Wayland, mutter silently declines to open input devices that
are missing this tagging, leaving the keyboard visible and producing
keycodes at the kernel layer but dead to the user in a graphical
session.

Truncate the returned UTF-8 string at the first C0 control character
(0x00..0x1F) or DEL (0x7F). Printable Unicode beyond ASCII is left
intact, so legitimate non-ASCII serials (e.g. European manufacturers)
continue to work. Callers that previously received a string with
trailing garbage now receive the clean leading portion, which is
well-formed UTF-8 and safe for all downstream consumers.

Signed-off-by: Taylor Hewetson <taylor@exponent.digital>
---

Changes since v1:
 - Move the sanitization from drivers/hid/usbhid/hid-core.c to
   drivers/usb/core/message.c so that all usb_string() callers
   benefit, not just usbhid. (Greg KH)
 - Broaden the scope from "ASUS Azoth workaround" to "well-formed
   string guarantee for usb_string()"; update commit message
   accordingly.

v1: https://lore.kernel.org/all/20260418025823.21767-1-taylor@exponent.digital/

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1052,6 +1052,25 @@
 			UTF16_LITTLE_ENDIAN, buf, size);
 	buf[err] = 0;
 
+	/*
+	 * Some devices report string descriptors with a declared length
+	 * greater than the actual serial, leaving uninitialized firmware
+	 * memory (often including C0 control characters) appended to the
+	 * returned string. Truncate at the first control character so
+	 * callers get a clean, well-formed string.
+	 */
+	{
+		int i;
+		for (i = 0; i < err; i++) {
+			unsigned char c = buf[i];
+			if (c < 0x20 || c == 0x7f) {
+				buf[i] = 0;
+				err = i;
+				break;
+			}
+		}
+	}
+
 	if (tbuf[1] != USB_DT_STRING)
 		dev_dbg(&dev->dev,
 			"wrong descriptor type %02x for string %d (\"%s\")\n",
