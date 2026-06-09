Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF98231832;
	Tue,  9 Jun 2026 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980915; cv=none; b=TzT+OTkfOLMdFZjPOO3XQLU0/6WFNZm56NvTc59RE4gb9ia5/anAq4jN1JqUKXGb0UU887ZhzN+K6nS92HzK8zK9RCDa1I75I+TXmOmfFYO1SR3QzVzLRIqDoOGJHjduVR4FLEIOu2MwHd8Acc4QUsCzB1NRjniBEIQwZwugjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980915; c=relaxed/simple;
	bh=0tAUv1ufAQetG8pYtRR1hW2a+7Recg4qQCoMziZxEV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQ4zD+GxO/BOpyO8Va8m15nKyzr4sCr3V/KPqv6BbQoFit2u/9AMv0kEISI7sWltr2TlNICvPRJe+FvBxa3gXg2vN5uohiMyeG68GfMXM1L4vURJlb2olNH16LGfb2ocGktD6F0Z9onnXPofIitRvrT/6JoVeczWI013pq6V+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+2TN+Gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+2TN+Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13AC1F00893;
	Tue,  9 Jun 2026 04:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980913;
	bh=kFYhtclELReS+sTzF5ORnJY+X7XoHYdwJNQBI3V3TEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+2TN+GbapBgcP9T3LczQie095yvUqgiCA9I4Z4DTmzLiDdctWAYZ9R5xbisZFBiX
	 xvyzquqhXvxrHsKm5enJ6/ogZIabuBFaxxZh3cbhHEQ9OxcCoc7HxtrXO9Dz9jXVJi
	 Q4ehhOHjq7o3CX8NKrY3AP0Au9xU8CDbMR6whvKaqP73F/2KrDpRePT2wjhdiNKHI9
	 EgBe4lzGYLQ9EU+VnVxzM7Xy/51o0DCSoodz9E506DyRbGcoOqKn54oIrvnmgBlnGA
	 aqdxB/mmLhnVudr6kumUCPGZ4KiWc7c1ecaK8PbdF7iu2jYDDkza/wq72mI85tWvBG
	 N6hLTNmL+9g2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] HID: spi_hid: add spi_hid traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260609-send-upstream-v4-6-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-6-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 04:55:12 +0000
Message-Id: <20260609045512.C13AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The `____cacheline_aligned` attribute was dropped from the DMA-saf=
e transfer buffers `read_approval_header` and `read_approval_body` when the=
 `spi_hid` struct was moved to a header file. This can lead to DMA cache co=
herency issues and memory corruption on architectures with non-coherent cac=
hes.
- [Medium] The `trace_spi_hid_input_sync` tracepoint logs the contents of t=
he receive buffer (`rx_buf`) *before* the SPI transfer completes, leaking u=
ninitialized heap memory or stale data from previous transfers.

Pre-existing issues:
- [Critical] A missing bounds check on `header.report_length` against the d=
ynamically allocated buffer size allows a massive out-of-bounds DMA write, =
leading to a heap buffer overflow.
- [High] Concurrent reallocation of the shared `shid->input` buffer in `spi=
_hid_ll_parse` while the interrupt handler accesses it leads to a Use-After=
-Free.
- [High] Handling `HID_REQ_GET_REPORT` in `spi_hid_ll_raw_request` causes a=
n out-of-bounds write to the caller's buffer by exactly 1 byte.
- [High] Concurrent overwriting of `shid->response` by the IRQ handler whil=
e a waiting thread is actively processing it leads to data corruption.
--

