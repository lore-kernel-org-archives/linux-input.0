Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CB592B84
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420563; cv=none; b=YpJ2mIHGQvelCqnlwG/OQKl/qLkAzKpfDoc5sWOArVlyjrMIaTNhPHlD1FvaItB76ws92iiixL26/1Wld0Z7FWX09D8C02Z4g0/pXJGUeOO/ldt5MPbMu0cHlWuKOdHMqBPjk0XkkyDS1QOJawXuoeNMdii0Yypwre2uY4LM9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420563; c=relaxed/simple;
	bh=GlA7ApQ1YEs53kh/B3CFNGcWLMtdfnSoqdKc7DcdG4k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SgQsuKd7h2/oz5Z2im3gOQORecIurdRsx3kRgBHtlYldQ4Cpz3/3vPlewXcbVl+OyduqfHqH7al/jWKDsIvCK4nNXGn5loTPOI1Fs/hzZ+Hl0o6EuZE3BAzxWZWZu9D3Ojs875ui4PiAqX343dDG7prTG+OqIl46vKKgRPlepXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm6wKQQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm6wKQQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBDF1F000C5;
	Mon, 19 Oct 2026 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420560;
	bh=LxywffUEyeNoD90uYb0mxih3AWrWtLH2abmm+80ouw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zm6wKQQB+Bak4zHmDyotaxxZUp/0zZe0OIrbChf6452+Rj1PPvHzvlQl2f03FBqtt
	 p7NSWHAS0su+0JkkcQqbenExxZUSF69T96FxC97Q9KIdOs9ulTS/k+oyCPF8ATnFfw
	 kLyNCABKAWjq4Qt4feLBygFth7v5TJvSODgkFmagrYaKQ4QbIBwDIOplaB/JPDedJI
	 p+engDH48DEZubdQD5QyBj2jovSfJCXztEFpChTwqvasN8MsuXlc7j7b7T2/vHWc0K
	 AnDT55h78KfgHyPMGvAzBC/0VC9cd0X8GxjqJCxM1cW1diktFs1Aw43bc0+6NmHQSa
	 99QlUOzkVbZew==
Message-ID: <sashiko-outbox-177440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] HID: Intel-thc-hid: Intel-quicki2c: Fix
 buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019135441.1420968-123-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-123-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:35:59 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] HID: quicki2c: input_buf size mismatch with DMA in quicki2c_alloc_=
report_buf()
- [Medium] HID: intel-thc-hid: incomplete report_buf sizing in quicki2c_all=
oc_report_buf()
--

commit 916fd20197b9aebc1d04d169b7d6a4523c3d0a4d
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Fix buffer overflow

This commit enlarges the qcdev->input_buf and qcdev->report_buf allocations
in quicki2c_alloc_report_buf() by wrapping max_report_len with
HIDI2C_PACKET_LEN() to account for the 2-byte HID-over-I2C packet length
header.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index c6ba6886072ad..4588c55cf255d 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -586,7 +586,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_=
device *qcdev)
>  	 */
>  	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4=
K);
> =20
> -	qcdev->input_buf =3D devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNE=
L);
> +	qcdev->input_buf =3D devm_kzalloc(qcdev->dev,
> +					HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);

[Severity: High]
Can qcdev->input_buf still be overflowed or mismatched with the DMA packet
limits when reading reports into it?

In drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c, read_dma_buffer()
bounds-checks the incoming DMA transfer only against
read_config->max_packet_size before copying into read_buff
(qcdev->input_buf):

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
	prd_tbl =3D &read_config->prd_tbls[prd_table_index];
	mes_len =3D calc_message_len(prd_tbl, &nent);
	if (mes_len > read_config->max_packet_size) {
		...
		return -EMSGSIZE;
	}

	sg =3D read_config->sgls[prd_table_index];
	ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
}

