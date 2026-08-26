Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B731F9A5
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787716603; cv=none; b=b41InES2EORCs1Mq4jDFDUpUCODTcbtI3NIld9oVGYHWBsLQo/DHm0ozH9gPpXcz53g1aDDlXpEIlz9f4nmNJ7n1WNfzZagd0AWePDb6YkGzt+DuHqPe4MlGEuRMwi0JJ1vWniD9ZZBCGHAqIPDKavCDr6jdnkA9IU1i/CBAZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787716603; c=relaxed/simple;
	bh=VK8qfcim9LrRUB+kXoPPfQKcGp2AmCFwzfBBBXA8Oco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhgvG5zfbXN4cl63hddiFBElWkdzzSTK1lJmMrHBktI8fdzTN2pj96PQ0taEEOtWnmS1MKZhJMHu6Z0/JBLm3UoOLr2Zqsd1Bo4DTpqVYYQwwaAhHLwMtTm2wEXGyX+ygiOjziHo+FMRNJ8gHqVZTKLVsVI+Xlb9LjvNGqUJbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdxpVOn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdxpVOn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0541F000E9;
	Wed, 26 Aug 2026 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787716602;
	bh=GeoxOvvQ7bo5FN67QwSYVdmtDdup+OWnzpPqh8iU/ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdxpVOn7l2LXO+ySrj8V/WLyvZk8iMZt1ZatppI4WbbaP62A42uIJy7eAOuUDLFzK
	 lxlvgoJ8JcXqr3nSNi8NUgalxh5dxRHRrOL7d0c3nwBq2Zictb4uexd54GagLfidS9
	 2BrdfU8mPcPBSBH02Va1hHx+kFND1v6d/ihfl2W3fQryJ4CtXQ2wQnfhvvDgdCp3AJ
	 qdLesJa7g5fQ3QlT0sie5AowJmW1aPdmDdPaIeA6wFeGRC9W1Uys1h1iZ+gJNBLPPX
	 V+5b1hfJkZ+/eSyylvkrU/b2KelpyY/bRAnxISaOMITo48QFTNz/YTgVHYu4poTaUQ
	 0hJlcUvxLHd6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input: sur40: fix use-after-free in disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260826034239.QMESl9TtJLm8R_oB5SkE5YErhpU_WDuou8ER3A1oZmI@z>
References: <6a8e44ca.dbb3a75c.7844.002f.GAE@google.com>
 <20260826034239.QMESl9TtJLm8R_oB5SkE5YErhpU_WDuou8ER3A1oZmI@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 03:56:41 +0000
Message-Id: <20260826035642.1F0541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unkillable deadlock in `sur40_stop_streaming` during disconnect.
- [High] Hang in VIDIOC_DQBUF or poll due to missing queue abort in disconn=
ect.
--

commit 8870e5b6bd950af7749d533c844ef1b23fd8c7bb
Author: Pei Xiao <xiaopei01@kylinos.cn>
Date:   Wed Aug 26 03:42:39 2026 +0000

    input: sur40: fix use-after-free in disconnect

This commit fixes a use-after-free in sur40_disconnect() by replacing the
direct kfree() with a new vdev->release callback. This ensures the sur40_st=
ate
structure is only freed when the last userspace reference is released. It a=
lso
adjusts the error paths in sur40_probe() to prevent accessing freed memory.

Reported-by: syzbot+4a6e6173b1fc7916e950@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a8e44ca.dbb3a75c.7844.002f.GAE@google.=
com/
Cc: stable@vger.kernel.org

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 09d8c5f8d09fc..2d93234cc86a0 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -820,19 +824,23 @@ static int sur40_probe(struct usb_interface *interf=
ace,
>  	return error;
>  }
> =20
> -/* Unregister device & clean up. */
> +static void sur40_video_release(struct video_device *vdev)
> +{
[ ... ]
> +}
> +
>  static void sur40_disconnect(struct usb_interface *interface)
>  {
>  	struct sur40_state *sur40 =3D usb_get_intfdata(interface);
> =20
>  	input_unregister_device(sur40->input);
> =20
> -	v4l2_ctrl_handler_free(&sur40->hdl);
>  	video_unregister_device(&sur40->vdev);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that
unregistering the video device without aborting the pending V4L2 queue
leaves blocked ioctls waiting forever?

When the device is disconnected, video_unregister_device() is called here
without first waking up q->done_wq waiters with -EIO (e.g. by using
vb2_video_unregister_device()).=20

Because the input poller is stopped synchronously by input_unregister_devic=
e()
just above, no further frames will arrive.=20

Does this cause any thread blocked in VIDIOC_DQBUF or poll() to hang forever
until interrupted by a signal?


[Severity: High]
This is also a pre-existing issue, but does this disconnect sequence create=
 an
unkillable deadlock later on?

If userspace closes the device after a disconnect, the V4L2 core invokes
sur40_stop_streaming(), which calls:

    vb2_wait_for_all_buffers(vq);
    sur40->sequence =3D -1;

Since input_unregister_device() was already called synchronously in
sur40_disconnect(), the input polling thread is permanently stopped.=20

Does this cause vb2_wait_for_all_buffers() to block indefinitely in a
D-state, since the driver-owned buffers will never be processed and returned
via vb2_buffer_done()?

> -	v4l2_device_unregister(&sur40->v4l2);
> -
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
> =20
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826034239.QMES=
l9TtJLm8R_oB5SkE5YErhpU_WDuou8ER3A1oZmI@z?part=3D1
