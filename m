Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA3284690
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771508; cv=none; b=aXHHik76Q7IAQtHUVWYFXgpkhYYgOzkGML4HU3ga0CP2ahjaq0NBEHK6wfFKDaJ1BUAXlbWm6FjFG9y7NJ7SUygn7wuT7MNCDPAa6N1Gd34Z9lPgaS3P9uwD4S1BjnfuGuAjHt0gV7k0/A1u5A5JMepDtFvaKRKaRGKaXdi/5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771508; c=relaxed/simple;
	bh=LgMAc9I/u7EaLnwP3oOIlDUwoTVTjoZ7m0wBa/U3nIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Td8fLl1+iYJ2qiECe5gJ/mJZT00fo63Hi/O1l1rJhWBNU0dm9h40GGE6wlmUtPxHseCvIMuztokVAIGgHdBnUej4FgtlOrNXp8zDXyFm4BDL16wtzNTJ/EQtXo5iUxUiP/wJ+aLaJexJ81Mpxx8KwXV/0zfaqIFQaYq5Z0wGzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF3czAsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF3czAsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9651F000E9;
	Sat, 11 Jul 2026 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783771506;
	bh=IXs2ml2rP0vUf0yKMCryomwjO0fQ4nv/jgUb207Zhz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BF3czAsTDeQZhGWTMm0PLjRv/6bCjZtW9rx2Jc0l+7w8QvPh+IGRWmlY6mcB6/2c4
	 GG0zF3bISnOHQJgDSYuQOGMudGARVBb6z216eaTxVQLOwYqJ+kdOkQgpQ1iKnK50y8
	 rMhJ0rAy0DSZNN1SJRg+HKsvlL4roThkmhiB9t1PI/BMM9xgMmATIiQ8KhBw638jwq
	 eKOQ6cIu1/DbnLWFAb5u65MKp5Q06E5SICBON8SQLsp5HXb+/0SfMf63lQ0KL+WkJl
	 7RCquAAf2MhiPj7rh9+YxN4a5JnexzgkNZXn0cEgvP+41+V21EEvfVtdNCHFxgt+7B
	 s7FFnKWgJ1bBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] Input: applespi - cancel pending work on driver
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260711114937.16670-2-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
 <20260711114937.16670-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:05:06 +0000
Message-Id: <20260711120506.7B9651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multiple processing of `PACKET_DEV_INFO` causes the driver to unco=
nditionally allocate and register multiple touchpad devices, leaking previo=
usly allocated devm resources.
- [High] Potential use-after-free of `applespi->gpe` in `applespi_async_rea=
d_complete()` due to premature driver unbind.
- [High] Dereferencing `applespi->touchpad_input_dev` before it is initiali=
zed in `applespi_tp_dim_open`.
--

--- Patch [1]: [PATCH v4 1/3] Input: applespi - cancel pending work on driv=
er remove ---
commit 89c8a3961b949e3c0049b442d0905f82cd245fbd
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - cancel pending work on driver remove
   =20
This commit fixes a use-after-free vulnerability during driver removal.
It explicitly cancels the pending worker thread that registers the touchpad
device before devres frees the private data structure.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b5ff71cd5a701..3bdb9e7cfb8b2 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
> =20
>  	applespi_drain_reads(applespi);

[Severity: High]
This is a pre-existing issue, but can applespi_drain_reads() lead to a
use-after-free of applespi->gpe?

In applespi_remove(), applespi_drain_reads() waits for the read to complete:

static void applespi_drain_reads(struct applespi_data *applespi)
{
	...
	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
			    applespi->cmd_msg_lock);
	...
}

The async read callback signals completion and wakes the waitqueue:

static void applespi_async_read_complete(void *context)
{
	...
	applespi_msg_complete(applespi, true, true);
	...
	acpi_finish_gpe(NULL, applespi->gpe);
}

If applespi_remove() unblocks, completes, and triggers devres cleanup
before the read callback finishes, could the callback dereference the freed
applespi->gpe when calling acpi_finish_gpe()?

> +	cancel_work_sync(&applespi->work);
> +
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

[Severity: High]
This is a pre-existing issue, but does the driver leak devm resources if
multiple info packets are received?

When the driver receives a PACKET_DEV_INFO packet:

applespi_handle_cmd_response()
    applespi->rcvd_tp_info =3D message->tp_info;
    schedule_work(&applespi->work);

The worker unconditionally allocates and registers the touchpad device:

applespi_register_touchpad_device()
    touchpad_input_dev =3D devm_input_allocate_device(&applespi->spi->dev);
    ...
    sts =3D input_register_device(touchpad_input_dev);
    ...
    smp_store_release(&applespi->touchpad_input_dev, touchpad_input_dev);

If a malfunctioning or malicious device sends multiple PACKET_DEV_INFO
messages, does this overwrite applespi->touchpad_input_dev and leak the
previously allocated devm resources and registered input devices?

[Severity: High]
This is a pre-existing issue, but can the debugfs tp_dim file dereference a
NULL pointer?

The touchpad_input_dev is allocated asynchronously by the worker:

applespi_worker()
    applespi_register_touchpad_device()

However, the debugfs entry is created synchronously during probe:

applespi_probe()
    debugfs_create_file("tp_dim", ...);

If userspace opens the tp_dim file before the worker completes initializati=
on,
applespi_tp_dim_open() will unconditionally dereference the pointer:

applespi_tp_dim_open()
    snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
             "0x%.4x %dx%d+%u+%u\n",
             applespi->touchpad_input_dev->id.product,

Could this lead to a kernel panic since applespi->touchpad_input_dev might
still be NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711114937.1667=
0-1-fourdollars@debian.org?part=3D1
