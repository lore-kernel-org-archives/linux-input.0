Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A043BB669
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713669; cv=none; b=OlFebCEMcYEXIltXIvVh26IX4gi0mExLnMVlgW2yTcf7hMj4cRnMlYLNajVdLS8ZMrkj96mihOIAzNYTHQPUcSzXZJ7j09jHwDKguyKqWrYn8r6iKKV7AkasHbG20QujHR5o9MKzPZPPA+GM5IB0D9XWtNAVZ+/qhKbZA+9zLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713669; c=relaxed/simple;
	bh=8VKy50GOF/Quk+JI1jw3va+Ma7x+OYrlMLPchA2FYTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=avo3Ku9ekoYcJRYzJWEpNzn8T/CMIl46T58wPpgWplLE5X+d5jrMr44FC7McVSSbVTa4GCeuOPEbVeW+k4E5DETbbzH6hJpQshofc4fUFOfwqrNfNyPaU187oiP8me1z+OYCRfWvEi+WMiSAMrBLL6IrEFdHQDjVuXQ7riPd3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0tnHJRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0tnHJRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662C21F000E9;
	Wed, 22 Jul 2026 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784713667;
	bh=eZnChMN0cFp3C42Che7VUEMrlJIbB1tXxaaV2ZgaSf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T0tnHJRKwUFstluc+8eXSyET7Z9tYFl6pFCYtuXbvoWjdTJJZkdPoeOjjiqxktkWA
	 MecANUcHR5QgjLDTxHTy4hXCjNANMAlmGqflxI8jP+dg0ZxAqa3/wRgnV6o0Ofmh4n
	 9Hf5WwtLcu2Db+uKH2PbVFBxIo29JrrflwqiUDC/wlcNyNWvz/lZV8WWLN9YLtYwMr
	 EARoCThAIfnwOg5S89Efg7huo8G0x2weGtxK/Gug8KSmU3bgccoIKa53i8cBBuPz8Y
	 2sLLTsZma/5vmYTCu2c2O42qT8S3S9+m4rpQ+fdt5bG5QPHsGab8tMyJs55JOBYyzC
	 4nbt0NjCc/QgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: goodix: Disable VDD on VDDIO enable
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chao Huang" <958028483@qq.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
References: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:47:46 +0000
Message-Id: <20260722094747.662C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check on device_get_match_data() return value leads t=
o NULL pointer dereference if the driver is instantiated via sysfs.
--

--- Patch [1]: [PATCH] HID: i2c-hid: goodix: Disable VDD on VDDIO enable fa=
ilure ---
commit 2325dfd5a42520477bfee927eabe09ddf852ba83
Author: Chao Huang <huangchao@kylinos.cn>
Subject: HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure

This commit prevents a regulator enable count imbalance during device power=
 up.
It disables the VDD regulator if enabling the VDDIO regulator fails.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hi=
d/i2c-hid-of-goodix.c
> index f1597ad67e7c8..f4dbcd1d1d472 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -51,8 +51,10 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *=
ops)
>  		return ret;
> =20
>  	ret =3D regulator_enable(ihid_goodix->vddio);
> -	if (ret)
> +	if (ret) {
> +		regulator_disable(ihid_goodix->vdd);
>  		return ret;
> +	}
> =20
>  	if (ihid_goodix->timings->post_power_delay_ms)

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer
dereference if the driver is instantiated via the I2C sysfs new_device
interface?

In i2c_hid_of_goodix_probe(), the driver unconditionally assigns the
result of device_get_match_data() to ihid_goodix->timings:

drivers/hid/i2c-hid/i2c-hid-of-goodix.c:i2c_hid_of_goodix_probe() {
    ...
    ihid_goodix->timings =3D device_get_match_data(&client->dev);
    ...
}

When created via sysfs (e.g., echo gt7375p 0x12 > new_device), the device
lacks an OF/fwnode, so device_get_match_data() returns NULL.

Does this cause a crash when ihid_goodix->timings is subsequently
dereferenced here in goodix_i2c_hid_power_up()?

>  		msleep(ihid_goodix->timings->post_power_delay_ms);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_FE1CA7ED990=
22E1734F8C9CAB538AB477405@qq.com?part=3D1
