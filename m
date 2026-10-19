Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438019;
	b=tEkngr4Hp3VrHEXXMs86dEOpr4Oy2IXKHLOdTKxnAQv4P1tBJHYMtF3SneHMWFJo++Vb
	 w8SKCscdPcvBlfDzIRqdtaELE2acUtX1VRCNUVNZRFkQh7cJNulSdhUK7dn0iju3IVK1R
	 aNl2Zq6HertIVjPDBJu1RfAcnBcBPN3mTQdR4YwE+KGDNlbCd3YnNcM5U4jz1+fmLFEg5
	 8c5foTeOf/vTyRWurTZ36GKzZ9FEF7nVN7xsHSWl0AA8Edbqf+vkgNimskQf7KWveRjtx
	 uIIo1hM7G3sj564uFpdij+msYAi8Yjb1kiW6+cUK6XUyFw6jz9sKot7KG2vIE7OwPkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XJxIc7IZPOWvgbXWTDNvi1oJM4oQX4nC6DFxnxfPJAM=;
	b=TmFj/jS/fwbZzq+Vu609zhXqVMNT+oydqrgHOX83rjuneFNlTUVvXDNp0wMqwGX9G0/D
	 LNSoUNVwjkzlu9G2P8afFrimlfsQdFPaFBot/ruoIlk3H6DvTre6MxeAaKOFwjm5UrBWx
	 Xg9Mf1Qx5rJH3LoCi2SuPc+Vb0pMMK39OxmdkB0/xtbxCYFUcsF/4QSrhI2dZQx68N/bq
	 CHcfumoBKHnKS310db29amRdLQL9LXf/AknZeSa+32fWXv4JWBIFHZynb3PdWHyhOmZW1
	 TSy63/Vq4x52/luRTDGdac3YmArSy7yEOooymZkQx5pi//S14tdAQRu2zF07iPqjLhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HA1u57TD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43C606A320;
	Mon, 19 Oct 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HA1u57TD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166701F000C5;
	Mon, 19 Oct 2026 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438018;
	bh=XJxIc7IZPOWvgbXWTDNvi1oJM4oQX4nC6DFxnxfPJAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HA1u57TDRPq6UjOED+DV69EWPkOi8yCEx96AEr5kGy2qe3RJi7Ab6Ly8iaOxkiSKH
	 lm0zv+l+S6wwyOeA7P7+mEOR2a+g6OCYU8OpxHXYYENrilGYEj8tfaaUvFNOO5OhH4
	 FtC4qYMVfsodyItizF+JbQ8RnMpqmMTFPaRCqT5fdejkpv5QAYs6//+K0jNARJotnK
	 XHDDn3ZzcEdn7jsWrr8FJgBz0G7Stm9RRjT0+ylhFahPIOhIgEXmDRCB4dR75+i07r
	 IwNQbJv0HhJtBWqGHpOE+q12tOR7icBRZSoB3WDy+RirGai4VQGHUdVtZwucKyQjBL
	 QsY/yu1f42BzA==
Message-ID: <sashiko-outbox-178143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/11] HID: spi-hid: add spi-hid driver HID layer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019-send-upstream-v6-4-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-4-cb9ba4b3d6fa@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 19:26:57 +0000
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
- [Medium] HID: spi-hid: zero-length report descriptor accepted in spi_hid_=
ll_parse()
--

commit 9328ec8c48a0b55cf1019d845ec2c37e89f4cdbb
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add spi-hid driver HID layer