Meanwhile, quicki2c_dma_init() and quicki2c_dma_adv_enable() in
drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c configure the DMA
and hardware frame limits using the raw max_input_len and report_desc_len
without HIDI2C_PACKET_LEN():

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_dma_init()=
 {
	swdma_max_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len),
			    le16_to_cpu(qcdev->dev_desc.report_desc_len));

	ret =3D thc_dma_set_max_packet_sizes(qcdev->thc_hw, 0,
					   le16_to_cpu(qcdev->dev_desc.max_input_len),
					   le16_to_cpu(qcdev->dev_desc.max_output_len),
					   swdma_max_len);
}

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_dma_adv_en=
able() {
	if (qcdev->i2c_max_frame_size_enable) {
		if (qcdev->i2c_max_frame_size >=3D
		    le16_to_cpu(qcdev->dev_desc.max_input_len)) {
			thc_i2c_set_rx_max_size(qcdev->thc_hw,
						le16_to_cpu(qcdev->dev_desc.max_input_len));
}

Because dma_set_max_packet_size() rounds max_packet_size up with
ALIGN(size, SZ_4K), this leaves three mismatches on the
quicki2c_irq_thread_handler() -> handle_input_report() -> thc_rxdma_read()
and quicki2c_hid_raw_request() -> quicki2c_get_report() -> thc_swdma_read()
paths:

1. If report_desc_len is larger than max(max_input_len, SZ_4K) + 2,
THC_SWDMA has max_packet_size =3D ALIGN(report_desc_len, SZ_4K) while
qcdev->input_buf is only max(max_input_len, SZ_4K) + 2 bytes, so
quicki2c_get_report() calling thc_swdma_read() with prd_tbl_len =3D NULL can
copy past the end of qcdev->input_buf.

2. If max_input_len > SZ_4K and is not within 2 bytes of a 4K multiple (for
example, 4100), qcdev->input_buf is 4102 bytes while THC_RXDMA2 and
THC_SWDMA have max_packet_size =3D 8192 bytes, allowing read_dma_buffer() to
overflow qcdev->input_buf if a larger DMA transfer arrives.

3. If max_input_len is 4095 or an exact multiple of SZ_4K (such as 4096),
passing raw max_input_len to thc_dma_set_max_packet_sizes() and
thc_i2c_set_rx_max_size() leaves the DMA buffer and RX max frame size at
4096 or 4095 bytes, whereas a full-size input packet with its 2-byte length
header requires 4098 or 4097 bytes.

Should quicki2c_dma_init(), quicki2c_dma_adv_enable(), and the
qcdev->input_buf allocation all use consistent packet sizes?

>  	if (!qcdev->input_buf)
>  		return -ENOMEM;
> =20
> @@ -596,7 +597,8 @@ static int quicki2c_alloc_report_buf(struct quicki2c_=
device *qcdev)
>  	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_output_len),
>  			     max_report_len);
> =20
> -	qcdev->report_buf =3D devm_kzalloc(qcdev->dev, max_report_len, GFP_KERN=
EL);
> +	qcdev->report_buf =3D devm_kzalloc(qcdev->dev,
> +					 HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);
>  	if (!qcdev->report_buf)
>  		return -ENOMEM;
> =20

[Severity: Medium]
Does enlarging qcdev->report_buf by HIDI2C_PACKET_LEN(max_report_len) allow
maximum-length output or feature reports to succeed?

At the end of quicki2c_alloc_report_buf(), qcdev->report_len is still set
to max_report_len:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_alloc_repo=
rt_buf() {
	qcdev->report_buf =3D devm_kzalloc(qcdev->dev,
					 HIDI2C_PACKET_LEN(max_report_len), GFP_KERNEL);
	if (!qcdev->report_buf)
		return -ENOMEM;

	qcdev->report_len =3D max_report_len;
}

When write_cmd_to_txdma() or quicki2c_get_report() in
drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c formats a
packet into qcdev->report_buf, it passes qcdev->report_len as write_buf_len
to quicki2c_init_write_buf():

drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c:write_cmd_to_t=
xdma() {
	ret =3D quicki2c_init_write_buf(qcdev, cmd, cmd_len, buf ? true : false, b=
uf,
				      buf_len, qcdev->report_buf, qcdev->report_len);
}

And quicki2c_init_write_buf() prepends cmd_reg (HIDI2C_REG_LEN =3D 2 bytes),
cmd (HIDI2C_CMD_LEN =3D 2 bytes, or HIDI2C_CMD_LEN_OPT =3D 3 bytes when
report_id >=3D 15), data_reg (HIDI2C_REG_LEN =3D 2 bytes), and the packet
length header (HIDI2C_LENGTH_LEN =3D 2 bytes) before checking against
write_buf_len:

drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c:quicki2c_init_=
write_buf() {
	buf_len =3D HIDI2C_REG_LEN + cmd_len;

	if (append_data_reg)
		buf_len +=3D HIDI2C_REG_LEN;

	if (data && data_len)
		buf_len +=3D data_len + HIDI2C_LENGTH_LEN;

	if (buf_len > write_buf_len)
		return -EINVAL;
}

Because qcdev->report_len is left at max_report_len, the extra 2 bytes in
qcdev->report_buf cannot be used, and because quicki2c_init_write_buf()
writes 8 to 9 bytes of framing ahead of data_len, HIDI2C_PACKET_LEN() (only
2 extra bytes) is still 6 to 7 bytes short for a payload of max_report_len
bytes, causing quicki2c_init_write_buf() to return -EINVAL.

Should qcdev->report_buf and qcdev->report_len both be sized to include the
full command, register, and packet length headers written by
quicki2c_init_write_buf()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-123-sashal@kernel.org?part=3D1
