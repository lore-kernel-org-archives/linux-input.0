Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABFD3AC0E5
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451700; cv=none; b=kA3rN0p5c9MjLKX6McfdQd/Q43oqHz6UwcVWq+RwwSpqsyICg4s14g+5/IyyysWzUVwUrnXnHgwqfT7c/oQWEhCz36Q8PViefyuewO+MvhacRKF9LzXfFlgxEoIdqgGn+eM+FdX6QmEiXURS0WpAjcteWBWMfDQbxxGJxGIl9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451700; c=relaxed/simple;
	bh=azZaoSz5oaV8njoNv4zlvmiEJk6USTgscP5RdAcbPTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sWFIwrpVwbhP667lNPpedDjBlXhkCPfCQzgzzcjeNzuw4WanotBTHLGh5skBNJv8Idw49XBTq/NHIxKBm7Q4Hi+srESGzE70LA3MnNBLs9b2GCqHjxF1bN23eweMRxgSfyEcqbx4BBTULDtB3QJp83Xrzjq5kQa9+LAnhkvMle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he8MJEud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he8MJEud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B131F000E9;
	Fri, 26 Jun 2026 05:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451690;
	bh=UeBUQX+LKgwi2hIPWcOTOd7V/pLrGARlLkhXhpHzLWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=he8MJEudiZq9uCXAoygVuYuw7BcZ+yShdUrYgbuR0/QGJ3DOPmAjQszJqhkcIXEN0
	 7f675+TGJdKpiK9cBl+D8CN+0pmtKZC9ADuzY2FpHwgNH7uuGas5dOhnOgGGvDkfUl
	 DZu2T0sdrSP0MbhYxMnfLtkO26xbCn8lQL+60KLXTY0sZYFPk+RLA7TDX5uStU8Rdm
	 pPrw3U1FhXIU7O3AyoKoZyaIO+OK76JB0lFWtdt6sGSZm/EygysVZ5sQajfjVY7mXg
	 ipAF03YmWKwvO5H+/TUyxbaVl8D3GZ9dfeVxKi1myrCZyjXa/UIoisqJU933HJsIZn
	 DobQzgsyAnAVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] Input: synaptics-rmi4 - cancel delayed work on
 F54 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260626051802.4033172-4-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-4-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:28:10 +0000
Message-Id: <20260626052810.A7B131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `video_device` structure is embedded in a `devm`-allocated con=
tainer with an empty release callback, leading to a Use-After-Free if the V=
4L2 device file is kept open after unbind.
- [High] Concurrent V4L2 ioctls are not synchronized or aborted during `rmi=
_f54_remove()`, leading to a Use-After-Free when an active ioctl times out =
or accesses a destroyed workqueue.
--

commit 169f0c9cee8746030206895c2135191d57259b56
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - cancel delayed work on F54 remove

This commit ensures that pending delayed work is cancelled before destroying
the workqueue in rmi_f54_remove() to prevent a potential Use-After-Free. It
fixes a race condition where a timer handler might run after the workqueue
is destroyed or the devm-allocated f54 structure is freed.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -749,6 +749,7 @@ static void rmi_f54_remove(struct rmi_function *fn)
> =20
>  	video_unregister_device(&f54->vdev);

[Severity: High]
This is a pre-existing issue, but the video_device structure is embedded in
a devm-allocated container with an empty release callback. This circumvents
the V4L2 core's mechanism to defer freeing the structure until all file
descriptors are closed:

drivers/input/rmi4/rmi_f54.c:rmi_f54_video_device {
    ...
    .release =3D video_device_release_empty,
};

In rmi_f54_probe():
    f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);

If a userspace application holds the V4L2 device file descriptor open while
an unbind occurs, video_unregister_device() returns and devm immediately
frees f54_data. Closing the file descriptor later or issuing ioctls will
access the freed f54_data container. Could this lead to a Use-After-Free?

>  	v4l2_device_unregister(&f54->v4l2);
> +	cancel_delayed_work_sync(&f54->work);
>  	destroy_workqueue(f54->workqueue);

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown sequence
destroy resources locklessly while V4L2 ioctls can still be executing?

During rmi_f54_remove(), we unregister the video device, cancel the work,
and destroy the workqueue without acquiring f54->lock.

If a concurrent VIDIOC_QBUF ioctl executing rmi_f54_buffer_queue() is
blocked:

drivers/input/rmi4/rmi_f54.c:rmi_f54_buffer_queue() {
    ...
    if (!wait_for_completion_timeout(&f54->cmd_done,
                                     msecs_to_jiffies(1000))) {
    ...
}

The remove() function cancels the delayed work (so cmd_done never completes)
and returns, allowing devm to free f54_data. When the timeout expires in the
blocked ioctl, it will access the freed f54 pointer.

Additionally, a concurrent ioctl might attempt to queue work:

drivers/input/rmi4/rmi_f54.c:rmi_f54_request_report() {
    ...
    queue_delayed_work(f54->workqueue, &f54->work, 0);
    ...
}

If this runs right after rmi_f54_remove() has destroyed the workqueue, could
it cause a crash? Should the teardown sequence serialize with active V4L2
ioctls?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D4
