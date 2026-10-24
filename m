Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804781;
	b=kVy61q8imum7BAEownCx9/FMDvNcnWEeUResTefQiJy3bcYiJxckra+RsaEQiJlgsc/s
	 5Og53q+aWGhXQ4NOlC9+3QSeOh0ZgmYwX6P6lmUZnTJl/vuLreUi46oUNFKxran36PM+L
	 3sV/twM54DlTNc9g/TSsCV5E5JMf8AXs0DZAOm5Cn7Q6DW5Pm6Lw/iG6+2SqLgb/5XSbG
	 F/qPhqFUQ0MPqzGiiBeRcLqPHBM5J3qAj6GWdGiQpVad8e70ANf0Cso9s+H8wRhv8eqCT
	 AIrxbcMjxgtM3ULzuRQ6AFpatIomCrusk8p0/83aakremuH4nBiYZIGWSyGXo0ajIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RRpIz9YptYeOb9UL4YoX/0KazKBsdDQBORh1PGSCla4=;
	b=L4FterTiRXEZFRj0OwhJtlB/W9nYKEK9wak7x1CQfXbqYuVuZQO+tC8pfLjdonrVvlsA
	 usVfAiE5GB3VKDrOZBAyTe3GMELXaxZFu+8xJP7k1gXZncc182+MncCPM9wSE/y1BJ9nF
	 hzSj+GxstX59HqFGLHNrqy0ycaX9wlCFLKy8f/Q6z7Ufc60tQ3bxoZJPP/Miy67gTvYuZ
	 5pRt3w7IC+vg43wPVJjmr9yDaApGv55i+5s85IJc6xms2UQNr8iK1frDpqICpgNSzuQ6j
	 mUUYCd3LgtD54P7gKM9xKiao2wwq5qjEV69uZzz9OgXLXvMlKhOZa5cUl8GZRrukDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxELPvsA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE525606A31A;
	Sat, 24 Oct 2026 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxELPvsA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AAA1F01825;
	Sat, 24 Oct 2026 01:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792804780;
	bh=RRpIz9YptYeOb9UL4YoX/0KazKBsdDQBORh1PGSCla4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxELPvsApqPItJje1LxwSVvko/LHe61g6XtRyXxctIfSslsd1dT+6Mf+SPaniJZUc
	 p2gWNw4FbOpVr785T1UhrrwVvQWR/J6XBPsbAfpliT+Eez7piVGYylLBpdqMvg0iun
	 A52IjhNN1s59/b8DcfQugVWeDyB8NNbPr/B2eiXLzsCmCNU01VTnrLwrMJv1WZZ6f+
	 2ozDPhlmKg2akygSM7rIIen1bD4I50yJkOBfo32KwtySMsxVmFtvBAg/Xs7wVUTpV1
	 SRkJQ+eZllsRkYfbzEtOW30Cw1sOpe5Kl/CGBLYGcMRUFzv440fnw2Ea01ByMXznO+
	 h/BSevnHnGb6Q==
Message-ID: <sashiko-outbox-183486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/11] HID: spi-hid: add power management
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261024-send-upstream-v7-10-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-10-abad13174b43@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:19:39 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: spi-hid: unhandled deassert_reset() failure in spi_hid_resume=
()
- [Medium] HID: spi-hid: race and missed hid_driver_reset_resume() in spi_h=
id_resume()
--

commit 9bd51942caad3c04cffc9fdd14002340e1980586
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add power management implementation

