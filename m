Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973007;
	b=cn/YqaVLXsoJ4mkEM6P7GQawZICVl6lZyTPhIkKodNGgM/Tc9BxwFX0mIjGvSuk/Cv1i
	 08LSeFbIqbDBXJklM8sSilshc2lETOm0lLSZN1jGoOyfbKr2I9qTJQ3z64ZO0O1EX43/W
	 sqI3te5sSG5aDn0WWk8VAfN2Q7niEz43mNMougljtZGg+eEUd4cyeoqNqq8Od8KmuHw1L
	 tAbazalnUhhTYm8GVZyuSl6k9nrl/EfOlSOxJNeO/D03/FT4SR9KLvhqBg90QBzpwaKph
	 HEtK/c47l57+jJZETXRHNeW59lXUzn/wwGN24TzTN5Svq83F7Ci6+cMoJh0/O57Y1Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973007;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V6GJX7XzZSooPdNCJxPdibC1I1560YQc804oILU8QXc=;
	b=KwSnlRhN0tw2tZz2+r3WgOFHf4nBbl838FUXQu4wF0EEffKN4xx4PF7mGqwzECW+9IXi
	 vUD2/VKEpWWgpxlfsWo6sq+6k9Swvv7bK0nHOq8ZOMhZxelqQoaC8hJu/mek2nODqsfwZ
	 iNHacN/cb5HDzqYFiFRBwLlNH+YoBFFDkKuJAyRG1gmRg7x37axsXffaggcx+Qa5McqIE
	 7EHBBcRxRzQd3Mf1IvvQOYaGw1Dw9NLInNggrBVQNmDcEmITuIKHnBzcNOOWBfAt9fA4+
	 lBWblVHv/xB41tBJ6uvPO5MkxBZ24xY6ied0AawwU7ifJa6jgDlVIOdDZYCXQ9KH0uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQkFHsYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62C606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQkFHsYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA801F01825;
	Mon, 26 Oct 2026 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973006;
	bh=V6GJX7XzZSooPdNCJxPdibC1I1560YQc804oILU8QXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQkFHsYcIt4CTlQ9fW3hmZlNZIflU3OUs6A5DNrXHA5peKQuwQtygC+ivlk0ucNpl
	 +ey/vCiPUoy6E01pnijJsgg+W4usaN1ePHDKrShrd8M8cUmBSKvGrdYHa7wcYRwqVg
	 FavbbIZiMTjkzbHL5IqhrzEUZoRTuhAcvsSNL11egNbDjvzx/P0PLG5nQ+pMnFc2QE
	 eLU1ffyoXBRaBO92zNiIao+e4bwZJbpz1M/TeOMFBzUNFcgSoJBcbmRrUoXw6nponY
	 WExfBrC2ZsNfwfFR66kHgg8MlWTl9cZFq9m6qVGeitLZwjbXHr2VYNN9/h7cVfaWy6
	 745S8I0G0c0Mw==
Message-ID: <sashiko-outbox-184543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/18] HID: asus: report the XG Mobile GPU vendor to
 asus-wmi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-18-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-18-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:03:25 +0000
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
- [High] HID: asus: u8 gpu_id[4] truncates 16-bit PCI vendor ID in asus_xgm=
_init()
--

commit 739505f96f6292806a14e712690bf33782dd803a
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: report the XG Mobile GPU vendor to asus-wmi

This commit parses the 4-part GPU PCI ID from the XG Mobile station version
query response and reports the GPU vendor ID to asus-wmi on initialization,
clearing it when the station is unbound.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e444cad85b32c..244d103fbd4c8 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -186,6 +186,7 @@ struct asus_xgm_info {
>  	char part_number[ASUS_XGM_INFO_LEN];
>  	char firmware_version[ASUS_XGM_INFO_LEN];
>  	char generation[ASUS_XGM_INFO_LEN];
> +	u8 gpu_id[4];
>  };
> =20
>  struct asus_touchpad_info {
> @@ -6313,6 +6314,12 @@ static int asus_xgm_get_version(struct hid_device =
*hdev,
>  	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
>  			 buf, len, "VER");
> =20
> +	/* the 4-part PCI ID of the GPU installed in the station: buf[3..10] */
> +	if (len < 11)
> +		return -ENODATA;
> +
> +	memcpy(info->gpu_id, buf + 3, sizeof(info->gpu_id));
> +
>  	return 0;
>  }
> =20
> @@ -6685,6 +6692,8 @@ static int asus_xgm_init(struct hid_device *hdev, s=
truct asus_drvdata *drvdata)
>  		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
>  			 info->firmware_version, info->generation);
> =20
> +	asus_wmi_egpu_set_vendor(info->gpu_id[0]);

[Severity: High]
Does declaring gpu_id as u8 gpu_id[4] in struct asus_xgm_info truncate the
16-bit PCI vendor ID to a single byte?

In asus_xgm_get_version(), the comment and length check expect the 4-part
PCI ID to occupy 8 bytes in buf[3..10] (four 16-bit fields), but
sizeof(info->gpu_id) is 4, so memcpy() only copies buf[3..6].

When asus_probe() -> asus_xgm_init() calls
asus_wmi_egpu_set_vendor(info->gpu_id[0]), it passes a single u8 value
(0x00..0xff) to asus_wmi_egpu_set_vendor(u16 vendor). Downstream in
drivers/platform/x86/asus-armoury.c:egpu_default_enable_value():

static u32 egpu_default_enable_value(void)
{
	switch (asus_wmi_egpu_vendor()) {
	case PCI_VENDOR_ID_ATI:
		return 0x0101;
	case PCI_VENDOR_ID_INTEL:
		return 0x0201;
	default:
		return 0x0001;
	}
}

the 8-bit value can never match the 16-bit constants PCI_VENDOR_ID_ATI
(0x1002) or PCI_VENDOR_ID_INTEL (0x8086), causing egpu_enable to always fall
back to 0x0001.

Should gpu_id be a 4-element 16-bit array (such as u16 gpu_id[4] or __le16
gpu_id[4] with the appropriate endianness conversion) so the full 8-byte
PCI ID is stored and the 16-bit vendor ID is passed to
asus_wmi_egpu_set_vendor()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D17
