Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531225B09D
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185877; cv=none; b=Oincp5FikF43q6Q37AlhNxI/0zkyD2FvQY4AiPLgYddyWHlbLJr+1sPTW6YbsDndXdCs7+Z5pI3L2bss6QAALMWLZ7SIU6EY2cmyTwrdzvGrgUAIEMKe6aoaFMhWgiLisxS2j+4dIRyqyaa1agGNgwz7GgENP8qI6BDPPu5Ktmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185877; c=relaxed/simple;
	bh=a9DUlZzQCB2GJGSOO90QfxPqhmD+/yc97ClZ3hStlnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZF4k/Vk3ezoJzAk/YH/fzX42IEFn9o8cXF2lZkSP4b3353Ugmu7Ha9wfuChKt4cN/XO9m4cs+zI7iaoR4iDfglxdFs2PxQFLIC0TUBFxOoIXk7zKXKHrAQCyXJEliIihNKOs7o0TGD92Ir4xTjynsAsSipnq1ve/cV3gATKUlho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+XatCP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+XatCP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863831F000FF;
	Sat, 12 Sep 2026 04:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789185875;
	bh=+zdSYEC3rnFrzP8OPnFvQWIbgLcMMuQOYk72t+u2DFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+XatCP9HmxjeJdmHd12VLnmA33y8k+ajkx3kRFYw2TEI2y9zBym+dAU0VfYE9rII
	 ToWWjUPOQyAfWFuVdwoMaX6GSCC0c4Fu3KifKeZWuYQqQZ65BDwX+U55MFQ3iAtW9C
	 YfNCI2wbhKmrV0X22LO8JwNKxs+9xS2CfcSF1ZP8e6BbryaSRT0RMStZteDEzeYxDz
	 J3ZLCVNTS7xPzTEtK82pXrLFwYurrrhnYnSy/mXvxAKTfLer2BU2d46172bD1RAIit
	 dZ5qT5k9GVrjohkW9aQDjW6umLaxwU8DF2YOXRmaNSG0eaDhSUrLI9+lvAk/t9LzbJ
	 LLHgpQYOJFjug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: sur40 - fix use-after-free in v4l2_release on
 disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912035306.13130-1-kartikey406@gmail.com>
References: <20260912035306.13130-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 04:04:35 +0000
Message-Id: <20260912040435.863831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `sur40_probe` error path executes a newly added `sur40_video_r=
elease` callback synchronously, causing catastrophic Use-After-Frees and do=
uble frees of the `sur40` structure.

Pre-existing issues:
- [High] Premature destruction of the V4L2 control handler in `sur40_discon=
nect` allows active or new ioctls to access freed memory and a destroyed mu=
tex.
--

commit d6c7a72108e0520323af3e9a931c367af91b2e23
Author: Deepanshu Kartikey <kartikey406@gmail.com>

Input: sur40 - fix use-after-free in v4l2_release on disconnect

The commit attempts to fix a use-after-free in v4l2_release on disconnect
by introducing a proper .release callback for the video device. This defers
freeing the sur40 structure until the last reference is dropped.

Tested-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Reported-by: syzbot+34957180b0ed2581edaf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D34957180b0ed2581edaf

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 09d8c5f8d09fc..7936f3d78454d 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c

[ ... ]

> @@ -820,6 +822,16 @@ static int sur40_probe(struct usb_interface *interfa=
ce,
>  	return error;
>  }
> =20
> +static void  sur40_video_release(struct video_device *vdev)
> +{
> +	struct sur40_state *sur40 =3D container_of(
> +						vdev, struct sur40_state, vdev);
> +
> +	v4l2_device_unregister(&sur40->v4l2);
> +	kfree(sur40->bulk_in_buffer);
> +	kfree(sur40);
> +}

[Severity: High]
If input_register_device() fails in sur40_probe(), the error path calls
video_unregister_device(&sur40->vdev). Since there are no open file
descriptors during probe, won't this synchronously invoke
sur40_video_release() and free the sur40 structure?

The error path in sur40_probe() then continues to execute:

err_unreg_video:
	video_unregister_device(&sur40->vdev);
err_free_ctrl:
	v4l2_ctrl_handler_free(&sur40->hdl);
err_unreg_v4l2:
	v4l2_device_unregister(&sur40->v4l2);
err_free_buffer:
	kfree(sur40->bulk_in_buffer);
err_free_input:
	input_free_device(input);
err_free_dev:
	kfree(sur40);

Does this lead to use-after-free and double-free bugs on the probe error
path?

> +
>  /* Unregister device & clean up. */
>  static void sur40_disconnect(struct usb_interface *interface)
>  {
> @@ -829,10 +841,6 @@ static void sur40_disconnect(struct usb_interface *i=
nterface)
> =20
>  	v4l2_ctrl_handler_free(&sur40->hdl);
>  	video_unregister_device(&sur40->vdev);

[Severity: High]
This isn't a bug introduced by this patch, but won't freeing the control
handler here allow a use-after-free if a userspace process holds an open fi=
le
descriptor and issues concurrent VIDIOC_S_CTRL ioctls?

If v4l2_ctrl_handler_free() destroys the handler and its mutex while the
video device is still open, concurrent ioctls can access the freed nodes and
destroyed mutex. Should v4l2_ctrl_handler_free() also be deferred until
sur40_video_release()?

> -	v4l2_device_unregister(&sur40->v4l2);
> -
> -	kfree(sur40->bulk_in_buffer);
> -	kfree(sur40);
> =20
>  	usb_set_intfdata(interface, NULL);
>  	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912035306.1313=
0-1-kartikey406@gmail.com?part=3D1
