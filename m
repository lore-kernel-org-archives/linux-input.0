Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960ED3955EB
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878984; cv=none; b=GP5fJSy76dfjRIx4FrEba71hPZFaCbKXVFkPsVteAtuaiPOGipyfxaAdZoxotKNzTZXKsYvYfH3MRwOK14PQp12/AoW+d0nLxrXu5IiSh4f9z+YuIRiyWz5wSGtKeepJSsnmGmkGPdO5OIyBLX8w9WlYB5agsCULnTsW06gSsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878984; c=relaxed/simple;
	bh=oAakZM4C9T6n3/whozx6Jjl8+vsnA4M+WCW5MEb849U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3imOpTRF7gds5Qj0LrREpEslNiOjiK44lL/eM0KofiGXJ4hf4UN9IcRu96T4wwHPmtLZzxUHS1p0Zxkwk4Uv/iv+JmfuaL2GSIOnGjZLk4FG57hX40qqUkmkbnx7NT0M2gW97plVNcuKjh8rjVGVBWH3kbYHKYEfI8/5fueG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu; spf=pass smtp.mailfrom=azeron.eu; dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b=T8/2LrQ3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azeron.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b="T8/2LrQ3"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ad4b60f6d5so2271858e87.2
        for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=azeron.eu; s=google; t=1781878981; x=1782483781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phbPrnXdbGjR6CtR0S5yTB3/REYnXEYdrzgdlczAkns=;
        b=T8/2LrQ3SvYnFEhtwsLBr9nVN5jzTBX81Sw1+hpYrNXFkYK13SN72akw5j8o75muaV
         z581HFE2xxvdX/VcM1cRMUG31Sny7teJYZPbk8Q28ZwuglEaZSmTvuliDqQEzUcBubGf
         iQtDXVVgtINaofSQ0j/3OMaSDwi7REpmZb/8SFjmn5sHyLSXQsXL7HOrbfMPbwW2//gu
         WLVuh0++WHWdT1mJpmvhGiVINVtxoq16kCeMKUzYfWWgvGZVbWq/p3+WQRrvodGJqEE0
         gFbxhA3cBLi+VXKOCPQ9fSozvc9zNhL68sk4ewaUj2sq3UeEccSSzYCRe5CH+wdhNIuV
         5Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781878981; x=1782483781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=phbPrnXdbGjR6CtR0S5yTB3/REYnXEYdrzgdlczAkns=;
        b=rbNoXgUorX1rtfUhji3SrzeYX/Y8a+k9KZv+f1Mi5TUSXbpqYKToDQ5VzolWWNMKac
         Ay+s5lVGvufKSVQGDxw3hB6dELFLE0zI4f7F/WWygqLr9p8xpepdUl/MboJNur8bGUi4
         IFYbFOgirGAMHc0DqlndRdQ4zW/9EerC0zwJmSJlufIKhOtuOXSp0yAuTbFPkxlQLZtl
         lybzulFBjc1szhj5AZHix4dGftedbvpDH8kvHH6A62CEJErOJ94uW6Kfo4faUZWlPq4g
         z3N324jU2xiJHaoRFowIiv5Y2LmNF8OsIOda+EWnNmN9bikOjoAHZAnQS0M0AXVAJ/4D
         Lhxg==
X-Gm-Message-State: AOJu0YzsuiRKFyXXzB3DNVvaa9i4FHSH+nBktKmhCR0rXctziWigAxV6
	/bzPsxPe1woX6D188m8Lr+bfbmumKadBTYU4dkfT8izxeolhX7DXFW+UvcXQDSFxUJt5vx5M4Cf
	U/EohzRM=
X-Gm-Gg: AfdE7cm2fCkXBOUQEWj5+HAEkMz78BquagawXqbzarBQjzUXXgA+yhM3/DBGxBgqgEq
	w+gaIunKe9ij6myR1dZPMfv5ZuxESjeLsJZiKGTVVs1rLgqzs6bvhKKy/rVtKFuXtKDiLJvNPrF
	yZmcQoHlEkWgQokHyMRWup5BmkndvYEKM9Ye6HlJg/NnVllpOdFbeL+EJMeyumDKtm0//VYD6mS
	BSvo6uXqbjrF8qrWkcnxtjqEsWWMOMUl4+FxzzZrx/8HqjWRG+jmCAfzKN/2HUw2vJO7B7EB5ZU
	rRc0oQmVeozKoLs7Ee+DRhVixmXKAYLU/qrB1Xcr8xAnAGfdU94W22Btxhl9bSThjKJ/fyvLWCE
	0jXEBWPZVA1Wi/rcaALqYrC1NhSAFyT0v8INrQOHrB1aau3lG5LVLOCH8qzwQoh5MxeEWVaCuLv
	rx3KlUGUPS4MvXgscyFbrmYyCcLh04pw==
X-Received: by 2002:ac2:4a76:0:b0:5ad:53b3:adcd with SMTP id 2adb3069b0e04-5ad57709908mr807229e87.32.1781878980653;
        Fri, 19 Jun 2026 07:23:00 -0700 (PDT)
