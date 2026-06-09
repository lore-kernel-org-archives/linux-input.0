Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433032B9A8;
	Tue,  9 Jun 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981206; cv=none; b=hsO+5hMfL92+eQs3MZ/S96o2q2A1rga4CBZ6l2tEnuOJA0xBjPocBxdSqZNrxLx0FEBP+GdEnvRL41NybxC1Z5QFUz//6MAnl1Yv3wqTra+GTBh+3tcgShFgai4dY58thNg8rZkXG0TJeif23JTIT9ZyC55LEbx/PWYIGlGQFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981206; c=relaxed/simple;
	bh=43TOeatrZOkH1SrfdyoflMfGNpLqJ1dYR6NUdnI2WfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G3aDDt70Qfb/9elIsDrN8ANFOymApTF5SJ/t8WB2KA2lUiPo7Ta6ZGcxHA5ZP2aCciVJe0ZgB+9XPOFOAG+3nOQ5aqe2uaevPD57zAUZv7PCdqrjUdOjTHyp64s6+EFasq/Bc2UVf9KGERAH11znZl+sUaSn5lKRt7xYny6mvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBftEo0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBftEo0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8A51F00898;
	Tue,  9 Jun 2026 05:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780981204;
	bh=XcVGmy+V4GnwOBRE4Ntf07jj8w/RsrsZOH2XDPlAk1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBftEo0C12QcoEgHyn/MEUb6uZttRYpoK05UbQ3MHxVI3bmCkul8QDp8kX7A4wWGG
	 H8+Obj5+eg62GEva1LV1dnq4gDg2ZRmTwkRKim3o8KxQn5n8IIqG4Pv6pOrkE1Y8Je
	 Wso3giE5DJ1XbRKtlp7fXwxNllqwKh0MAAZeK/HVtblRRPy0MUKTmJuy7PkHqbTEMT
	 tVU/U3D1UwKYg2lupMhfNhYM10M/rShpd23HhvVkSrx7d+UCU2XhKpq4TfOto3OylW
	 GewrzyDOdw2tutTmmd7JoWQ/k/w724lWXaML+2v51PYaxjm/W9zUFZwM9NSbdjV2P1
	 LyIVNXhxDwRdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] HID: spi-hid: add HID SPI protocol
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260609-send-upstream-v4-5-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-5-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:00:03 +0000
Message-Id: <20260609050003.DC8A51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [Critical] Missing validation of `report_length` against the allocated DM=
A buffer size allows an out-of-bounds write of up to ~64KB during SPI input=
 read.
- [Critical] Use-After-Free of `shid->input` DMA buffers via concurrent rea=
llocation and IRQ handling.
- [Critical] Out-of-bounds write in `spi_hid_response_handler` using device=
-supplied length.
- [High] Incorrect sizing of arrays in `struct spi_hid_input_buf` drops the=
 Report ID and causes an out-of-bounds read when reporting to the HID core.
- [High] Returning `IRQ_HANDLED` when the device is off without servicing t=
he interrupt causes an interrupt storm.
- [High] Missing power state update in `spi_hid_error_handler` abort path l=
eads to an infinite interrupt storm.
- [High] Use-After-Free (UAF) on driver unbind due to missing synchronizati=
on with active HID raw requests.
- [High] Holding `io_lock` over `hid_input_report` creates an ABBA lock inv=
ersion and potential self-deadlock with `output_lock`.
- [High] Missing validation of response type in `spi_hid_response_handler` =
leaks stale data to userspace.

Pre-existing issues:
- [High] Handling of `HID_REQ_GET_REPORT` in `spi_hid_ll_raw_request` copie=
s too many bytes into the output buffer, overflowing the caller's allocatio=
n by 1 byte and reading out of bounds.
- [Medium] Concurrent calls to `HID_REQ_GET_REPORT` cause a data race on th=
e shared `shid->response` buffer, corrupting data returned to userspace.
--

commit 49a8cad2bdbcc64aa9d451335312691879579a95
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add HID SPI protocol implementation

