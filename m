Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F192364E9E;
	Tue,  9 Jun 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981207; cv=none; b=NUOqHEDCKIT0Qh3weD7RPHwJhaOX1c024JmwKrwEojhX6s14tOFuaD60xT2IjpOudY3PP/dEkKwq4c1dqAVo+VL4veHJcfIT8mA4KQKPkVnCHp1Shiq+0n0rK6/00XPN6hX5zkLFcwtNiN6yy8Wft0moBkKE4xysnb7YD2KHEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981207; c=relaxed/simple;
	bh=kNTpQLx5iGX+a6wdTMSgSrKk4rqY3Ir/DuTVeVfFnK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qIodJS65f2xfaOyZh/66kpzTHklvkqn4iC+iSHygROj0793/oahXXfRUxJJgWJKLpwYgp8sHZmFqcE32UcgPT9B03vS4jeWhfQp824qyQJmInGsNhBB6FyOUcttR5dGrYaIrKoDlEs72IMb3cxccBRr0UT4++61H9QhneNWTwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcHyARb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcHyARb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549721F00893;
	Tue,  9 Jun 2026 05:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780981205;
	bh=cfMYUezpnwJfFl7UXHHGcuQoYlbZqRVon9qvdNzyibY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcHyARb05p+EY/zJOOYt0qDTkUzHrWLYd7WEs/lFkqQjSjEuYCiaH5RPgpox3wHWd
	 aJ1DhGg6Ka5cev46nLzxIl02cWuGd76wHbKF7sdJ2OUCnOBoaRPkH2DDPWa0YDDh1I
	 qQFz3bJXxkI8TLQJtiOGpvHfYg8HCPEvgNLY92/Tbm1iC/eZowq5PEvsR1sXvViNZG
	 io+u/3ez2Onl6cv9ZLX3843T7mvCI5EFBMdLkqJn1f6ex4uk+b85Y1swa7LL7jk6Uz
	 Y1Ukj3+CuFRSvLbWC32ptCT9kwxCLDdQFwRjK1lNWFf7RXqtACK2LdP0iO2WunS5jB
	 OICOJ5Ibk6XtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/11] HID: spi-hid: add power management
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260609-send-upstream-v4-10-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-10-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:00:04 +0000
Message-Id: <20260609050005.549721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] `spi_hid_resume()` calls `hid_driver_reset_resume()` synchronously=
 before the device signals readiness.
- [High] Error path in `spi_hid_resume()` creates unbalanced IRQ disable de=
pth for wakeup-capable devices.
- [High] Missing synchronization between system suspend and `reset_work` ca=
uses a TOCTOU race on `power_state`.
- [High] System suspend cuts device power without synchronizing against ong=
oing SPI HID requests.
- [High] Unbalanced `enable_irq()` in `spi_hid_resume()` triggers a kernel =
warning if the device was already `HIDSPI_OFF`.
- [Medium] Conditional cleanup of the wake IRQ leads to a memory leak if us=
erspace disables wakeup.

Pre-existing issues:
- [Critical] Returning `IRQ_HANDLED` for an unpowered device causes an infi=
nite IRQ storm.
--

commit 57585bfd26214992cdd5246d2df2a4622693a915
Author: Jingyuan Liang <jingyliang@chromium.org>
HID: spi-hid: add power management implementation

This commit implements HID over SPI driver power management callbacks, addi=
ng
suspend and resume functions for system power state transitions.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> index 698e72102c11e..517f069134775 100644
> --- a/drivers/hid/spi-hid/spi-hid-core.c
> +++ b/drivers/hid/spi-hid/spi-hid-core.c

[ ... ]

