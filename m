Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437745;
	b=KjpviDiouTst8POR2L1+V5v6HUb30WQ/eOJmdEaeJBTTgVYAtwaZFjOjARXoTH8CQdsi
	 G3c8/h5Ni71fZDiwVgQZ8DAT75T/rM5yQ6v1P2sypTeg7efoJoiLhYXqQnt/kHIRmNiy/
	 RfPPk6vcennFSxTx1fdG1f4WsTwlMtOB7XgO5dDY9/cFqnModH3RmKeFUtPZcTohhL/1O
	 4jHxXbusCmo2hoHhjPRi1lOEIxkXaaF/g65PgqV4QVz5pjF1cxoGAZT4vgFun5+62V1D6
	 PpJ2b3x10mc/Sln+g5l2FuuUMRfx8upy+zgTZ8MUAHNkQW9wrygxJyMFkbXbtr+vawA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2CqIM8rtOhPss9Xy/8YrW6uTOhZSkBp4/vflFvLKrmY=;
	b=bf0eL0pNkDIG+6A9tm0HqH2jUgRYDVWu0saqKDqa0UhPCeHGvKNMOvDuV6GLaJYwkMbu
	 101vyVRr4IMXxNY84ZF50pS+hTnkswdAfSl/4CA4Cjt8nTc/HU0OZ97xh5YRsAY2h6OG2
	 0SPa+bD1x20Wf2Cd+X7FyWmqEBQr1bFv7smCYTnirTm6kT9B5fVuqKiNvECqE5KWch0F1
	 9L2MTQ4uo1gKbv5UXC5EcgA0NAqKaAnVu3wE3UKxeQCLLxdwFELUliGygJ+fWvbQyxCQQ
	 +KVAgq+VmBiUL0L7xLQJEoHrwZ9UBHkzA0UkOcFv0z/UPGAOm8RKLbo3v0A9rG4//dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHmtjieu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDD606A323;
	Mon, 19 Oct 2026 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHmtjieu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88A91F000C4;
	Mon, 19 Oct 2026 19:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437745;
	bh=2CqIM8rtOhPss9Xy/8YrW6uTOhZSkBp4/vflFvLKrmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHmtjieuFSlEyeiMRe/dDlcvGg49mLaB0KqpuNELtppXw+qWCThoOs1mETBoL0BXV
	 wBmDOJNLku4nxIm+5g9bvTkK9rmtzp/WVz91bXckP8azdJ7qiBgZ5MY7ePFE++Z3gK
	 V3tXoy+8AhAPhmq6FJHTh+v4X8BrlXgz31uw8bG83yBYMJf7I9iy74Pv93dKGeniVV
	 lS/E5juYmwzcOMXISCzLwBc5Po+mRwG3FIwBccMIv7dYeuOx955RWHlw1M6a06cYBL
	 6YEWy02ZQcHL/NAYAHvkwx65forn9tFlIh78/HSFaYxtka4xlAEdd9zgPj9UIZLj9m
	 QTRBah124UQNQ==
Message-ID: <sashiko-outbox-178141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/11] HID: spi-hid: add HID SPI protocol
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019-send-upstream-v6-5-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-5-cb9ba4b3d6fa@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 19:22:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] hid: spi-hid: spi_hid_bus_validate_header() rejects descriptors > =
max_input
- [High] hid: spi-hid: spi_hid_dev_desc_response() clears reset_attempts to=
o early
- [Medium] hid: spi-hid: spi_hid_bus_validate_header() allows 0-length repo=
rt body
- [Medium] hid: spi-hid: stale flags and duplicate SPI_HID_ERROR cause spur=
ious resets
- [Medium] hid: spi-hid: unaborted sync request in __spi_hid_sync_request()=
 on reset
--

commit 68d1db2b55c0e004ec2c06854ae93db414465298
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add HID SPI protocol implementation