This driver follows HID Over SPI Protocol Specification 1.0 available at
https://www.microsoft.com/en-us/download/details.aspx?id=3D103325. The
initial version of the driver does not support: 1) multi-fragment input
reports, 2) sending GET_INPUT and COMMAND output report types and
processing their respective acknowledge input reports, and 3) device
sleep power state.

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index 72c2e1ce3e8d9..f6ea2d4365a70 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
@@ -187,15 +336,64 @@ static const char *spi_hid_power_mode_string(enum hid=
spi_power_state power_state
> +static void spi_hid_error_handler(struct spi_hid *shid)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	int error;
> +
> +	guard(mutex)(&shid->power_lock);
> +	if (shid->power_state =3D=3D HIDSPI_OFF)
> +		return;
> +
> +	guard(disable_irq)(&shid->spi->irq);
> +
> +	if (shid->reset_attempts++ >=3D SPI_HID_MAX_RESET_ATTEMPTS) {
> +		dev_err(dev, "unresponsive device, aborting\n");
> +		spi_hid_stop_hid(shid);
> +		shid->ops->assert_reset(shid->ops);
> +		error =3D shid->ops->power_down(shid->ops);
> +		if (error) {
> +			dev_err(dev, "failed to disable regulator\n");
> +			shid->regulator_error_count++;
> +			shid->regulator_last_error =3D error;
> +		}
> +		return;
> +	}

[Severity: High]
Does this error path need to update the power state?

When reset_attempts exceeds the maximum, this function powers down the
device and returns immediately without setting shid->power_state to
HIDSPI_OFF.

Because this function uses guard(disable_irq), returning automatically
re-enables the interrupt. Since the device is unpowered, it will assert
its IRQ line and trigger the handler again. Since power_state is still
HIDSPI_ON, can this cause an infinite interrupt storm?

[ ... ]
@@ -263,6 +462,88 @@ static int spi_hid_sync_request(struct spi_hid *shid,
> +static int spi_hid_input_report_handler(struct spi_hid *shid,
> +					struct spi_hid_input_buf *buf)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	struct spi_hid_input_report r;
> +	int error =3D 0;
> +
> +	guard(mutex)(&shid->io_lock);

[Severity: High]
Can this cause an ABBA lock inversion with output_lock?

This function holds io_lock before calling into the generic HID subsystem.
If a BPF program attached to the HID core synchronously triggers
hid_hw_raw_request during this call, it routes back to the driver
via spi_hid_ll_raw_request(), which calls spi_hid_sync_request()
(acquiring output_lock) and then __spi_hid_send_output_report(), which
attempts to acquire io_lock. Could this self-deadlock the thread?

> +
> +	if (!test_bit(SPI_HID_READY, &shid->flags) ||
> +	    test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) || !shid->hid) {
> +		dev_err(dev, "HID not ready\n");
> +		return 0;
> +	}
> +
> +	spi_hid_input_report_prepare(buf, &r);
> +
> +	error =3D hid_input_report(shid->hid, HID_INPUT_REPORT,
> +				 r.content - 1, r.content_length + 1, 1);

[Severity: High]
Does passing r.content - 1 drop the Report ID?

Looking at struct spi_hid_input_buf, the body array is sized to
SPI_HID_READ_APPROVAL_LEN (which is 5 bytes). However, the actual protocol
body header is only 4 bytes. This means the first byte of the content lands
in buf->body[4], while the Report ID is in buf->body[3].

Since this passes r.content - 1 (which points to buf->body[4]) to
hid_input_report, it completely skips the Report ID. Because it also passes
r.content_length + 1 as the size, does this read one byte past the end of
the received SPI transfer into uninitialized heap memory?

[ ... ]
> +static void spi_hid_response_handler(struct spi_hid *shid,
> +				     struct input_report_body_header *body)
> +{
> +	shid->response_length =3D body->content_len;
> +	/* completion_done returns 0 if there are waiters, otherwise 1 */
> +	if (completion_done(&shid->output_done)) {
> +		dev_err(&shid->spi->dev, "Unexpected response report\n");
> +	} else {
> +		if (body->input_report_type =3D=3D REPORT_DESCRIPTOR_RESPONSE ||
> +		    body->input_report_type =3D=3D GET_FEATURE_RESPONSE) {
> +			memcpy(shid->response->body, shid->input->body,
> +			       sizeof(shid->input->body));
> +			memcpy(shid->response->content, shid->input->content,
> +			       body->content_len);

[Severity: Critical]
Can this memcpy overflow the response buffer?

The memcpy uses body->content_len to copy data into
shid->response->content. While body->content_len is validated against
header.report_length elsewhere, that header length is only bounded by
shid->desc.max_input_length (up to 65535).

Since shid->response is only allocated to shid->bufsize (typically 2048),
can a device sending a large content length cause a heap buffer overflow?

> +		}
> +		complete(&shid->output_done);

[Severity: High]
Is it safe to unconditionally trigger completion here?

If an unexpected response (such as OUTPUT_REPORT_RESPONSE) arrives,
this completes shid->output_done without updating shid->response->content.
The waiting thread will then wake up and return success. Could this leak
stale kernel heap memory to userspace?

> +	}
> +}
[ ... ]
> +static int spi_hid_bus_validate_header(struct spi_hid *shid,
> +				       struct spi_hid_input_header *header)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	if (header->version !=3D SPI_HID_INPUT_HEADER_VERSION) {
> +		dev_err(dev, "Unknown input report version (v 0x%x)\n",
> +			header->version);
> +		return -EINVAL;
> +	}
> +
> +	if (shid->desc.max_input_length !=3D 0 &&
> +	    header->report_length > shid->desc.max_input_length) {
> +		dev_err(dev, "Input report body size %u > max expected of %u\n",
> +			header->report_length, shid->desc.max_input_length);
> +		return -EMSGSIZE;
> +	}

[Severity: Critical]
Does this header validation also need to check the allocated buffer size?

This validates header->report_length against shid->desc.max_input_length,
which can be up to 65535, but never validates it against the actually
allocated buffer size (shid->bufsize).

Later in spi_hid_dev_irq(), spi_hid_input_sync() will use this unvalidated
length for a DMA transfer directly into shid->input->body. Could a
malfunctioning device cause a massive kernel heap buffer overflow?

[ ... ]
@@ -371,9 +860,83 @@ static int spi_hid_set_request(struct spi_hid *shid, u=
8 *arg_buf, u16 arg_len,
> +static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
> +{
> +	struct spi_hid *shid =3D _shid;
> +	struct device *dev =3D &shid->spi->dev;
> +	struct spi_hid_input_header header;
> +	int error =3D 0;
> +
> +	scoped_guard(mutex, &shid->io_lock) {
> +		error =3D spi_hid_input_sync(shid, shid->input->header,
> +					   sizeof(shid->input->header), true);
> +		if (error) {
> +			dev_err(dev, "Failed to transfer header: %d\n", error);
> +			goto err;
> +		}
> +
> +		if (shid->power_state =3D=3D HIDSPI_OFF) {
> +			dev_warn(dev, "Device is off after header was received\n");
> +			goto out;
> +		}

[Severity: High]
Can returning IRQ_HANDLED here cause an interrupt storm?

If the device is unpowered, it may float its IRQ line, which is often
level-triggered. Returning IRQ_HANDLED without communicating with the
device to clear the interrupt prevents the spurious IRQ detector from
disabling it. Will this lead to an infinite re-triggering of the interrupt
and a hard lockup?

[ ... ]
> +		if (shid->input_message.status < 0) {
> +			dev_warn(dev, "Error reading body: %d\n",
> +				 shid->input_message.status);
> +			shid->bus_error_count++;
> +			shid->bus_last_error =3D shid->input_message.status;
> +			goto err;
> +		}
> +	}
> +
> +	error =3D spi_hid_process_input_report(shid, shid->input);

[Severity: Critical]
Is it safe to dereference shid->input outside of the io_lock?

This passes shid->input to spi_hid_process_input_report() entirely outside
of the io_lock scoped guard.

If a concurrent call to spi_hid_alloc_buffers() happens:

    tmp =3D devm_krealloc(dev, shid->input, inbufsize,
                        GFP_KERNEL | __GFP_ZERO);

This reallocates and frees the buffer while the device IRQ is fully enabled.
Could this lead to a use-after-free if an interrupt fires during or
immediately after the reallocation?

> +	if (error) {
> +		dev_err(dev, "Failed to process input report: %d\n", error);
> +		goto err;
> +	}
> +
> +out:
> +	return IRQ_HANDLED;

[ ... ]
@@ -762,6 +1335,9 @@ void spi_hid_core_remove(struct spi_device *spi)
>  	struct device *dev =3D &spi->dev;
>  	int error;
> =20
> +	disable_irq(spi->irq);
> +	cancel_work_sync(&shid->reset_work);
> +
>  	spi_hid_stop_hid(shid);
> =20
>  	shid->ops->assert_reset(shid->ops);

[Severity: High]
Does driver unbind safely synchronize with active HID raw requests?

This remove function disables the IRQ and destroys the HID device, returning
to allow devres to free the shid struct. However, hid_destroy_device() does
not serialize against active userspace ioctls in hidraw.

If a thread is blocked inside spi_hid_sync_request() holding
shid->output_lock and waiting on shid->output_done:

    error =3D wait_for_completion_interruptible_timeout(&shid->output_done,=
 ...);

Can it wake up after the timeout and access the freed shid memory, causing
a use-after-free?


[Severity: High]
This is a pre-existing issue, but does the handling of HID_REQ_GET_REPORT
overflow the caller's allocation?

Looking at spi_hid_ll_raw_request() from drivers/hid/spi-hid/spi-hid-core.c:

    case HID_REQ_GET_REPORT:
        ret =3D spi_hid_get_request(shid, reportnum);
        ...
        ret =3D min_t(size_t, len,
                    (shid->response->body[1] |
                     (shid->response->body[2] << 8)) + 1);
        buf[0] =3D shid->response->body[3];
        memcpy(&buf[1], &shid->response->content, ret);
        break;

If ret =3D=3D len, the memcpy writes len bytes starting at &buf[1], consumi=
ng
len + 1 bytes in total and overflowing the caller's buf by 1 byte.

It also reads ret bytes from shid->response->content, which only contains
ret - 1 valid payload bytes, causing a 1-byte out-of-bounds read.


[Severity: Medium]
This is a pre-existing issue, but does reading the shared response buffer
require synchronization?

In that same HID_REQ_GET_REPORT path in spi_hid_ll_raw_request(), the code
accesses shid->response->body and shid->response->content without holding
any locks after spi_hid_get_request() drops output_lock.

If multiple threads concurrently issue ioctls, could a second thread
overwrite shid->response via the IRQ handler while the first thread is
executing its memcpy, corrupting data returned to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D5
