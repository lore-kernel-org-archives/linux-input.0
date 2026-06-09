Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B429E11A;
	Tue,  9 Jun 2026 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980888; cv=none; b=ex4uk0eUzM9+WRSvf+9AZ0TVWrLRXqlPIVFha/YOfyBV34kklTvEFaD3+nddtDAmGC72q/ZWsoq+zGb3vkuEARWizZq0NGSOJAhATtmIaLwDxOZswuGo6g1G0Qe3YT2nWPh6Gamfwl18DJdXZLrPQ+VEAniEEWSUsSDVNQ5M8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980888; c=relaxed/simple;
	bh=8F9unHM7y0kQfvjRrQE5GoHcibJvRbowezwQwUVj7M4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ODMW9hGp7C9PmY7V2P4Pmo50SCmyeEvHS3aCjTaC3TzAf02zp1SOc7qUTVjRy3Cnxb4Rjv03AVdGLfl2+Djsa47/VHpeLXJ5Zt9VcJ/d7wgFZ7s6eueidP7bo71NBk8+F6FVkw18y1Vul5/a3Mxe9DiiQ0EDH+yMw5yt4+V4+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK3R7FRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK3R7FRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578A81F00898;
	Tue,  9 Jun 2026 04:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980886;
	bh=q3+YkNfLytp6RfBXLR6VrduVf5M6z+sZ7k2s5FPMEsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TK3R7FRAxwI0SeBcZY3hs+GntK3C7Z5ri5eedEMWbG+GjLZTj1TzDRKi5NqU5ACk8
	 76KxibnxAzmaWn7MMQIh+Qnxg/JHF1eXlraefmpl5+Xj4a3ecoImy2Rgk+gxfytVGa
	 9xKkJ2ykJJosFkQKLrtqun9KvoDA/YMYlDBowFpYlY+i4M8HimObHg2Vv33mktG7Pb
	 UvfiGDI4V+q4t42Tszsa4aWJ4xGHZvVWxcaffZ4PCP/1c+S288jlZCo7ndUaJZkrIt
	 O/UOV3Qwgk76Kn+4PvqsWwxqhvZnKb0v10/1vn3SAsmeLNSHTEZNzyP1zvr6m+mn+q
	 hJoW7YcTnJApA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/11] HID: spi-hid: add spi-hid driver HID layer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260609-send-upstream-v4-4-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-4-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 04:54:45 +0000
Message-Id: <20260609045446.578A81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing bounds check against allocated buffer size leads to a =
kernel heap buffer overflow.
- [High] Out-of-bounds write by 1 byte when copying the `HID_REQ_GET_REPORT=
` response in `spi_hid_ll_raw_request`.
- [High] Unsynchronized access to the shared `shid->response` buffer in `sp=
i_hid_ll_raw_request`.
- [High] Timeout or interruption in `spi_hid_sync_request` leaves the devic=
e state and completion structure out-of-sync.
- [High] Device probe fails for standard HID devices with small reports bec=
ause `spi_hid_ll_start` returns `-EINVAL`.
--

