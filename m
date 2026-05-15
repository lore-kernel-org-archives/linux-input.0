Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78F3F9293
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861911; cv=none; b=RT/AROTLNrE5UhoXTRR3nLuYoyPNYeD+ZqjuIvqaYFAjzSlcGN+nKPV2qbXEYWsa2yF4uN277p+GQIj3KYTEYyE28kC7CA3yO3rex9oVFJZTr6Ee1v1phAhgZtTr9CuivZPvRb4chLV1XJ/EPSm9YkS9DCrCsQaPuitBNpmNGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861911; c=relaxed/simple;
	bh=S8xyMLM8WxSQmi0VNkR9FKw0XrTUh+VRyrz7EAv8scE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDA4V59LrsdGuDFgl6LghNwC118e5nHqL94w/Cbylfg64YJVAFt0io6+TQI9ApW958U8KdfyMyIqm2MmrZ7NpjvPKiJMqBIAgtwYR29dKY78cMq2eUz0bKq70nTHPul/WrsqE6innbhwrFr6JwD1uGIOHelYISqX3Vnudkw+MVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOuIx1tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOuIx1tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E2BC2BCB3;
	Fri, 15 May 2026 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778861911;
	bh=S8xyMLM8WxSQmi0VNkR9FKw0XrTUh+VRyrz7EAv8scE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IOuIx1txv/+F2CI14mG3rH1eMUK+Q0MZmvAvbPJsq0Hf1B+onQcevxQDFDRYl3kwF
	 1MZz3PpskJ9gqvdRGTrOP27OL/KkcYbMMrhKh3tIyh2mlvEisQ9MUAcI1f13zEMV2D
	 KOJqLCesg8YUSb8q1oz7N2tJYfu/6V4I3IX5j7jQUnaWSklMMjPk8EETlNJ8ZOWGtJ
	 EJUs6EVqrTyw0MvNEb1lWOvAFPuJpw4wlmSMR4+HxOxoMgB+A5/sBbRxBJbsBY1tcI
	 zY4LJvmABmsnb9VvCQ0I4oga2qfqU6uO+EXv26CQQForPfrh6FW4u+VmT64AQxnZ3T
	 ZWTkJCcj2wcFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-lenovo-go: cancel cfg_setup work in
 hid_go_cfg_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manish Khadka" <maskmemanish@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260515153607.76175-1-maskmemanish@gmail.com>
References: <20260515153607.76175-1-maskmemanish@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 16:18:30 +0000
Message-Id: <20260515161830.E6E2BC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] AB-BA deadlock between device removal and sysfs operations.
- [High] Global state corruption due to static per-device structs.
- [High] Use-After-Free window due to mixing devm registration with explici=
t teardown.
- [High] Resource leaks on probe error paths.
- [Medium] Unconditional success return in `mcu_property_out()` masks timeo=
ut errors.
- [Medium] Probe arbitrarily fails due to incorrect `schedule_delayed_work(=
)` boolean logic.
- [Low] Commit message mechanism explanation is factually incorrect.
--

commit 8001481b81b1932a98238ba0e2de3079e8807d91
Author: Manish Khadka <maskmemanish@gmail.com>

HID: hid-lenovo-go: cancel cfg_setup work in hid_go_cfg_remove()

This commit drains the delayed go_cfg_setup workqueue at the start of
hid_go_cfg_remove() to prevent it from dereferencing a stale device pointer
after teardown. It places the cancellation before the mutex acquisition to
avoid deadlocks.

Cc: stable@vger.kernel.org

> If the device is unbound within the 2 ms scheduling delay (a probe
> failure rolling back via remove, or a fast rmmod after probe), the
> work fires after hid_set_drvdata(NULL) has cleared the back pointer,
> leaving cfg_setup() with a NULL or stale drvdata.hdev.

This isn't a bug, but the explanation of the mechanism seems slightly
inaccurate.

Does hid_set_drvdata(hdev, NULL) only clear hdev->dev.driver_data rather
than the global drvdata.hdev variable?

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index d4d26c7833563..ef69869f0a009 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -2408,6 +2408,13 @@ static int hid_go_cfg_probe(struct hid_device *hde=
v,
> =20
>  static void hid_go_cfg_remove(struct hid_device *hdev)
>  {
> +	/*
> +	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay;
> +	 * drain it here before tearing down so the workqueue cannot run
> +	 * after hid_set_drvdata(NULL) and dereference a stale drvdata.hdev.
> +	 */
> +	cancel_delayed_work_sync(&drvdata.go_cfg_setup);

The driver uses static global structures for device state (drvdata) and
LED attributes.

If multiple Legion Go controllers are connected, or a device is rapidly
re-bound, does re-initializing an active mutex or delayed workqueue, and
re-registering an already-linked LED struct corrupt internal kernel linked
lists and lock wait queues?

> +
>  	guard(mutex)(&drvdata.cfg_mutex);
>  	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

In hid_go_cfg_remove(), guard(mutex)(&drvdata.cfg_mutex) acquires the
mutex before calling sysfs_remove_groups(). sysfs_remove_groups() drains
kernfs active references, blocking until any currently executing sysfs
operations finish.

If the driver's sysfs callbacks acquire drvdata.cfg_mutex via
mcu_property_out(), can this cause an AB-BA deadlock if a sysfs operation
runs concurrently with device removal?

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

The RGB LED class device and RGB sysfs attributes appear to be registered
using devm_* APIs, which clean up resources after the driver's .remove()
callback finishes.

If hid_go_cfg_remove() explicitly stops and closes the hardware here,
could userspace accessing the LED brightness or RGB sysfs files in the
window between hardware teardown and devres cleanup cause a use-after-free
when the sysfs callbacks call hid_hw_output_report()?

>  	hid_set_drvdata(hdev, NULL);
>  }

Looking at hid_go_cfg_probe(), if a step after sysfs_create_groups() fails,
the function returns an error without calling sysfs_remove_groups().

Does this leave dangling sysfs files that could be accessed later?

Also, if hid_go_cfg_probe() returns an error, does hid_go_probe() leak the
hardware open references by failing to call hid_hw_stop() and
hid_hw_close()?

In hid_go_cfg_probe(), the driver checks ret =3D schedule_delayed_work(...)
and fails the probe if !ret.

Since schedule_delayed_work() returns false (0) when the work is already
pending, and the driver uses a single global workqueue structure, will a
second device fail to probe if it connects before the first device's work
fires?

In mcu_property_out(), wait_for_completion_interruptible_timeout() is used
to wait for hardware responses. If a timeout occurs, ret is set to -EBUSY.

Because the function ends with an unconditional return 0, does this drop
the error code and mask communication failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515153607.7617=
5-1-maskmemanish@gmail.com?part=3D1
