Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E633590A9
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805538; cv=none; b=BNQ/MFKIMAXXSSOs7bFOMubeSOMUtp4IJNIgG2CfrjnNWaCzSqfmatz5elzRYH+As7aMzVyNJdI/5qcyOJJvdVSreVtrMENygx1UgLX4w7Tw5OZGnoBShH+HSNMX3aJzwYWUgxsdnO/hR4+VM9jWyoTeDQ6oYo1J2pCMsEhl2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805538; c=relaxed/simple;
	bh=y+F4fJTWrD67n636c509BjVq/XDpgd2gBCKI2dNNzGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ft/JniGy6PDyKTq1d8TKf2L+zXT3XY+kKFfKrp/csMySqN2YI5w76vBsO+v77QAn4radwHCYXSKpxj/zYrwy6D2+W7g1W33Yzhbt0aGPV9MS9qKcP3dsWsu4KfF3yh9t6Wj1vQuve36J2Xg2Emx/Ps8EADqllEZClDxMErStfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKExl2FJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKExl2FJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B311F000E9;
	Tue, 30 Jun 2026 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782805537;
	bh=uLkuba/o/Nt/cUFVoQb6M9XashJb0UfuzhZOR2iBfVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKExl2FJYXbw5RtrBaO0ZCJ5jjcb+jEhZZepcox9Hp+z9QEskMxqk5kyKizRfa21x
	 ZfWDqU5vvCjQ77ib4/udNKDl5bnwuaw5+g3W74IrIP9f6ye1v1YbuPqLea9lKE4Fr+
	 pQ/+CXAAlubL3dBqRiy5Ejzl22H3XuAIiCLZEtdNhO1uw+X03GGNJ1vW3t2wXUocnm
	 iVl4RcvwP/h54rCe+/JiymF953KU+aZCzslaJKJ3WzzQ8YmGyTpUhSJOOCcRZEUdbp
	 yrzDoDn4kKhCmsQ9AimmTM4N3rLI/Zi61apVtMe5FvMiwYHYBZBt5xj21ueH8mTh8e
	 WNkeY0F1gbVsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: hynitron_cstxxx - validate touch count against
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <2026063009041899.4-ccfa108-0047-Input-hynitron_cstxxx---val-pengpeng@iscas.ac.cn>
References: <2026063009041899.4-ccfa108-0047-Input-hynitron_cstxxx---val-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:45:36 +0000
Message-Id: <20260630074537.03B311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver passes stack-allocated memory to `i2c_transfer()` and `=
i2c_master_send()`, which can cause memory corruption or system crashes if =
the underlying I2C controller uses DMA.
--

commit c00eb5cc820dacf72d27095570836d29b4df9d2d
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: hynitron_cstxxx - validate touch count against buffer

Bounds the device-reported touch count against the chip limit and buffer
layout before parsing touch slots.

> diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/=
touchscreen/hynitron_cstxxx.c
> index 1d8ca90dcda69..6644272bc72a4 100644
> --- a/drivers/input/touchscreen/hynitron_cstxxx.c
> +++ b/drivers/input/touchscreen/hynitron_cstxxx.c
> @@ -313,6 +313,12 @@ static void cst3xx_touch_report(struct i2c_client *c=
lient)
>  		return;
> =20
>  	touch_cnt =3D buf[5] & CST3XX_TOUCH_COUNT_MASK;

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to use
stack-allocated memory for I2C transfers?

Looking at cst3xx_touch_report(), buf is allocated on the stack and passed
down to cst3xx_i2c_read_register():

drivers/input/touchscreen/hynitron_cstxxx.c:cst3xx_touch_report() {
        ...
        u8 buf[28];
        ...
        err =3D cst3xx_i2c_read_register(client, CST3XX_TOUCH_DATA_PART_REG,
                                       buf, 28);
        ...
}

The cst3xx_i2c_read_register() function also appears to allocate its regist=
er
address buffer on the stack:

drivers/input/touchscreen/hynitron_cstxxx.c:cst3xx_i2c_read_register() {
        ...
        __le16 buf =3D cpu_to_le16(reg);
        ...
                .buf =3D (u8 *)&buf,
        ...
}

If the underlying I2C adapter driver uses DMA to perform the transfer, mapp=
ing
stack memory for DMA can cause cache coherency issues, memory corruption, or
kernel panics, particularly when CONFIG_VMAP_STACK is enabled.

> +	if (touch_cnt > ts_data->chip->max_touch_num ||
> +	    (touch_cnt > 1 && touch_cnt * 5 + 2 >=3D sizeof(buf))) {
> +		dev_err(&client->dev, "cst3xx touch read failure\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Check the check bit of the last touch slot. The check bit is
>  	 * always present after touch point 1 for valid data, and then

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026063009041899.4-=
ccfa108-0047-Input-hynitron_cstxxx---val-pengpeng@iscas.ac.cn?part=3D1