This patch adds system sleep power management callbacks to the HID over SPI
transport driver, handling device power down, reset synchronization, and wa=
ke
IRQ setup across suspend and resume.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 4ff93d22715cd..3b8874ca0e1cc 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -231,6 +239,147 @@ static const char *spi_hid_power_mode_string(enum h=
idspi_power_state power_state
>  	}
>  }
> =20
> +/*
> + * Wait for the device descriptor response after reset; the device then =
takes
> + * requests. Set READY here: the report descriptor check that normally s=
ets it
> + * needs power_lock, which callers hold.
> + */
> +static int spi_hid_wait_for_reset(struct spi_hid *shid)
> +{
> +	unsigned long timeout =3D msecs_to_jiffies(SPI_HID_RESET_TIMEOUT +
> +						 SPI_HID_RESP_TIMEOUT);
> +
> +	if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
> +		dev_warn(&shid->spi->dev,
> +			 "Device descriptor not received after reset\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	set_bit(SPI_HID_READY, &shid->flags);
> +	return 0;
> +}
> +
> +static int spi_hid_suspend(struct spi_hid *shid)
> +{
> +	int error;
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	/*
> +	 * Stop reset_work until resume; pending steps keep their flags. The
> +	 * IRQ stays on so a request in flight gets its response.
> +	 */
> +	disable_work_sync(&shid->reset_work);
> +
> +	/* HID driver suspend may talk to the device; responses need the IRQ. */
> +	scoped_guard(mutex, &shid->power_lock) {
> +		if (shid->power_state !=3D HIDSPI_OFF && shid->hid) {
> +			error =3D hid_driver_suspend(shid->hid, PMSG_SUSPEND);
> +			if (error) {
> +				dev_err(dev, "%s failed to suspend hid driver: %d\n",
> +					__func__, error);
> +				enable_work(&shid->reset_work);
> +				/* Redo a schedule_work() dropped while disabled. */
> +				schedule_work(&shid->reset_work);
> +				return error;
> +			}
> +		}
> +	}
> +
> +	/* disable_irq() waits for a running IRQ thread. */
> +	disable_irq(shid->spi->irq);
> +
> +	guard(mutex)(&shid->power_lock);
> +	if (!device_may_wakeup(dev)) {
> +		if (shid->power_state !=3D HIDSPI_OFF) {
> +			/* Device is fully reset on resume; drop stale state. */
> +			clear_bit(SPI_HID_READY, &shid->flags);
> +			clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
> +			clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> +			clear_bit(SPI_HID_ERROR, &shid->flags);
> +			set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> +
> +			shid->ops->assert_reset(shid->ops);
> +
> +			error =3D shid->ops->power_down(shid->ops);
> +			if (error)
> +				dev_err(dev, "%s: could not power down: %d\n", __func__, error);
> +
> +			/* Held in reset either way; resume resets it. */
> +			shid->power_state =3D HIDSPI_OFF;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int spi_hid_resume(struct spi_hid *shid)
> +{
> +	int error;
> +	struct device *dev =3D &shid->spi->dev;
> +	bool was_reset =3D false;
> +
> +	guard(mutex)(&shid->power_lock);
> +	enable_work(&shid->reset_work);
> +	if (test_bit(SPI_HID_DEAD, &shid->flags)) {
> +		/* Stay off; only balance disable_*() in suspend. */
> +		enable_irq(shid->spi->irq);
> +		return 0;
> +	}
> +
> +	if (!device_may_wakeup(dev)) {
> +		if (shid->power_state =3D=3D HIDSPI_OFF) {
> +			shid->ops->assert_reset(shid->ops);
> +
> +			shid->ops->sleep_minimal_reset_delay(shid->ops);
> +
> +			error =3D shid->ops->power_up(shid->ops);
> +			if (error) {
> +				dev_err(dev, "%s: could not power up: %d\n", __func__, error);
> +				/* Suspend runs next even if resume fails. */
> +				enable_irq(shid->spi->irq);
> +				return error;
> +			}
> +			shid->power_state =3D HIDSPI_ON;
> +			reinit_completion(&shid->reset_done);
> +			error =3D shid->ops->deassert_reset(shid->ops);
> +			if (error)
> +				dev_err(dev, "%s: failed to deassert reset: %d\n",
> +					__func__, error);
> +			else
> +				was_reset =3D true;
> +		}
> +	}

[Severity: High]
What happens in spi_hid_resume() if shid->ops->deassert_reset(shid->ops)
fails (or if was_reset is true while shid->hid is still NULL and the reset
times out)?

When deassert_reset() fails in spi_hid_error_handler(), the driver sets
SPI_HID_ERROR and schedules shid->reset_work because a device held in reset
will not assert a reset-response IRQ:

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_error_handler() {
	...
	error =3D shid->ops->deassert_reset(shid->ops);
	if (error) {
		dev_err(dev, "failed to deassert reset: %d\n", error);
		set_bit(SPI_HID_ERROR, &shid->flags);
		schedule_work(&shid->reset_work);
	}
}

In spi_hid_resume(), however, a deassert_reset() failure only logs the error
and leaves was_reset false. Because spi_hid_suspend() cleared SPI_HID_READY,
SPI_HID_RESET_RESPONSE, SPI_HID_CREATE_DEVICE, and SPI_HID_ERROR before
powering down, shid->reset_work is not scheduled, spi_hid_wait_for_reset() =
is
skipped, and spi_hid_resume() returns 0 when !test_bit(SPI_HID_READY,
&shid->flags).

Similarly, because spi_hid_wait_for_reset() is gated inside if (shid->hid),=
 if
shid->hid was not yet created before suspend and the post-resume reset times
out, nothing sets SPI_HID_ERROR or schedules shid->reset_work.

Could this leave the device permanently held in reset with its regulator
enabled in HIDSPI_ON and no recovery work queued?

> +
> +	enable_irq(shid->spi->irq);
> +
> +	/*
> +	 * For devices that may wake up, process work that was pending while
> +	 * suspend had reset_work disabled. Otherwise suspend already dropped i=
t.
> +	 */
> +	if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> +	    test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> +	    test_bit(SPI_HID_ERROR, &shid->flags))
> +		schedule_work(&shid->reset_work);
> +
> +	if (shid->hid) {
> +		if (was_reset && spi_hid_wait_for_reset(shid)) {
> +			/* No reset response: let recovery retry. */
> +			set_bit(SPI_HID_ERROR, &shid->flags);
> +			schedule_work(&shid->reset_work);
> +			return -ETIMEDOUT;
> +		}
> +		/* HID requests would fail while the device is not ready. */
> +		if (!test_bit(SPI_HID_READY, &shid->flags))
> +			return 0;
> +		error =3D hid_driver_reset_resume(shid->hid);
> +		if (error) {
> +			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
> +				__func__, error);
> +			return error;
> +		}
> +	}
> +	return 0;
> +}

[Severity: Medium]
On the wakeup path (when device_may_wakeup(dev) is true and was_reset is
false), how does hid_driver_reset_resume(shid->hid) interact with a pending
reset_work?

When spi_hid_irq_error() sets SPI_HID_ERROR or spi_hid_process_input_report=
()
sets SPI_HID_RESET_RESPONSE in the IRQ thread, SPI_HID_READY is not cleared
immediately. Instead, SPI_HID_READY is cleared later when shid->reset_work
runs spi_hid_error_handler() (which must first acquire shid->power_lock) or
spi_hid_reset_response().

Because spi_hid_resume() holds shid->power_lock across the entire function,
scheduling shid->reset_work and immediately checking test_bit(SPI_HID_READY,
&shid->flags) means:

1. If SPI_HID_ERROR or SPI_HID_RESET_RESPONSE was set while SPI_HID_READY is
still set, spi_hid_resume() sees SPI_HID_READY set and calls
hid_driver_reset_resume(shid->hid) right before shid->reset_work runs and
resets the device.

2. Conversely, if SPI_HID_READY was already cleared (for example, after a s=
ync
request timeout or while SPI_HID_CREATE_DEVICE is pending), spi_hid_resume()
returns 0 early at !test_bit(SPI_HID_READY, &shid->flags). Once
shid->reset_work later completes in spi_hid_refresh_device():

drivers/hid/spi-hid/spi-hid-core.c:spi_hid_refresh_device() {
	...
	/* Same report descriptor, so no need to create a new hid device. */
	if (new_crc32 =3D=3D shid->report_descriptor_crc32) {
		shid->reset_attempts =3D 0;
		set_bit(SPI_HID_READY, &shid->flags);
		return;
	}
}

it sets SPI_HID_READY and returns without calling
hid_driver_reset_resume(shid->hid), leaving the HID driver in the suspended
state set by spi_hid_suspend().

Should spi_hid_resume() coordinate with pending reset work on the wakeup pa=
th
so hid_driver_reset_resume() runs after the reset completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-upstr=
eam-v7-0-abad13174b43@chromium.org?part=3D10
