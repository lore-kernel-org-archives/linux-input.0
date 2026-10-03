Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34A39DBF7;
	Sat,  3 Oct 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050175; cv=none; b=s16U6FKfa8osLn03bahTbP0J0xcnfzVfsYrWwdZNtuCedkFdtuLTEJ9QyeglK4pNGEDgjNjDNdJ3Ls1RweH7uVa05/sTjtFZBnkEt6FLa/xOUwNzYiOMlAUFtUjVy3Qtjo2X1MnlWcreBLlfR8x0T2csQqBIbAeM2erGCOTnf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050175; c=relaxed/simple;
	bh=M8+bhaXQ3AGosn4onSx5ceR7KM6Ccdq5PCxTO4fsTV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfdDtuG5LDc4i5Voq6AKbPHQBj+iT4dbAUnY2WBiDkFzJn8qsPCeboygX3Fg/XLPBt1QUPHaxeqplkqlobhMNrAFXCvjzxvTSlFhrgmd1fqDrqcKYTav5ZtbyUqsPpc2iaKkf2bzmahIBNiyf3me7rRgZmf8OznBXs2bRd0buTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR7M77yN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR7M77yN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE88F1F0089C;
	Sat,  3 Oct 2026 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050174;
	bh=O1vVHSd2ar0/BIgXLZTDFn5bSvY+gQkAoVxemt1pASk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NR7M77yNvwSIrLOzWBp4oeC5X3nSF56sTqvllJBjeTzI5no9KKF4g0bkH+9RZ3Sa9
	 v1jhYbkjbfv+MiZqkeIM7RhVqNJeKHJ0vWnxmw58Q16eSIVFqp37kyISL68OOoOGGH
	 6k8UVJtxrfLOgjc2TSangWBpRH/oxwBDbqWty8jD887HMRW14D3ogC0LHmhT2rsWIg
	 9GLuXVtp91Fmh/ZL1a+ubyxULyTyE0EysanOXrT7Tg61/rDOksk0JT+UJunB7U/PGK
	 EujXt97ZVIvTAj9kIjqG0ICsd1u00s5YBK4qaHvPryhk3EVB7j6ufO8j558AeCf+K6
	 AmfQGgFiP8glw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] HID: himax: Report the touch and heatmap data
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261003142741.48634-6-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-6-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:13 +0000
Message-Id: <20261003175613.CE88F1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Heap buffer overflow in heatmap decompression due to integer trunc=
ation
- [High] Null pointer dereference in himax_decompress_heatmap due to concur=
rent IRQ execution
--

commit c3f3c5296c4dbb7b96df08e22f2c194d4ef65577
Author: Micha=C5=82 Kope=C4=87 <michal@nozomi.space>

HID: himax: Report the touch and heatmap data

This commit adds reporting of heatmap data for the HX83102J firmware.
It extracts the heatmap following the stylus report and decompresses
it from 12-bit to 16-bit values.

Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/ker=
nel/+/5326106

> diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
> index 533d7be629147..40abae724743d 100644
> --- a/drivers/hid/hid-himax.c
> +++ b/drivers/hid/hid-himax.c
> @@ -2150,6 +2150,37 @@ static void himax_hid_remove(struct himax_ts_data =
*ts)
>  	ts->hid =3D NULL;
>  }
> =20
> +/**
> + * himax_decompress_heatmap() - Unpack the heatmap into its HID report
> + * @ts: Himax touch screen data
> + * @src: Heatmap as read from the event stack
> + *
> + * The IC packs two 12-bit heatmap values into three bytes, while the HID
> + * report descriptor of the firmware declares 16-bit values. Copy the re=
port
> + * ID and heatmap info header, then widen every pair of values to the
> + * little-endian 16-bit layout of the report.
> + *
> + * Return: None
> + */
> +static void himax_decompress_heatmap(struct himax_ts_data *ts, const u8 =
*src)
> +{
> +	u32 i;
> +	u32 count =3D ts->ic_data.rx_num * ts->ic_data.tx_num;
> +	const u32 header_size =3D HIMAX_HEAT_MAP_INFO_SZ + 1;
> +	u8 *dst =3D ts->heatmap_buf;
> +
> +	memcpy(dst, src, header_size);

[Severity: High]
Does this code dereference a NULL pointer if the IRQ fires concurrently?

If an interrupt fires early, himax_ts_thread() executes himax_ts_operation()
which locklessly checks ts->hid_probed.

If another thread running himax_initial_work() sets ts->hid_probed =3D true=
 via
himax_hid_register(), but hasn't yet allocated ts->heatmap_buf in
himax_hid_report_data_init(), won't dst be NULL here when memcpy() is calle=
d?

> +	for (i =3D 0; i < count; i +=3D 2) {
> +		const u8 *packed =3D src + header_size + i * 3 / 2;
> +		u8 *unpacked =3D dst + header_size + i * 2;
> +
> +		unpacked[0] =3D packed[0];
> +		unpacked[1] =3D packed[2] >> 4;
> +		unpacked[2] =3D packed[1];
> +		unpacked[3] =3D packed[2] & 0x0f;
> +	}
> +}

[Severity: High]
Can this loop read and write past the end of the allocated buffers if count
is an odd number?

Since count is the product of rx_num and tx_num read dynamically from the
device, it might be odd. The loop processes elements in pairs (i +=3D 2).

During the final iteration with an odd count, won't this write 4 bytes to
unpacked and read 3 bytes from packed, exceeding the bounds of both buffers?

[ ... ]

> @@ -2322,6 +2362,9 @@ static int himax_hid_report_data_init(struct himax_=
ts_data *ts)
>  	ts->touch_data_sz =3D ts->hid_desc.max_input_length;
>  	if (ts->ic_data.stylus_function)
>  		ts->touch_data_sz +=3D ts->hid_desc.max_input_length;
> +	ts->heatmap_data_size =3D ts->ic_data.rx_num * ts->ic_data.tx_num * 3 /=
 2;

[Severity: High]
Does this calculation truncate the required size if the product of rx_num a=
nd
tx_num is odd?

If the count is odd, this division by 2 truncates the result, potentially
leading to an undersized allocation for xfer_buf that doesn't account for t=
he
full packed heatmap size.

> +	ts->touch_data_sz +=3D HIMAX_HEAT_MAP_HEADER_SZ +
> +			     HIMAX_HEAT_MAP_INFO_SZ + ts->heatmap_data_size;
>  	if (ts->touch_data_sz !=3D ts->xfer_buf_sz) {
>  		kfree(ts->xfer_buf);
>  		ts->xfer_buf_sz =3D 0;
> @@ -2331,6 +2374,14 @@ static int himax_hid_report_data_init(struct himax=
_ts_data *ts)
>  		ts->xfer_buf_sz =3D ts->touch_data_sz;
>  	}
> =20
> +	if (!ts->heatmap_buf) {
> +		ts->heatmap_buf =3D devm_kzalloc(ts->dev,
> +					       ts->ic_data.rx_num * ts->ic_data.tx_num * 2 +
> +					       HIMAX_HEAT_MAP_INFO_SZ + 1, GFP_KERNEL);

[Severity: High]
Does this allocation fail to account for the loop's 2-element processing
chunk size?

If the count is odd, the destination buffer is sized exactly for the odd co=
unt.
Since the decompression loop in himax_decompress_heatmap() processes elemen=
ts
in pairs, won't it write past the end of this allocated buffer?

> +		if (!ts->heatmap_buf)
> +			return -ENOMEM;
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003142741.4863=
4-1-michal@nozomi.space?part=3D5
