Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804431;
	b=dn0k6O5r2jhfnHM1zZuVUqROT/ZJ4jR6XQ6e21jAu8H+14mLw5cktTLR5qadQfvIkmsQ
	 IztW53/jN7crn2fkhGB+eHRcJWmWamYFuwuVG2rmJ4YYLZkVIdaFHArD4iY+WxtaTO6ue
	 pZv5feIl6jDJwYmj5F/TiAfCyW93+K6Ixc4EUgnANBtothXyKZ1PkwSNDk1X29R3H2Bxt
	 ZCXiPdC7ndloPtkzviDzsYD0DZeCS/MWEAtmLHDlFFgEHzySVpFWF36vHNgnEmO66eNSR
	 988PhwxJy1n1gU8rjrPmLw4wzUpomF+H6g10UVmxvzVKMXvD1uzhfepujjjNak19uug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lqfmmoYAbACYA70XH3Sq1h4s2eL1PqYm8xkSeSJb0R0=;
	b=4PFvX5t2uL1c75VSRvpuJ/wHH3Gx2FPJChfsfNuLfQRYGUpLIq02Nho+BMOmzE9ULB3D
	 boki8hOWB7NnsFVJoDaCwyZ0C6It3T1uuA+GrjrvI2t+d5CCpKSpYzTAuW7Z9oMIFm0yq
	 c3pBoI1NYOKvSJTGB7GWK1r7pVoI58so3reFalk4itTYdrfklLKktQ2uL1Azi04R8w9K3
	 PnvyYoLaQoQmwGLV1gZiv0/PIPe1SYjKoFAWiPrWoOGJlxFii1EkQwOMYKDdI4q7JkC3y
	 ITuOMZCtniHp8tWWPAqKdztd8AizF+l0nEGZBZXR/VX8xoWkprMP1FSrweLTyNBfPSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBUx+p3r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A34606A31A;
	Sat, 24 Oct 2026 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBUx+p3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FA71F01825;
	Sat, 24 Oct 2026 01:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792804430;
	bh=lqfmmoYAbACYA70XH3Sq1h4s2eL1PqYm8xkSeSJb0R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OBUx+p3rT17M43Mt39JguVTvysr1uCBzV9CUZ14k8IK3OvrqX9j1BQI6eip6MMT+b
	 HmBs8u0Zcs8MLCSSs4SBCx3A3A+NqgwQIQCXQ82i5kS8KWnjGN0Ale5cPKCFm0gLE+
	 vYxo5bEwcY2VsVaW9vI93YGkX6xgFJn7atoNpnYB87sQN8/aC1neSfG+M3rCedfhYV
	 zJfexxF27a7upDwGTrm2Xhyq7tDUB3ClMusLpNcs14N6fIoBkYa8ZRFrgT33sZhq6c
	 xuFxK5OR0Yq/BryxyLRgxB6sgibRwxBGvWLjOo2kUkPsSqIyEYrzt8GFapuNGpjsqw
	 8lFtvlHa0BJAQ==
Message-ID: <sashiko-outbox-183485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/11] HID: spi-hid: add HID SPI protocol
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261024-send-upstream-v7-5-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-5-abad13174b43@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:13:49 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] HID: spi-hid: spi_hid_reset_work() runs pre-error work before SP=
I_HID_ERROR
- [Medium] HID: spi-hid: sync requests not aborted or serialized on reset i=
n error path
- [Medium] HID: spi-hid: duplicate reset scheduled on timeout in spi_hid_ge=
t_request()
--

commit 921e27cc043191cc71704b14d2cdca05f5da7a1c
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add HID SPI protocol implementation

This commit implements the HID over SPI protocol in spi-hid-core.c,
adding interrupt handling, input report processing, synchronous output
request/response tracking, and error recovery via device reset.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 54c278ac8803b..cd4d763840098 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
[ ... ]
> @@ -172,17 +333,96 @@ static const char *spi_hid_power_mode_string(enum h=
idspi_power_state power_state
[ ... ]
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
> +		if (error)
> +			dev_err(dev, "failed to disable regulator: %d\n", error);
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
> +
> +	/* Drop work requested before this reset. */
> +	clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
> +	clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> +	clear_bit(SPI_HID_ERROR, &shid->flags);
> +
> +	shid->ops->sleep_minimal_reset_delay(shid->ops);
> +
> +	shid->power_state =3D HIDSPI_ON;
> +
> +	shid->ops->deassert_reset(shid->ops);
> +
> +	enable_irq(shid->spi->irq);
> +}

[Severity: Medium]
What happens if a synchronous request is waiting on shid->output_done in
__spi_hid_sync_request() while an interrupt error in spi_hid_dev_irq() ->
spi_hid_irq_error() or a spontaneous RESET_RESPONSE in
spi_hid_process_input_report() triggers a reset?

In __spi_hid_sync_request(), the caller holds shid->output_lock while
waiting in wait_for_completion_timeout(&shid->output_done, ...). However,
spi_hid_error_handler() only acquires shid->power_lock: it does not
serialize with shid->output_lock or shid->io_lock, nor does it clear
shid->expected_response or complete shid->output_done to abort an in-flight
request.