This commit implements the HID Over SPI Protocol Specification 1.0 in
drivers/hid/spi-hid/spi-hid-core.c, handling SPI input/output transfers,
descriptor parsing, interrupt processing, and error recovery resets.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index fca7a44eeb9f9..90b2c2fea6501 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -187,17 +350,94 @@ static const char *spi_hid_power_mode_string(enum h=
idspi_power_state power_state
> =20
>  static void spi_hid_stop_hid(struct spi_hid *shid)
>  {
> -	struct hid_device *hid =3D shid->hid;
> +	struct hid_device *hid;
> =20
> -	shid->hid =3D NULL;
> -	clear_bit(SPI_HID_READY, &shid->flags);
> +	scoped_guard(mutex, &shid->io_lock) {
> +		hid =3D shid->hid;
> +		shid->hid =3D NULL;
> +		clear_bit(SPI_HID_READY, &shid->flags);
> +	}
> =20
>  	if (hid)
>  		hid_destroy_device(hid);
>  }
> =20
> +static void spi_hid_error_handler(struct spi_hid *shid)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	int error;
> +
> +	guard(mutex)(&shid->power_lock);
> +	if (shid->power_state =3D=3D HIDSPI_OFF)
> +		return;
> +
> +	disable_irq(shid->spi->irq);
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
> +		shid->power_state =3D HIDSPI_OFF;
> +		/* Dead device: leave the IRQ permanently disabled. */
> +		return;
> +	}
> +
> +	clear_bit(SPI_HID_READY, &shid->flags);
> +	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> +
> +	shid->ops->assert_reset(shid->ops);
> +
> +	shid->power_state =3D HIDSPI_OFF;
> +
> +	/*
> +	 * We want to cancel pending reset work as the device is being reset
> +	 * to recover from an error. cancel_work_sync will put us in a deadlock
> +	 * because this function is scheduled in 'reset_work' and we should
> +	 * avoid waiting for itself.
> +	 */
> +	cancel_work(&shid->reset_work);

[Severity: Medium]
Should spi_hid_error_handler() also clear pending SPI_HID_RESET_RESPONSE,
SPI_HID_CREATE_DEVICE, and SPI_HID_ERROR bits in shid->flags here?

Furthermore, in __spi_hid_sync_request(), a timeout already sets
SPI_HID_ERROR and schedules shid->reset_work, but its callers
(spi_hid_reset_response(), spi_hid_report_descriptor_request(), and
spi_hid_get_request()) unconditionally set SPI_HID_ERROR and schedule
shid->reset_work a second time on error:

  spi_hid_get_request()
    __spi_hid_sync_request()
      set_bit(SPI_HID_ERROR, &shid->flags);
      schedule_work(&shid->reset_work);
      return -ETIMEDOUT;
    set_bit(SPI_HID_ERROR, &shid->flags);
    schedule_work(&shid->reset_work);

If shid->reset_work starts on another CPU after the first schedule_work()
and clears SPI_HID_ERROR via test_and_clear_bit(), the caller can set
SPI_HID_ERROR and queue shid->reset_work again. If cancel_work() cancels
the work item without clearing the flag bits, the stale SPI_HID_ERROR bit
remains set in shid->flags and will trigger a second reset when
spi_hid_reset_work() later checks pending flags to reschedule itself. And
if the second schedule_work() runs after cancel_work(), reset_work will run
a second time immediately.

Also, if spi_hid_get_request() is called while SPI_HID_READY is cleared,
__spi_hid_send_output_report() returns -ENODEV, which spi_hid_get_request()
treats as a fatal error by setting SPI_HID_ERROR and scheduling a hardware
reset.

Finally, in spi_hid_reset_work(), SPI_HID_RESET_RESPONSE and
SPI_HID_CREATE_DEVICE are checked before SPI_HID_ERROR in the if/else-if
chain, so if SPI_HID_ERROR is set while one of those bits is pending, the
worker will attempt normal initialization before running
spi_hid_error_handler().

> +
> +	shid->ops->sleep_minimal_reset_delay(shid->ops);
> +
> +	shid->power_state =3D HIDSPI_ON;
> +
> +	shid->ops->deassert_reset(shid->ops);
> +
> +	enable_irq(shid->spi->irq);
> +}

[ ... ]

