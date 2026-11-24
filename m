Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795548458;
	b=sdVStJPPHYc0wMJK3OZGtM9yGkB1id+fGPbQHTBDXqnSovsrMg4fkCtSHnV0C/NqzU1K
	 TJ6zLxKAd7uQtaURI7w4tDObfK84zGaOyjJT/rs/ls5XE4oqaeS2DSNx9UDbupISNPOuX
	 4XwOhoAJppcol7WrL0Mg/wlpI6cUvgysqop0NyCAjVoX89rpuF+uAng/1PhkSOdBqfpNC
	 LoFlhNvJP0dTL++rFImHbj8IZa2Gf2BKVEf95y49c6oO0VbgsYNxWK9ySlgV9t7yVqiGy
	 diuBHwsCKOobdIay1F4nPMDmYW+HjBdpURHt+1DMG9tscw8WDV3xwWZCj7HFzTtCjkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548458;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kOYgCz6iTNFbwJ+3AYBE8ISwfQLT+3GEzhSRzg6EO1Q=;
	b=kXNWY2NClVKLfjHI6HbDmKTlTiceDdphWpEAL4+mXcTDjVT8kbKeMWgtC7lP8JqAwTUt
	 OH4j5OO4nq7I7UMiudBx6b4odveNXf0+ryyqiXmjrKZLX+V4p7pR2u89QoKUjnIBZ2S+o
	 q5GKyLeRr+n8ZVIwcbfVAhIgDu33In1dz7N0UXbhM3csSQGzVMEaVG1dDqhhvw7e+duHp
	 GV7LKb+sVACwV0GZ7jE4nAywKjSF9N/Mdn5X0FGFmw+iNPbdN70oCVYEYSzTuz/tF3zXb
	 wr6c/2fmcDQRgpdaZPYI5FPfMazaWzgqqqUWrR+y40xorlx3NpHJnsMCHYNtUTW7/Mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvbww+Jc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D8606A321;
	Tue, 24 Nov 2026 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kvbww+Jc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795548457;
	b=UNfQgSNY8UOyGI0hMnsXJ6ZN4CmYxFjbv4fuq+V5paawhz8ZpwEbLgTfa9BfnMOuAaxj
	 8oo7xe/Ux2Wd6H1BWCUhDO/CkYdVtv+Tbl8EjThKCNeHY56gPR3/wiPuUtrGDesDpXdRL
	 ueJPlHFBWubrpDXM91C+4Jve7PDnt0acC3j/fFVOjoCwYo2B8pr9QyOrHrN9ceQKAW0M+
	 O6PpjVXUXbeJJ+O3Ve42emQbs1DWa6Ns+Qk/miu9UrvLQJI5kOwmtGcaF2jC/j7uukXAu
	 gtXTgd6yjRVeUcZINMbWgW7GRGd7xd0XbjqgikyY8C02Snp2ubn6uE10X5uyabHC9Hg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795548457;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kOYgCz6iTNFbwJ+3AYBE8ISwfQLT+3GEzhSRzg6EO1Q=;
	b=Y922AQH4U4uoCYbLUunvmcA9vNUA3r/2pArfA9dBsk2BDBrLTquGW2D9vk8Tx7PrkERm
	 2BuQnM4CDUoLcRTxjBKvP6C7YKKskU4fBAXhglccGOTQCB+oQekGtltc/YY2yVdCHtn4Y
	 bhVgpKEKonp3MAfv3faviJh5AH7IX4hYY8l6qPVYLyzU4KPH15piwvEiiJV6XD/2Zah8/
	 gBk/48t6QUqqENuHJvtLRL2IqofgprWeFb7197g8pZfmgXfrwkzZgzdD6vf77BGMPBFPj
	 +jnsrkhKjxb5U9SaQVI9efcsjPpPuF/KbgCV3L/PD99y55u3MSjRVrvPisld6ozFBwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0A061F000C0;
	Tue, 24 Nov 2026 19:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795548457;
	bh=kOYgCz6iTNFbwJ+3AYBE8ISwfQLT+3GEzhSRzg6EO1Q=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=kvbww+JcBcyHhzxRw1n1N9qEHr6JvconzYBE4bNA/+NVzz9t8wQZ58gVfvvhYnLMm
	 ZqaEncxeRgDMrpYdpgzDm4+LKjeUh/3CsRtcBvi7s0w2rRPYyJQpncP/vk/GFt5lqG
	 gad+lWASnpyvqiaY6EgswERHMUeZR8tyfTA/CIlxm3xk9puMJvyT5CK9QpjUeyV5Ly
	 TsZSONfVY39qM/zHjGT5LLAzf+Kw249bPHxAK4I9IxrHUvNkj3xhdQ3RWRrdLs0KuZ
	 xqv+kkILw56iBPaf3PLLkpypz3L3ICgqjqQt6bOWPlei65rkqollQT4jNC2WlZCwYz
	 ZcXFb1MJIdgLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 614024CB5E;
	Tue, 24 Nov 2026 19:27:33 +0000 (UTC)
