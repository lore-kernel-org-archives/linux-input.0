Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8951168BD
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779649175; cv=none; b=IbxkQPZUVzxTR/3CI4Q8qd/CFnR7/AyaqrGvk0VbjCE3N1wPvpvHUfVty/45yNOn0jdbcYFfCWhdvZpsgzCr4LiDmWT6V3gLKbFJEaPyRlMHmbaofeXaE7l8nuZ55uS4rASu8K2e+CeJH6QT+zvfNptmqd/5ZIsO7eLXTUBtyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779649175; c=relaxed/simple;
	bh=0/5R9PmW+mdLmDmuTC4xJw7T1AO4UVaunMhi/L0AvRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UkQIpmeC7gpqu4btrM8FxT9QagoK/e5tkdITGKX3EPFG0UdYtG26k6q0zjnZtyhdWMvEDwnzLAT4mSOsw2Ohm9WWauecOlh9eyi/4kQNuqQk2RcZaDBK2sL4Fzwg6m+pWARrcsanw/HUdDzyDhmnwOeN1oy5BxCiHpF7aHj8YnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot5qNfkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot5qNfkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F871F000E9;
	Sun, 24 May 2026 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779649174;
	bh=uoIBso1jihG1VVFdOZSNd8fQCC5mFR7PsTdOFuv9psk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ot5qNfkJs3gVZ6vKBq2WCNjbZTCtypHVjyWC7W/zbhM5aKQeTLJcv9/V/iaOo9bcv
	 G1D8m33tA35RdGXmyuX0m4uLJK+ONYmhG9W/JnM6dWyIJoY0Un2J2po+UDa2gqrefy
	 CBiz1mgd3TvxaZ7dZjKuHb7mrIjtTnNNHBSGkgWyChcYhDo6/nW4FY8+tTI8ZweydA
	 x8gj9vXrcIamxBJ3+QL3QkDTv9GeQPwvFChxezqiFUkCajnU4ktilYPlv1LgFKbiyH
	 zL3m5ovowCYMXxmqCaO9VVz4isbQVXPXMJ/nYzqlBeF2nK8/VXqQcxx+5GP1lPwlSe
	 6jHCoGRSOVWWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: rmi4 - release F54 queue on video registration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260524182351.27658-1-mhun512@gmail.com>
References: <20260524182351.27658-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 18:59:33 +0000
Message-Id: <20260524185934.60F871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Embedding `struct video_device` and `struct vb2_queue` inside a de=
vm-managed structure causes a Use-After-Free if the device node is held ope=
n after unbind.
- [High] `destroy_workqueue()` is called in `rmi_f54_remove()` without firs=
t canceling the delayed work, risking a Use-After-Free.
--

commit f89d07a2e226d7667f0c3e90fb7262a70db54401
Author: Myeonghun Pak <mhun512@gmail.com>

Input: rmi4 - release F54 queue on video registration failure

rmi_f54_probe() initializes the videobuf2 queue before registering the
video device. If video_register_device() fails, probe only unregisters
the V4L2 device and leaves the initialized queue unwound.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index ac4041a69fcd3..d35b5164b170a 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -722,6 +722,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
>  	ret =3D video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
>  	if (ret) {
>  		dev_err(&fn->dev, "Unable to register video subdevice.");
> +		vb2_queue_release(&f54->queue);

[Severity: High]
This isn't a bug introduced by this patch, but does embedding struct
video_device and struct vb2_queue inside the devm-managed f54_data
structure cause a use-after-free if the device node is held open after
unbind?

In rmi_f54_remove(), video_unregister_device(&f54->vdev) is called, which
clears the registered flag and drops one reference to vdev. However, if a
userspace process still has the character device open, the V4L2 core has
elevated the vdev refcount.

When rmi_f54_remove() returns, f54_data is immediately freed by devres,
even though vdev still has active references. When userspace later closes
the file descriptor, v4l2_release() calls the driver's .release operation,
which dereferences the already-freed vdev and vdev->queue.

>  		goto remove_v4l2;
>  	}

[Severity: High]
This is a pre-existing issue, but is there also a use-after-free risk in
rmi_f54_remove() regarding the delayed work?

destroy_workqueue(f54->workqueue) is called in rmi_f54_remove() without
first calling cancel_delayed_work_sync(&f54->work).

destroy_workqueue() drains pending work but does not cancel or wait for
non-pending delayed_work that is only linked on the timer side. After
rmi_f54_remove() completes, f54_data is freed by devres.

When the pending timer subsequently expires, it will attempt to access the
freed f54->work structure and schedule work on the destroyed workqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524182351.2765=
8-1-mhun512@gmail.com?part=3D1