> @@ -234,39 +491,208 @@ static int spi_hid_send_output_report(struct spi_h=
id *shid,
>  				      struct spi_hid_output_report *report)
>  {
>  	guard(mutex)(&shid->output_lock);
> -	return __spi_hid_send_output_report(shid, report);
> +	return __spi_hid_send_output_report(shid, report, 0);
>  }
> =20
>  static int __spi_hid_sync_request(struct spi_hid *shid,
>  				  struct spi_hid_output_report *report)
>  {
>  	struct device *dev =3D &shid->spi->dev;
>  	int error;
> =20
> -	reinit_completion(&shid->output_done);
> -
> -	error =3D __spi_hid_send_output_report(shid, report);
> +	error =3D __spi_hid_send_output_report(shid, report,
> +					     spi_hid_response_type(report->report_type));
>  	if (error)
>  		return error;
> =20
> -	error =3D wait_for_completion_interruptible_timeout(&shid->output_done,
> -							  msecs_to_jiffies(SPI_HID_RESP_TIMEOUT));
> -	if (error =3D=3D 0) {
> -		dev_err(dev, "Response timed out\n");
> -		return -ETIMEDOUT;
> +	if (wait_for_completion_timeout(&shid->output_done,
> +					msecs_to_jiffies(SPI_HID_RESP_TIMEOUT)))
> +		return 0;
> +
> +	/* Drop late responses and block new HID requests until the reset. */
> +	scoped_guard(mutex, &shid->io_lock) {
> +		shid->expected_response =3D 0;
> +		clear_bit(SPI_HID_READY, &shid->flags);
>  	}
> -	if (error < 0)
> -		return error;
> =20
> -	return 0;
> +	dev_err(dev, "Response timed out\n");
> +	/* The device may still answer later: resync it with a reset. */
> +	set_bit(SPI_HID_ERROR, &shid->flags);
> +	schedule_work(&shid->reset_work);
> +	return -ETIMEDOUT;
>  }

[Severity: Medium]
What happens if a spontaneous firmware reset (RESET_RESPONSE in
spi_hid_process_input_report()) or an IRQ error (spi_hid_error_handler())
occurs while a synchronous request is waiting on shid->output_done in
__spi_hid_sync_request() with shid->output_lock held?

Because neither the RESET_RESPONSE path nor spi_hid_error_handler() aborts
the in-flight request or wakes shid->output_done, the waiter continues
holding shid->output_lock for the full SPI_HID_RESP_TIMEOUT (blocking
spi_hid_reset_response() in reset_work) and then sets SPI_HID_ERROR and
schedules reset_work when the timeout expires, resetting the device a
second time after recovery.

[ ... ]

> +static int spi_hid_dev_desc_response(struct spi_hid *shid,
> +				     struct spi_hid_input_report *body)
> +{
> +	struct hidspi_dev_descriptor *raw =3D
> +		(struct hidspi_dev_descriptor *)shid->input->content;
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	/* Validate device descriptor length before parsing */
> +	if (body->content_length !=3D HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
> +		dev_err(dev, "Invalid content length %d, expected %zu\n",
> +			body->content_length, HIDSPI_DEVICE_DESCRIPTOR_SIZE);
> +		return -EPROTO;
> +	}
> +
> +	if (le16_to_cpu(raw->dev_desc_len) !=3D HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
> +		dev_err(dev, "Invalid wDeviceDescLength %d, expected %zu\n",
> +			le16_to_cpu(raw->dev_desc_len),
> +			HIDSPI_DEVICE_DESCRIPTOR_SIZE);
> +		return -EPROTO;
> +	}
> +
> +	if (le16_to_cpu(raw->bcd_ver) !=3D SPI_HID_SUPPORTED_VERSION) {
> +		dev_err(dev, "Unsupported device descriptor version %4x\n",
> +			le16_to_cpu(raw->bcd_ver));
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	/* Fail before reset_attempts is cleared so resets stay bounded. */
> +	if (!le16_to_cpu(raw->rep_desc_len) ||
> +	    le16_to_cpu(raw->rep_desc_len) > HID_MAX_DESCRIPTOR_SIZE) {
> +		dev_err(dev, "Invalid wReportDescLength %d, max %d\n",
> +			le16_to_cpu(raw->rep_desc_len),
> +			HID_MAX_DESCRIPTOR_SIZE);
> +		return -EPROTO;
> +	}
> +
> +	spi_hid_parse_dev_desc(raw, &shid->desc);
> +
> +	/* Reset attempts at every device descriptor fetch */
> +	shid->reset_attempts =3D 0;
> +	set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> +	schedule_work(&shid->reset_work);
> +
> +	return 0;
> +}

[Severity: High]
Does clearing shid->reset_attempts =3D 0 here in spi_hid_dev_desc_response()
cause an unbounded reset loop if fetching or validating the report
descriptor subsequently fails?

When SPI_HID_CREATE_DEVICE runs spi_hid_create_device() -> hid_add_device()
-> spi_hid_ll_parse() (or spi_hid_refresh_device()), it calls
spi_hid_report_descriptor_request(). If that request times out or fails
validation in spi_hid_dev_irq(), SPI_HID_ERROR is set and
spi_hid_error_handler() increments shid->reset_attempts from 0 to 1 and
resets the device.

After the reset, if the device responds to DEVICE_DESCRIPTOR again,
spi_hid_dev_desc_response() resets shid->reset_attempts back to 0 before
REPORT_DESCRIPTOR is retried, so shid->reset_attempts oscillates between 0
and 1 and never reaches SPI_HID_MAX_RESET_ATTEMPTS. Should
shid->reset_attempts only be cleared once the report descriptor is fetched
and SPI_HID_READY is set?

[ ... ]

> @@ -334,13 +766,205 @@ static int spi_hid_create_device(struct spi_hid *s=
hid)

[ ... ]

> +static int spi_hid_bus_validate_header(struct spi_hid *shid,
> +				       struct spi_hid_input_header *header)
> +{
> +	struct device *dev =3D &shid->spi->dev;
> +	/*
> +	 * Body capacity of shid->input, matching spi_hid_alloc_buffers().
> +	 * shid->bufsize only changes with the IRQ disabled, so it is stable he=
re.
> +	 */
> +	u32 max_body =3D round_up(sizeof(shid->input->header) +
> +				sizeof(shid->input->body) + shid->bufsize, 4) -
> +		       sizeof(shid->input->header);
> +
> +	if (header->version !=3D SPI_HID_INPUT_HEADER_VERSION) {
> +		dev_err(dev, "Unknown input report version (v 0x%x)\n",
> +			header->version);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * report_length is device-provided and is used as the size of the body
> +	 * transfer, so it must never exceed the input buffer.
> +	 */
> +	if (header->report_length > max_body) {
> +		dev_err(dev, "Input report too big: %u > %u\n",
> +			header->report_length, max_body);
> +		return -EMSGSIZE;
> +	}

[Severity: Medium]
Can header->report_length be 0 (or smaller than sizeof(shid->input->body))
here?

In spi_hid_populate_input_header(), header->report_length is computed as
(get_unaligned_le16(&buf[1]) & 0x3fff) * 4. If a malformed header or bus
glitch during reset produces a length of 0, spi_hid_bus_validate_header()
returns 0 because it only checks the upper bound.

In spi_hid_dev_irq(), that bypasses the SPI_HID_RESET_PENDING check,
performs a 0-byte body read via spi_hid_input_sync(), and then parses stale
bytes from shid->input->body in spi_hid_process_input_report(), triggering
spi_hid_irq_error(). Should spi_hid_bus_validate_header() reject
header->report_length < sizeof(shid->input->body)?

> +
> +	if (shid->desc.max_input_length !=3D 0 &&
> +	    header->report_length > shid->desc.max_input_length) {
> +		dev_err(dev, "Input report body size %u > max expected of %u\n",
> +			header->report_length, shid->desc.max_input_length);
> +		return -EMSGSIZE;
> +	}

[Severity: High]
Won't this check in spi_hid_bus_validate_header() reject
REPORT_DESCRIPTOR_RESPONSE (and post-reset DEVICE_DESCRIPTOR_RESPONSE)
whenever the descriptor packet is larger than shid->desc.max_input_length?

During initialization:

  spi_hid_dev_desc_response()
    spi_hid_parse_dev_desc(raw, &shid->desc)
      desc->max_input_length =3D le16_to_cpu(raw->max_input_len);
    set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
    schedule_work(&shid->reset_work);

When spi_hid_reset_work() then calls spi_hid_create_device() ->
hid_add_device() -> spi_hid_ll_parse() ->
spi_hid_report_descriptor_request(), shid->desc.max_input_length is already
populated with wMaxInputLength.

When the device replies with REPORT_DESCRIPTOR_RESPONSE, spi_hid_dev_irq()
calls spi_hid_bus_validate_header() before reading the body or knowing the
report type. Since wMaxInputLength is the maximum length of input reports
while wReportDescLength (up to HID_MAX_DESCRIPTOR_SIZE =3D 4096) is typical=
ly
much larger, header->report_length > shid->desc.max_input_length will fail
with -EMSGSIZE and trigger spi_hid_irq_error() on every attempt until the
device is aborted. (Note also the comment in spi_hid_find_max_report() that
some devices set wMaxInputLength to an inaccurate length.)

> +
> +	if (header->last_fragment_flag !=3D 1) {
> +		dev_err(dev, "Multi-fragment reports not supported\n");
> +		return -EOPNOTSUPP;
> +	}

[ ... ]

> @@ -365,6 +989,8 @@ static int spi_hid_get_request(struct spi_hid *shid, =
u8 content_id,
>  		dev_err(dev,
>  			"Expected get request response not received! Error %d\n",
>  			error);
> +		set_bit(SPI_HID_ERROR, &shid->flags);
> +		schedule_work(&shid->reset_work);
>  		return error;
>  	}

[ ... ]

> @@ -397,9 +1023,81 @@ static int spi_hid_set_request(struct spi_hid *shid=
, u8 *arg_buf, u16 arg_len,
>  	return spi_hid_sync_request(shid, &report);
>  }
> =20
> -/* This is a placeholder. Will be implemented in the next patch. */
> +/* Schedule a reset to recover from an error in the IRQ handler. */
> +static irqreturn_t spi_hid_irq_error(struct spi_hid *shid)
> +{
> +	set_bit(SPI_HID_ERROR, &shid->flags);
> +	schedule_work(&shid->reset_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
>  {
> +	struct spi_hid *shid =3D _shid;
> +	struct device *dev =3D &shid->spi->dev;
> +	struct spi_hid_input_header header;
> +	int error =3D 0;
> +
> +	scoped_guard(mutex, &shid->io_lock) {
> +		if (shid->power_state =3D=3D HIDSPI_OFF) {
> +			dev_warn(dev, "Device is off, ignoring interrupt\n");
> +			return IRQ_NONE;
> +		}
> +
> +		error =3D spi_hid_input_sync(shid, shid->input->header,
> +					   sizeof(shid->input->header), true);
> +		if (error) {
> +			dev_err(dev, "Failed to transfer header: %d\n", error);
> +			return spi_hid_irq_error(shid);
> +		}
> +
> +		if (shid->input_message.status < 0) {
> +			dev_warn(dev, "Error reading header: %d\n",
> +				 shid->input_message.status);
> +			shid->bus_error_count++;
> +			shid->bus_last_error =3D shid->input_message.status;
> +			return spi_hid_irq_error(shid);
> +		}
> +
> +		spi_hid_populate_input_header(shid->input->header, &header);
> +
> +		error =3D spi_hid_bus_validate_header(shid, &header);
> +		if (error) {
> +			if (!test_bit(SPI_HID_RESET_PENDING, &shid->flags)) {
> +				dev_err(dev, "Failed to validate header: %d\n", error);
> +				print_hex_dump(KERN_ERR, "spi_hid: header buffer: ",
> +					       DUMP_PREFIX_NONE, 16, 1, shid->input->header,
> +					       sizeof(shid->input->header), false);
> +				shid->bus_error_count++;
> +				shid->bus_last_error =3D error;
> +				return spi_hid_irq_error(shid);
> +			}
> +			return IRQ_HANDLED;
> +		}
> +
> +		error =3D spi_hid_input_sync(shid, shid->input->body, header.report_le=
ngth,
> +					   false);

[ ... ]

> @@ -479,6 +1177,8 @@ static int spi_hid_ll_start(struct hid_device *hid)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-upstr=
eam-v6-0-cb9ba4b3d6fa@chromium.org?part=3D5
