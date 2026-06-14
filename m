Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23292301460
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781479601; cv=none; b=e3Fc+RrH2qd1GQrTk7rWKayXQ2rcJUsv8EsYEdowBciPziI03JFblwGR57JOuIunDERRV+096nO/r8PKCf4fYWw9/smMIFTePOglSs1cUGlYE30YMKtbgCdxys5hvF6KuCCsua+P0KDcw1bLNi21afAtNBCY9nP6HPNNZNNdtfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781479601; c=relaxed/simple;
	bh=m/vCyf6uVriiVOfao5CdrpPMwCjALd7sbVSKK57njFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jX6P3oP+sbB9azPNy3a6OYMmYsLhBAO/NTFd87jy8u49PEeGcDbtosUb0OF+/tMvnGvuJkbxXszLKTKSZi9QCQD0f15pvmihPV8PBMjHGuHyV49J3SvuTsimWZ10S8D/MsB7M6pHRKquUDnksermkM0tcxZDbawHeUC8BLZUatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq4abexa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq4abexa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959561F000E9;
	Sun, 14 Jun 2026 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781479599;
	bh=2lOuW1e/6m4/WFlS9Xyfl2T1My9oyoipXiX/SzJfj68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iq4abexaw5hFqiF6hglB4JqjzJhP5DDF4AsrOwDQXPJsoVVkaywMJf4MUNJ1EiM92
	 Zi1trW8Dz2GB3Zc1gvD7OmRvkPvnQ3K88FVDwwC7fOZzTUZB06KtaeQDlD4n/W62h4
	 68CktArUylsFVeGmfZiGSiGnmIrgZx4v7NdjfV4k+tscSraS0XbGDyTN1yVrCy/te0
	 QDigDMz++Y/oJdx39gXpI8b98fkzMHjSw6cmOZlH1yeBIrRxTqzXSZRJjJ2jCGvpe8
	 4eQELiGXoVAo6Bbl5MkMx7IHarXNk4SwYxFiYUInlDlYMDIA7pdLKP7cUju3tqEfqI
	 B+kMmbSgjmdvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: sur40: fix MAX_CONTACTS value based on
 PixelSense specification
Reply-To: sashiko-reviews@lists.linux.dev
To: Oliver <oliverburns.kernel@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260614230847.4938-1-oliverburns.kernel@gmail.com>
References: <20260614230847.4938-1-oliverburns.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 23:26:39 +0000
Message-Id: <20260614232639.959561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Synchronously freeing the driver state in `sur40_disconnect()`=
 while the V4L2 device may still be open leads to use-after-free vulnerabil=
ities.
- [High] The error path in `sur40_probe` incorrectly calls `input_free_devi=
ce()` on a successfully registered input device instead of `input_unregiste=
r_device()`, leading to potential use-after-free and state corruption.
- [High] The input device is registered and exposed to userspace before the=
 driver's private video queue and V4L2 components are fully initialized.
--

commit 36ed451619f33b71bb9cc6a733570423cba1565e
Author: Oliver <oliverburns.kernel@gmail.com>

Input: sur40: fix MAX_CONTACTS value based on PixelSense specification

This patch updates the maximum number of contacts for the Samsung SUR40
touchscreen to 52 to match the documented hardware specification. It also
removes an older FIXME comment that guessed the maximum contacts was 64.

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index fe63d53d56db0..77ec2c94b91fd 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -128,8 +128,8 @@ struct sur40_image_header {
>  /* polling interval (ms) */
>  #define POLL_INTERVAL 1
> =20
> -/* maximum number of contacts FIXME: this is a guess? */
> -#define MAX_CONTACTS 64
> +/* maximum number of contacts */
> +#define MAX_CONTACTS 52
> =20
>  /* control commands */
>  #define SUR40_GET_VERSION 0xb0 /* 12 bytes string    */

[Severity: High]
This isn't a bug introduced by this patch, but I noticed something in
sur40_probe(). The input device is registered and exposed to userspace
before the driver's private video queue and V4L2 components are fully
initialized:

drivers/input/touchscreen/sur40.c:sur40_probe() {
    ...
	/* register the polled input device */
	error =3D input_register_device(input);
	if (error) {
		dev_err(&interface->dev,
			"Unable to register polled input device.");
		goto err_free_buffer;
	}
    ...
	/* initialize the queue */
	error =3D vb2_queue_init(&sur40->queue);
    ...
}

Does this leave a window where an open operation could trigger sur40_open()
and start the sur40_poll() worker thread? If the worker thread invokes
sur40_process_video() and checks vb2_start_streaming_called(&sur40->queue)
concurrently with the main thread's initialization, could this cause a data
race regression on partially initialized structures?

[Severity: High]
This is a pre-existing issue, but looking at the sur40_probe() error handli=
ng,
if a failure occurs after the input device is successfully registered, the
code jumps to error labels that fall through to err_free_input:

drivers/input/touchscreen/sur40.c:sur40_probe() {
    ...
err_unreg_video:
	video_unregister_device(&sur40->vdev);
err_unreg_v4l2:
	v4l2_device_unregister(&sur40->v4l2);
err_free_buffer:
	kfree(sur40->bulk_in_buffer);
err_free_input:
	input_free_device(input);
err_free_dev:
	kfree(sur40);

	return error;
}

Can calling input_free_device() on a successfully registered device lead
to state corruption? If a userspace process opens this lingering device nod=
e,
would the polling thread dereference the freed sur40 pointer and cause a
use-after-free regression on the error path? It seems like
input_unregister_device() should be used instead.

[Severity: Critical]
This is also a pre-existing issue, but I noticed sur40_disconnect()
synchronously frees the driver state while the V4L2 device may still be ope=
n:

drivers/input/touchscreen/sur40.c:sur40_disconnect() {
	struct sur40_state *sur40 =3D usb_get_intfdata(interface);

	v4l2_ctrl_handler_free(&sur40->hdl);
	video_unregister_device(&sur40->vdev);
	v4l2_device_unregister(&sur40->v4l2);

	input_unregister_device(sur40->input);
	kfree(sur40->bulk_in_buffer);
	kfree(sur40);
    ...
}

Could this lead to a use-after-free regression? If userspace holds a
file descriptor open to the video device during a USB disconnect,
video_unregister_device() does not forcefully close the active file
descriptor. When userspace later calls ioctl(), poll(), or close() on the
descriptor, wouldn't the V4L2 core invoke file operations like
vb2_fop_release() which dereference the already freed sur40 memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614230847.4938=
-1-oliverburns.kernel@gmail.com?part=3D1