> @@ -245,6 +247,96 @@ static const char *spi_hid_power_mode_string(enum hi=
dspi_power_state power_state
>  	}
>  }
> =20
> +static int spi_hid_suspend(struct spi_hid *shid)
> +{
> +	int error;
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	guard(mutex)(&shid->power_lock);

[Severity: High]
Does this suspend routine need to synchronize against ongoing SPI I/O?

HID I/O routines like spi_hid_ll_output_report() and spi_hid_ll_raw_request=
()
acquire output_lock and io_lock to serialize transfers, but they do not che=
ck
or lock power_state. Because spi_hid_suspend() acquires power_lock to disab=
le
the device's regulator but does not acquire output_lock or io_lock, nor does
it clear SPI_HID_READY, could it cut hardware power concurrently while a ke=
rnel
thread is actively executing spi_write() on another CPU, leading to hardware
bus timeouts?

[Severity: High]
Does this function also need to flush or cancel the asynchronous reset_work
before cutting device power?

If it doesn't synchronize with the workqueue, could there be a race where
spi_hid_reset_response() locklessly reads power_state as HIDSPI_ON, gets
preempted, and allows spi_hid_suspend() to power down the device? If the
workqueue then resumes and calls spi_hid_sync_request(), it would initiate
SPI transmissions to an unpowered device.

> +	if (shid->power_state =3D=3D HIDSPI_OFF)
> +		return 0;

[Severity: High]
If this early return is taken, will the subsequent resume cause an unbalanc=
ed
IRQ enable warning?

In spi_hid_suspend(), this early return completely bypasses the call to
disable_irq(shid->spi->irq). However, upon system resume, spi_hid_resume()
unconditionally calls enable_irq(shid->spi->irq). If the IRQ disable depth
was not incremented during suspend, could this unconditional enable drop the
depth below zero and trigger a WARN(1, "Unbalanced enable for IRQ %d\n")?

> +
> +	if (shid->hid) {
> +		error =3D hid_driver_suspend(shid->hid, PMSG_SUSPEND);
> +		if (error) {
> +			dev_err(dev, "%s failed to suspend hid driver: %d\n",
> +				__func__, error);
> +			return error;
> +		}
> +	}
> +
> +	disable_irq(shid->spi->irq);
> +
> +	if (!device_may_wakeup(dev)) {
> +		set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> +
> +		shid->ops->assert_reset(shid->ops);
> +
> +		error =3D shid->ops->power_down(shid->ops);
> +		if (error) {
> +			dev_err(dev, "%s: could not power down\n", __func__);
> +			shid->regulator_error_count++;
> +			shid->regulator_last_error =3D error;
> +			/* Undo partial suspend before returning error */
> +			shid->ops->deassert_reset(shid->ops);
> +			clear_bit(SPI_HID_RESET_PENDING, &shid->flags);
> +			enable_irq(shid->spi->irq);
> +			if (shid->hid)
> +				hid_driver_reset_resume(shid->hid);
> +			return error;
> +		}
> +
> +		shid->power_state =3D HIDSPI_OFF;
> +	}
> +	return 0;
> +}
> +
> +static int spi_hid_resume(struct spi_hid *shid)
> +{
> +	int error;
> +	struct device *dev =3D &shid->spi->dev;
> +
> +	guard(mutex)(&shid->power_lock);
> +
> +	if (!device_may_wakeup(dev)) {
> +		if (shid->power_state =3D=3D HIDSPI_OFF) {
> +			shid->ops->assert_reset(shid->ops);
> +
> +			shid->ops->sleep_minimal_reset_delay(shid->ops);
> +
> +			error =3D shid->ops->power_up(shid->ops);
> +			if (error) {
> +				dev_err(dev, "%s: could not power up\n", __func__);
> +				shid->regulator_error_count++;
> +				shid->regulator_last_error =3D error;
> +				return error;
> +			}
> +			shid->power_state =3D HIDSPI_ON;
> +			shid->ops->deassert_reset(shid->ops);
> +		}
> +	}
> +
> +	enable_irq(shid->spi->irq);
> +
> +	if (shid->hid) {
> +		error =3D hid_driver_reset_resume(shid->hid);

[Severity: High]
Does this code need to wait for the device's asynchronous RESET_RESPONSE
before sending further commands?

During a full resume cycle, the device is powered up, its reset line is
deasserted, and enable_irq() is called. The hardware then begins booting
and will signal readiness via an asynchronous RESET_RESPONSE interrupt.
However, spi_hid_resume() does not wait for this interrupt and synchronously
executes hid_driver_reset_resume() immediately. Because the SPI_HID_READY
flag is left set during suspend, any HID initialization commands generated
by the upper layer's resume callback will be immediately transmitted over
the SPI bus to a device that is still booting. Could this result in bus
timeouts and failed resume cycles?

> +		if (error) {
> +			dev_err(dev, "%s: failed to reset resume hid driver: %d\n",
> +				__func__, error);
> +			/* Undo partial resume before returning error */
> +			disable_irq(shid->spi->irq);
> +			if (!device_may_wakeup(dev)) {
> +				set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> +				shid->ops->assert_reset(shid->ops);
> +				shid->ops->power_down(shid->ops);
> +				shid->power_state =3D HIDSPI_OFF;
> +			}

[Severity: High]
Can this error path create an unbalanced IRQ disable depth for
wakeup-capable devices?

If a device is wakeup-capable, spi_hid_suspend() skips powering down the
device (leaving power_state at HIDSPI_ON) but still calls disable_irq().
In spi_hid_resume(), enable_irq() is called, bringing the IRQ depth to 0.

If hid_driver_reset_resume() subsequently fails, this error recovery path
calls disable_irq() to undo the resume, but skips setting HIDSPI_OFF due
to the if (!device_may_wakeup(dev)) condition. Because the PM core ignores
resume errors and continues, the device remains at HIDSPI_ON.

On the next system suspend cycle, spi_hid_suspend() will see HIDSPI_ON and
execute disable_irq() a second time. A later successful resume will only ca=
ll
enable_irq() once, leaving the device's interrupt permanently disabled.

> +			return error;
> +		}
> +	}
> +	return 0;
> +}