commit 2915829fcdae73aed3b7b4c76739fccf90310d7d
Author: Jingyuan Liang <jingyliang@chromium.org>

    HID: spi_hid: add spi_hid traces
   =20
    Add traces for purposed of debugging spi_hid driver.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index f6ea2d4365a70..ef527999d6dc6 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> @@ -295,6 +225,11 @@ static int spi_hid_input_sync(struct spi_hid *shid, =
void *buf, u16 length,
>  	spi_message_init_with_transfers(&shid->input_message,
>  					shid->input_transfer, 2);
> =20
> +	trace_spi_hid_input_sync(shid,	shid->input_transfer[0].tx_buf,
> +				 shid->input_transfer[0].len,
> +				 shid->input_transfer[1].rx_buf,
> +				 shid->input_transfer[1].len, 0);
> +
>  	error =3D spi_sync(shid->spi, &shid->input_message);

[Severity: Medium]
Does this tracepoint log the contents of the receive buffer before the SPI
transfer actually completes? Since spi_sync() hasn't executed yet, it appea=
rs
this will blindly copy uninitialized heap memory or stale data from previous
transfers into the trace output.

[ ... ]
> @@ -528,6 +468,8 @@ static int spi_hid_input_report_handler(struct spi_hi=
d *shid,
>  static void spi_hid_response_handler(struct spi_hid *shid,
>  				     struct input_report_body_header *body)
>  {
> +	trace_spi_hid_response_handler(shid);
> +
>  	shid->response_length =3D body->content_len;
>  	/* completion_done returns 0 if there are waiters, otherwise 1 */
>  	if (completion_done(&shid->output_done)) {

[Severity: High]
This is a pre-existing issue, but is the completion_done() check sufficient
to protect against data corruption?

When a waiting thread wakes up from wait_for_completion_interruptible_timeo=
ut()
in spi_hid_sync_request(), the completion's internal done count is decremen=
ted
to 0. A newly arriving interrupt will see completion_done() =3D=3D 0, and w=
ill
overwrite shid->response while the awakened thread is concurrently reading =
it
outside of the output_lock.

[ ... ]
> @@ -867,6 +815,9 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_sh=
id)
>  	struct spi_hid_input_header header;
>  	int error =3D 0;
> =20
> +	trace_spi_hid_dev_irq(shid, irq);
> +	trace_spi_hid_header_transfer(shid);
> +
>  	scoped_guard(mutex, &shid->io_lock) {

[Severity: High]
This is a pre-existing issue, but does concurrent buffer reallocation in
spi_hid_ll_parse() lead to a use-after-free here?

spi_hid_ll_parse() calls spi_hid_alloc_buffers() (which uses devm_krealloc(=
))
without disabling the IRQ or holding the io_lock. If devm_krealloc() frees
the old buffer while the IRQ handler is concurrently configuring DMA transf=
ers
into shid->input, will the IRQ handler write into freed memory?

[ ... ]
> @@ -916,6 +874,12 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_s=
hid)
>  			goto out;
>  		}
> =20
> +		trace_spi_hid_input_body_complete(shid, shid->input_transfer[0].tx_buf,
> +						  shid->input_transfer[0].len,
> +						  shid->input_transfer[1].rx_buf,
> +						  shid->input_transfer[1].len,
> +						  shid->input_message.status);
> +
>  		if (shid->input_message.status < 0) {

[Severity: Critical]
This is a pre-existing issue, but is there a missing bounds check that could
lead to an out-of-bounds DMA write?

In spi_hid_bus_validate_header(), the validation only checks if
header.report_length > shid->desc.max_input_length. If a malicious device
advertises a max_input_length of 0, the check is bypassed entirely. The dri=
ver
then unconditionally performs a DMA read of header.report_length bytes into
shid->input->body, which could overflow the dynamically allocated bufsize.

[Severity: High]
This is a pre-existing issue elsewhere in this file, but does handling
HID_REQ_GET_REPORT in spi_hid_ll_raw_request() cause an out-of-bounds write?

In spi_hid_ll_raw_request():

    ret =3D min_t(size_t, len,
                (shid->response->body[1] | (shid->response->body[2] << 8)) =
+ 1);
    buf[0] =3D shid->response->body[3];
    memcpy(&buf[1], &shid->response->content, ret);

The driver writes the 1-byte ID to buf[0] and then copies ret bytes into
&buf[1], meaning it writes a total of ret + 1 bytes. If ret equals the
caller's buffer size (len), doesn't this overflow the destination buffer by
exactly 1 byte?

> diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi=
-hid-core.h
> new file mode 100644
> index 0000000000000..293e2cfcfbf74
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid-core.h
[ ... ]
> @@ -0,0 +1,91 @@
> +/* Driver context */
> +struct spi_hid {
[ ... ]
> +	struct completion output_done;
> +
> +	u8 read_approval_header[SPI_HID_READ_APPROVAL_LEN];
> +	u8 read_approval_body[SPI_HID_READ_APPROVAL_LEN];
> +
> +	u32 report_descriptor_crc32;	/* HID report descriptor crc32 checksum. */

[Severity: High]
When moving struct spi_hid to this new header, the ____cacheline_aligned
attribute was dropped from the read_approval_header and read_approval_body
buffers.=20

Could this lead to DMA cache coherency issues and memory corruption on
architectures with non-coherent caches, since these arrays might now share
cachelines with adjacent fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D6