commit 475a21113f187310ac25983762798463f8e5115e
Author: Jingyuan Liang <jingyliang@chromium.org>

    HID: spi-hid: add spi-hid driver HID layer
   =20
    Add HID low level driver callbacks to register SPI as a HID driver, and
    an external touch device as a HID device.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 02a7608c4b882..72c2e1ce3e8d9 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -84,11 +185,455 @@ static const char *spi_hid_power_mode_string(enum h=
idspi_power_state power_state

[ ... ]

> +static int spi_hid_sync_request(struct spi_hid *shid,
> +				struct spi_hid_output_report *report)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	int error;
> +
> +	guard(mutex)(&shid->output_lock);
> +
> +	reinit_completion(&shid->output_done);
> +
> +	error =3D __spi_hid_send_output_report(shid, report);
> +	if (error)
> +		return error;
> +
> +	error =3D wait_for_completion_interruptible_timeout(&shid->output_done,
> +							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
> +	if (error =3D=3D 0) {
> +		dev_err(dev, "Response timed out\n");
> +		return -ETIMEDOUT;
> +	}

[Severity: High]
If this times out or is interrupted, the function returns and releases
shid->output_lock, but does the hardware stop processing the request?

If the hardware is still running and sends a late response, could it
prematurely complete shid->output_done for a subsequent request, permanently
desynchronizing the driver and the device?

[ ... ]

> +static int spi_hid_alloc_buffers(struct spi_hid *shid, size_t report_siz=
e)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	int inbufsize =3D round_up(sizeof(shid->input->header) +
> +				 sizeof(shid->input->body) + report_size, 4);
> +	int outbufsize =3D round_up(sizeof(shid->output->header) + report_size,=
 4);
> +	void *tmp;
> +
> +	tmp =3D devm_krealloc(dev, shid->output, outbufsize, GFP_KERNEL | __GFP=
_ZERO);
> +	if (!tmp)
> +		return -ENOMEM;
> +	shid->output =3D tmp;
> +
> +	tmp =3D devm_krealloc(dev, shid->input, inbufsize, GFP_KERNEL | __GFP_Z=
ERO);
> +	if (!tmp)
> +		return -ENOMEM;
> +	shid->input =3D tmp;
> +
> +	tmp =3D devm_krealloc(dev, shid->response, inbufsize, GFP_KERNEL | __GF=
P_ZERO);

[Severity: Critical]
When allocating these buffers based on report_size, is there a corresponding
bounds check against the allocated size when reading from the SPI device?

In spi_hid_dev_irq() and spi_hid_input_sync(), the driver appears to read
header.report_length bytes into shid->input->body. Furthermore, in
spi_hid_response_handler(), memcpy copies body.content_len bytes into
shid->response->content.

Since these lengths are provided by the device, could a malicious or
malfunctioning device send a larger length and overflow the allocated heap
buffers?

[ ... ]

> +static int spi_hid_ll_start(struct hid_device *hid)
> +{
> +	struct spi_device *spi =3D hid->driver_data;
> +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> +	int error =3D 0;
> +	u16 bufsize =3D 0;
> +
> +	spi_hid_find_max_report(hid, HID_INPUT_REPORT, &bufsize);
> +	spi_hid_find_max_report(hid, HID_OUTPUT_REPORT, &bufsize);
> +	spi_hid_find_max_report(hid, HID_FEATURE_REPORT, &bufsize);
> +
> +	if (bufsize < HID_MIN_BUFFER_SIZE) {
> +		dev_err(&spi->dev,
> +			"HID_MIN_BUFFER_SIZE > max_input_length (%d)\n",
> +			bufsize);
> +		return -EINVAL;
> +	}

[Severity: High]
Does this check unconditionally reject standard HID devices (like mice or
keyboards) that legitimately have maximum report sizes smaller than
HID_MIN_BUFFER_SIZE (64 bytes)?

Should the driver enforce a minimum allocation size (for example, by padding
bufsize) instead of refusing to probe the device?

[ ... ]

> +static int spi_hid_ll_raw_request(struct hid_device *hid,
> +				  unsigned char reportnum, __u8 *buf,
> +				  size_t len, unsigned char rtype, int reqtype)
> +{
> +	struct spi_device *spi =3D hid->driver_data;
> +	struct spi_hid *shid =3D spi_get_drvdata(spi);
> +	struct device *dev =3D &spi->dev;
> +	int ret;
> +
> +	switch (reqtype) {

[ ... ]

> +	case HID_REQ_GET_REPORT:
> +		ret =3D spi_hid_get_request(shid, reportnum);

[Severity: High]
After spi_hid_get_request() returns, shid->output_lock is no longer held.
Could another thread concurrently call spi_hid_ll_raw_request() or
spi_hid_ll_output_report(), acquire the lock, and overwrite shid->response
before the current thread copies it?

> +		if (ret) {
> +			dev_err(dev, "failed to get report\n");
> +			return ret;
> +		}
> +
> +		ret =3D min_t(size_t, len,
> +			    (shid->response->body[1] | (shid->response->body[2] << 8)) + 1);
> +		buf[0] =3D shid->response->body[3];
> +		memcpy(&buf[1], &shid->response->content, ret);

[Severity: High]
Does this memcpy() cause an out-of-bounds write of 1 byte?

The code copies 'ret' bytes starting at '&buf[1]', which means it writes a
total of 'ret + 1' bytes into 'buf'. If 'ret' equals the allocated buffer
size 'len', it will write 'len + 1' bytes. Should the memcpy length
parameter be 'ret - 1'?

> +		break;
> +	default:
> +		dev_err(dev, "invalid request type\n");
> +		return -EIO;
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D4