[ ... ]

> @@ -795,6 +887,11 @@ static irqreturn_t spi_hid_dev_irq(int irq, void *_s=
hid)
>  	trace_spi_hid_header_transfer(shid);
> =20
>  	scoped_guard(mutex, &shid->io_lock) {
> +		if (shid->power_state =3D=3D HIDSPI_OFF) {
> +			dev_warn(dev, "Device is off, ignoring interrupt\n");
> +			goto out;
> +		}

[Severity: Critical]
This isn't a bug introduced by this patch, but should this path return IRQ_=
NONE
instead of IRQ_HANDLED?

In spi_hid_error_handler(), if the device exceeds maximum reset attempts,
it is aborted and powered off (HIDSPI_OFF). The function then returns,
releasing guard(disable_irq)(&shid->spi->irq) and explicitly re-enabling
the IRQ line.

If the active-low interrupt line floats low due to power loss, it immediate=
ly
triggers. This threaded handler detects HIDSPI_OFF, logs a warning, and
returns IRQ_HANDLED via goto out.

Returning IRQ_HANDLED circumvents the kernel's spurious interrupt detector.
Because the physical line remains asserted and the handler claims success
without clearing the hardware source, the genirq subsystem immediately
re-fires the interrupt. Can this lead to a 100% CPU lockup?

[ ... ]

> @@ -1251,10 +1343,19 @@ int spi_hid_core_probe(struct spi_device *spi, st=
ruct spihid_ops *ops,
>  		dev_err(dev, "%s: unable to request threaded IRQ\n", __func__);
>  		return error;
>  	}
> +	if (device_may_wakeup(dev)) {
> +		error =3D dev_pm_set_wake_irq(dev, spi->irq);
> +		if (error) {
> +			dev_err(dev, "%s: failed to set wake IRQ\n", __func__);
> +			return error;
> +		}
> +	}
> =20
>  	error =3D shid->ops->power_up(shid->ops);
>  	if (error) {
>  		dev_err(dev, "%s: could not power up\n", __func__);
> +		if (device_may_wakeup(dev))
> +			dev_pm_clear_wake_irq(dev);

[Severity: Medium]
Will this conditional cleanup leak memory if userspace alters the wakeup
settings?

In spi_hid_core_probe(), dev_pm_set_wake_irq() is executed if
device_may_wakeup(dev) is true. The cleanup path conditionally calls
dev_pm_clear_wake_irq(dev) based on the same check.

However, device_may_wakeup() evaluates dev->power.should_wakeup, which is
mutable state controllable by userspace via sysfs
(/sys/devices/.../power/wakeup). If userspace disables wakeup after the
device is probed, the check fails, bypassing the cleanup and permanently
leaking the allocated wake_irq memory while leaving a dangling pointer in
dev->power.wakeirq. Should dev_pm_clear_wake_irq() be called unconditionally
since it handles missing wake IRQs gracefully?

[ ... ]

> @@ -1284,9 +1385,31 @@ void spi_hid_core_remove(struct spi_device *spi)
>  	error =3D shid->ops->power_down(shid->ops);
>  	if (error)
>  		dev_err(dev, "failed to disable regulator\n");
> +
> +	if (device_may_wakeup(dev))
> +		dev_pm_clear_wake_irq(dev);

[Severity: Medium]
As noted above, should dev_pm_clear_wake_irq() be called unconditionally he=
re
to avoid leaking the wake_irq structure if userspace disables device wakeup?

>  }
>  EXPORT_SYMBOL_GPL(spi_hid_core_remove);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D10
