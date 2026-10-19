Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438581;
	b=LZB2TV1pHXkS85DXViNduftspRKPzSUTG0XqY6pKR93CkTytHJ1s9pzLPPORdHQIMztw
	 POOwpLMAnL0sSoZk9P+aGD29k05dcJZcBZoPvEHBm2OD4PI++tyT+6BzHwLiizAEdDoBX
	 3e+8gM8LynZgopKljjiCuYGKIKXdW63eJv2AXwPDOd3MTQTqSclWM6jZNcHjXj1khY5Er
	 VEPk6r9osmbz6zn2g31ixYQJBWX4vp0RHDcdbbu4hh2FvxWBQkDSVDKkwjxTi3WD9sEcd
	 hb8PrYuH8n7qD2jrcekNbx2fEf21kGdGP3xjp1iW272FWfCGbi/PCZu902SwC99LOww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W7xF4X0313Gar3bIlHTJB4P38nOpBpbUXLNefhqD9UE=;
	b=zgADqEWDPpk3Tlfn7NtZyEE8IXH62/qCrjR51JTSIFJpFB+dwWFhPnccD3ZelSDQOZpJ
	 qRXWFmc3KG04CUTQv1Y2vdkULrB+53aL43K9i3AaLjkBVbvn8Pz06wFj0u200MJLbsCBm
	 YHhB1G+JvuxLS6xUEIv1RToVfTnAZkTehWKzUqap9Pao1A8pQYeCT5Gc97KFeWrOteFJZ
	 ZBUkITIjhv0gN//iE3YXF8oA5oYz3RdLG9kjC2RsxmrzfVm0ABHIoKYK57L0rpciOFj/j
	 hmniIr0/MeiqQ3261V5Fsabm/KnpsuaSqZVvgfkVgtIjLaeuxxTZh9/NQtlXHUsQ6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMqvdcMX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061B606A31D;
	Mon, 19 Oct 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMqvdcMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6F81F000C4;
	Mon, 19 Oct 2026 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438580;
	bh=W7xF4X0313Gar3bIlHTJB4P38nOpBpbUXLNefhqD9UE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TMqvdcMXZn8XWQ6EbxSbYmfgS2KB2IwRaCHibOvOVOxDm81SgS1kR3o9PQ892bszq
	 rY+YdKXPxms5spFFtQrBSiKSr5JDar1jS1LSH/Wi20zyJx+5zm3utIq1YpBI1T7wXr
	 m3kPwJrJgJNWk7dxGPUHuy9DdNvepn41bozRI4O6tuXoUchay7TZEXet043n8mon9Y
	 9Dl9tONhB+ayZpQutswpBS9x3T4nAtsrT2P1S3OV2OwOEg1ZHTtYLXRul7bfxOxecZ
	 GNjH/EzAC0ucISancunDska3TWEk6gAhaZxBI/4OyGcUdhlBHl41nZ7mV6CK/h1vi6
	 Ly++FkhsEqV8A==
Message-ID: <sashiko-outbox-178144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/11] HID: spi-hid: add power management
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019-send-upstream-v6-10-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-10-cb9ba4b3d6fa@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 19:36:19 +0000
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
- [High] hid: spi-hid: disable_irq() before cancel_work_sync() in spi_hid_s=
uspend()
- [High] hid: spi-hid: unchecked deassert_reset() and reset timeout in resu=
me/suspend
- [High] hid: spi-hid: holding power_lock in spi_hid_wait_for_reset() block=
s recovery
- [Medium] hid: spi-hid: spi_hid_resume() runs reset_resume before pending =
reset_work
- [Medium] HID: spi-hid: skipped power-up in spi_hid_resume() when wakeup i=
s enabled
--

commit 943f2d7ec87adee993c65a27b7655a39b4d0ef5c
Author: Jingyuan Liang <jingyliang@chromium.org>

HID: spi-hid: add power management implementation