Because of this:
1. A thread in __spi_hid_send_output_report() that already passed the
   test_bit(SPI_HID_READY, &shid->flags) check before acquiring
   shid->io_lock can perform spi_hid_output() on the SPI bus while
   spi_hid_error_handler() has asserted reset and set shid->power_state to
   HIDSPI_OFF.
2. When the device finishes resetting and sends RESET_RESPONSE,
   spi_hid_reset_response() -> spi_hid_sync_request() blocks on
   shid->output_lock until the pre-reset waiter's 1000 ms timeout expires.
3. Once wait_for_completion_timeout() in __spi_hid_sync_request() finally
   times out, the pre-reset caller sets SPI_HID_ERROR and schedules
   shid->reset_work again, triggering a second hardware reset after the
   first recovery completes and incrementing shid->reset_attempts a second
   time.

Should the error and reset paths abort any in-flight request (or serialize
with shid->output_lock / shid->io_lock) so that pre-reset waiters do not
stall recovery and schedule a stale reset on timeout?

[ ... ]
> @@ -324,13 +752,206 @@ static int spi_hid_create_device(struct spi_hid *s=
hid)
[ ... ]
> +static void spi_hid_reset_work(struct work_struct *work)
> +{
> +	struct spi_hid *shid =3D
> +		container_of(work, struct spi_hid, reset_work);
> +	struct device *dev =3D &shid->spi->dev;
> +	int error =3D 0;
> +	bool resched =3D false;
> +
> +	if (test_and_clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags)) {
> +		spi_hid_reset_response(shid);
> +		resched =3D true;
> +	} else if (test_and_clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags)) {
> +		guard(mutex)(&shid->power_lock);
> +		if (shid->power_state !=3D HIDSPI_OFF) {
> +			if (!shid->hid) {
> +				error =3D spi_hid_create_device(shid);
> +				if (error) {
> +					dev_err(dev, "%s: Failed to create hid device: %d\n",
> +						__func__, error);
> +				}
> +			} else {
> +				spi_hid_refresh_device(shid);
> +			}
> +		} else {
> +			dev_err(dev, "%s: Powered off, returning\n", __func__);
> +		}
> +		resched =3D true;
> +	} else if (test_and_clear_bit(SPI_HID_ERROR, &shid->flags)) {
> +		spi_hid_error_handler(shid);
> +	}

[Severity: Medium]
Should spi_hid_reset_work() check SPI_HID_ERROR before
SPI_HID_RESET_RESPONSE and SPI_HID_CREATE_DEVICE?

In spi_hid_error_handler(), the code clears SPI_HID_RESET_RESPONSE and
SPI_HID_CREATE_DEVICE with the comment:

	/* Drop work requested before this reset. */
	clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
	clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
	clear_bit(SPI_HID_ERROR, &shid->flags);

However, because spi_hid_error_handler() is only called from the final
else-if branch in spi_hid_reset_work(), it cannot run while
SPI_HID_RESET_RESPONSE or SPI_HID_CREATE_DEVICE is set. If an error sets
SPI_HID_ERROR while either of those bits is pending (for example, an IRQ
error in spi_hid_dev_irq() -> spi_hid_irq_error() after
spi_hid_dev_desc_response() sets SPI_HID_CREATE_DEVICE),
spi_hid_reset_work() will first execute spi_hid_reset_response() or
spi_hid_create_device() / spi_hid_refresh_device(), reschedule itself, and
only then run spi_hid_error_handler() to immediately reset the newly
created or refreshed HID device.

[ ... ]
> @@ -355,6 +976,15 @@ static int spi_hid_get_request(struct spi_hid *shid,=
 u8 content_id,
>  		dev_err(dev,
>  			"Expected get request response not received! Error %d\n",
>  			error);
> +		/*
> +		 * -ENODEV: the device is not ready (e.g. a reset is in
> +		 * progress), so the GET_FEATURE request was not sent.
> +		 * Don't start another reset on top of the one already running.
> +		 */
> +		if (error !=3D -ENODEV) {
> +			set_bit(SPI_HID_ERROR, &shid->flags);
> +			schedule_work(&shid->reset_work);
> +		}
>  		return error;
>  	}

[Severity: Medium]
Won't a timed-out request in spi_hid_get_request() schedule a duplicate
reset?

When __spi_hid_sync_request() times out waiting on shid->output_done, it
already sets SPI_HID_ERROR and schedules shid->reset_work before returning
-ETIMEDOUT:

	dev_err(dev, "Response timed out\n");
	/* The device may still answer later: resync it with a reset. */
	set_bit(SPI_HID_ERROR, &shid->flags);
	schedule_work(&shid->reset_work);
	return -ETIMEDOUT;

Because spi_hid_reset_work() -> spi_hid_error_handler() does not take
shid->output_lock, the worker thread on another CPU can immediately begin
running spi_hid_reset_work() and clear SPI_HID_ERROR while
spi_hid_get_request() (and similarly spi_hid_report_descriptor_request()
and spi_hid_reset_response()) receives -ETIMEDOUT and sets SPI_HID_ERROR
and schedules shid->reset_work a second time. This triggers two
back-to-back hardware resets and increments shid->reset_attempts twice for
a single timeout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-upstr=
eam-v7-0-abad13174b43@chromium.org?part=3D5
