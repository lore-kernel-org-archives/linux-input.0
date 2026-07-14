Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B46C47CC85
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037873; cv=none; b=FW/yEC/Jh/fgwFYAC5N128KQiDdX9MdK+bzK3KoCP0EkEI+peVCf9qj3HGoPow4WeznkJKUh+DkaXhJ9Pp8HnwBRnqKqQEr6E6LbnEnW7tT+INWQdJriQJZAeJjJXlhsBF+E/6py//bKeOyt39A/ov0PMZDTuIsb+00oxfHb5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037873; c=relaxed/simple;
	bh=Ad0VW4gm3LIVU3AFKrEBthZrF+k+tZURYJIRKYX2gSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MHlbDHryY1wtSsO4mpS8D7LkML2hWf5zvtFhQwPB2q9A0YEFgPD6QyLYRig/lqncwcwtaB1tci1pGNzQMD79DtrV9ovsgu0ONG0UcjVT2aAgeDqtHMja6eSIeiE7Qb079AhNMu2Xc/FKr30GPBMyzrpTNaJW80jDRToAje0bsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAHSBG7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAHSBG7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9720B1F000E9;
	Tue, 14 Jul 2026 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037871;
	bh=GxoN1l652xkBuv6dZJOkUphiqyazLS2Gk3cHz/VVL6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAHSBG7NLCvBTyA7ViShKAuUHWTgS2ak51kGeJ15FqulslwmsADfH4jQGrnboQQ47
	 YTjKGsPLkWafC4j9F19Pb/AQn1YFTKy5sY/D+wBqI+2nIELeJabcKnYChF36zwvPY2
	 m+pszKB5OUMB4OeO+sLXJ7tdAlmZDwXCKCqhJHOU7L6Z6i77SkDf/4vhnEitK8hUp0
	 7UDyyHCACOQJf/AgxIxn/lpIhDCHw3GpoBAH0+OCTB7jtKkCt76D84TllQ/Ft4Vr2Z
	 r9Fl33sG0s3B42Bbydtop31dVuQDR5x9174cdxZ7sUnD109y1LGt3HcVGtxOeaWAJB
	 G5zaYLINMud1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: cp2112: fix out-of-bounds read in
 cp2112_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714131611.269929-4-yaojiale02@163.com>
References: <20260714131611.269929-1-yaojiale02@163.com>
 <20260714131611.269929-4-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:04:30 +0000
Message-Id: <20260714140430.9720B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cancel_delayed_work_sync() on the probe error path can lea=
d to Use-After-Free of devm-allocated dev structure.
- [High] Race condition in cp2112_remove() due to premature and conditional=
 cancellation of the delayed work.
- [High] Lockless updates to dev->read_data and dev->read_length lack requi=
red memory barriers when signaled via atomic flags.
- [High] A TOCTOU race condition on dev->read_length in cp2112_read() can b=
ypass length checks and return uninitialized kernel memory.
- [High] Using an interruptible wait in cp2112_wait() allows signals to per=
manently desynchronize the hardware response state.
--

--- Patch [4]: [PATCH 4/4] HID: cp2112: fix out-of-bounds read in cp2112_ra=
w_event ---
commit 1ea70eb400858ee9a4d1aa2528079b6370e4b0a8
Author: Jiale Yao <yaojiale02@163.com>

HID: cp2112: fix out-of-bounds read in cp2112_raw_event

The TRANSFER_STATUS_RESPONSE path dereferences xfer->length at
offset 6, requiring sizeof(*xfer) bytes.  The DATA_READ_RESPONSE
path uses the device-supplied read_length to drive memcpy()
without clamping it to the remaining report size.  Add both
checks, and clamp read_length to size - 3.

> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 04379db93571b..99e31724a4211 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c

[ ... ]

