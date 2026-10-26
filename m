Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973153;
	b=2cg55JaTpZ4Gd/TvkzqrBMZ2WZwbguR8pgwCtoAU07U0kb3h0BVRLk4MAMgs4hDktFxG
	 o4bon+b0uWMGbuSp1NHniWhCLO2VMXAvNSfWa7YcaziZzawoGqVGkhapaOPYWA5PRBd6I
	 Ue8FA1NdGFNsoM5X5AKFRs/47tEQaQgYSUyGQncK4h9m76lFlP4OflprhqSdK61SEthFR
	 L+63kwibajK72ds3+M5rCzWFpGR+XyaxaZrMjdswWzjmRbOfFqcE/IX25tqhq8YrPPzkQ
	 LoK857TYwEsd0dmvOS+IKR1eu2/VXHuEJns4EaIdHtNpuX4GrVMFMtG16CtXNEeHKEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973153;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y6izCSKXKN3cnbdnWYT352CP5MMOkZW2v455mNNo4hE=;
	b=AuYzAMAX2n8gIlClqtB9YWk1Nqb9FMDZkKvMaQz+xNtFshTYnxR/a5KW2k3HR0uqfZna
	 Es/8eeUXeIOyy5suvvhLHofDS7NP9UQCAFmbLK8bHf01JGZd37wTXdnDmMbrHH7iEvjJW
	 jkrVFNfg7dv1Dqb4jL/NpLA+sl4Yc9MvV5zIIjNDKRgN+5wOpoxtfDnL/Ilm/Fa82zuY6
	 qAyRZQN69DirZgtHN0lHQZOCM56NpTn8pD8MMWtJixmvIj5/Xis+F6nNDwN9YprICIBde
	 6AHUEVi2aAHk/GcFAQNXZVZcXNgJPCFCE1CMDEzILPuGMocz+63I59cq5XgjiyxoqNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfrLgeJ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940F606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfrLgeJ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96301F01825;
	Mon, 26 Oct 2026 00:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973152;
	bh=y6izCSKXKN3cnbdnWYT352CP5MMOkZW2v455mNNo4hE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfrLgeJ9M85p0j10ZqyugJ2+AW8+WztDvzQro2RVSxLdeA+S4PS7CAciPd8fP0L77
	 kMKblRcC1EvHfbJFlPIqyxhodlBQUwYlJ3J39vHpm0wbyqVF2xDcR2OXQGX7oK1TP4
	 MvdzErRTOlYGjd0O+gKf8mT3bs+YXDB9RgXUx125GKHZjbfbsSF1EriU4TtNZJX9Kn
	 WXKkGnA4IxtSuOl0Zv05YmHKkJm2o9WrHxSO/rk7gpuowcOVzZYD5xABIjtzQjAZiv
	 3tR7zfTU3yBnhHoVg9jcfz0WMkfYPxbWU588VRo68MuS81KLh7MYvLO0GVjBcS92JC
	 V7J/8X59pe/ug==
Message-ID: <sashiko-outbox-184548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/18] HID: asus: expose XG Mobile identity and
 firmware information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-15-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-15-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:05:52 +0000
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
- [Medium] HID: asus: unchecked return and unaligned scan in asus_xgm_tlv_s=
tr()
--

commit a88274a1b2531f51181e1da6036282f6753460c3
Author: Denis Benato <benato.denis96@gmail.com>

HID: asus: expose XG Mobile identity and firmware information

