Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF348664C
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727599; cv=none; b=k8KXAN4Tkn5JRk7yn0iABJLglQs8VoAmuFviZS5OS0RnjIWTCkT3USkouQBnrEPwBWg8hX8DBWT1+DZmo2yurOApJHUybyTN7EV80odVZ5jTCQktyLylfWTDiXprCf2oFtyU2g8pYWxK+Ug4ZWMY//eT2zIj777j9r4n7eEn7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727599; c=relaxed/simple;
	bh=F9gDNVaJ3C+6YRNszbI7ZGC7ftNdUIqeu98pykpw3gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0xYHoHT89relVvib74k5PwCtxYf86MDvjzztxrTUy/LQKfeN3qOznKR2AuqXPOW0fN1MqWPOUeutGkMmLGdJtDWi8NCIYEpWc0QbymQmlT7rOqzwhfK2Y6LNTzKOuZWozOkz+jIIlT4ciLTWc9fMvcsLL57jByaPenN6Vm0F/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLhZjNxM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLhZjNxM"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso1420059e87.2
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727596; x=1787332396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+nU5bC8o57Fty25VzTAUvQUJbxW3clKqFSDtJTbIEY=;
        b=dLhZjNxMHSN+uJXOYw5jGX02WsusgmmXYp/dx4vuQ9BoIFGl9+MqzR2Txz0tyej09K
         BSzNl6Qa6Ir3qeSpuhd0riat4Z8Tlzyqw5bxOkG5e+IL9A4HX9Wx1HYTKmSPnwG0iQ9Z
         0sSHMZtJprsJRSGzImM9UIT2S9iZ/h/3X20GfEk4cyN9GAAs4A4vN1sVl+eWt34Obrej
         NyscvydUztXN1iYxpyXfnFizJsgSKflyux04+XrPRnwqWd8qCE0ZZAvvUGLnz9SAHOzd
         xpJY6hN7bFQQ12wp3epjnxtHgwTOx4IEn8sgcOv2HjpTrp6pkMRcczOA9rMIP6JmdbaT
         0djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727596; x=1787332396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+nU5bC8o57Fty25VzTAUvQUJbxW3clKqFSDtJTbIEY=;
        b=qsphJx5uIRDlDZ77kxNPEHGSzf2KqPy3PUiacRwuhHxM4f1+zreI9tpL4HChVueW3J
         1kyOpuaxoRH9SLnPs3ocYsiPKtPu5yCAGoqGFfOirOsq8CLvRNwoXQDAUwafqe8aj0gj
         S9EtUE5EwFB7CMVrvKAsF4Kd2W1P5BUdW3TOp+WMbGA77iAodmw6MpwqV4Ev601nld82
         aThkVUVJi+4THkGf+Dei5lfueEvEL5HDEPAdlZDkdmKOfHFUyjMwB+GYV6G1x1NoFlBD
         E1aZ2bhO0OlndHp2ftgHsE0mw7qM0kNqJRlgpMPhjcdI60OvxEUwQNcFmwNnS8fkeVJ0
         j1/g==
X-Gm-Message-State: AOJu0YwvB8CpSp9j9mupuizhpqGceyarTWFBkrzA4/sqoe819ne3N54s
	9nl/vqjk5AEHBk19gg2zLwuH61nGP1oC0/JeAXC56C+jiaQyE8UwJGegOHXTzER6rZt82w==
X-Gm-Gg: AR+sD10FjZVjqg9y5EfM0w35cBpc8PT47JSDunDyf4sD6mOYtJNrGLnbkgASinxdCif
	ArmOzqnsDrp5oMoxgdF6mrPCqBJTnLoKHuvm6fXvpT8PyANY6O3tNhqzfB3eIXiDPEY6xwckxRv
	MkAHURpyS8bC3t44B+PRC3et/HvLRb9NC9Ew2qQd3BVB+yMlxWV8bqzpd4QDlRV1GR6U8/iyM3A
	pdLO5eQoTngvKGvR9BNooMLfJrCUwdRP3wuATGjgLbiYOgaELziaLV389wj/w1cskCMPXSp2V7H
	FW25oJ8QVZ+eMZsWPNVB/0Bm/edSsO07GJPe01BQHW8aKMD3ZENqGGksuOTBESwkq2CtR7O96FT
	yWWYcMInyX24rEE/qksc2ZfHWMOjvCo7e6BoSmN17HnIHwy6QC4hLYDN55QvUKVm/vdourNFB1Q
	z6rYE1x7CYO6Exf7vKMCklJ8ZDO3djHk8h5RnJwSbAjkNFTXycELa+zJC13y0ELBk=
X-Received: by 2002:a05:6512:838f:b0:5ae:c21b:1cb6 with SMTP id 2adb3069b0e04-5b45918ea8fmr788247e87.28.1786727595973;
        Fri, 14 Aug 2026 10:13:15 -0700 (PDT)
Received: from archlinux ([178.207.93.112])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458bac85asm677955e87.36.2026.08.14.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:13:15 -0700 (PDT)
From: Ruzal Daminov <daminovruzal7@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruzal Daminov <daminovruzal7@gmail.com>
Subject: [PATCH 1/2] HID: multitouch: add support for Goodix GXTP7863 touchpad
Date: Fri, 14 Aug 2026 20:12:47 +0300
Message-ID: <20260814171247.16707-1-daminovruzal7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Goodix GXTP7863 touchpad controller (VID: 0x27c6, PID: 0x01e0)
found on Honor MagicBook laptops (e.g. FMI-76 / X14 / X16 Plus)
was missing from the mt_devices[] table.

As a result, it was claimed by hid-generic, which erroneously mapped
the vendor telemetry collection (0xFF01) to an input node, translating
the 1-Hz heartbeat timestamp into an endless loop of phantom
KEY_BRIGHTNESSUP autorepeat events.

Add the device to mt_devices[] with MT_CLS_DEFAULT so hid-multitouch
claims the touchpad, eliminating the phantom input node.

Tested on Honor MagicBook X14 Plus (FMI-76, AMD Ryzen 8845HS).

Signed-off-by: Ruzal Daminov <daminovruzal7@gmail.com>
---
 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index edb37b4c8..f5ddaff5c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2269,6 +2269,11 @@ static void mt_on_hid_hw_close(struct hid_device *hdev)
  * So there is no point in adding here any device with MT_CLS_DEFAULT.
  */
 static const struct hid_device_id mt_devices[] = {
+	/* Goodix GXTP7863 Touchpad */
+	{ .driver_data = MT_CLS_DEFAULT,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY,
+		     I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01E0) },
+
 
 	/* 3M panels */
 	{ .driver_data = MT_CLS_3M,
-- 
2.55.0

