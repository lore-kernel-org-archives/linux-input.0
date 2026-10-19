Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422467;
	b=nRdtiblIpsoYEzZAZqtIdYqpUNAZF3dNjKY3DCuDkGEoHkIKroaOeL8QqXs7OoODG/+/
	 S0vEXcJisksk+BLJtysYKvuxC9T8LuCM6GLMgMxJod5IdSkrCBSHYj9d9nGZm7JbBo2Rx
	 VcLkxxC+6h7T3p7CB73/2X7ES7n4OSTAp9Kc4pkXKO9ypp7Uq1/LiQ9qaKupfR3LeAXqm
	 Hrq7MZ6J3qbsRcjhmjoy6MC1kCA/DTLt3zqilzgIVggm33v2fPScf61V0S8Udsb07lwAp
	 5FfoBay01Bt8+/WiuOyd08pJf1+sZIS0CR5U2B9l4FcxYt3z/gDB+qLdPjPNXjhREZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pDSQjlnKteASJ3B7IRTs/AnP6+4VRRni8091d6C1nhA=;
	b=cbHEPvCwTcFkGdEzilE07sCHlPc3VNxqHqDp7dkl89W/ZYhnqoDHwdNXgPHVetD3Av+A
	 XXcvQNmdhtIa/RA4RTs2FAk3hd5epPBSJ9elDUJvSBDUCL7TU/+QmZGc24I0med9LyFx/
	 Qm7MXlMhklsE1B7x0KPkNj75S8sL1i2SshjJgDMd6hSSf5wxfANyAW4TyMbxWJzcuNUJ3
	 jC/s7XPfk7ozGnwiYWVaQGPyAj31GSMfSLlRF2CBqRSpsRStXBod5b2hnaK7BQSffRYtD
	 LYHRiEs3iYs7bCey/PFfqblTFJ5ShqmaZaSt9ujzMGfx9CheDYvqQkq2kYgl587/Rig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFA9QboZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5176084857
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFA9QboZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B971F000C4;
	Mon, 19 Oct 2026 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422467;
	bh=pDSQjlnKteASJ3B7IRTs/AnP6+4VRRni8091d6C1nhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFA9QboZmp51kenFxuP8B7yp/9Nc9Pg4s2IrFIwNiOLd4CaDtsinebAinLCYhYjAN
	 4D6xw6KUiX5uisjxs5NQqYZgJJp/q8WlGViRU0UAhy7CN8rrvnRlfwXTfb5J0UnscJ
	 f9b8e454w4rEaVArB7tzstVviMtfW4g788f/+NsZ3olhf+F+9nrhrXwQF0lQc1pgFU
	 LdU6Ypf1T6ghTyOHoTqFQSjJ1oU4NnI78He7s6J7GiKMf/JUAujYoK2Lva3b2jb9ST
	 1s7V2eq5ABJOtSIKUCIUgIKncZXVnN0EZDHzPdt/AZbWGm9ekuUkMw9AQhNJJoWQGZ
	 oblzDNDuCjbrA==
Message-ID: <sashiko-outbox-177617@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] HID: wacom: avoid copying Bluetooth input
 reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019135441.1420968-386-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-386-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:07:46 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: wacom: unaligned 16-bit reads in wacom_intuos_general() on =
BT reports
--

commit c4e8a30b627ffd270cacd2aea99e17a24a724562
Author: Ruoyu Wang <ruoyuw560@gmail.com>

HID: wacom: avoid copying Bluetooth input reports

This commit avoids duplicating Bluetooth reports with kmemdup() in
wacom_intuos_bt_irq() by temporarily updating wacom->data to point at each
10-byte payload slice in wacom_intuos_bt_process_data() before calling
wacom_intuos_irq().

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index af76e49fd0f25..8feb8027be95e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1192,8 +1192,11 @@ static int int_dist(int x1, int y1, int x2, int y2)
>  static void wacom_intuos_bt_process_data(struct wacom_wac *wacom,
>  		unsigned char *data)
>  {
> -	memcpy(wacom->data, data, 10);
> +	u8 *saved_data =3D wacom->data;
> +
> +	wacom->data =3D data;
>  	wacom_intuos_irq(wacom);
> +	wacom->data =3D saved_data;

[Severity: Medium]
Could pointing wacom->data directly at the payload slice introduce unaligned
16-bit memory accesses in wacom_intuos_general()?

When an Intuos4 Wireless report 0x03 or 0x04 arrives in wacom_intuos_bt_irq=
(),
it calls wacom_intuos_bt_process_data(wacom, data + i) with odd byte offsets
(i =3D 1, 11, and 21):

drivers/hid/wacom_wac.c:wacom_intuos_bt_irq() {
	...
	switch (data[0]) {
	case 0x04:
		...
		wacom_intuos_bt_process_data(wacom, data + i);
		i +=3D 10;
		fallthrough;
	case 0x03:
		...
		wacom_intuos_bt_process_data(wacom, data + i);
		i +=3D 10;
		wacom_intuos_bt_process_data(wacom, data + i);
		i +=3D 10;
	...
}

Previously, memcpy(wacom->data, data, 10) copied each 10-byte payload to the
start of the aligned wacom->data buffer. By setting wacom->data to data + 1,
data + 11, or data + 21 directly, the call chain
wacom_intuos_bt_process_data() -> wacom_intuos_irq() ->
wacom_intuos_general() will dereference &data[2] and &data[4] at odd byte
offsets (3, 5, 13, 15, 23, and 25) via be16_to_cpup():

drivers/hid/wacom_wac.c:wacom_intuos_general() {
	...
	x =3D (be16_to_cpup((__be16 *)&data[2]) << 1) | ((data[9] >> 1) & 1);
	y =3D (be16_to_cpup((__be16 *)&data[4]) << 1) | (data[9] & 1);
	...
}

Since be16_to_cpup() expects natural 16-bit alignment, won't this trigger
UBSAN alignment splats or alignment faults on strict-alignment architectures
unless get_unaligned_be16() is used?

> =20
>  	input_sync(wacom->pen_input);
>  	if (wacom->pad_input)

[ ... ]

>
>
>

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-386-sashal@kernel.org?part=3D1
