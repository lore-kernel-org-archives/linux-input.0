Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0D331209
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377428; cv=none; b=NZss9WlBnO/Hm4urx7k7H2ndS48Z1xI1mFBAsomp+qdrpsaAS5ca5tk0rLVikGPTuVTN6ateoopsG5Fl0oC/lpVnn5dmYgoSSv4LjnhTqKANx17pBpMTwxlf4upolvzzJPMJKEM2ttx5XPvtNAfp5IidcLBGbHLV0Aw8l0Hg6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377428; c=relaxed/simple;
	bh=7W5vI6IJAU5OoDDL8dr9cd7dZQUtR1DHDpSrdaRnviU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mbA2b+hp+ULjQ4skxikk6xNFEHo4kMskDHbrLWVti+wQ+gmoIo+KcWbqYotmQvXXZCE9x6zAfgDKSZLzLtM0VuUijOyiEOQ+7INRU9+1LQ+z4JCJqsKOT4bNRJSeY2NZRF8zkiisZqhAYLWHqaxrw6F4ho+LPpf+Z7xTgYsZd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVaFYBuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVaFYBuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5751F00A3D;
	Mon, 10 Aug 2026 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377427;
	bh=y6AUynOBCj/Ua2cQnI3AkuEdDDGponqxdHM3iZFQqDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVaFYBuzmfq88qdc/pjmSVDQkRzjvI2np94ng82dFq3UeJW6NOtsfArkH+pKehXY8
	 wq/kG4JT9cXMfPHQdVzyMNmJHplFLU+FiZaW2ioQnL3kCks2Y9TQqvwId5Je2ntybv
	 ZfL7L0OzRJGGGG2RgTM89n/CslnH5Fk+rjZKUUqNJgj/1g5+GhyUjxVmiOTUO/fWRe
	 KylToH+iKRt/PeUB27XYuSX00nskbPqr3eDuYKxZ3Wkp+E/Jk+Rz1qYQ4ryE+Bzwka
	 nNmjVIM/YXR3ALiPBzTLnzgfylAuWe/YHUfYeHbwrqlEajWjd77XQmxVChFs07ycAD
	 ZmWP+XjtNEbkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] input: sur40: fix error recovery in sur40_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260810153509.124147-1-dmantipov@yandex.ru>
References: <178637340988.1434984.13114510500553043049.b4-review@b4>
 <20260810153509.124147-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:57:06 +0000
Message-Id: <20260810155707.2C5751F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver frees the `sur40_state` structure synchronously in `sur=
40_disconnect()` while userspace may still hold open file descriptors to th=
e V4L2 video device, leading to a Use-After-Free when the file is later clo=
sed or accessed.
- [High] Freeing `sur40->bulk_in_buffer` before unregistering the input dev=
ice creates a use-after-free window if polling is active.
--

--- Patch [1]: [PATCH v2] input: sur40: fix error recovery in sur40_probe()=
 ---
commit e90ee91ad15aa01f67bf74f5cd08571c1f3ecf61
Author: Dmitry Antipov <dmantipov@yandex.ru>

input: sur40: fix error recovery in sur40_probe()
   =20
Since an input device which has passed 'input_register_device()' should
be released with 'input_unregister_device()', adjust 'sur40_probe()'
to do so and call 'input_free_device()' to handle device register error
only. To avoid V4L2 memory leak, ensure that 'v4l2_ctrl_handler_free()'
is called on all error handling paths, including the one after
'video_register_device()' failure.

Reported-by: syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D2a123f6269da57ffefaa
Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input d=
evices")

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 77ec2c94b91fd..9208d8404c539 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -806,12 +807,17 @@ static int sur40_probe(struct usb_interface *interf=
ace,
> =20
>  err_unreg_video:
>  	video_unregister_device(&sur40->vdev);
> +err_unreg_ctrl:
> +	v4l2_ctrl_handler_free(&sur40->hdl);
>  err_unreg_v4l2:
>  	v4l2_device_unregister(&sur40->v4l2);
>  err_free_buffer:
>  	kfree(sur40->bulk_in_buffer);
>  err_free_input:
> -	input_free_device(input);
> +	if (sur40->input)
> +		input_unregister_device(input);
> +	else
> +		input_free_device(input);

[Severity: High]
This isn't a bug introduced by this patch, but does freeing
sur40->bulk_in_buffer before unregistering the input device create a
use-after-free window?

If an error occurs after input_register_device() succeeds, userspace might
have already opened the device, starting the sur40_poll() poller.

Since the poller reads directly from sur40->bulk_in_buffer, freeing it here
before calling input_unregister_device() (which stops the poller) allows the
poller to access freed memory.

Should the error path call input_unregister_device() before freeing
the bulk_in_buffer?

>  err_free_dev:
>  	kfree(sur40);

[Severity: High]
This is a pre-existing issue, but does the driver have a use-after-free
risk when handling the V4L2 video device lifecycle?

In sur40_disconnect(), the driver synchronously frees the sur40_state
structure:

	video_unregister_device(&sur40->vdev);
	...
	kfree(sur40);

However, the video device (sur40->vdev) uses video_device_release_empty:

	.release =3D video_device_release_empty,

If a userspace process still has the video device open when the USB device
is disconnected, closing the file descriptor later will invoke
vb2_fop_release(). This will dereference the freed vdev and its queue
locks.

Could the driver be adjusted to use a properly refcounted release callback
for the video device instead of video_device_release_empty and a
synchronous kfree()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810153509.1241=
47-1-dmantipov@yandex.ru?part=3D1
