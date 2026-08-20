Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E83432BC6
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225523; cv=none; b=iyoEQvyC1AAPf+hhk3J+Gbby1FkgIm7n3TekLv0tKtZ6jGebZS32utGdSDEMKTb4cGuNTEjt3rkTZPjzM+d7TdYO2c3yYH7vhvQsd5bLLzU7P7s7qMiCop9XVVwnGs8qww4Ta43k3cQNWMAWFTjfeNYwExNbY3ZKYfEVRsgC9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225523; c=relaxed/simple;
	bh=7kABu0ux8KsNG00bIY6bSBMdPMJ1tQEbWrpC3BBGtZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y0Kw+yLwbDF2SSb5H4+mhJ1m04Pwu0UQ7MCPkdUVV51G1pF3OA+2JxJz+7q1b3UoitOZiBFBOjYC6CNU3oi4ty2lzEXx1o2PKdmOF5FmBShm2ic3k0cqFg0gxHUvpIu1/C+VqdAJfm4LiN0Gp0LoWQEN/lB5jigma1U1TK5rbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqI2aXsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqI2aXsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17AC1F32A93;
	Thu, 20 Aug 2026 11:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787225493;
	bh=wfCPCTp7Lnq7RhYeI4lkM6wNTlnb3ddbbB1Uknzy16Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqI2aXsxzMQMfDqtLAW9RxIgcVutG16CTnus7lmJM5S9FLFMR0nJLfaSBnZbbJCjk
	 8OeWkQx8MU1s8s3ImhLFPtamK1k2ns1i/VZZA4FDMUX7qAUUVWsrFrEwcp2df7Z/Xz
	 PkVayOAs+B9xhB3SScm/i9Mj0sPq9KLvTDrQZdSkNnZ9U7fE1VcSyewNqgHVwqDLo7
	 I3v92dJl8QGC/iWz5su2+EA5HEnyj+L9lQUaSo5cstGRN4SOS9mideZaYnLUeWzFoB
	 hXiegISh/IRwOBmlShnFSyxzg2+1zd8PnTEzkMC+tM1JO1IIXSubXFgxw/q3ghQ+2y
	 OrECqGe6mKMVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: intel-thc-hid: intel-quickspi: size the input
 buffer for the DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260820111558.475304-2-sammiee5311@gmail.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
 <20260820111558.475304-2-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:31:33 +0000
Message-Id: <20260820113133.B17AC1F32A93@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow in intel-quicki2c when receiving oversized DM=
A packets.
- [High] Out-of-bounds kernel memory read in intel-quicki2c leading to an i=
nformation leak.
- [High] Use-After-Free of DMA buffers during driver teardown due to missin=
g IRQ synchronization.
- [Medium] Transport drivers violate HID subsystem guidelines by using the =
unsafe hid_input_report API.
--

--- Patch [1]: [PATCH 1/2] HID: intel-thc-hid: intel-quickspi: size the inp=
ut buffer for the DMA ---
commit b291dd6cc5d97a1fbb9fb9824d1d976e0d317c24
Author: HyeongJun An <sammiee5311@gmail.com>

HID: intel-thc-hid: intel-quickspi: size the input buffer for the DMA

quickspi_alloc_report_buf() sizes input_buf from max_input_len, but the
RXDMA2 channel it feeds is programmed with ALIGN(max_input_len, SZ_4K):
quickspi_dma_init() passes the raw value and dma_set_max_packet_size()
rounds it up.  setup_dma_buffers() maps that rounded size and
read_dma_buffer() bounds the message against it, so a controller
reporting max_input_len 64 and rep_desc_len 600 gets a 600 byte buffer
behind a 4096 byte DMA.  thc_rxdma_read() has no capacity argument, so
nothing downstream can catch it.

> The intel-quicki2c sibling floors its input buffer at SZ_4K for this
> reason, with the comment "give default 4K buffer to avoid DMA buffer
> overrun".  Round up the same way the DMA does.

[Severity: High]
This isn't a bug introduced by this patch, but does intel-quicki2c actually
suffer from the same DMA buffer overrun you are fixing here?

