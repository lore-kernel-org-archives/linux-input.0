Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896434C9569
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689982; cv=none; b=IDebfld9GoiqxzydHayhnlPTNisD1gpbHjrL4zhdinf7GQLtbLC3G1WnbuPB+ZfvH/GrMWLCKVYPB9nhUrTim5ylDyBazwigC8xT1/qaNOERRgJ0eAG91B7ujd3N0NtffyGXj4HKIlzmk4ZB1PTP7KVwohs976N5Js3hidF71sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689982; c=relaxed/simple;
	bh=/F7mkLpMSkilJ6XgDF6sYNk6aokRckj3LgTd7MUUzrE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmrIsiFeH/an3y7gcLgdlGBNOJRl2oezaNyiA5hUNuttU4mkCpY+ffNbW88UXFefXkwtxP0OojoQrOcaphp2Y2qlR13xcPTZakX9VdyAu1/eSC1t5zZMY5Y4kQuT2PMn1zBPBMY6dDBEIdsxGVhOaVp/wtM8cuFzx6U4Q6sIU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCsYVqbI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCsYVqbI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7e23defbso4221046f8f.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689979; x=1779294779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lj/PBGY77hCYFHRzm2arS0qQSCxh8sdGd+dCofuJGrQ=;
        b=UCsYVqbI8aUlCfWbFMp14YhrchuJdhsxqdOvGBxSXU2ZmZw0QLNnV9zVbZ829HNcIc
         h/Ff4pWm7tIt+FG6DK+uHUaYvh3YjBrUXIRfglNIsCqZaHqJKC2ZhFz+6SW45YMPhYfy
         w5VrNX96uSYzxH9zEmH8ut5QcaD039xt1Y7VYpya9ymM5BYdiDSyxh13ULiay4Ykkqup
         IllcbCq3kpq3O++DeZk0axLZbQLdI4HfpcPATcFdf6Qlwb0kN9c3/YL3XkT0Ld3rN+4w
         jX6cdcKJxAEx6s2TTpKSzLK51yXrVMhvjYQAlDEgMLc7eKPwlzZ5ZSOWLXuRRiB0QkAA
         N/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689979; x=1779294779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lj/PBGY77hCYFHRzm2arS0qQSCxh8sdGd+dCofuJGrQ=;
        b=TILbVuNMPnHSqyH9as1uzaZEd+mJrm3ffD+L3rCRNW7R41S8Q+TnwUcS9GvdbFuPgO
         9RqVZoAjNdUi893enCVetJVMsC/qIsikc7gy5/dPRY7OoOPfrgCXu/xrztUOJJbVT68a
         YW7WPpLCACGZ4CPrS3pBV8adi2b8I7/9phM90beUY4jfEnCuYkOBk71BFVHvv/w+m6Nc
         F4z2LKHidgnt01we7cn+Ouar93y8vctwrmr3LwyLVkAhsCDtDnRdrrIVhTiCUoTyPQvK
         rZsF7MbBGFDZDcx6A2TJZ0dbVhxHRBDLnFkkc0eVHKRYd6ADoxxS7vbCUZ/zom6x3ucp
         scag==
X-Forwarded-Encrypted: i=1; AFNElJ86FePdjENgfJhfcjBSwp+jzQfJ1TloS1D9dXZlup+cMlPsuh7WOTlRJFAyP4tUae7a0VQikXlXQ72wkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yf4p3Jb9E3RFmyFMut1HvxCmpw9fZ9ooi3fm+mDAW4wEi7o6
	lil1kBtm8Kas/bPpQriBhUZIaT165LxvXP62PYgKONuZhrU23DhaFjFv
X-Gm-Gg: Acq92OEZGvhWz4FmT8mkdLU5KHvwDt6f5fgmJFnMzGIdLxlcYepTjVgjn/6WvwOKBfh
	YWfNGLRxUxnbxXIo5kzYFuScS3PI45Z/Boo3AgiPIw7fItTb4+0SPVR8OGJAeARAxawAVaFmxuY
	tsjFWta+sQysm/WzMf7ERvOOFrbgWhVLNvaPSASvN5Ru0pxhTlEc/nQHVCXB0MgmOPUakxL/5/I
	fu/JWdr4T2DKynDBrpLU/ZkcQVTKZghmtOv9iFCgC0kLfSGEYGGlqj6bwjW5FpM2D5IZ0m673q8
	ULuXH9Q26ekunx8E3B7O9g3tVaXBRxBfVxhGaj6vw760UJWgWDZBioTxhHMsD6VJWAWcq++8EQG
	aiAQylUEeQR/f+70yaY0ENccLnmyfiHmShluYNNWCH4+zg3KVOSC48oiL1sSHNf4icmHTgedp1t
	or8EFH+InW9jCFx0xOV0uiC/tE9xovQRdIYAKiBPNUTDJsC2UE073c44ywDXdk/CNY5axmFYg9n
	VO3pFY=
X-Received: by 2002:a05:600c:1d03:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48fc9a100damr65857495e9.10.1778689978579;
        Wed, 13 May 2026 09:32:58 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6481bd6sm2301725e9.3.2026.05.13.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:58 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 7/7] hid-asus: add prod-id, quirk for Zenbook Duo keyboard
Date: Wed, 13 May 2026 18:32:48 +0200
Message-ID: <20260513163248.16483-8-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Jones <luke@ljones.dev>

The 2024/2025/2026 ASUS Zenbook Duo has a similar keyboard setup as many of the ROG
range of laptops, with the same init sequence and control for backlight.
Enable the keyboard control and backlight by:
- adding the product ID for 2024/2025/2026 Zenbook Duo keyboard MCU
- adding the Bluetooth Zenbook Duo keyboard IDs
- use Fn-lock on Zenbook Duo keyboards

Intended for the UX8406-style product line with the fully removable keyboard.

Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
Signed-off-by: Ivan Levchenko <me@livan.pro>
---
 drivers/hid/hid-asus.c | 18 ++++++++++++++++++
 drivers/hid/hid-ids.h  |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 37e3aec612b6d..ba093f11f802f 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1583,6 +1583,24 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBOARD },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_HID_FN_LOCK | QUIRK_ZENBOOK_DUO_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_ROG_ALLY_XPAD},
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf63742315bf..97dc451adac5a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -227,6 +227,12 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
 #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO		0x1a30
+#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD	0x1b2c
+#define BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD	0x1b2d
+#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD	0x1bf2
+#define BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD	0x1bf3
+#define USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD	0x1cd7
+#define BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD	0x1cd8
 #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR		0x18c6
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY		0x1abe
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c
-- 
2.53.0

