Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794066439;
	b=LJPhnJlL1L05LP9VidM4KLMqE5KbfiV9LLoILp+na1kTjjX2smSlyW7LmAAuUW1ysOE+
	 GBD2V5rdxda/JJz2FAeBrQ2IVTaahY9HcRD5ZzZjHk7HkgFkKOTP/8l/8so9Sbs88OpJx
	 KycR3oLvKReKZtJNYr8gje517Saz7iqIWO22aZRIi/C9KfWA6oG93Ms0vAQi1QGXXPaPS
	 5s6568is94Rdcuymh3Ay9pCKvF5eVygl2UKqpuvQ1C8EZymGz04Sg8JmYS6MQHK74nUDc
	 D1puAmzZd680D/WwKQ4PQb/BbnQcs2KNuEGegPxQaHpvBgw30U+vEJjgANdyvsXHtrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=LGKkrJ8tAyPahhVgu1uA6tK3tk0jmIDk1hW8JwAzYag=;
	b=w00TAPl9/VNXYXrFzjDmumlEzuhNwGroIw79lF3VTWy56aV7Nd2DAbcKCm/1TQxh8BHV
	 pGoIFdoMKELcyt+KuLGsb7722jvY1HOucKLGiq28eStK0e/hpFetUfPoQR2+I4MBmubK9
	 EoWBElqtxEjRuIRzmQhUrXW8Cq9doVRMdMk+sIA2jZtmFB1p3QJKfzEr5qvkGBod4GlJg
	 7+6cYx5yltk/5ZocEt3Hcwob9+/du1r5bHAjgoUJclXOrJ50dLXW2YFwnBgsO5U21Zmoz
	 +RXGtvwGAk+gu/Uk0zn/Km6uLaKPf81+t2DyIOv6sZT+paCKhoVmFPIlJPbfZWLWbwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gc+5US5g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ADF606A32D
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70ADF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gc+5US5g
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-5642e0910a3so604206b6e.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 07:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794066438; cv=none;
        d=google.com; s=arc-20260327;
        b=W02OUz41chaSg6vuA1trJz2tnROmR0aY/g7QL6sy/2WQY/9HdvkKOR08pwSH2FtQPB
         JB/QRWuiu1ehX9LjtL4d+Duo7H4nBSRexFr18hSUH2kOFOq5oPtOu4H2f5OZ50b4NumF
         kMTXqtJRe7cSsg/HSruIAhftGTa0ydIgNNSl5KScus1xJz/HID0UWo+S0zDtxNh3Shcr
         GteIg0e6iBek5xfxWRJ73dEqvPixhfLnxilGeBNjgld6aEcBKATW2sQCuQ/WZ9ZvVcXD
         RibkJBH2tW8r3uSFzX9FUxQBiTGY4TAIwySDEdixK99Z0ASw0Sq7tGLSmNCNo7b6lbIU
         qspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LGKkrJ8tAyPahhVgu1uA6tK3tk0jmIDk1hW8JwAzYag=;
        fh=RlhTxD77Ow880eqrTAlehrA5R92+cuE9nzPgBgkt7xg=;
        b=LB48zbr8vpJvHluo8BadFiVHhYcNFEUIvoIBYVfrQqKOl0tIrzPu1NdSGJAFj6R1fI
         OHO6afZOynI1iT7hMrMuFTAjIXQFl1cOzJhBwfISHmJviYLV8FlDrzpL8SSFbFpiLO0Y
         Dya3Gz4HW3bCQbnvmSQVt2aBs42qEWPg7uTL6CVdn9X4mXoB0DojhyejB3Q3X7RdRaIY
         LSo0Nf+Pn2/EE9r3W6nqrott1q8A28GXOe3ZTukHZQxcrB4GnIjdp2gFjOH1y6MfX/Dw
         WmrP3GCAfpAd6xFLAX7tJH5GRXW4kJZOforBwJpdhO5XTCbbLqsttO0Dl2B8w+R/QR0M
         jAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794066438; x=1794671238; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGKkrJ8tAyPahhVgu1uA6tK3tk0jmIDk1hW8JwAzYag=;
        b=gc+5US5gqQF3rTiHTuvZnOmskYcWkBCn8cshIDMpl80bVgGggxF9BbIMZZpod8QZxp
         Q12aQejLH7U1OCsCuJMRkJxqKBtuILgQ2pVt3RA9CJbdAaQXognyAWviejbWi8toO+NP
         ZKlOIo5/uzTAI8Vdw/TwID628Rw7w8aQqC1AxyPIY/wWvYrZqLJNiPJwyq4I18saUvZh
         Qxoe/v/AfgBgLQ0XBB3mFdLzRxPMUJmF6fE5S3ile0Wi8kXhbOq7Nev1Lp9bfgC0gKV3
         NDhjVitsh5klh2VRIevM44CejBdhB7zS4AXvx3MsVuxNDvEYaE+hul43KKIbXja0EPiI
         SX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794066438; x=1794671238;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LGKkrJ8tAyPahhVgu1uA6tK3tk0jmIDk1hW8JwAzYag=;
        b=OSITIo3YK/3ORXZ/f3ig/U56rL0Gt3FOAXULFTObo3jzLbJ2uBorErnbTGo2cPaQXq
         bD+dVxR5kEm50JSK4HRGTAzT/gCI8cVYgsHsN++zSfL2ddHPofuVnP0smU/QiuHUngLy
         ZN8d0xtlBYP/ldRhFT36/YMFzFYrb/1ZYhtZUddVB818J/IMntc6cN6/enej2Rhkubpo
         Jz28uOCscp7PZwl0gnoHgRbKkOErSu6Jfp5cA95R+ZTVd7kWncVYJoaYmR5N7pguPveo
         kFA58U3LT1rsmqq7a09bHkOzfRvgnkf4rlnkAMVroooe/OJdoIuNypKP2oT6GCSnlnPq
         53MQ==
