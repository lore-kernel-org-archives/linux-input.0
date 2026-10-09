Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2329A37F73A;
	Fri,  9 Oct 2026 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585737; cv=none; b=Ku9wSYM9cdCgAwPTP5gYZuWhvi3qu2k32XFqe/i2WIZEZZKf3EpXOQF4Lub8wKAyLbGbHXy6XyPU3fr+Zq2XqQpRIfmk2wQHMcHnHB8flXe1W1AJAvPeDbSxnGacZKJQlPRHmTIOdTiZKTO8LyELbzMZ8/dTcwDVCQ59jFtF4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585737; c=relaxed/simple;
	bh=9T7Jbaw86Dipe3n9n3/Adh5lQpbhxhYSq9pRzceD/Cc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=saaLSAloh5Qq/yOBbTt9WkslWBJu8pxV3/fGcR9DQWoEvRXsAXje/ILK6L9hJxxfEQm8/hHqDUcJVGjX/G1PsuXm3RLxfFgpSDKEMQerZF/JxQ1pNalx5KnWh4OgI6m7tEWiEAzJlZvDB+rMx7AJoS5SagFcnEpq8sFTmFZccBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CicUglhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CicUglhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A8F1F000FF;
	Fri,  9 Oct 2026 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791585735;
	bh=YTBG9TBiWek4ocZrBBwzHrrjyx7+s+A9a+uDLxEiDRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CicUglhjQpJo3F+galnvWaCI/ZTxPxavZnWNiAyehApi34/mFNnmpCeAoAwvDKkVR
	 aorO6tyNISNLTMjvW/UoZqg6KfRDwYRCyVySxlOh9UyljGlI8l5TLLMULYKdZ4txnW
	 9l2ilLi25BevOSdLKqCkSn81xUI6gyXCmduQ31Enfm2+vwY+uJaljeh6rclAs0oi7r
	 inQmwY6lbmhdze+SsaONda89wUkeZaLC23otFzuklnxyDYAMdj75BNLkyDqNHVfUtZ
	 doAuBi/A49aWsRLLZ6MiIY8GWre8DzVAR9zQUElgEsfw760GCbPh8p42ctbOWPHTHd
	 LlF80UoJapmHQ==
Message-ID: <sashiko-outbox-166153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] HID: spi-hid: add HID SPI protocol
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20261009-send-upstream-v5-5-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-5-384af01da3ee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:42:14 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] hid: sleeping in atomic context via synchronous output_report
- [High] spi: dma: unaligned DMA transfer buffers cause memory corruption
- [High] hid: spi-hid: use-after-free of transport buffers on concurrent re=
alloc
- [Medium] hid: spi-hid: SPI_HID_REFRESH_IN_PROGRESS breaks hid_device_io_s=
tart() during probe
--

commit 4647f83267b811c038d6b541aee03ea186664da4
Author: Jingyuan Liang <jingyliang@chromium.org>
Subject: HID: spi-hid: add HID SPI protocol implementation

