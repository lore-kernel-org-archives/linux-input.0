Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.104.220.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813932;
	b=GxJ4vI+BHkbETZ24U7ix13LETsrnVUE0bhwFFspLS8JvCDqFI7HYBzcp38m/POnFwvKT
	 N0zl/3bTavQ/Dqw9y6v0EOrIdGUix7lSghbfZq0OI3SUzTAbeacqURaK5q1cXaQC5oY41
	 UkErgY/lI6P1P8UCN1rRj4QupJzXGIzBaSzDxe4F6+hbSQEAUTMnUa3d+jlAF77COaN4S
	 dGEhUucRzLrn4+MQ4Sec4dQQIKARL83jn3U6/s0F1rL2BayeVnr8QrVmD8bwY+ESBJOBH
	 bl9xXrO4JWcjuwqVKUbacgScL4HgrDfjF2ByAp7l5Yco0CANJI/pfw5jcEBAGrdIGxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813932;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:Autocrypt:Content-Type:User-Agent:MIME-Version:X-Greylist:
	 X-Scanned-By;
	bh=QNcIhA31kObFTlvW5JJH2BSN8FtRTJ0xO+ItQb0MQaM=;
	b=BXGf25l3c2bDNlL+l3dYk1z4Xww7BdSXW9vkDMxwekK7629TaJaS7Dn0DRdL3AlLqGSO
	 28kp+ktScDBe3RUiIe0nKSri6PIFbJGiBwv5ErvlbwmqV9CzBRoH5KzJx7bDA7tEDXpyq
	 4HnmecMvC78qyh9H3o/zHH6aQegxMHe9fq3vcdCcCPTy2p1SyIul0Q3KMYuu2BHNgevwY
	 DEWI9Dars7l/XkSAPyvHhPvEE9lnwB4WpQN8MR0AFSoOfaT1KdSwjiz9pgZCMBCdpK3U9
	 iySJiiOPmWYOIeZg3wfZVABYFh80+dc314hWFekD/PGjoebzQMVcMzd5DPu+gPdJkCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=taz.de;
	spf=pass smtp.mailfrom=taz.de;
	dkim=pass header.d=taz.de header.i=@taz.de header.a=rsa-sha256 header.s=p25 header.b=cTEVKBEM;
	arc=none smtp.remote-ip=193.104.220.5
