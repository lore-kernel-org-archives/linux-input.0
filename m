Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C730C165
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869427; cv=none; b=kxUzhPjmqDsPx7948vAR1j1V8k8nzRCg79bVy4Bi3IvyTtGb2w2qCd3sOfrbmoMC5OMCME1JACl7p7DYWG00IH+/R1EDiR+uma5fCtXyF7HWjrcpFktDYra3AfdMbm9BZjB0h0paqmORCIlGZM/RcawkRZ0PDi3v3ckpF6ehuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869427; c=relaxed/simple;
	bh=mkCaHkp5kTYtS2H67/rCKosnb4mEHEHx7EntMRflNXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fsoyDtHltSUnIlioTrG23jP4NVs3I8AExoFicIMUNzifPTRRX1jhEXLqSZkaW3BMpNOa6ksOqduznSPza9IJocr8d86xSy42njRQIj39/4XpmBOACk3y1JxfDQnNxtzZLOg65SXq0/XwVeOWg03mqZJjdVa5I6XCg20kyXgRUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7XKAHkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7XKAHkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C82FC2BCB0;
	Fri, 15 May 2026 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778869427;
	bh=mkCaHkp5kTYtS2H67/rCKosnb4mEHEHx7EntMRflNXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=P7XKAHkNbTooTM/7IUdv2arJXJ7IOCvhL0vnR9+3xiN20Qw3dE8DVoulj7C5ZeM8h
	 vGgwwHTqVUwYBICwjzNggTGZ+ttgz8I5ldckyCgzjx4o+J38P4+lte89jhM+HjX5Ji
	 2lJfai4jLryg3L/8ErOOGHRRSuWXL0DPInwegcfh+cB2G3Zqt0MhfknuR+xFBdMcPk
	 SZJGtElBhnjgFYdeTrNODxAgLqVhu/zMzMsaLe1SgyF3N6OW8Dl51+0JVZM3Nsm3dB
	 yEsBemqF+USf0ItdA+LPBl/SK+MgKHrkgeJtlrwyf46+ffX1Qs9ni1G5aIRdKFFbkE
	 wgKQPC4ww+d6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: hid-lenovo-go: cancel cfg_setup work in
 hid_go_cfg_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manish Khadka" <maskmemanish@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260515174511.78486-1-maskmemanish@gmail.com>
References: <20260515174511.78486-1-maskmemanish@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 18:23:46 +0000
Message-Id: <20260515182347.6C82FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Hardware state corruption and crashes due to use of a static g=
lobal struct for device data.
- [High] The patch provides an incomplete fix for the use-after-free and in=
troduces a resource leak because it assumes the driver core calls remove() =
on probe failure.
- [High] ABBA Deadlock in `hid_go_cfg_remove()` between `cfg_mutex` and sys=
fs kernfs removal.
- [High] 'Scheduling while atomic' panic in the LED subsystem callback.
- [High] Hardware event synchronization race condition permanently corrupts=
 the command state machine.
- [High] Resource leak on unbind if the device is operating as a generic HI=
D device.
- [High] Undefined behavior in `mcu_property_out()` due to passing a NULL p=
ointer to `memcpy()`.
--

commit 304d13b89ea5c6814d905d7149a191f0e8fad93d
Author: Manish Khadka <maskmemanish@gmail.com>

HID: hid-lenovo-go: cancel cfg_setup work in hid_go_cfg_remove()

This commit cancels the go_cfg_setup delayed work in hid_go_cfg_remove() to
prevent a use-after-free if the device is unbound before the work executes.

> If the device is unbound within the
> 2 ms scheduling delay (a probe failure rolling back via remove, or a
> fast rmmod after probe), the work fires after hid_destroy_device()

Is the statement about a probe failure rolling back via remove accurate?

In the Linux driver model, the core never calls remove() if probe() fails.

If hid_go_cfg_probe() fails after scheduling the delayed work, the work
remains pending and will dereference the freed hdev when it fires, causing
the exact use-after-free crash this patch attempts to fix.

Additionally, if hid_go_cfg_probe() fails, does hid_go_probe() return the
error code without calling hid_hw_close() and hid_hw_stop(), permanently
leaking the hardware session? Should explicit cleanup be added to the probe
error paths?

> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index d4d26c7833563..b9d8cde531365 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -2408,6 +2408,15 @@ static int hid_go_cfg_probe(struct hid_device *hde=
v,
> =20
>  static void hid_go_cfg_remove(struct hid_device *hdev)
>  {
> +	/*
> +	 * cfg_setup is scheduled from hid_go_cfg_probe() with a 2 ms delay
> +	 * and dereferences drvdata.hdev.  Drain it here before tearing
> +	 * down so the workqueue cannot run after hid_destroy_device()'s
> +	 * put_device() has released the underlying hdev and dereference
> +	 * a stale drvdata.hdev pointer.
> +	 */
> +	cancel_delayed_work_sync(&drvdata.go_cfg_setup);

This isn't a bug introduced by this patch, but does the driver use a global
static variable (static struct hid_go_cfg drvdata) to store device state?

A second device probe would unconditionally overwrite drvdata.hdev and
re-initialize both drvdata.cfg_mutex and drvdata.go_cfg_setup.

Re-initializing an active mutex destroys its wait lists, and re-initializing
an active delayed work overwrites its linked list pointers, leading to
immediate memory corruption and kernel panics.

Should the device state be dynamically allocated per-instance instead?

> +
>  	guard(mutex)(&drvdata.cfg_mutex);
>  	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);

This is a pre-existing issue, but does this sequence cause an ABBA deadlock?

sysfs_remove_groups() drains all active kernfs references, blocking until a=
ny
currently executing sysfs operations complete.

However, the driver's sysfs callbacks internally call mcu_property_out(),
which acquires drvdata.cfg_mutex. If a sysfs read or write races with driver
removal, the sysfs thread holds the active kernfs reference and waits for
cfg_mutex, while the removal thread holds cfg_mutex and waits for the kernfs
reference.

Could this result in an unrecoverable deadlock?

[ ... ]

This isn't a bug introduced by this patch, but does the driver assign
hid_go_brightness_set to the led_cdev.brightness_set callback?

The LED subsystem requires this callback to be non-blocking because it can
be invoked from atomic contexts. However, hid_go_brightness_set calls
mcu_property_out(), which allocates memory with GFP_KERNEL, locks a mutex,
and blocks via wait_for_completion_interruptible_timeout().

Will this violate the LED API contract and cause scheduling while atomic
panics? Should the callback be assigned to .brightness_set_blocking instead?

This is another pre-existing issue, but does mcu_property_out() call
reinit_completion() after wait_for_completion_interruptible_timeout() retur=
ns?

If a command times out and the hardware response arrives shortly afterward,
the interrupt handler signals the completion.

The next call to mcu_property_out() will send a new command but fail to
re-initialize the completion first. Its wait_for_completion will immediately
return by consuming the stale signal, without waiting for the new response.

Does this permanently desynchronize all subsequent hardware communications?
Should reinit_completion() be called prior to sending the output report?

This is also a pre-existing issue, but does hid_go_remove() bypass hardware
cleanup if the device is operating as a generic HID device?

In hid_go_probe(), if get_endpoint_address() fails (e.g., returns -ENODEV),
the driver returns 0 to allow generic HID operation, leaving the hardware
started and open.

During unbind, hid_go_remove() calls get_endpoint_address() again. If it
returns <=3D 0, the function returns immediately instead of falling through=
 to
the default case.

Does this mean hid_hw_close() and hid_hw_stop() are bypassed entirely,
permanently leaking the HID hardware session and its resources?

Finally, this is a pre-existing issue, but does mcu_property_out()
unconditionally execute memcpy(dmabuf + header_size, data, len)?

Several hardware commands, such as GET_VERSION_DATA, invoke this function
with data =3D=3D NULL and len =3D=3D 0.

Under the C standard, passing a NULL pointer to memcpy() is undefined behav=
ior
regardless of the length. This triggers UBSAN kernel panics if enabled and
allows aggressive compiler optimizations to discard the operation.

Should the copy be conditionally guarded by if (len > 0) or if (data)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515174511.7848=
6-1-maskmemanish@gmail.com?part=3D1