Looking at `quicki2c_alloc_report_buf()` in `pci-quicki2c.c`, `input_buf` is
allocated using `max(..., SZ_4K)` instead of `ALIGN(..., SZ_4K)`:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:quicki2c_alloc_repo=
rt_buf() {
	max_report_len =3D max(le16_to_cpu(qcdev->dev_desc.max_input_len), SZ_4K);
	qcdev->input_buf =3D devm_kzalloc(qcdev->dev, max_report_len, GFP_KERNEL);
}

If a device declares a `max_input_len` of 5000 bytes, `input_buf` will be s=
ized
to exactly 5000 bytes. However, `thc_dma_set_max_packet_sizes()` unconditio=
nally
rounds the DMA RX size up to the next 4K boundary (8192 bytes).

When an oversized packet arrives, `thc_rxdma_read()` validates it against t=
he
8192-byte limit and copies the excess data into the smaller 5000-byte
`input_buf`, which seems to overflow it:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
	if (mes_len > read_config->max_packet_size) { ... }
	...
	ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
}

Could `intel-quicki2c` be updated to use `ALIGN()` as well?


[Severity: High]
This is a pre-existing issue, but can a malicious device cause an out-of-bo=
unds
read by sending a short physical packet with a maliciously large length hea=
der?

In `handle_input_report()` of `pci-quicki2c.c`, the driver reads an interru=
pt
payload via `thc_rxdma_read()`, which populates `report_len` with the actual
number of bytes transferred. However, the driver directly uses the
device-provided length field `pkt->len` from the packet header:

drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:handle_input_report=
() {
	quicki2c_hid_send_report(qcdev, pkt->data, HIDI2C_DATA_LEN(le16_to_cpu(pkt=
->len)));
}

If `pkt->len` exceeds `report_len`, does the HID core read past the valid p=
acket
data bounds into adjacent kernel heap memory?


> Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC Qu=
ickSPI driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
>=20
> ---
> drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 89226f5ce45e0..9ef33574c202b 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c

[ ... ]

> @@ -549,8 +550,12 @@ static int quickspi_alloc_report_buf(struct quickspi=
_device *qsdev)
>  	if (!qsdev->report_descriptor)
>  		return -ENOMEM;
> =20
> -	max_input_len =3D max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
> -			    le16_to_cpu(qsdev->dev_desc.max_input_len));
> +	/*
> +	 * thc_dma_set_max_packet_sizes() rounds the RXDMA2 packet size up to
> +	 * 4K, so the DMA can hand back more than max_input_len bytes.
> +	 */
> +	max_input_len =3D max_t(size_t, le16_to_cpu(qsdev->dev_desc.rep_desc_le=
n),
> +			      ALIGN(le16_to_cpu(qsdev->dev_desc.max_input_len), SZ_4K));
> =20
>  	qsdev->input_buf =3D devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL=
);
>  	if (!qsdev->input_buf)

[Severity: Medium]
This isn't a bug introduced by this patch, but should the transport drivers
be using `hid_safe_input_report()` instead of `hid_input_report()`?

According to HID subsystem guidelines, low-level transport drivers feeding =
raw
data from interrupt handlers should use the safe variant. Currently, both
`intel-quickspi` and `intel-quicki2c` use the unsafe API:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c:quickspi_hid_send_r=
eport() {
	ret =3D hid_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data, data_len,=
 1);
}

Because the allocated size of the input buffer is not provided, the core
cannot strictly validate if the reported payload fits inside the backing bu=
ffer
allocation.


[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during dri=
ver
teardown if an active IRQ handler executes concurrently?

During `quickspi_remove()`, the driver unconfigures the hardware and frees
the DMA allocations:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_remove() {
	quickspi_dev_deinit(qsdev);
	quickspi_dma_deinit(qsdev);
}

However, the driver relies on `devm_request_threaded_irq()` for cleanup, wh=
ich
only executes after the `remove` function returns. There appears to be no
synchronous wait (like `disable_irq()` or `free_irq()`) to stop a currently
running threaded handler.

If the handler is executing or preempted, could it resume and call
`thc_rxdma_read()`, accessing the now-freed DMA structures?

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_irq_thread=
_handler() {
	ret =3D thc_rxdma_read(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf, &input=
_len, &read_finished);
}

The `intel-quicki2c` driver seems to have the exact same teardown sequence =
in
`quicki2c_remove()`. Does the IRQ handler need to be explicitly stopped bef=
ore
freeing the DMA buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820111558.4753=
04-1-sammiee5311@gmail.com?part=3D1
