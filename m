Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF73CDBA9
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587637; cv=none; b=CWHNW7CsfB+PlBm6PSLwAJCtGY7eLG7/hEkLR5QP/94lo7iKhdzjzV/uJOrvRKBCCugEleABJDxAkSAMdyT+1lYiLcNuxhk4oPj8lKZ7VXac2UUbCHc/RbalnOyPt6IOzSri2ZONtehLEDxo+xsnSaQ/dfJ6kIoY1G8oC9qCP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587637; c=relaxed/simple;
	bh=4i6Bje3eRxhheHZnoraIobzxpVJnKRfT9Ug4QqnRm9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nORUkGhIuU0MHgW/5roKYuo+FTvnt7PX1xI1/HnBYtrgZnzdrw7BsdLINxvqAlfDVwMpn+AEUp9Bw2YkCQVUQkiezPM4M54OC8+Jcq0HU2XouexBXwQkIOQwxcr48ZEa2uN2cf8v4bJlUyRyWIUluHiQSGeozKD3nvZhLU5L2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2wuE4ws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2wuE4ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11A91F000E9;
	Tue, 16 Jun 2026 05:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587635;
	bh=C47xCpTrea4Ztv0x5Cl3oZM8CAsTrl6kgG7Vq6J14PM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2wuE4wsxEdFLPq/gPSKKLaqoSZXw14oUVFl7fe+Gvf7FDwWvgMtrI7HOytNinZaS
	 sW0tjLoyNZ55ly1ZikIT+m1pbcSsDhh0zXSgS7C7jw/7TCnf+SRGfwZyneBssJ0Tao
	 ub8qijzWpcWS35jxGn+hDZyeCrgPi6ucZhfdyh7maii0m45CRm5YYX+zNtgR1s9bWa
	 lA45BYDj6g7EH82pIsDUi3E3GlDjOkEIBmKFekt8zZMXSYvDfqOZlSBcmvSXUGZ5Mv
	 xDrQLWxZ6GCQlRGTscRxnj2OyvpVRVwvFxJxf2t+TbexL9CXMYlCrYdszStPqKdjc3
	 UkZQT4k0RsKbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] Input: sur40 - fix input device registration
 ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:27:15 +0000
Message-Id: <20260616052715.B11A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious USB device can cause the input polling thread to hang =
indefinitely in an infinite loop.
- [High] Device unplug while streaming causes a deadlock in `sur40_stop_str=
eaming()`.
--

commit e70bc2bfbadc0d9c5dd284e6e5e9d8bace3e06fd
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: sur40 - fix input device registration ordering

This patch changes the device registration ordering in sur40_probe() to
ensure V4L2 components are initialized before the input device is registere=
d,
preventing a race condition. It also updates sur40_disconnect() to
unregister the input device first, stopping the polling worker thread
before cleaning up V4L2 structures.

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index fe63d53d56db0..8639ec3ad7038 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -823,11 +823,12 @@ static void sur40_disconnect(struct usb_interface *=
interface)
>  {
>  	struct sur40_state *sur40 =3D usb_get_intfdata(interface);
> =20
> +	input_unregister_device(sur40->input);
> +
>  	v4l2_ctrl_handler_free(&sur40->hdl);
>  	video_unregister_device(&sur40->vdev);

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing deadlock
when the device is unplugged while streaming.

If the device is physically disconnected, sur40_disconnect() calls
input_unregister_device() which synchronously stops the polling worker thre=
ad.
When the application then closes the video file descriptor,
sur40_stop_streaming() is invoked:

drivers/input/touchscreen/sur40.c:sur40_stop_streaming() {
    ...
    vb2_wait_for_all_buffers(vq);
    sur40->sequence =3D -1;

    /* Release all active buffers */
    return_all_buffers(sur40, VB2_BUF_STATE_ERROR);
    ...
}

Because vb2_wait_for_all_buffers() blocks waiting for the now-dead polling
worker to return queued buffers, and the manual buffer release
return_all_buffers() is executed after the wait, will this code deadlock the
system call?

>  	v4l2_device_unregister(&sur40->v4l2);
> =20
> -	input_unregister_device(sur40->input);
>  	kfree(sur40->bulk_in_buffer);

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing Denial of
Service vulnerability where a malicious USB device can cause the input
polling thread to hang indefinitely.

In sur40_poll(), the driver reads bulk messages and calculates packet_blobs:

drivers/input/touchscreen/sur40.c:sur40_poll() {
    ...
    packet_blobs =3D result / sizeof(struct sur40_blob);
    // ...
    for (i =3D 0; i < packet_blobs; i++) {
        need_blobs--;
    ...
}

If a malicious USB device sends exactly 16 bytes (the size of struct
sur40_header) with count > 0, result will be 0, leading to packet_blobs =3D=
 0.
The inner loop is skipped, leaving need_blobs unchanged.

Because need_blobs never decrements, could the outer do { ... } while
(need_blobs > 0) loop spin indefinitely, hanging the worker thread and
blocking cancel_delayed_work_sync() during module removal and device
cleanup?

>  	kfree(sur40);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616051235.1549=
517-1-dmitry.torokhov@gmail.com?part=3D1
