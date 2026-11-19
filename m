Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124424;
	b=b2ylqIHiFBZZj+CZ0duv5hAKN+MNbc29V10Hs4IIJEh5qX3LzTkBlX1gbezV55yJf7Oc
	 4aOyZaasFrNlFnitOA2jGqv73nP3OcPz1lbDm9YKBuzvAl/OGNk3f69U188mSF0X9Xfd9
	 Q9wftN3XMjNcFwo6S99j/R+0Quzb2CuFONPsfubBQejSY3N+SBYjUMYhR11g8IyUIv7GZ
	 yvnIZPV2tOPtgJBPp/cKyNsu8BcD4xXfbB+oc5qhzoVEx2+b9UVbKcwteW/hlFJf2bPeX
	 M/rk8YtQnojaCotHsleUVjmhGAR8CCPoSFIHudWEdJF2ovv4lIbz2sOvXz2CzcOOR0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124424;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OOULv6zSS+OTY4Jnd+ORZdvjO678hGTlH/2OVRC18Bg=;
	b=zPJ9hr6CLReT4Noa0G9pHPZ5IOV8feTAjz9NJyHiP1lt0/LQEaZeA+X5FUVeKT26T9sO
	 g2k2SC5WUmoyjii6YerarsMsa7AEGkylLWrcB24P7RdTI062vpj2doHdWbsAU8gf6vrjT
	 9Q8mOR0s4MiHjlsY7nk0Nh1CnDRor+oOZl9pGyh0am4Jqc12+8AZuKgbrC0SxVkS15z4L
	 VEqo7a4t7WUzpwgscKw3Tt7vWXXTavacPlwP8QjvyT3E7fuO7yJSxhoMZaRdV8Y37fyEo
	 brLE02XZxY6jAARqpJwR7qFGe543D0HkWyrxNy7NQe+kJqbqQjYtftyKaTjK8OKVYzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ys+fnZWA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D4606A326;
	Thu, 19 Nov 2026 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ys+fnZWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA591F000CA;
	Thu, 19 Nov 2026 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124423;
	bh=OOULv6zSS+OTY4Jnd+ORZdvjO678hGTlH/2OVRC18Bg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Ys+fnZWA3mzMiZrrQzHBjZe4G+DTX2nxqMVf8K/XRiDuMf7SGQHeCUVN+w8MgLQwL
	 DZ6TMD6ho3ueg/leyz/MHxCT6wFqNOmJTlGIyeE0Jcqy1UVRArIPYrmWy/mxBTt0P4
	 zTEfkA3U10xi9kKsLF4yGeXMznJ6MEGLSqVzWQRUOQJIEEZ0v7JEEBt3eNqX0wNlJm
	 x0a2IQNmBTXg6X0bo57pTkZPUE9Hsyvvu6r3hP7+7+RG8av2wX8AL7ClQ0gdf3cIfW
	 e3VA5blejJv4NN3NFQs4bCooNRKyaQziFzF7Daxy3beThtCHjYaq3yygFW6hdswiZ/
	 /niYbDPCAH+rA==
Date: Thu, 19 Nov 2026 22:40:20 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?M=E9ven_Car?= <meven29@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: logitech-headset: add a battery driver for the
 PRO X 2
In-Reply-To: <20261016114757.1099300-1-meven@kde.org>
Message-ID: <pp3188sp-o171-6s7n-r73p-612570poq796@xreary.bet>
References: <20261016114757.1099300-1-meven@kde.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Oct 2026, M=E9ven Car wrote:

> The PRO X 2 LIGHTSPEED receiver does not speak HID++, so
> hid-logitech-hidpp cannot read its battery. Its report descriptor has a
> consumer collection for the media keys and two vendor collections, and
> no report 0x10 or 0x11.
>=20
> The battery answers on usage page 0xffa0. A single 64 byte frame on
> report 0x51 asks for it, with no handshake, and the reply gives the
> level and whether the headset is charging. The driver asks every 120
> seconds. It also reads the power frames that the headset sends on its
> own. A switch-off frame marks the headset absent at once, and a
> switch-on frame moves the next request to one second later, so the level
> appears without waiting for the poll.
>=20
> hid-generic sets HID_QUIRK_INPUT_PER_APP, so this receiver had one input
> device per application collection, among them the Consumer Control node
> for the media keys. A driver does not inherit that quirk, so probe sets
> it and the input devices stay as they were.
>=20
> The power supply is registered with POWER_SUPPLY_SCOPE_DEVICE. The
> headset is present from a reply until the next switch-off frame, and
> capacity returns -ENODATA while it is absent, so a headset that is off
> when the driver binds reports no level.
>=20
> The G522 LIGHTSPEED uses the same vendor protocol with a different frame
> layout. That device is left out until someone can test it.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: M=E9ven Car <meven@kde.org>
> ---
> Changes in v4:
> - Make HID_LOGITECH_HEADSET a hidden option, selected by
>   HID_LOGITECH_DJ in the same way as HID_LOGITECH_HIDPP, as suggested by
>   Jiri Kosina.

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