This commit implements system sleep power management callbacks for the
HID over SPI transport driver, handling device suspend, resume, reset
synchronization, and wake IRQ setup.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 96805c10bfe36..c2232d5959b88 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -242,6 +250,148 @@ static const char *spi_hid_power_mode_string(enum h=
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
> +static void spi_hid_wait_for_reset(struct spi_hid *shid)
> +{
> +	unsigned long timeout =3D msecs_to_jiffies(SPI_HID_RESET_TIMEOUT +
> +						 SPI_HID_RESP_TIMEOUT);
> +
> +	if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
> +		dev_warn(&shid->spi->dev,
> +			 "Device descriptor not received after reset\n");
> +		return;
> +	}
> +
> +	set_bit(SPI_HID_READY, &shid->flags);
> +}

[Severity: High]
What happens if an error occurs during the post-reset handshake while a
caller is waiting in spi_hid_wait_for_reset()?

Both spi_hid_resume() and the power_down() rollback path in
spi_hid_suspend() hold shid->power_lock across spi_hid_wait_for_reset()
and hid_driver_reset_resume().

If a transient bus error, header validation error, or descriptor error
occurs in spi_hid_dev_irq(), spi_hid_reset_response(), or
spi_hid_dev_desc_response(), the driver sets SPI_HID_ERROR and schedules
shid->reset_work to run spi_hid_error_handler():

  spi_hid_reset_work()
    spi_hid_error_handler()
      guard(mutex)(&shid->power_lock);

Because spi_hid_wait_for_reset() is sleeping with shid->power_lock held,
spi_hid_error_handler() blocks on shid->power_lock and cannot perform any
of its SPI_HID_MAX_RESET_ATTEMPTS recovery resets until
spi_hid_wait_for_reset() times out after 2000 ms and spi_hid_resume() or
spi_hid_suspend() returns. That leaves SPI_HID_READY cleared when
hid_driver_reset_resume() runs, and delays the error reset until after
resume finishes.