This commit adds the HID low-level driver callbacks and device creation log=
ic
for spi-hid, handling report descriptor fetching, buffer allocation, and
output/feature report requests.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 02a7608c4b882..fca7a44eeb9f9 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> @@ -84,11 +185,484 @@ static const char *spi_hid_power_mode_string(enum h=
idspi_power_state power_state
[ ... ]
> +/*
> + * This function returns the length of the report descriptor, or a negat=
ive
> + * error code if something went wrong.
> + */
> +static int spi_hid_report_descriptor_request(struct spi_hid *shid)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	struct spi_hid_output_report report =3D {
> +		.report_type =3D REPORT_DESCRIPTOR,
> +		.content_length =3D 0,
> +		.content_id =3D SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQUEST,
> +		.content =3D NULL,
> +	};
> +	int ret;
> +
> +	ret =3D  spi_hid_sync_request(shid, &report);
> +	if (ret) {
> +		dev_err(dev,
> +			"Expected report descriptor not received: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D shid->response_length;
> +	if (ret !=3D shid->desc.report_descriptor_length) {
> +		ret =3D min_t(unsigned int, ret, shid->desc.report_descriptor_length);
> +		dev_err(dev, "Received report descriptor length doesn't match device d=
escriptor field, using min of the two: %d\n",
> +			ret);
> +	}
> +
> +	return ret;
> +}
[ ... ]
> +static int spi_hid_ll_parse(struct hid_device *hid)
> +{
> +	struct spi_device *spi =3D hid->driver_data;
> +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> +	struct device *dev =3D &spi->dev;
> +	unsigned int rsize =3D shid->desc.report_descriptor_length;
> +	int error, len;
> +
> +	if (rsize > HID_MAX_DESCRIPTOR_SIZE) {
> +		dev_err(dev,
> +			"Report descriptor size %d is greater than HID_MAX_DESCRIPTOR_SIZE %d=
\n",
> +			rsize, HID_MAX_DESCRIPTOR_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	if (rsize > shid->bufsize) {
> +		error =3D spi_hid_alloc_buffers(shid, rsize);
> +		if (error)
> +			return error;
> +	}
> +
> +	len =3D spi_hid_report_descriptor_request(shid);
> +	if (len < 0) {
> +		dev_err(dev, "Report descriptor request failed, %d\n", len);
> +		return len;
> +	}
> +
> +	/*
> +	 * FIXME: below call returning 0 doesn't mean that the report descriptor
> +	 * is good. We might be caching a crc32 of a corrupted r. d. or who
> +	 * knows what the FW sent. Need to have a feedback loop about r. d.
> +	 * being ok and only then cache it.
> +	 */
> +	error =3D hid_parse_report(hid, (u8 *)shid->response->content, len);
> +	if (error) {
> +		dev_err(dev, "failed parsing report: %d\n", error);
> +		return error;
> +	}
> +	shid->report_descriptor_crc32 =3D crc32_le(0,
> +						 (unsigned char const *)shid->response->content,
> +						 len);
> +
> +	set_bit(SPI_HID_READY, &shid->flags);
> +
> +	return 0;
> +}

[Severity: Medium]
What happens in spi_hid_ll_parse() if the report descriptor length is 0?

In spi_hid_ll_parse(), rsize (shid->desc.report_descriptor_length) is check=
ed
against HID_MAX_DESCRIPTOR_SIZE, but not for zero. Later in the series, the
commit "HID: spi-hid: add HID SPI protocol implementation" validates
raw->rep_desc_len !=3D 0 in spi_hid_dev_desc_response(), but if a device re=
turns
a REPORT_DESCRIPTOR_RESPONSE with content_length =3D=3D 0 (shid->response_l=
ength =3D=3D
0), spi_hid_report_descriptor_request() computes min_t(unsigned int, 0,
shid->desc.report_descriptor_length) and returns 0.

Both spi_hid_ll_parse() here and spi_hid_refresh_device() in the protocol p=
atch
only check if (len < 0), treating len =3D=3D 0 as success.

When len =3D=3D 0 is passed to hid_parse_report():

drivers/hid/hid-core.c:hid_parse_report() {
	hid->dev_rdesc =3D kmemdup(start, size, GFP_KERNEL);
	if (!hid->dev_rdesc)
		return -ENOMEM;
	hid->dev_rsize =3D size;
	return 0;
}

kmemdup() returns ZERO_SIZE_PTR (non-NULL), so hid_parse_report() returns 0.
spi_hid_ll_parse() then caches a CRC32 of 0 and sets SPI_HID_READY, and
hid_add_device() sees a non-NULL hdev->dev_rdesc and calls device_add(),
registering an unusable hid_device while bypassing SPI_HID_ERROR reset
recovery.

Should spi_hid_report_descriptor_request() or its callers reject a 0-length
report descriptor (for example, checking !rsize in spi_hid_ll_parse() and
returning -EINVAL when shid->response_length =3D=3D 0 or len <=3D 0)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-upstr=
eam-v6-0-cb9ba4b3d6fa@chromium.org?part=3D4
