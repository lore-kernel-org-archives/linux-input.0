Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538623438B5
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515644; cv=none; b=BzUD2xsTppzccuqVpBijuRc5GzYGyUqZaKJ4N6z69XLEYs9RjKvAERBSjLaF8OHc7aP2fBHDl/01HENoKuef9u/hLAc3q5du9hJOwr9TCIMZk2+IjI5oxDMeYpk/YbEBJGoaN90KG7BKgdsBIOGVuoN5NOwhwqnHx7gw+Afzje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515644; c=relaxed/simple;
	bh=oHABUSpe3jSDXfzPGIUl9aIc8jkGBJsiQB65auWR0c0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Miha5lTi41kYxiqlPNingyDxHvkHc3XypdpS7nz+iWn7cVuc/AhiOEUuFlDGg9sGatSmao2GDdF37Gy/fSvLbiInvAlVjkL/s+1DfpWA1msgkxxbFtyeTY1ATZffjYsIdt22Sw5j/3OyOkMKdhovS3WLtfKWbP/PGsq2ik1UK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsEsfky2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsEsfky2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4CA1F000E9;
	Sat, 23 May 2026 05:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779515643;
	bh=fciPq7z/jtpDvgxSE0KYhknDKoLjWAykw/3OQ4yFNUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gsEsfky2mo6nUrmqe5zlKhFzJq5DKa/rh6nn0Vaq9g64rMnGNf4xVMDUEql5m8DTp
	 leagLL7DXxRTlADSRrQAPWRTxrAz79yo/xPMn2VdfRwtH3Vyoo+x5G5aBkBuZE0jkf
	 6zBGzo2MFXuOQooLCiFkZWzYbMLmpuBq8ot1tgqf+fYS3tQi0PBnZvJbVmtyIAo+lx
	 jIAwMBLlzzbBgxL/7Nc40L/PZJMaqz8ynV6kF7pIs9S2iW17fOPIl9fLTz+C+IOxZs
	 i1j67u3EFNqe10gQJH1MqKZKDXkQomcgQCq9Qkbi+n9gMcpt4MaCPkq4znGGq9alFi
	 UtweMKAhpAZKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] Input: ims-pcu - add response length checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-10-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-10-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:54:02 +0000
Message-Id: <20260523055402.7E4CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch aims to fix out-of-bounds reads and processing of stale =
data by adding response length checks, but the fix is incomplete. Several f=
unctions continue to read from `pcu->cmd_buf` unconditionally without verif=
ying `pcu->cmd_buf_len`.
--

commit 1053ecbb5cda993188d606f124de0009c93c1fdd
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - add response length checks

The driver processes response data from device buffers without verifying
that the device actually sent enough data. This commit adds checks for
the expected response length before accessing the buffers.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 7746a8242f2a0..7cdf40ac42ce1 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
[ ... ]
> @@ -1283,6 +1298,12 @@ static int ims_pcu_read_ofn_config(struct ims_pcu =
*pcu, u8 addr, u8 *data)
>  	if (error)
>  		return error;
> =20
> +	if (pcu->cmd_buf_len < OFN_REG_RESULT_OFFSET + 2 + 1) {
> +		dev_err(pcu->dev, "Short OFN_GET_CONFIG response: %d bytes\n",
> +			pcu->cmd_buf_len);
> +		return -EIO;
> +	}
> +
>  	result =3D (s16)get_unaligned_le16(pcu->cmd_buf + OFN_REG_RESULT_OFFSET=
);
>  	if (result < 0)
>  		return -EIO;

[Severity: High]
This is a pre-existing issue, but while this change fixes out-of-bounds rea=
ds
in several places, it seems to miss a few other functions that still read f=
rom
pcu->cmd_buf without verifying pcu->cmd_buf_len.

For example, in ims_pcu_write_ofn_config(), result is read unconditionally:

static int ims_pcu_write_ofn_config(struct ims_pcu *pcu, u8 addr, u8 data)
{
	...
	error =3D ims_pcu_execute_command(pcu, OFN_SET_CONFIG,
					&buffer, sizeof(buffer));
	if (error)
		return error;

	result =3D (s16)get_unaligned_le16(pcu->cmd_buf + OFN_REG_RESULT_OFFSET);
	...
}

Similarly, ims_pcu_backlight_get_brightness() accesses the buffer without
bounds checks:

static enum led_brightness
ims_pcu_backlight_get_brightness(struct led_classdev *cdev)
{
	...
	error =3D ims_pcu_execute_query(pcu, GET_BRIGHTNESS);
	if (error) {
		/* Assume the LED is OFF */
		brightness =3D LED_OFF;
	} else {
		brightness =3D
			get_unaligned_le16(&pcu->cmd_buf[IMS_PCU_DATA_OFFSET]);
	}
	...
}

In __ims_pcu_execute_bl_command(), pcu->cmd_buf[2] is accessed directly:

static int __ims_pcu_execute_bl_command(...)
{
	...
	error =3D __ims_pcu_execute_command(pcu, ...);
	if (error) {
		...
		return error;
	}

	if (expected_response && pcu->cmd_buf[2] !=3D expected_response) {
	...
}

And ims_pcu_verify_block() casts into the buffer without length verificatio=
n:

static int ims_pcu_verify_block(...)
{
	...
	error =3D ims_pcu_execute_bl_command(pcu, READ_APP, NULL, 5,
					IMS_PCU_CMD_RESPONSE_TIMEOUT);
	if (error) {
		...
		return error;
	}

	fragment =3D (void *)&pcu->cmd_buf[IMS_PCU_BL_DATA_OFFSET];
	if (get_unaligned_le32(&fragment->addr) !=3D addr ||
	    fragment->len !=3D len) {
	...
}

If a malfunctioning USB device sends short packets during these operations,
could the driver bypass the intended length checks and read stale data from
previous packets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D10