X-Gm-Message-State: APuU4Z/yHwELuHUEVnlqYt5jllv7HSOBlWmD2AUfl+Aq5Aac6fdfQaef
	N+nRbN3UEf5t6P5iH8bTXh9NRRt7k24Vdc3PbRlYZVUXzzDCzMsSHvPuw75KEpboia1OvfLTASg
	BP/AGFZ26u24/7Ao/IWVXAl95XSsicoYnZRYD5xY=
X-Gm-Gg: AYBFou3BNB9dRcx/WNyM3246ig1u4618SLIde5ZLMdMUyKe74yTrUliep0ukxa8mz5L
	m73AU0GnkUbwvTIBJYYU6Ve1/CPf5Y8+RIfjjj5IBGio2VPrCqlNr2VgGNuIet13ZvMto8dubEG
	94+W/RtZPb/tIHSSZS4v73bcyhCDtWlV19MOBOWCTgBP5U8XQGlSh1bvfUc3bo7khWYmx0VvTG/
	6syG+UO5im6ikaDoUX4BOb0eeNVQCaiB0FU5fUGvpjRu0F/20XKovqhUibFZacHKyNE2hPK4krN
	SmKW0AnHy4sD1lHoCovjIg89HOumfrzpReefqOLvwRtrashh9dA/IjvLxoHSGnZM1BHQ5So9juw
	TVK7WX8abggDFYNUEEirAkbR3Q6+N1yu45Owk
X-Received: by 2002:a05:6808:1509:b0:4e9:a959:7a4c with SMTP id
 5614622812f47-567e101a3c1mr3836931b6e.24.1794066438235; Sat, 07 Nov 2026
 07:47:18 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Juan_Parrado_Garc=C3=ADa?= <jparrado.1817@gmail.com>
Date: Sat, 7 Nov 2026 16:47:07 +0100
X-Gm-Features: AclHuK-K96I59kgerSKax1Vlo3chWSgPdIhhDe_ntnCLsm8W4gFkn351rM8TL6M
Message-ID: <CAFkAFXod+xQ2o9SVGbKwg_pacnLrUYgzoVeQLcf4wQZN7JyUHg@mail.gmail.com>
Subject: [PATCH] xpad.c: Add support to hyperkin xenon, hori taiko controller
 dx and 8bitdo pro controller.
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"

Add specific support to various controllers:
- HORI Taiko Controller DX
- 8BitDo M30 Wired Controller for Xbox
- Hyperkin Xenon Controller

Signed-off-by: Juan Parrado <jparrado1817@gmail.com>

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782..be81990ce 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -259,6 +259,7 @@ static const struct xpad_device {
  { 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch",
MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
  { 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X",
0, XTYPE_XBOXONE },
  { 0x0f0d, 0x0152, "Hori Racing Wheel Overdrive for Xbox Series X",
0, XTYPE_XBOXONE },
+ { 0x0f0d, 0x01b1, "HORI Taiko Controller DX", 0, XTYPE_XBOX360 },
  { 0x0f0d, 0x01b2, "HORI Taiko No Tatsujin Drum Controller",
MAP_SHARE_BUTTON, XTYPE_XBOXONE },
  { 0x0f30, 0x010b, "Philips Recoil", 0, XTYPE_XBOX },
  { 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
@@ -380,6 +381,7 @@ static const struct xpad_device {
  { 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
  { 0x2993, 0x2001, "TECNO Pocket Go", 0, XTYPE_XBOX360 },
  { 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0,
XTYPE_XBOXONE },
+ { 0x2dc8, 0x200a, "8BitDo M30 Wired Controller for Xbox",
MAP_SHARE_BUTTON, XTYPE_XBOXONE },
  { 0x2dc8, 0x200f, "8BitDo Ultimate 3-mode Controller for Xbox",
MAP_SHARE_BUTTON, XTYPE_XBOXONE },
  { 0x2dc8, 0x201e, "8BitDo Pro 2 Wired Controller for Xbox",
MAP_SHARE_BUTTON, XTYPE_XBOXONE },
  { 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired
Controller", 0, XTYPE_XBOX360 },
@@ -389,6 +391,7 @@ static const struct xpad_device {
  { 0x2dc8, 0x6001, "8BitDo SN30 Pro", 0, XTYPE_XBOX360 },
  { 0x2e24, 0x0423, "Hyperkin DuchesS Xbox One pad", MAP_SHARE_BUTTON,
XTYPE_XBOXONE },
  { 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
+ { 0x2e24, 0x072e, "Hyperkin Xenon Controller", MAP_SHARE_BUTTON,
XTYPE_XBOXONE },
  { 0x2e24, 0x1688, "Hyperkin X91 X-Box One pad", 0, XTYPE_XBOXONE },
  { 0x2e95, 0x0504, "SCUF Gaming Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
  { 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