From: John Vrachnis via B4 Relay <devnull+john.al.vra.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 21:27:27 +0200
Subject: [PATCH] HID: quirks: ignore Sony cameras in USB charging mode
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-sony-camera-charger-ignore-v1-1-65e457b43241@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQrCMBAF0KsMf92BZhpEcxVxEdJpOgsTmYAop
 XcXfAd4B4a66UCiA65vG9YbEoWJUPbcqrKtSASZ5RKCRB69fbnkp3rmsmev6my1dVee5bYsEuO
 2XgUT4eW62eef3x/n+QM1TQSXbAAAAA==
X-Change-ID: 20261124-sony-camera-charger-ignore-02933244fd82
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 John Vrachnis <john.al.vra@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795548451; l=3419;
 i=john.al.vra@gmail.com; s=20261124; h=from:subject:message-id;
 bh=BtH9nhDSGnPZPdnBmfhnyBuwMLusVkripd1HxJKRhfk=;
 b=rN83bbjFc+A+DhXvEnFDgzAwv0Heeh2e3pbBQk2xCKFWFUTfoMxOe3tI9mMMeiIjm0XTjnF/0
 Q+TZ/Y4FAvHC7t8R8DKTY6T/4vE2Tkpl3Dukrb/hhWrA6MXO4rKeI02
X-Developer-Key: i=john.al.vra@gmail.com; a=ed25519;
 pk=dsOoK9BfFDyY0QBd5ot7lbyvsclTm7pCUIO6KCzcalc=
X-Endpoint-Received: by B4 Relay for john.al.vra@gmail.com/20261124 with
 auth_id=1629
X-Original-From: John Vrachnis <john.al.vra@gmail.com>
Reply-To: john.al.vra@gmail.com
Content-Transfer-Encoding: 7bit

From: John Vrachnis <john.al.vra@gmail.com>

When a Sony camera such as the ILCE-7M3 (A7 III) is switched off and
connected over USB, it enumerates as 054c:0994 "Sony USB Charger" with a
single HID interface. The same ID is used by other models in charging
mode: usb.ids lists it for the ILCE-6000, while each model has its own
IDs for its mass-storage and MTP modes.

Its 19-byte report descriptor declares one 8-bit input with Generic
Desktop usage 0x00 (undefined); the interface does nothing beyond letting
the camera draw charging current.

Sometimes the interface does not answer during probe. usbhid then gives
up after 25 seconds, and the device disconnects:

  usb 1-1: Product: USB Charger
  usb 1-1: Manufacturer: Sony
  usbhid 1-1:1.0: can't add hid device: -110
  usbhid 1-1:1.0: probe with driver usbhid failed with error -110
  usb 1-1: USB disconnect, device number 25

This happened in 2 of 6 connections on an AMD 600-series xHCI
controller. When probing does succeed, a useless "Sony USB Charger"
input device with a single ABS_MISC axis is created instead.

Add the device to hid_ignore_list so usbhid does not bind to it.

Tested on 7.3.4 (Fedora 45) with the equivalent boot parameter
usbhid.quirks=0x054c:0x0994:0x4: 13 connections in charging mode, with
no probe timeout and no input device, and the camera charged its
battery to full.

The problem was found, and this patch and its changelog were drafted,
with the help of an AI assistant (Claude) that analysed the kernel log
and the device's USB and HID descriptors; I reviewed and tested the
change.

Signed-off-by: John Vrachnis <john.al.vra@gmail.com>
---
Side note: the older Sony NEX-5R exposes a similar "USB Charger" HID
interface (054c:05b2, a consumer-control descriptor) in charging mode.
It did not show the probe timeout in 6 connections on the same
controller, so it is not included.
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c40d818417..854d54003c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1384,6 +1384,7 @@
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
+#define USB_DEVICE_ID_SONY_CAMERA_CHARGING	0x0994
 
 #define USB_VENDOR_ID_SONY_RHYTHM	0x12ba
 #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE	0x074b
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 39e93b1383..b6db6cd9f1 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -981,6 +981,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PHILIPS, USB_DEVICE_ID_PHILIPS_IEEE802154_DONGLE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_POWERCOM, USB_DEVICE_ID_POWERCOM_UPS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAI, USB_DEVICE_ID_CYPRESS_HIDCOM) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_CAMERA_CHARGING) },
 #if IS_ENABLED(CONFIG_MOUSE_SYNAPTICS_USB)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_INT_TP) },

---
base-commit: 4a30b295fc34467e0468a0c8aeef73ecbe876d07
change-id: 20261124-sony-camera-charger-ignore-02933244fd82

Best regards,
-- 
John Vrachnis <john.al.vra@gmail.com>


