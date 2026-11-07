Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.205.69.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052995;
	b=csLdlGPvqEeeLLjpDsLr6LfaLFHK3ENW4LK2UJstU3fB+Af4nVKAu4TsvR0StLAN4fSj
	 g2qlxwvskH1+6d9lRx/l7Emr+dMZNy6vrwbdtlPdYZA2DQyia4YDk34DqLIN308OZoc/1
	 NiAu8eES0UdjVX05081AJy2T+8N6YEC7arbO0tMJ7xsph9M0F7L6XY+ktvyqTBAXn0x3e
	 50f+Cevafz8DNXncqM44TMG6+KdyxkzfZMBAWEeSthJsKDnz6njpclypP5KHZkpMT2fYN
	 x/sheZS5WfBCDk2e3p7tMC6AR+nTKHclxBbGkyUkOJNIBUsmBTFpmAb6TrQ1FNePnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052995;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID;
	bh=WUQ9p15I8SKVBgkTZxS/3Du56ceDlIEsQltmCAn36nc=;
	b=tHg0j1/L/IHHgMo01wUmv/rQlAraus0gf3EX7aQIZrlDMAbRzyI7VF/Io4gqQlTh2MSp
	 rRyJlHEw9Shy1gXe8yWw9quzw5W1dF01rZ2qaC70PRa/5NgJStTd1M9/yyIoqRSmQFijc
	 QZgyi5VjetHR6LrIXHtdEl/uX2FE/9raLyFAiSxfzHpFOtQgE0Lac2WUlmyAwvHRhg9AC
	 FdglYoiteEZS4XeQ9pD8srLVa/2a7G9pnxAKUO8dqA7LZwmk97OhLIwOKNfNDqLeflCrM
	 eet/K20JIPMKsnKpszPd6rWyziErlhLWhEuY1+tSDFpTdqVKtHwQYkcoz9sBJ5rk1ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tutamail.com;
	spf=pass smtp.mailfrom=tutamail.com;
	dkim=pass header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=Ap+kgmqn;
	arc=none smtp.remote-ip=185.205.69.213
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D7606D80F
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 12:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B56D7606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=Ap+kgmqn
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id EF3D51A0392B9
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 13:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1794052992;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=WUQ9p15I8SKVBgkTZxS/3Du56ceDlIEsQltmCAn36nc=;
	b=Ap+kgmqngCHf71+UKHVaLSbIr/mR7gqSUpZq6KPXWWBry3T7PdAJIbnMRpmR6oge
	EQH6n8cv1gclih0wcWVKg54oKI2B7HIZTMd558FTmibOSHCtfMvhfC9mgfc3OtefTmh
	Tur/vPrj3I8T+5IqkJBZtinSq4Bo/99yswgB+W5ZZT4Tv/AYFUCmvMPM680VsCg2hcw
	c4kCuAPPKnqF0hu02pxDp35UPoBEiAodWlptU8BZsli777cKfEa9T/QY+qQ3WdefK9F
	9EbHT1UGpXUabVk75Qj6edHjHFSdOJuSofOTQKmK4R8eyEv8blq0fMxECp2XE4p8rkh
	NKsucPUzaQ==
Date: Sat, 7 Nov 2026 13:03:12 +0100 (CET)
From: willowswaving@tutamail.com
To: Linux Input <linux-input@vger.kernel.org>
Cc: Jikos <jikos@kernel.org>, Bentiss <bentiss@kernel.org>
Message-ID: <P5psz0r--F-9@tutamail.com>
In-Reply-To: <P5pmaU5--J-9@tutamail.com>
References: <P46njqS--N-9@tutamail.com> <P4DHMrF--F-9@tutamail.com> <P5pmaU5--J-9@tutamail.com>
Subject: Re: FWD: [RFC] HID: uclogic: Add support for Xencelabs Pen Display
 (28bd:520d) and request for switch-to-vendor-mode sequence
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 015fe4ab774a31809b4b05b8c610ead356bcc03e5c866e6007fd3e8866c7c0a22bb5af78b76e2b2d682867fe72df3c2e2eae226386f9c0a8fc7fe2cb63b896dd32:TurnOnPrivacy!:tutamail



