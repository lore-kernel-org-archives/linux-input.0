Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DD3E00A8
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459010; cv=none; b=BWS3JL5Uh7Ou+qNLytmuj3a5kHiR69ynyZ6vbwRjhqPhmlq0Z4pZedAIkwlf2JY45OMRnrCJPxVXCkCMPoaCHvR4N7OUbpw0R8bjrOb7gEuas0mNuq7T4I4FMa1tuftO/uqjANLXjrKmAnITEQoXpnZwNv5zbyCCB+U/sAdwjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459010; c=relaxed/simple;
	bh=2iLa9VF5EwjABCk/liidoO9E67eMgpwLlUmqSEHRlNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h+m0+LNKICAhHwMNRB62XK3K3VoXvN5e4sz5BJvXaxc3JCkO6A6OW7u2RQ2ubelTxf3x2QS87VejeTHI8LEd8ceS4IP/GNaE1QmhKfJlZyqdvSBKXrhf+z104JMpdt0gPeKbjFDKBnohtYoEeC02UxTckdvAgAIcjC6Q9gV0P+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUyw4pfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUyw4pfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9131F000E9;
	Fri, 26 Jun 2026 07:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782459008;
	bh=Frb3OKNd2SP9TM7EpLmOrT++61O8gOFPui/HDkA2Fiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUyw4pfnhKY6KU0VYKYfeMbQb5DBr/UiF1HD8NI60nuNeFWAIhR9kI1Fig93uMjwS
	 UFiebeu3S9TzUa5aSmOMYGvhxxIn9WgorYa2sEStdfS5xhKknjtUFByZ3bFx8n1z8B
	 x8pSU+fIFTp+33hP+cJxbXZCoXpG4dT2cz20tCI7NgTLsacmAtOHAFhayo8IimNZDP
	 91/9vmsh1KkyZNEdkYSPjQ652G5fVkWNoNy0HFwRactO2eIJJXqRqujlS7M4kIYttI
	 RUFaHSW2CLczF6GSCbNDle8y50ICSaixvkKsbuU59++8ZaAdgMUIec7L6HblKutg7e
	 mPXvWVLnQML4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/10] Input: synaptics-rmi4 - propagate F54 worker
 errors to V4L2 queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-6-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-6-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:30:08 +0000
Message-Id: <20260626073008.7C9131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The V4L2 video_device, vb2_queue, and mutex lock are embedded insi=
de struct f54_data, which is allocated using devm_kzalloc(). When the devic=
e is unbound, devres frees f54_data immediately after rmi_f54_remove() retu=
rns. If a userspace process holds the /dev/videoX file descriptor open, sub=
sequent V4L2 ioctl calls or close() operations will trigger a Use-After-Fre=
e.
- [Medium] The V4L2 buf_queue callback executes synchronous, blocking hardw=
are polling via wait_for_completion_timeout(), turning an asynchronous queu=
eing mechanism into a fully blocking operation that starves other ioctls.
--

commit ed5dda6c6cb42efd8468fff80b16a819c0e59afb
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue

Previously, rmi_f54_buffer_queue() waited for the worker thread to finish b=
ut
ignored whether it succeeded. This patch adds a report_error field to struct
f54_data to store the worker's exit status and marks the buffer with
VB2_BUF_STATE_ERROR if the worker failed.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index e86dfc9ce7d9a..c86bc81845bb1 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -106,6 +106,7 @@ struct f54_data {
>  	u8 *report_data;
>  	size_t max_report_size;
>  	int report_size;
> +	int report_error;

[Severity: High]
This is a pre-existing issue, but does using devres to allocate struct
f54_data create a use-after-free risk during device removal?

Since the V4L2 video_device, vb2_queue, and mutex lock are embedded inside
this structure, and it is allocated via devm_kzalloc() in rmi_f54_probe():

rmi_f54_probe() {
        ...
        f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);
        ...
}

The memory will be freed immediately when the device is unbound. If a
userspace process still holds the /dev/videoX file descriptor open,
subsequent V4L2 ioctl calls or close() operations could access the freed
video_device or queue.

[ ... ]

> @@ -340,6 +341,12 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *=
vb)
>  		mutex_lock(&f54->data_mutex);
>  	}
> =20
> +	if (f54->report_error) {
> +		dev_err(&f54->fn->dev, "Error acquiring report: %d\n", f54->report_err=
or);
> +		state =3D VB2_BUF_STATE_ERROR;
> +		goto data_done;
> +	}
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but does waiting for the hardware
completion inside rmi_f54_buffer_queue() starve other concurrent V4L2
operations?

Just before this error check, rmi_f54_buffer_queue() executes:

rmi_f54_buffer_queue() {
        ...
        while (f54->is_busy) {
                mutex_unlock(&f54->data_mutex);
                if (!wait_for_completion_timeout(&f54->cmd_done, ...)) {
        ...
}

This executes synchronously while holding the V4L2 queue lock. Blocking here
via wait_for_completion_timeout() for up to 1000ms could prevent other users
from executing concurrent ioctls like DQBUF or STREAMOFF.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D6