> @@ -1463,12 +1468,18 @@ static int cp2112_raw_event(struct hid_device *hd=
ev, struct hid_report *report,
>  		atomic_set(&dev->xfer_avail, 1);
>  		break;
>  	case CP2112_DATA_READ_RESPONSE:
> +		if (size < 4) {
> +			hid_err(hdev, "short data read response(%d < 4)\n", size);
> +			return 0;
> +		}
>  		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
> =20
>  		dev->read_length =3D data[2];
>  		if (dev->read_length > sizeof(dev->read_data))
>  			dev->read_length =3D sizeof(dev->read_data);
> =20
> +		if (dev->read_length > size - 3)
> +			dev->read_length =3D size - 3;
>  		memcpy(dev->read_data, &data[3], dev->read_length);
>  		atomic_set(&dev->read_avail, 1);

[Severity: High]
This is a pre-existing issue, but does this lockless update to dev->read_da=
ta
and dev->read_length lack required memory barriers?

In cp2112_raw_event(), dev->read_data is updated and then read_avail is
signaled locklessly:

    memcpy(dev->read_data, &data[3], dev->read_length);
    atomic_set(&dev->read_avail, 1);

However, the consumer in cp2112_wait() evaluates atomic_read() locklessly,
and cp2112_read() reads the payload without an acquire barrier:

cp2112_wait():
    ret =3D wait_event_interruptible_timeout(dev->wait,
        atomic_read(avail), msecs_to_jiffies(RESPONSE_TIMEOUT));

cp2112_read():
    memcpy(data, dev->read_data, size);

On weakly ordered architectures, could the CPU reorder the producer's data
write after the flag set, or the consumer's data read before the flag check,
leading to stale memory reads and I2C data corruption?


[Severity: High]
This is a pre-existing issue, but does the error path in cp2112_probe()
leave the delayed work running?

drivers/hid/hid-cp2112.c:cp2112_probe() {
...
err_gpiochip_remove:
    gpiochip_remove(&dev->gc);
err_free_i2c:
...
}

If gpiochip_add_data() succeeds, the GPIO chip is exposed and its IRQ can be
immediately requested, scheduling the gpio_poll_worker.

If a subsequent initialization step fails, the probe function jumps to
err_gpiochip_remove and removes the gpiochip, but fails to cancel the
delayed work before the dev structure is freed.

Could this lead to a Use-After-Free of the dev structure?


[Severity: High]
This is a pre-existing issue, but is there a race condition in
cp2112_remove() due to premature cancellation of the delayed work?

drivers/hid/hid-cp2112.c:cp2112_remove() {
...
    if (dev->gpio_poll) {
        dev->gpio_poll =3D false;
        cancel_delayed_work_sync(&dev->gpio_poll_worker);
    }

    gpiochip_remove(&dev->gc);
...
}

Because the GPIO chip is still registered when the cancellation is evaluate=
d,
a concurrent IRQ request can execute cp2112_gpio_irq_startup(), setting
dev->gpio_poll =3D true and scheduling the work just after the cancellation
check but before the chip is removed.

Once remove() completes and dev is freed, will the scheduled work cause a
Use-After-Free?


[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race on
dev->read_length in cp2112_read()?

drivers/hid/hid-cp2112.c:cp2112_read() {
...
    if (size > dev->read_length)
        size =3D dev->read_length;

    memcpy(data, dev->read_data, size);
    return dev->read_length;
}

If a spurious or delayed USB CP2112_DATA_READ_RESPONSE packet is processed
concurrently by cp2112_raw_event(), dev->read_length can increase between
the bounds check and the return value.

Since cp2112_read() reads dev->read_length locklessly twice, could it copy
fewer bytes than it returns? This would cause the caller cp2112_i2c_xfer()
to advance its buffer by the larger returned value and leak uninitialized
heap memory to the userspace I2C client.


[Severity: High]
This is a pre-existing issue, but does using an interruptible wait in
cp2112_wait() allow signals to permanently desynchronize the hardware
response state?

drivers/hid/hid-cp2112.c:cp2112_wait() {
...
    ret =3D wait_event_interruptible_timeout(dev->wait,
        atomic_read(avail), msecs_to_jiffies(RESPONSE_TIMEOUT));
    if (-ERESTARTSYS =3D=3D ret)
        return ret;
...
}

If a user process executing an I2C transaction receives a signal,
wait_event_interruptible_timeout() aborts with -ERESTARTSYS. The driver
exits, but the hardware will eventually deliver the response for the
aborted transaction.

Because the hardware lacks transaction IDs, will this late response falsely
satisfy the cp2112_wait() of the next I2C transaction, returning garbage
data or false success?

Should the driver use wait_event_timeout() for short hardware
synchronization instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714131611.2699=
29-1-yaojiale02@163.com?part=3D4