Received: from PC-077.localdomain ([94.140.104.242])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad5749f0b3sm610327e87.72.2026.06.19.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:22:59 -0700 (PDT)
From: Roberts Kursitis <roberts.kursitis@azeron.eu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberts Kursitis <roberts.kursitis@azeron.eu>
Subject: [PATCH v3] Input: xpad - add support for Azeron devices
Date: Fri, 19 Jun 2026 17:22:56 +0300
Message-ID: <20260619142256.208361-1-roberts.kursitis@azeron.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619132821.18764-1-roberts.kursitis@azeron.eu>
References: <20260619132821.18764-1-roberts.kursitis@azeron.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB Vendor and Product IDs for the Azeron devices (Cyro, Cyborg,
Classic/Compact, Cyro Lefty, Cyborg II and Keyzen). These devices share
a firmware XInput implementation and expose the standard Xbox 360
interface signature.

Note that 0x16d0 is a shared vendor block (MCS Electronics / pid.codes
allocations), but binding here is safe as the XPAD_XBOX360_VENDOR macro
only binds interfaces presenting the strict Xbox 360 signature.

These devices reject Xbox 360 LED and rumble magic packets with a
stall (-EPIPE). Add FLAG_NO_LED and FLAG_NO_RUMBLE device flags,
set on all Azeron entries, so xpad_led_probe() and xpad_init_ff()
skip LED and force-feedback initialization for them.

Signed-off-by: Roberts Kursitis <roberts.kursitis@azeron.eu>
---
v2 -> v3:
 - Move 0x16d0 entries after 0x1689 to keep both tables sorted by
   vendor ID
 - Move quirks from the mapping field to the flags field; mapping is
   u8 and the new bits overflowed it
 - Add FLAG_NO_RUMBLE; these devices stall on rumble packets too

 drivers/input/joystick/xpad.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..405fcd5e9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -72,6 +72,9 @@
 #define PKT_XBE2_FW_5_11    4
 
 #define FLAG_DELAY_INIT BIT(0)
+#define FLAG_NO_LED	BIT(1)
+#define FLAG_NO_RUMBLE	BIT(2)
+#define FLAG_NO_LED_RUMBLE	(FLAG_NO_LED | FLAG_NO_RUMBLE)
 
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -292,6 +295,12 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1103, "Azeron Cyro", 0, XTYPE_XBOX360, FLAG_NO_LED_RUMBLE },
+	{ 0x16d0, 0x113c, "Azeron Cyborg", 0, XTYPE_XBOX360, FLAG_NO_LED_RUMBLE },
+	{ 0x16d0, 0x1192, "Azeron Classic/Compact", 0, XTYPE_XBOX360, FLAG_NO_LED_RUMBLE },
+	{ 0x16d0, 0x1212, "Azeron Cyro Lefty", 0, XTYPE_XBOX360, FLAG_NO_LED_RUMBLE },
+	{ 0x16d0, 0x12f7, "Azeron Cyborg II", 0, XTYPE_XBOX360, FLAG_NO_LED_RUMBLE },
+	{ 0x16d0, 0x13ea, "Azeron Keyzen", 0, XTYPE_XBOX360, FLAG_NO_LED_RUMBLE },
 	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1a86, 0xe310, "Legion Go S", 0, XTYPE_XBOX360 },
@@ -533,6 +542,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x16d0),		/* Azeron controllers */
 	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1a86),		/* Nanjing Qinheng Microelectronics (WCH) */
@@ -776,6 +786,8 @@ struct usb_xpad {
 	const char *name;		/* name of the device */
 	struct work_struct work;	/* init/remove device from callback */
 	time64_t mode_btn_down_ts;
+	bool no_led;			/* device stalls on LED packets */
+	bool no_rumble;			/* device stalls on rumble packets */
 	bool delay_init;		/* init packets should be delayed */
 	bool delayed_init_done;
 };
@@ -1615,6 +1627,9 @@ static int xpad_init_ff(struct usb_xpad *xpad)
 	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
+	if (xpad->no_rumble)
+		return 0;
+
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
 
 	return input_ff_create_memless(xpad->dev, NULL, xpad_play_effect);
@@ -1719,6 +1734,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	struct led_classdev *led_cdev;
 	int error;
 
+	if (xpad->no_led)
+		return 0;
+
 	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
@@ -2082,6 +2100,10 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->name = xpad_device[i].name;
 	if (xpad_device[i].flags & FLAG_DELAY_INIT)
 		xpad->delay_init = true;
+	if (xpad_device[i].flags & FLAG_NO_LED)
+		xpad->no_led = true;
+	if (xpad_device[i].flags & FLAG_NO_RUMBLE)
+		xpad->no_rumble = true;
 
 	xpad->packet_type = PKT_XB;
 	INIT_WORK(&xpad->work, xpad_presence_work);
-- 
2.43.0

