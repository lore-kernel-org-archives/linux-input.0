Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDE4C6507;
	Fri,  9 Oct 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557243; cv=none; b=iDoy/kp9LuR06dyLWZx6N5qr6z8fsnwriugQQWFUiu2Lg5WA26x+le9JmggZdCkfHj/Dwqnn5V5Q/slwTVhUSf8I9PRBpyfrDDEbT4B/QjBdxzJA+L6L9sVISK5MffeKZKPF3FYXbHuSEgVN4WBVF5OGQcba+QZIMZ3swdY5ImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557243; c=relaxed/simple;
	bh=Nd1UQuWIPVoZCN1JAxsjjYrIHel7MXAsOmh7A1+b3zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b0UVM4M6khewIngIZ8PINIwNTtfLEdJDsh14jcJDje9erAY6xXD188W1LbztmTGAn2obQTcXE3vzJb0dBaVIkJYCKEqdZ+nem9kmXU31e2owLu8QS2Uqi2gWu0PxEJhrKK6gApMeLeMq7Ly6+58jI/4gTfPM3hKVPiCvpeidFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jALUDBK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jALUDBK/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36F14C2BCF7;
	Fri,  9 Oct 2026 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791557243;
	bh=Nd1UQuWIPVoZCN1JAxsjjYrIHel7MXAsOmh7A1+b3zs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jALUDBK/M29d/RAFgkazOUpBDF4WawjR1Tg+8Wqh5fqGx2zzGQjB0iRzWFzJO5ity
	 M377cEURzuTbaZptiKEaD7JOjGTwT/X3fD6Y4NL14sAnQwlsjIux7n45szZ2OWYASN
	 mZm4GFWPQE/AeLVM3uE1ty+YV2AMKvLBBqIlx4z+e8GNLoVEfKbPlVSDibCmVHPrLX
	 LZLHtCsDd7EgSAsRm2v0hUVFay3PfOoDQ6Blf9wO8HngM4YBgS6p2RtJL5kyY2nUM4
	 dW0SEzsaHzileI7S+/swWd8Gcxzfh//HFuNshWI3XLT6oEtbzR78JljpAggLJoTBkg
	 gLTseTPj2Ngsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F176CA601D;
	Fri,  9 Oct 2026 14:47:23 +0000 (UTC)
From: Krzysztof Furman via B4 Relay <devnull+krisfur.proton.me@kernel.org>
Date: Fri, 09 Oct 2026 15:47:10 +0100
Subject: [PATCH] Input: xpad - add support for Corsair Novablade Pro
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-xpad-corsair-novablade-v1-1-e58746bef99f@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtoK6zMVxEPWRs1Iu1IdAzG3
 n2dHr/D/69grMIGl24F5VlMamnwpw7Sk8qDUXIzBBd679yAy0QZU1UjUSx1pvFNmfEcKEQfAw1
 9hBZPyndZfuPr7W/7ji9On+MG27YDCXq0b3oAAAA=
X-Change-ID: 20261009-xpad-corsair-novablade-32a27172a967
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Furman <krisfur@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791557242; l=2357;
 i=krisfur@proton.me; s=20261009; h=from:subject:message-id;
 bh=ajmN4wE5ck5/WbQMqQHqcLzqggS+I8lqcfuBpb4LQN4=;
 b=wzJJIbfQiRN5ky9nCpFii1qs1PySNhBwCcTc84sMUoo2+khwff3rbZTzDbC52zM6Y8jB/LR/s
 Cl0Mscxp8TuDiiuhS482ab8w28WJcxQ1TCOB0A1qd17f/NJb+Y1S5Kj
X-Developer-Key: i=krisfur@proton.me; a=ed25519;
 pk=qWf2loGTQN6F4MMZofmcek16QZYEtENBLRL0vg4m0F0=
X-Endpoint-Received: by B4 Relay for krisfur@proton.me/20261009 with
 auth_id=1142
X-Original-From: Krzysztof Furman <krisfur@proton.me>
Reply-To: krisfur@proton.me

From: Krzysztof Furman <krisfur@proton.me>

Add device IDs for the Corsair Novablade Pro leverless fight controller
in both wired (0x2b1f) and 2.4 GHz receiver (0x2b2b) modes, and add
Corsair's vendor ID to the Xbox 360 vendor match list.

Outside of its PS4/PS5 modes the controller uses the Xbox 360 protocol
(vendor-specific class, subclass 93, protocol 1) on interface 0, which
xpad does not currently bind, so no gamepad device is created. The
PS4/PS5 modes present a standard HID gamepad and already work with
hid-generic.

Tested on 7.2.5 with the 2.4 GHz receiver and wired.

Assisted-by: Claude Opus 5.5
Signed-off-by: Krzysztof Furman <krisfur@proton.me>
---
The PS5 mode (0x2b27) presents a plain HID gamepad and needs no xpad
change, so it is not included.
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..51f889389 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -295,6 +295,8 @@ static const struct xpad_device {
 	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1a86, 0xe310, "Legion Go S", 0, XTYPE_XBOX360 },
+	{ 0x1b1c, 0x2b1f, "Corsair Novablade Pro (Wired)", 0, XTYPE_XBOX360 },
+	{ 0x1b1c, 0x2b2b, "Corsair Novablade Pro (2.4 GHz Receiver)", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0130, "Ion Drum Rocker", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
@@ -536,6 +538,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1a86),		/* Nanjing Qinheng Microelectronics (WCH) */
+	XPAD_XBOX360_VENDOR(0x1b1c),		/* Corsair controllers */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harmonix Rock Band guitar and drums */
 	XPAD_XBOX360_VENDOR(0x1ee9),		/* ZOTAC Technology Limited */
 	XPAD_XBOX360_VENDOR(0x20bc),		/* BETOP wireless dongles */

---
base-commit: 1a3ba2dc2b91d50201a9d4721f166e68f4903eb6
change-id: 20261009-xpad-corsair-novablade-32a27172a967

Best regards,
--  
Krzysztof Furman <krisfur@proton.me>