> Subject: Re: [RFC] HID: uclogic: Add support for Xencelabs Pen Display (2=
8bd:520d) and request for switch-to-vendor-mode sequence
>
> Hello,
>
>
> I am writing to send a friendly ping regarding the support for the Xencel=
abs Pen Display (28bd:520d). I understand you are very busy, and I just wan=
ted to check if there is any update or if there is any additional informati=
on I can provide to help move this forward.
>
>
> The device is still available for testing. I would be happy to try any pa=
tches or collect further USB traces if needed.
>
>
> Thank you for your time.
>
>
> Best regards,
>
> Willows
>
> 2026/10/18 17:13 =E6=9D=A5=E8=87=AA willowswaving@tutamail.com:
>
>>> Hello,
>>>
>>> I would like to report a missing device support in the hid-uclogic
>>> driver, and ask for guidance on how to properly add it.
>>>
>>> Device information
>>> ------------------
>>> =C2=A0 Name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Xencelabs Pen Display
>>> =C2=A0 Vendor ID:=C2=A0 0x28bd (Hanvon Ugee / XP-Pen)
>>> =C2=A0 Product ID: 0x520d
>>> =C2=A0 Firmware:=C2=A0=C2=A0 20250121(230322)
>>> =C2=A0 Model:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UG902_LPH2412_P10
>>>
>>> Problem
>>> -------
>>> The device is not handled by hid-uclogic. With hid-generic, the device
>>> is registered only as a mouse and no pen events (ABS_X, ABS_Y,
>>> ABS_PRESSURE, ABS_TILT) are reported to userspace.
>>>
>>> When I add the device ID to hid-uclogic-core.c, the driver binds, but
>>> the resulting interface is still a mouse. evtest shows no pen events.
>>> This suggests the device is still in "firmware mode" and never gets
>>> switched into the vendor reporting mode that exposes the pen interface.
>>>
>>> Key observations from testing
>>> -----------------------------
>>> 1. lsusb reports only one interface (bNumInterfaces =3D 1, interface 0,
>>> =C2=A0=C2=A0 HID class, mouse). It has only two interrupt endpoints:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x81 (IN, 64 bytes)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - 0x01 (OUT, 64 bytes)
>>> =C2=A0=C2=A0 Note: There is NO endpoint 0x03, which is the endpoint use=
d by
>>> =C2=A0=C2=A0 uclogic_ugee_v2_probe_endpoint in hid-uclogic-params.c. An=
y attempt
>>> =C2=A0=C2=A0 to send magic bytes to 0x03 fails with "Invalid endpoint a=
ddress".
>>>
>>> 2. Reading the string descriptor at index 0x64 under LANGID 0x0409
>>> =C2=A0=C2=A0 successfully returns a 14-byte binary blob (13 bytes of co=
ntent).
>>> =C2=A0=C2=A0 Raw HEX: 0e03289a78e60300ff1fd8130100
>>> =C2=A0=C2=A0 (Other indexes return normal strings like the serial numbe=
r and
>>> =C2=A0=C2=A0 "hanvon ugee Tech"). Reading index 0x64 does NOT switch th=
e device.
>>>
>>> 3. Sending the UGEE v2 magic bytes (02 b0 04 00 00 00 00 00 00 00)
>>> =C2=A0=C2=A0 via SET_REPORT (Feature 0x02, Output 0x02, Feature 0x03) r=
eturns
>>> =C2=A0=C2=A0 success, but the device never re-enumerates.
>>>
>>> 4. A vendor-specific control request (bRequest 0xb0, wValue 0x0402)
>>> =C2=A0=C2=A0 times out.
>>>
>>> 5. Note: Sending unexpected control transfers to this device can cause
>>> =C2=A0=C2=A0 the USB HID interface to hang. It requires a complete powe=
r cycle
>>> =C2=A0=C2=A0 (unplugging USB and power) to recover.
>>>
>>> Request
>>> -------
>>> Could someone with access to the Xencelabs USB documentation, or
>>> someone who has reverse-engineered the 520d, share the correct
>>> sequence to switch this device into vendor mode?
>>>
>>> Specifically:
>>> =C2=A0 - Is the 0x64 string descriptor read the right trigger, or is a
>>> =C2=A0=C2=A0=C2=A0 specific control transfer required?
>>> =C2=A0 - If a control transfer is needed, what is the correct bRequest,
>>> =C2=A0=C2=A0=C2=A0 wValue, wIndex, and endpoint?
>>> =C2=A0 - Are there known quirks for this device?
>>>
>>> If a capture from the Windows driver is needed, I can provide one.
>>> If you have any hints, I will be happy to prepare a proper patch
>>> with hid-uclogic-params.c changes and re-test.
>>>
>>> I am attaching the text files with:
>>> =C2=A0 - lsusb -v output for 28bd:520d
>>> =C2=A0 - the raw HID report descriptor (usbhid-dump)
>>> =C2=A0 - the string descriptor enumeration (showing 0x64)
>>> =C2=A0 - dmesg logs showing the binding behavior.
>>>
>>> Thank you very much for your time.
>>>
>>> Best regards,
>>> Willows
>>>

