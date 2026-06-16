Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E743CF668
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587601; cv=none; b=VjNT9AaFfqLVXlQoxdHKqGZjZ3EQboNwHwXKSm8uU0Ke2oGh6q1LEcHvzsSrpc+Rjqaa+q8pXdh2Pe4IjGQP108AncOB1nnUzdhgabvNmJTuxXwSfb4IfhIb8oyT/X68UCb8MEL1/GZwxPYG6VUMqve8+U1Hn/G6vMR6yVE0YJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587601; c=relaxed/simple;
	bh=x7rA+Qi6IEMfuF+oxIIkQs683Iic3pB7pqYIq2YZ8BU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TF9iGf1zIJNzjeVqF7Y005HGWIs3VFws0IDtRzS2XwNVO+G/qZrl79GEu+3kYDRWu7Dy84/Ip5X7nWWnzvKQzevLxJulM0K3wb+hv5H5XnGIsrt2gA6FNrRiwrhhF/0RAU0TjxalWsprgwcn7Ns9gP/mJ4NqNOLeEYprtLCKwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHCcfEUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHCcfEUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB16A1F000E9;
	Tue, 16 Jun 2026 05:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587600;
	bh=MOC1SMz03MUNe+JmUGgz9Z2HbmBexMgcoiMv1CgqHC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHCcfEUsokQ0Mk7npqJ9Yi1n9PReVliRUO1VXRIPtFwYs1kGLSfiCy0e01Cu4gm3M
	 iBpyG2SK78WQFagpnsdBNJqXc0p3LAc/p2p4Gm/nxc8ZYDwKM7ICuXfnfJMgzp+86d
	 sIRROHsN3T/yfcnPVvWq6boTJEgn0AwMPiZrldfNLKZP9zTQdHvv7/OgVZCGNYRmwL
	 VK661xO2SvZ+k+8zTme1BYi2QQDBzODOqJI9+V8HHFbNUxY+v7usZgUec81ZJ4JWEx
	 vgmyQGGcBwe7Ib8FqMTwC5R+/ucxj7sakywap7ZmgJIJ73wFGy4PnqKKiys2twZyaK
	 rdgmfST47TZ9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Input: sur40 - fix V4L2 video device lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616051235.1549517-4-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:26:39 +0000
Message-Id: <20260616052639.CB16A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Calling `v4l2_device_disconnect()` after `video_unregister_dev=
ice()` causes a deterministic use-after-free on device unplug.
- [Critical] Double-free and use-after-free of the `sur40` structure and V4=
L2 components if `video_register_device()` fails during probe.

Pre-existing issues:
- [High] `sur40_stop_streaming()` hangs forever waiting for buffers to be r=
eturned by a stopped polling thread.
- [High] Lingering input device file descriptor allows Use-After-Free acces=
s to sur40->phys via EVIOCGPHYS.
--

commit c1c922112f8294f71a1841f179b4f4b61138851b
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: sur40 - fix V4L2 video device lifetime

This commit introduces a V4L2 release callback to clean up components and
free the sur40 structure only when the last video file descriptor is closed.
It updates the error path and disconnect sequence to handle this new
lifecycle.

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 1ad68131e3a64..2f0efee23d1ec 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -806,8 +806,10 @@ static int sur40_probe(struct usb_interface *interfa=
ce,
>  	}
> =20
>  	error =3D sur40_init_input(sur40);

[Severity: High]
This is a pre-existing issue, but could there be a use-after-free when
userspace queries EVIOCGPHYS?

Inside sur40_init_input(), the input device's phys path is pointed directly
to the sur40->phys array:

sur40_init_input()
    input->phys =3D sur40->phys;
   =20
If the video device is closed, the new release callback frees the sur40
structure. If a userspace process still holds the input device open, a
subsequent EVIOCGPHYS ioctl will read from the freed sur40 memory.

> -	if (error)
> -		goto err_unreg_video;
> +	if (error) {
> +		video_unregister_device(&sur40->vdev);
> +		return error;
> +	}
> =20
>  	/* we can register the device now, as it is ready */
>  	usb_set_intfdata(interface, sur40);
> @@ -815,8 +817,6 @@ static int sur40_probe(struct usb_interface *interfac=
e,
> =20
>  	return 0;
> =20
> -err_unreg_video:
> -	video_unregister_device(&sur40->vdev);
>  err_free_ctrl:
>  	v4l2_ctrl_handler_free(&sur40->hdl);
>  err_unreg_v4l2:

[Severity: Critical]
Does this error path cause a double-free if video_register_device() fails
earlier in sur40_probe()?

If video_register_device() fails internally during device_register(), the
V4L2 core handles cleanup by dropping the reference count, which
synchronously invokes the new sur40_video_release() callback. That
callback frees the control handler, buffer, and the sur40 structure.

Jumping to err_free_ctrl on failure will then call v4l2_ctrl_handler_free()
and kfree() again on the already-freed pointers.

> @@ -835,13 +835,8 @@ static void sur40_disconnect(struct usb_interface *i=
nterface)
>  	struct sur40_state *sur40 =3D usb_get_intfdata(interface);
> =20
>  	input_unregister_device(sur40->input);

[Severity: High]
This is a pre-existing issue, but does this sequence cause a deadlock when
sur40_stop_streaming() is eventually called?

Calling input_unregister_device() synchronously stops the input polling
thread (sur40_poll). Later, when the video device is closed and
sur40_stop_streaming() is triggered, it invokes vb2_wait_for_all_buffers().
This waits indefinitely for buffers that can only be returned by the
now-dead polling thread.

> -
> -	v4l2_ctrl_handler_free(&sur40->hdl);
>  	video_unregister_device(&sur40->vdev);
> -	v4l2_device_unregister(&sur40->v4l2);
> -
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
> +	v4l2_device_disconnect(&sur40->v4l2);

[Severity: Critical]
Will this dereference the newly freed sur40 memory?

If there are no open file descriptors, video_unregister_device() drops the
final reference to the video device. This synchronously triggers the
new sur40_video_release() callback, which executes kfree(sur40).

Immediately after, v4l2_device_disconnect(&sur40->v4l2) is called, which
would access the freed memory. Should the order of these two calls be
swapped?

> =20
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616051235.1549=
517-1-dmitry.torokhov@gmail.com?part=3D4