Received: from prime.taz.de (prime.taz.de [193.104.220.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80D606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 21:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E80D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=taz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=taz.de header.i=@taz.de header.a=rsa-sha256 header.s=p25 header.b=cTEVKBEM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taz.de; s=p25;
	t=1795813911; bh=QNcIhA31kObFTlvW5JJH2BSN8FtRTJ0xO+ItQb0MQaM=;
	h=Subject:From:To:Cc:Date:From;
	b=cTEVKBEMV6jpHf+oWcn9dN0qVUnLRtCCL/+7GYB/nHUacDIb+Kuore7mFz94xIvdZ
	 WdtQ+3X+UTdso4QzQREkFtB2UYbynD12Ne+jyD94WjI2z/wnaoipkmwXLtULzKy7E1
	 bHvOIfQS0gdqtq6vGZiCkpLpD5z4Boeixr3b71UCYG4CVTtMikiERNDoQZBj//QBy+
	 ZeVheX5CmkZh4g1QqjJiKjRrs/FD03txBCk7DuqX+ZECeL7Nd7wJA1cnTX7dU8v0K4
	 U4dMCBX2guMvLogb+P0TLNf3ZAwRF6tBjSbROigUUNwvDcA29AzWcS+gHHr/GIMEZd
	 dKrLWgZ47gVSA==
Received: by prime.taz.de (8.18.1/8.15.2/Debian-22+deb11u3) with ESMTPSA id 6ARLBota1556418
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 27 Nov 2026 22:11:50 +0100
Message-ID: <acacb91951ad3b1aac3fe7fc12c53e9507c34370.camel@taz.de>
Subject: HID: Apple Magic Mouse 1 (05ac:030d) drops Bluetooth link when
 battery is queried
From: Ulf Schleth <ulf@taz.de>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org
Date: Fri, 27 Nov 2026 22:11:49 +0100
Autocrypt: addr=ulf@taz.de;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-3ZuWCEDWwFhtjaHrLmJa"
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (prime.taz.de [193.104.220.1]); Fri, 27 Nov 2026 22:11:51 +0100 (CET)
X-Scanned-By: MIMEDefang 3.6


--=-3ZuWCEDWwFhtjaHrLmJa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The first-generation Apple Magic Mouse (Bluetooth, 0005:05AC:030D)
drops its Bluetooth connection when its battery level is queried. This
looks like the same problem that was fixed for the Magic Trackpad 1 in
commit 9c34660ee6d5 ("HID: input: Fix Apple Magic Trackpad 1 Bluetooth
disconnect"), and it is still open as
https://bugzilla.kernel.org/show_bug.cgi?id=3D103631.

Setup:
- Kernel 7.0.0-43-generic (Ubuntu), CONFIG_HID_BATTERY_STRENGTH=3Dy
- BlueZ 5.85, Intel Bluetooth adapter (USB)
- upower running (default desktop setup)

Symptom:
- The mouse disconnects every few minutes. btmon shows "Disconnect
Complete, Reason: Connection Timeout (0x08)".
- It reconnects after a click. After reconnecting, scrolling often
stops working until the hid_magicmouse module is reloaded.

What I tested:
- Fresh batteries, battery contacts, Wi-Fi on 5 GHz, USB autosuspend
disabled: no change.
- With upower stopped (so the hid-<mac>-battery power_supply is not
read): one disconnect in about 67 minutes in a first test, none in a
second, longer session.
- With a HID-BPF rdesc fixup that changes Usage 0x20 (Battery Strength)
on Usage Page 0x06 to 0x00, so hid-input creates no battery, and upower
running: no disconnects in X hours of use.

Report descriptor (99 bytes):
05 01 09 02 a1 01 85 10 05 09 19 01 29 02 15 00
25 01 95 02 75 01 81 02 95 01 75 06 81 03 05 01
09 01 a1 00 16 01 fe 26 ff 01 36 c0 fe 46 40 01
65 13 55 0d 09 30 09 31 75 10 95 02 81 06 c0 05
06 09 20 85 47 15 00 25 64 75 08 95 01 b1 a2 06
02 ff 09 55 85 55 15 00 26 ff 00 75 08 95 40 b1
a2 c0 00

The battery is a Feature report (ID 0x47), so every read of the
capacity results in a GET_REPORT to the mouse.

Could the Magic Mouse 1 get HID_BATTERY_QUIRK_IGNORE in
hid_battery_quirks, like the Magic Trackpad 1? I'm happy to test a
patch, and I can share the HID-BPF program if that is useful.

Thanks,
Ulf

--=-3ZuWCEDWwFhtjaHrLmJa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQI/BAABCgApFiEEyUOtqJzCZxiuNG43pGT9EpXkMCEFAmsJ8hULHHVsZkB0YXou
ZGUACgkQpGT9EpXkMCGJNw//aRdiKHBUAodZ/otHQmG14u4bng2phUWlOBrtIpWu
kvsMyY/ZPlxnd0w4Q2Kbmo40Y9cbW5dPeZ5iZyrRgJmaowfhnv/2Vtmb88+BrrZI
SGfpOlnACFukPczf7UFDdPGj72aCNo+nK90QNYQ6Pwx9C0fFzfjRwI8/vmGDJLdA
YTaDTEwFpH/2EjTBp6Tc7BkVD6tH7E50c/R/E9w5DqvtjWN8yCvtsaNmEsfXpOgZ
jb6iBrRD29Wh1WXTDNLkfGOXL0DwIEZMLJOBoo+Ncq8f5Gu7FzPxHD3cWAl92c9w
zgdo9lWO0FlGbHgHoG1QZ/eBbwT7Db5CeaXWpt6LIFjzbxg0VabFEYRU/SGQaqfK
shC6C+it8ARKf53ij07tX1rq3IR7dkSzH66wBb9cUD1MFnzy1ateHjNz7rtnI6nG
jAjjI2JK91AYE4fYpAlhCApg9cxsv4bVUpE0msWKNvhmJqNumjrhUrA1DzBoC55R
tPuXuChIFfgUQklAb1D2Q8J4U9hVT3DPozQoZHkQiHiaLITRD70q5a08tLo70ZGz
PSfkGIaWUNh25KZFmJXin8FchMeyljI5G0FGjf5pZvBVfJ/dsJgeSTJqucoRx4G6
LtlvhlgoSl7iUwROr0AGx5Y8KHljlmqPy8HPQocNfkX2MfCmYyh7ulvmIz0wE7RX
zhA=
=k5bg
-----END PGP SIGNATURE-----

--=-3ZuWCEDWwFhtjaHrLmJa--
