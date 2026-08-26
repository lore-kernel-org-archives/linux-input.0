Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3B30F55B
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787716689; cv=none; b=mQH9U2WqayyoYT2TAiL3ZPI7+FnBIMR9E0ITo+/2sShqi2rTSIry5zpvXj2h7hkUJVygZEZeisFdYBioHkIQ0T3yYcu5sn0TDX0Ts4gelzbhFlowChB7D0YDRnydyK+20n9VpARscKcoM59gtrIzE+h3Hg+VYuL3bJ6rJQ8pVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787716689; c=relaxed/simple;
	bh=bO/hChNfijmUxtL5qk0D5mzm5uutlqSednWiXyGpz1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTHTIjWo4LhpnLZJh+xCkfP286a9YCh3vFJoj5gUArFuubv0ZI/Alve2F/T6EQkN++MxnsgntUry0Ps1PLPCpBnYnEE4U0zyJImCTGWVIACDTQIdKlkeeF/rOyIgePtQ0kZC6gLCD0n+19zwRMWeHo928/1fDpBuPRiPKb8VKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc7pvO1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc7pvO1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A47D1F000E9;
	Wed, 26 Aug 2026 03:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787716688;
	bh=kZyHuKfcCFHSAQBA8O8atPF3sNlQeCFusxHq95KVU44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sc7pvO1u3dZQ1QHjn/ypM77HM8uAcpl5AwtmK/+l+KllXNb00lpiwjfLoF0Dgqq54
	 +I9vQw8a+1saNRMc2CCEkpC+mO890lbgua00HVyY08JXevr98KsHYp6X8MEUto9mCi
	 HZuKxklyZ5Ge6uUjP3NVBdk5xMFaX2gl1WtDvNIlpaVf59sm9C2gQHeiDzO2UIXCeT
	 Bbmg9uLD8kA/KlRZlk/PsBtlgJBve2T5yyu6AOLkrsGHzO3ZpPGBF6ihBWbTIxJkiu
	 yhIsgfbAVwT7/NjatNDPLHJwE6vZ8t1EtLvVcGtLlpsUMNQYEkn07Z2X6ACX1Wp3Og
	 bkdcBz9c2dBTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input: sur40: fix use-after-free in disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, media-ci@linuxtv.org, linux-input@vger.kernel.org
In-Reply-To: <51e68e6de6d9e7a864a5729bac1b33bd083802f6.1787715605.git.xiaopei01@kylinos.cn>
References: <6a8e44ca.dbb3a75c.7844.002f.GAE@google.com>
 <51e68e6de6d9e7a864a5729bac1b33bd083802f6.1787715605.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 03:58:07 +0000
Message-Id: <20260826035808.0A47D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling vb2_wait_for_all_buffers() in sur40_stop_streaming() can c=
ause a permanent deadlock if the input device is not opened or if the USB d=
evice is disconnected while streaming.
- [High] Failing to use vb2_video_unregister_device() causes blocked video =
streams to hang forever, preventing memory release.
--

commit ef5f3b0676d23060459c7e109fbbbad456afb073
Author: Pei Xiao <xiaopei01@kylinos.cn>
input: sur40: fix use-after-free in disconnect

This commit fixes a use-after-free issue in sur40_disconnect() by providing
a proper release callback for the video device. It relies on the kref
mechanism triggered by device unregistration rather than immediately
freeing the state.

Closes: https://lore.kernel.org/all/6a8e44ca.dbb3a75c.7844.002f.GAE@google.=
com/

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
> +	struct sur40_state *sur40 =3D container_of(vdev, struct sur40_state, vd=
ev);
> +
> +	v4l2_ctrl_handler_free(&sur40->hdl);
> +	v4l2_device_unregister(&sur40->v4l2);
> +	kfree(sur40->bulk_in_buffer);
> +	kfree(sur40);
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
This is a pre-existing issue, but does failing to use
vb2_video_unregister_device() here at line 843 of
drivers/input/touchscreen/sur40.c cause blocked video streams to hang forev=
er?

During a physical USB disconnect, sur40_disconnect() calls
video_unregister_device() instead of vb2_video_unregister_device(). The
standard video_unregister_device() does not signal the vb2_queue to abort.

Because the input poller is stopped during disconnect, no new video frames
will arrive. Any userspace thread blocking in VIDIOC_DQBUF or poll() will
never wake up, preventing it from closing the file descriptor. This means
vdev->release is never executed and the sur40_state memory leaks.

[Severity: High]
This is also a pre-existing issue, but can calling
vb2_wait_for_all_buffers() in sur40_stop_streaming() cause a permanent
deadlock?

If the USB device is disconnected, input_unregister_device() stops the
poller. A subsequent close() of the video file descriptor will call
sur40_stop_streaming() (at line 940 in drivers/input/touchscreen/sur40.c),
which blocks waiting for buffers:

sur40_stop_streaming()
    ...
    vb2_wait_for_all_buffers(vq);

Since the poller (sur40_poll at line 525) is stopped, the buffers are never
returned, causing a hang in uninterruptible sleep. This can also be
triggered if a user opens only the video device and starts streaming without
opening the input device, as sur40_poll is only active while the input
device is opened.

> -	v4l2_device_unregister(&sur40->v4l2);
> -
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
> =20
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/51e68e6de6d9e7a864a=
5729bac1b33bd083802f6.1787715605.git.xiaopei01@kylinos.cn?part=3D1
