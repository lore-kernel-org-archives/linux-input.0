Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86234317D
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 04:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781410472; cv=none; b=qWtqlZXCCpZvMVf9lnfHb60nKw8VB87lukIeCd+ZnjATxf8jXkSVD0/WDyN9P82WrvN2ixXgniFPJz/WauRmCYN2VpF2/nJHVVMuQTRMAfBfCZ0Y8xtDjF8Jfm7l2iYj3QDJkWbIEHGLUM8w1Q9epj4F33V3qC1d3u1E7SBa7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781410472; c=relaxed/simple;
	bh=euTSMxLuK6FsoJ2cN+pzszs/K+H4Rp75W1CiYL/3B/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UM+8vjL4oGwwLTk4fv04p3rz8rGqVXC1dzFxc2bwrBbObPICXmdUQonKQQDGF7WAclDwlGP5TUVT3DlErnE8Q54Wl+qk8tAFYUDCsbT7aakh7OovusbzW3IM/Amc36hYkIHz/2mHcAJevVf/k7WxdAhbNAC3NiXymqK9unR7R0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga/Oqnrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga/Oqnrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA651F000E9;
	Sun, 14 Jun 2026 04:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781410471;
	bh=QGF9bXhK+2O4+pJj+9XJSRpWafJ5YSmeNNAM9EuKQ9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ga/OqnrkixceNOGD7tQYPwlmx2GsAPOYg4b3v4Q4tEuTYhSiq6EArMV/uz+uhWXVj
	 ZQshRhhM1k41yLSk/VcuvFACYUmuAteSnLVdF4jXE+BPsOhHXfqX5jka/K1FPfz4gN
	 yYuhEASnhUyn5SUta1dnliet0b3YmBzCY9FpcR4lLvBopmP1PkkFnCb2VqJ+n0+4tj
	 d0Visdr1qnhIAgYkdZdxyd0CgY2Zhdo8tCffTOuU5IRNu0VVomoJL2i02glk8vQ827
	 j8kaEbciDhdAZiWNxxWn1uUCAaBtCijT/WjWTssQfZimcGqp1hl1bHfbSyM2ZR1O/e
	 1dhauRaMoxsww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - bound the F54 report size to
 the allocated buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260613-b4-disp-6721686c-v1-1-4d5bb84ee520@proton.me>
References: <20260613-b4-disp-6721686c-v1-1-4d5bb84ee520@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 04:14:30 +0000
Message-Id: <20260614041431.2FA651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stale f54->report_size causes V4L2 buffer heap overflow.
- [High] Missing cancel_delayed_work_sync in rmi_f54_remove causes Use-Afte=
r-Free.
- [High] Preexisting copy-paste typo in F55 properties parsing triggers the=
 new oversize check, permanently breaking conforming devices.
- [High] Use-After-Free of devm-managed video_device on V4L2 file descripto=
r close.
- [Medium] V4L2 buffer queue silently returns uninitialized memory on hardw=
are errors.
--

commit 08992eb2bae1821355b21e17559ef51ec82606cd
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer

This commit adds a bounds check to ensure the F54 diagnostic report size
does not exceed the allocated buffer. It rejects reports that are larger
than the allocation to prevent writing past the end of the report data
buffer.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 61909e1a39e24..7a7508a4de85c 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
[ ... ]
> @@ -548,6 +549,13 @@ static void rmi_f54_work(struct work_struct *work)
>  		goto error;     /* retry won't help */
>  	}
> =20
> +	if (report_size > f54->report_data_size) {

[Severity: High]
This is a pre-existing issue, but does this new check permanently break
conforming hardware due to a copy-paste typo in the F55 parser?

Looking at rmi_f55_detect() in rmi_f55.c, it incorrectly assigns the
RX count to the TX count:

drv_data->num_rx_electrodes =3D f55->cfg_num_rx_electrodes;
drv_data->num_tx_electrodes =3D f55->cfg_num_rx_electrodes;

For hardware lacking F55_CAP_SENSOR_ASSIGN and having more RX electrodes
than TX electrodes, this inflates the perceived TX count. This inflated cou=
nt
propagates to rmi_f54_get_report_size(), yielding a larger value that will
unconditionally fail this new bounds check.

> +		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
> +			report_size, f54->report_data_size);
> +		error =3D -EINVAL;
> +		goto error;

[Severity: Critical]
This isn't a bug introduced by this patch, but does taking this goto error
path bypass the zeroing of f54->report_size and cause a V4L2 buffer heap
overflow?

In rmi_f54_work(), error paths jump to the error: label, bypassing the
abort: label where f54->report_size is normally zeroed out. This leaves
f54->report_size containing its previous successful payload size.=20

If a user then alters the V4L2 format to a smaller size, and an error occurs
(like this bounds check failing), rmi_f54_buffer_queue() will copy the
stale, larger payload size into the shrunken V4L2 buffer:

memcpy(ptr, f54->report_data, f54->report_size);

[Severity: Medium]
This is also a pre-existing issue, but does this error path cause the V4L2
buffer queue to silently return uninitialized memory?

When rmi_f54_work() triggers this bounds check and jumps to error, the
buffer is not updated. However, rmi_f54_buffer_queue() ignores the failure
and marks the buffer as fully populated:

vb2_set_plane_payload(vb, 0, rmi_f54_get_report_size(f54));
state =3D VB2_BUF_STATE_DONE;

This completes the buffer without indicating an error to userspace.

> +	}
> +
>  	/*
>  	 * Need to check if command has completed.
[ ... ]
> @@ -678,8 +686,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
> =20
>  	rx =3D f54->num_rx_electrodes;
>  	tx =3D f54->num_tx_electrodes;
> -	f54->report_data =3D devm_kzalloc(&fn->dev,
> -					array3_size(tx, rx, sizeof(u16)),
> +	f54->report_data_size =3D array3_size(tx, rx, sizeof(u16));
> +	f54->report_data =3D devm_kzalloc(&fn->dev, f54->report_data_size,
>  					GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does allocating the f54_data struct
(which embeds struct video_device vdev) with devm_kzalloc lead to a
use-after-free when the V4L2 file descriptor is closed?

In rmi_f54_probe(), f54 is allocated using devm_kzalloc(). When the driver
unbinds, devm automatically frees f54_data.=20

If a userspace application still holds /dev/videoX open, the V4L2 core
retains a reference to the freed vdev. Subsequent ioctl calls or the final
closing of the file descriptor will access the freed vdev structure.

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of a timer
cancellation in rmi_f54_remove() cause a use-after-free?

While rmi_f54_probe() correctly uses cancel_delayed_work_sync(&f54->work)
in its error path, the teardown path in rmi_f54_remove() just destroys
the workqueue:

rmi_f54_remove() {
    ...
    video_unregister_device(&f54->vdev);
    v4l2_device_unregister(&f54->v4l2);
    destroy_workqueue(f54->workqueue);
    ...
}

This does not cancel pending delayed_work timers. If the driver is unbound
while a V4L2 stream is active, the timer will fire after devm has freed
the f54 structure and attempt to dereference f54->workqueue.

>  	if (f54->report_data =3D=3D NULL)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-67=
21686c-v1-1-4d5bb84ee520@proton.me?part=3D1