This commit adds a new driver for the HID over SPI protocol. It supports
basic input and output reports but omits features like multi-fragment
reports and power states.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> +static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 lengt=
h,
> +			      bool is_header)
> +{
> +	int error;
> +
> +	shid->input_transfer[0].tx_buf =3D is_header ?
> +					 shid->read_approval_header :
> +					 shid->read_approval_body;
> +	shid->input_transfer[0].len =3D SPI_HID_READ_APPROVAL_LEN;
> +
> +	shid->input_transfer[1].rx_buf =3D buf;

[Severity: High]
Could this cause memory corruption on non-cache-coherent architectures?

The read_approval_body is a 5-byte array that immediately follows
read_approval_header in struct spi_hid. Since it starts at an unaligned
5-byte offset, passing it as tx_buf to the DMA sync path violates
architecture DMA API rules.

The rx_buf parameter also receives unaligned memory when buf is passed as
shid->input->body later in the IRQ handler, which starts 4 bytes after the
dynamically allocated input header. This can trigger CONFIG_DMA_API_DEBUG
warnings or corrupt adjacent memory.

[ ... ]
> +static int __spi_hid_send_output_report(struct spi_hid *shid,
> +					struct spi_hid_output_report *report,
> +					u8 expected_response)
> +{
> +	struct spi_hid_output_buf *buf =3D shid->output;
> +	struct device *dev =3D &shid->spi->dev;
> +	u16 report_length;
> +	u16 padded_length;
> +	u8 padding;
> +	int error;
> +
> +	lockdep_assert_held(&shid->output_lock);

[Severity: High]
Is there a potential use-after-free here if the output buffer is reallocated
concurrently?

When the HID core calls spi_hid_ll_start() dynamically from userspace or
BPF, it expands the transport buffers by calling spi_hid_alloc_buffers()
if the report sizes have increased. This reallocation uses devm_krealloc()
to free shid->output and replace it.

However, spi_hid_ll_start() does not appear to acquire shid->output_lock
before reallocating. If a spontaneous device reset interrupt schedules
reset_work on a global worker thread:

spi_hid_reset_work()
  spi_hid_reset_response()
    spi_hid_sync_request()
      __spi_hid_send_output_report()

This path can execute concurrently, accessing the freed shid->output buffer
under the lock, leading to a use-after-free when writing the header and
payload.

[ ... ]
> +static int spi_hid_send_output_report(struct spi_hid *shid,
> +				      struct spi_hid_output_report *report)
> +{
> +	guard(mutex)(&shid->output_lock);
> +	return __spi_hid_send_output_report(shid, report, 0);
> +}
> +
> +static int __spi_hid_sync_request(struct spi_hid *shid,
> +				  struct spi_hid_output_report *report)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	int error;
> +
> +	error =3D __spi_hid_send_output_report(shid, report,
> +					     spi_hid_response_type(report->report_type));

[Severity: High]
Does this sleeping lock violation trigger scheduling while atomic warnings?

According to the HID subsystem guidelines, the low-level output_report
callback is used for high-throughput data on the interrupt channel and
must be asynchronous.

When spi_hid_ll_output_report() calls spi_hid_send_output_report() or
spi_hid_sync_request(), these helpers immediately acquire shid->output_lock
(a sleeping mutex) and perform a synchronous, blocking SPI transfer. Since
the callback can be invoked from atomic contexts (like updating LED states
from an input event handler), sleeping here may cause panics.

[ ... ]
> +static int spi_hid_input_report_handler(struct spi_hid *shid,
> +					struct spi_hid_input_buf *buf)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	struct hid_device *hid;
> +	struct spi_hid_input_report r;
> +	int error =3D 0;
> +
> +	scoped_guard(mutex, &shid->io_lock) {
> +		if (!test_bit(SPI_HID_READY, &shid->flags) ||
> +		    !test_bit(SPI_HID_STARTED, &shid->flags) ||
> +		    test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) || !shid->hid)=
 {
> +			dev_dbg(dev, "HID not ready (flags 0x%lx), dropping input report\n",
> +				shid->flags);
> +			return 0;
> +		}

[Severity: Medium]
Will this prevent drivers from receiving input reports during probe?

When spi_hid_refresh_device() is executed, it sets the
SPI_HID_REFRESH_IN_PROGRESS flag before tearing down the old HID device
and creating the new one:

spi_hid_refresh_device()
  set_bit(SPI_HID_REFRESH_IN_PROGRESS, ...)
  spi_hid_create_device()
    hid_add_device()
      -> driver probe()

During this entire time, the input report handler will drop all incoming
reports. This conflicts with the HID core API contract, which explicitly
allows a driver to receive inputs during its probe phase by calling
hid_device_io_start(). A driver that requires a firmware handshake or
data during probe could hang or fail upon device refresh.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-upstr=
eam-v5-0-384af01da3ee@chromium.org?part=3D5
