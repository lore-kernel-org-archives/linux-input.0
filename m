Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641433537F9;
	Tue, 30 Jun 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826921; cv=none; b=pTztPIfwV7feWj68DggnGEctHxQRiT0ZRXlQ/D1LspO4wfJN3grZP+ivM0xK4c4EncMBnqR+YkEzEHxkDudLPPA1UEX+/51Cdr4Ve4gYEaOuxq+gnd4IdkJZidYk2zpi1U9nr1M5BZgiKhTu3OI8fHpFkruG/WRwbmUZy/8UwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826921; c=relaxed/simple;
	bh=nuq2LW10KyHK5kl8aqb/M3T8yKmd/O+uPY46d2YePkw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XhAGjbOZIJaw+omc1Bcvovg88aYz8BgB+DT2TPFKVYEyb4pGmKqAKAnJp71Bp0ASQpK+2n48ZwpIpT4cXr30cPLnZx9DlYKvpQ+OPA2pU12SM8z2aFTQPFtXsSNiOgzob17k62wXEJ8b3gLowFYycoZb9JNmu4tlCmGmDHfrkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=ftdTP7rU; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="ftdTP7rU"
Received: by chaosmail.tech (Postfix) id 4A48A1CB983;
	Tue, 30 Jun 2026 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1782826912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1S6bWwjFBo5Xa+HjUZ32P5iQHl6oakQlX84F8q/+L7A=;
	b=ftdTP7rUoUwCQTyNR4WfJCWeqW4KuYAEwjXvp7tFTaHoc/ZotEQ0kGlByzVec3EPs4091e
	NJHaVyqd2O70rIvJcKamQq+XAkh5F8cXI1BU4FUB16QRaSDTCHKAQLeRcHhNvlplbR+n6x
	Z8E+uh4Js6RtD/DHMcFQHD5kGn+1t+w=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 07/10] HID: apple: Add support for DockChannel HID
 keyboards
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-7-506d936a1707@gmail.com>
Date: Tue, 30 Jun 2026 15:41:40 +0200
Cc: Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 iommu@lists.linux.dev,
 linux-input@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B22C8EFD-DEDE-49C1-AD8E-BAEB5C91B6A6@chaosmail.tech>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-7-506d936a1707@gmail.com>
To: michael.reeves077@gmail.com


> On Jun 30, 2026, at 14:54, Michael Reeves via B4 Relay =
<devnull+michael.reeves077.gmail.com@kernel.org> wrote:
>=20
> @@ -659,6 +669,7 @@ static void apple_battery_timer_tick(struct =
timer_list *t)
> /*
>  * MacBook JIS keyboard has wrong logical maximum
>  * Magic Keyboard JIS has wrong logical maximum
> + * Internal DockChannel keyboards can advertise oversized report =
sizes
>  */
> static const __u8 *apple_report_fixup(struct hid_device *hdev, __u8 =
*rdesc,
> unsigned int *rsize)
> @@ -699,6 +710,27 @@ static const __u8 *apple_report_fixup(struct =
hid_device *hdev, __u8 *rdesc,
> rdesc[3] =3D 0x06;
> }
>=20
> + if (apple_is_dockchannel_keyboard(hdev) && *rsize >=3D 5) {
> + int i;
> +
> + for (i =3D 0; i <=3D *rsize - 5; i++) {
> + if (rdesc[i] =3D=3D 0x76 && rdesc[i + 1] =3D=3D 0x00 &&
> +    rdesc[i + 2] =3D=3D 0x40 && rdesc[i + 3] =3D=3D 0x95) {
> + u8 count =3D rdesc[i + 4];
> +
> + if (count > 0 && count < 32) {
> + hid_info(hdev,
> + "fixing up DockChannel report size\n");
> + rdesc[i] =3D 0x75;
> + rdesc[i + 1] =3D 0x08;
> + rdesc[i + 2] =3D 0x96;
> + rdesc[i + 3] =3D 0x00;
> + rdesc[i + 4] =3D count * 8;
> + }
> + }
> + }
> + }
> +
> return rdesc;
> }
>=20

It looks like this section is duplicated in the following commit (8).=20
Is that correct?