This commit queries the XG Mobile station for its firmware version and
generation at probe time and exposes the station's identity and firmware
fields through read-only sysfs attributes on the HID device.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e751bf1634349..f438cad13264a 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -6204,6 +6206,148 @@ static bool asus_xgm_is_supported_model(const str=
uct asus_xgm_info *info)
>  	return false;
>  }
> =20
> +/**
> + * asus_xgm_tlv_str() - Extract a "tag, length, data" field
> + * @dst: destination buffer
> + * @dst_len: size of @dst, including the trailing NUL
> + * @buf: answer of a version query
> + * @len: size of @buf
> + * @tag: three characters tag to look for
> + *
> + * The version query answers with an 8-byte binary blob followed by
> + * "tag, length, data" fields, where GEN holds the station generation and
> + * VER the firmware version.
> + *
> + * Return: 0 on success, -ENOENT if @tag is missing or its data does not
> + * fit @dst
> + */
> +static int asus_xgm_tlv_str(char *dst, size_t dst_len, const u8 *buf,
> +			    size_t len, const char *tag)
> +{
> +	size_t i;
> +	u8 n;
> +
> +	for (i =3D 3; i + 4 <=3D len; i++) {
> +		if (memcmp(buf + i, tag, 3))
> +			continue;
> +
> +		n =3D buf[i + 3];
> +		if (i + 4 + n > len || n >=3D dst_len)
> +			return -ENOENT;
> +
> +		memcpy(dst, buf + i + 4, n);
> +		dst[n] =3D '\0';
> +
> +		return 0;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/**
> + * asus_xgm_get_version() - Query the firmware version of a station
> + * @hdev: HID device
> + * @info: identity structure whose generation and firmware_version fields
> + * get filled in
> + *
> + * Return: 0 on success, negative errno on failure
> + */
> +static int asus_xgm_get_version(struct hid_device *hdev,
> +				struct asus_xgm_info *info)
> +{
> +	size_t len =3D asus_report_len(hdev, FEATURE_KBD_LED_REPORT_ID2);
> +	int ret;
> +
> +	if (!len)
> +		return -EINVAL;
> +
> +	u8 *buf __free(kfree) =3D kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret =3D asus_xgm_query(hdev, ASUS_XGM_QUERY_VERSION, buf, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (len < 4 || buf[1] !=3D ASUS_XGM_CMD_QUERY ||
> +	    buf[2] !=3D ASUS_XGM_QUERY_VERSION)
> +		return -ENODEV;
> +
> +	asus_xgm_tlv_str(info->generation, sizeof(info->generation),
> +			 buf, len, "GEN");
> +	asus_xgm_tlv_str(info->firmware_version, sizeof(info->firmware_version),
> +			 buf, len, "VER");
> +
> +	return 0;
> +}

[Severity: Medium]
In drivers/hid/hid-asus.c, asus_xgm_tlv_str() is documented to follow an
8-byte binary blob after the 3-byte report/command header (buf[0..2]) and
return -ENOENT when a tag is missing or its length is out of bounds.

However, in the asus_probe() -> asus_xgm_init() -> asus_xgm_get_version() ->
asus_xgm_tlv_str() path, two things stand out:

1. asus_xgm_tlv_str() starts scanning at i =3D 3 (inside the 8-byte binary =
blob
at buf[3..10]) and increments byte-by-byte (i++) rather than starting at
offset 11 and advancing across record boundaries by 4 + n. If the binary bl=
ob
or an earlier field's payload happens to contain the bytes "GEN" or "VER",
could asus_xgm_tlv_str() treat the following byte as the length and either
abort early with -ENOENT or copy unintended bytes into dst?

2. asus_xgm_get_version() ignores the return values of both
asus_xgm_tlv_str() calls and unconditionally returns 0. When a tag is missi=
ng
or truncated, asus_xgm_init() will log empty strings for
info->firmware_version and info->generation via hid_info() instead of taking
the ret < 0 warning branch:

	ret =3D asus_xgm_get_version(hdev, info);
	if (ret < 0)
		hid_warn(hdev, "Failed to query XG Mobile version: %d\n", ret);
	else
		hid_info(hdev, "XG Mobile: firmware %s, generation %s\n",
			 info->firmware_version, info->generation);

Should asus_xgm_tlv_str() start after the 8-byte binary header (or step by
TLV record length), and should asus_xgm_get_version() check and propagate t=
he
return values of asus_xgm_tlv_str()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D14
