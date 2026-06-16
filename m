Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17613CF672
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587708; cv=none; b=Hzmv3ZVPvzXC/zSpBKYFBc4jHx2wgOCdy7Ixt6yZ4hc3wEJWKqIb4A2f6oWtndS/vuetU3FD/7a6Jo968Zp8E9pU2wtIJOOr/+nAAvXkUB01qc9RVQ9W2fSUzMMYl51tZxRIY4M07PaZFk8y2hFp4fK8JxSW4GyKuZOo3tesXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587708; c=relaxed/simple;
	bh=+eeGyBUNKBz6iosJE1qJb5do/8HaOjs+wc0D+c8FPJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/NJ1xz6Es8eL9Dhf3KX2KuIWafK6t2tIDzX8FJQeIx+h6iAs1leT7hHbO4Ay72ZVajSNpO5IMuJujsVI9DHK5Qc+cSLxizloDOqBqgn3QCMxeaV8OlXEUNKSQBwBuLHBqO/ILgSdTw6imp92fDJI+6K9/mr2zdmDPYpZdImJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyx7gYip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyx7gYip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724001F000E9;
	Tue, 16 Jun 2026 05:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587707;
	bh=PrnEMStvo3WVpbIvw4Xz3Apv0jR3cb4AtnqOZvXXfwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gyx7gYipmFz8jG0O7D7BoLfH1hDR4hRljj+7PwPNRO1RPxIbjrglkSiNDaJny5ptD
	 m5pWqcO1Nl1CiA2GYg2tfqR70QI9K7EkmZ0wZ5sKBN6+paE610sTz5WE/bDGnc+J39
	 YLyM/XvHNXndeef03db93A9YnkWCfQp7G4wmUCQaWvTmIByGEDm35rixsJgaMf3yT0
	 DMiZ8ja6/RIMzE1+z+IGOIt/e5B9zoYel5QsJh1NRCy6fNh7i/JCw6Tcr7zK0lUlpa
	 vIoUe99x7BrAIFQET2QaDK8W5jlfOeV3+46uuoZtcMCOS+SEPexYIocmg/14QHKwG8
	 cgGBblafx0RqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] Input: sur40 - fix V4L error path cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616051235.1549517-2-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:28:27 +0000
Message-Id: <20260616052827.724001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `vb2_wait_for_all_buffers` in `sur40_stop_streaming` cause=
s a system deadlock.
--

commit 1d8742f82651a7f0160c799526e70838d3c9fa29
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: sur40 - fix V4L error path cleanup
   =20
    In sur40_probe(), if video_register_device() fails, the error path jump=
s to
    err_unreg_video. This incorrectly attempts to unregister a video device
    that was never successfully registered, and fails to free the V4L2 cont=
rol
    handler (v4l2_ctrl_handler_free) that was initialized immediately prior.

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 8639ec3ad7038..e9089b0c3e2f4 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the current implementation of
sur40_stop_streaming() cause a system deadlock?

Looking at drivers/input/touchscreen/sur40.c:sur40_stop_streaming():

	vb2_wait_for_all_buffers(vq);
	sur40->sequence =3D -1;

	/* Release all active buffers */
	return_all_buffers(sur40, VB2_BUF_STATE_ERROR);

The driver unconditionally calls vb2_wait_for_all_buffers() before forcibly
returning the active buffers. This blocks infinitely until all queued buffe=
rs
are returned via vb2_buffer_done().

The driver expects the poller thread (sur40_poll) to process and return the=
se
buffers. Is it possible for the poller thread to be stopped or not running
when this is called?

For instance, if userspace opens only /dev/videoX without ever opening
/dev/input/eventX, the input-bound poller never starts.

Additionally, if the device is abruptly unplugged while streaming is active,
sur40_disconnect() calls input_unregister_device(), which synchronously sto=
ps
the poller. When the video file descriptor is subsequently closed,
sur40_stop_streaming() is triggered.

In both of these scenarios, won't vb2_wait_for_all_buffers() wait forever f=
or
buffers to be returned by a thread that is not running? Should the driver
synchronously cancel transfers and immediately return all queued buffers wi=
th
VB2_BUF_STATE_ERROR instead of waiting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616051235.1549=
517-1-dmitry.torokhov@gmail.com?part=3D2