> +
> +static int spi_hid_suspend(struct spi_hid *shid)
> +{
> +	int error;
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	/* HID driver suspend may talk to the device; responses need the IRQ. */
> +	scoped_guard(mutex, &shid->power_lock) {
> +		if (shid->power_state !=3D HIDSPI_OFF && shid->hid) {
> +			error =3D hid_driver_suspend(shid->hid, PMSG_SUSPEND);
> +			if (error) {
> +				dev_err(dev, "%s failed to suspend hid driver: %d\n",
> +					__func__, error);
> +				return error;
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * disable_irq() waits for a running IRQ thread, so no new reset_work
> +	 * can be queued after it returns. Then wait for any queued or running
> +	 * instance. Must not hold power_lock here: reset_work takes it.
> +	 */
> +	disable_irq(shid->spi->irq);
> +	cancel_work_sync(&shid->reset_work);

[Severity: High]
Can calling disable_irq(shid->spi->irq) before
cancel_work_sync(&shid->reset_work) starve an in-flight synchronous
request in spi_hid_reset_work()?

If shid->reset_work is already running when spi_hid_suspend() disables the
IRQ, it may be executing a synchronous request in:

  spi_hid_reset_work()
    spi_hid_reset_response() / spi_hid_create_device() / spi_hid_refresh_de=
vice()
      spi_hid_sync_request()
        __spi_hid_sync_request()
          wait_for_completion_timeout(&shid->output_done, ...)

Since shid->output_done is completed by spi_hid_response_handler() from
the threaded IRQ handler spi_hid_dev_irq(), disabling the IRQ first
prevents the response interrupt from being serviced while
cancel_work_sync() waits for reset_work.

This stalls cancel_work_sync() for the full SPI_HID_RESP_TIMEOUT, fails
the request with -ETIMEDOUT, clears SPI_HID_READY, sets SPI_HID_ERROR,
and triggers dev_WARN_ONCE() in spi_hid_reset_response():

	error =3D spi_hid_sync_request(shid, &report);
	if (error) {
		dev_WARN_ONCE(dev, true,
			      "Failed to send device descriptor request: %d\n", error);
		set_bit(SPI_HID_ERROR, &shid->flags);
		schedule_work(&shid->reset_work);
	}

For wakeup-enabled devices, this also leaves the device suspended with
SPI_HID_READY cleared (causing spi_hid_input_report_handler() to drop
wakeup input reports) and SPI_HID_ERROR pending. In addition, because
shid->power_lock is released after hid_driver_suspend() and before
disable_irq(), spi_hid_create_device() or spi_hid_refresh_device() in
spi_hid_reset_work() can register a new shid->hid in that window that
never has hid_driver_suspend() called on it.

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
> +			if (error) {
> +				dev_err(dev, "%s: could not power down\n", __func__);
> +				shid->regulator_error_count++;
> +				shid->regulator_last_error =3D error;
> +				/*
> +				 * Undo partial suspend before returning error.
> +				 * Complete the reset; RESET_PENDING stays set
> +				 * until the device sends its reset response.
> +				 */
> +				shid->ops->sleep_minimal_reset_delay(shid->ops);
> +				reinit_completion(&shid->reset_done);
> +				shid->ops->deassert_reset(shid->ops);
> +				enable_irq(shid->spi->irq);
> +				if (shid->hid) {
> +					spi_hid_wait_for_reset(shid);
> +					hid_driver_reset_resume(shid->hid);
> +				}
> +				return error;
> +			}
> +
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
> +	if (test_bit(SPI_HID_DEAD, &shid->flags)) {
> +		/* Stay off; only balance disable_irq() in suspend. */
> +		enable_irq(shid->spi->irq);
> +		return 0;
> +	}
> +
> +	if (!device_may_wakeup(dev)) {
> +		if (shid->power_state =3D=3D HIDSPI_OFF) {

[Severity: Medium]
Can gating the power-up path on !device_may_wakeup(dev) and
shid->power_state =3D=3D HIDSPI_OFF leave the device unpowered across resume
or hibernation restore?

In this commit, if shid->power_state is HIDSPI_OFF while
device_may_wakeup(dev) is true (for example, if power/wakeup is enabled
while suspended or after a failed power_up()), spi_hid_resume() skips
powering up and resetting the device. A later commit in the series ("HID:
spi-hid: add panel follower support") removes the outer
!device_may_wakeup(dev) check in spi_hid_resume(), but hibernation still
has a related problem when wakeup is enabled.

Because spi_hid_core_pm uses SYSTEM_SLEEP_PM_OPS(spi_hid_core_pm_suspend,
spi_hid_core_pm_resume), .freeze, .thaw, .poweroff, and .restore all call
spi_hid_suspend() and spi_hid_resume(). When device_may_wakeup(dev) is
true during hibernation:

1. During .freeze, spi_hid_suspend() sees device_may_wakeup(dev) and skips
   clearing SPI_HID_READY, asserting reset, calling ops->power_down(), and
   setting shid->power_state =3D HIDSPI_OFF. The hibernation image therefore
   saves shid->power_state as HIDSPI_ON (and conf->supply_enabled as true
   in spi-hid-of).

2. During .poweroff, spi_hid_suspend() again skips powering down the
   device, and platform power is then removed by S4 or by the boot
   kernel's .freeze before image restoration.

3. During .restore, spi_hid_resume() sees shid->power_state =3D=3D HIDSPI_ON
   from the restored image, skips assert_reset(), power_up(),
   deassert_reset(), and spi_hid_wait_for_reset(), and calls
   hid_driver_reset_resume(shid->hid) while the hardware is unpowered or
   held in reset.

> +			shid->ops->assert_reset(shid->ops);
> +
> +			shid->ops->sleep_minimal_reset_delay(shid->ops);
> +
> +			error =3D shid->ops->power_up(shid->ops);
> +			if (error) {
> +				dev_err(dev, "%s: could not power up\n", __func__);
> +				shid->regulator_error_count++;
> +				shid->regulator_last_error =3D error;
> +				/* Suspend runs next even if resume fails. */
> +				enable_irq(shid->spi->irq);
> +				return error;
> +			}
> +			shid->power_state =3D HIDSPI_ON;
> +			reinit_completion(&shid->reset_done);
> +			shid->ops->deassert_reset(shid->ops);
> +			was_reset =3D true;
> +		}
> +	}
> +
> +	enable_irq(shid->spi->irq);
> +
> +	/*
> +	 * For devices that may wake up, process work that was pending when
> +	 * suspend cancelled reset_work. Otherwise suspend already dropped it.
> +	 */
> +	if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> +	    test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> +	    test_bit(SPI_HID_ERROR, &shid->flags))
> +		schedule_work(&shid->reset_work);
> +
> +	if (shid->hid) {
> +		if (was_reset)
> +			spi_hid_wait_for_reset(shid);
> +		error =3D hid_driver_reset_resume(shid->hid);

[Severity: High]
Should spi_hid_resume() and the power_down() error rollback in
spi_hid_suspend() check the return value of shid->ops->deassert_reset()
and handle timeouts from spi_hid_wait_for_reset()?

Unlike spi_hid_core_probe() and spi_hid_error_handler(), both sites ignore
the return value of shid->ops->deassert_reset(shid->ops) (which evaluates
the ACPI _RST method in spi_hid_acpi_deassert_reset() or drives the reset
GPIO in spi_hid_of_deassert_reset()).

If deassert_reset() fails, or if the device fails to respond before
spi_hid_wait_for_reset() times out, spi_hid_wait_for_reset() only logs a
warning and returns without setting SPI_HID_READY, setting SPI_HID_ERROR,
or scheduling shid->reset_work (and if shid->hid is NULL,
spi_hid_wait_for_reset() is not called at all).

Both functions then unconditionally call hid_driver_reset_resume(shid->hid)
while SPI_HID_READY is still 0, causing any synchronous HID requests
during reset_resume to fail with -ENODEV in __spi_hid_send_output_report(),
and leaving the device stuck in SPI_HID_RESET_PENDING with no recovery
scheduled.

[Severity: Medium]
Also in spi_hid_resume(), what happens when a wakeup-enabled device
(was_reset =3D=3D false) resumes while reset or recovery work is pending?

When SPI_HID_RESET_RESPONSE, SPI_HID_CREATE_DEVICE, or SPI_HID_ERROR was
pending when spi_hid_suspend() cancelled shid->reset_work, SPI_HID_READY
is 0.

In spi_hid_resume(), schedule_work(&shid->reset_work) queues the worker
asynchronously while shid->power_lock is still held, spi_hid_wait_for_reset=
()
is skipped because was_reset is false, and hid_driver_reset_resume(shid->hi=
d)
is called immediately before shid->reset_work can complete the reset and
set SPI_HID_READY.

As a result, __spi_hid_send_output_report() rejects any feature or output
reports sent by hid_driver_reset_resume() with -ENODEV:

	/* While not READY, only (re)init descriptor requests may be sent. */
	if (report->report_type !=3D DEVICE_DESCRIPTOR &&
	    report->report_type !=3D REPORT_DESCRIPTOR &&
	    !test_bit(SPI_HID_READY, &shid->flags))
		return -ENODEV;

> +		if (error) {
> +			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
> +				__func__, error);
> +			return error;
> +		}
> +	}
> +	return 0;
> +}

[ ... ]

> @@ -1454,6 +1620,25 @@ void spi_hid_core_remove(struct spi_device *spi)
>  }
>  EXPORT_SYMBOL_GPL(spi_hid_core_remove);
> =20
> +static int spi_hid_core_pm_suspend(struct device *dev)
> +{
> +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> +
> +	return spi_hid_suspend(shid);
> +}
> +
> +static int spi_hid_core_pm_resume(struct device *dev)
> +{
> +	struct spi_hid *shid =3D dev_get_drvdata(dev);
> +
> +	return spi_hid_resume(shid);
> +}
> +
> +const struct dev_pm_ops spi_hid_core_pm =3D {
> +	SYSTEM_SLEEP_PM_OPS(spi_hid_core_pm_suspend, spi_hid_core_pm_resume)
> +};
> +EXPORT_SYMBOL_GPL(spi_hid_core_pm);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-upstr=
eam-v6-0-cb9ba4b3d6fa@chromium.org?part=3D10
