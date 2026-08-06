Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E73BB674
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004277; cv=none; b=W7KYu3XAt0s4QfD9BXALUb4KiKbqWd9s1N0wmAUnpV3n6+XNbXwwhEiF8LAj+a/smbVTDApiJEaaIWxeQoQVvLXEBvYM/bej0v5QSqx7Yol2TqtjMNp8FoGa+zpKuZ0VMfuq9FOzoQ8HL8lpuSaZ1ZtBGFIWlWkcGBkAL3cQ81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004277; c=relaxed/simple;
	bh=hCART4Zp05HpfQ9RZkwulyW3XRFaoYx9wNYkm916eKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WiImkeaGXWmYItUWmg6reF21xzeLYUhNE1BWnUNKAVI0A/OWPwDKNhXHcwVVWqPUFo84tz2CIgnn65wTAw4qcOKkVLv2VWLpJTZYTB+Eo9Jt8AGV2GkZr/nPJhOYGWpWnfptB9thpkckT/XZN9QBStwm03iAHEO7f54djSst8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSHA77El; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSHA77El"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E2E1F000E9;
	Thu,  6 Aug 2026 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786004275;
	bh=12QWiPpVGwANLmH4BEmGzAw7tTmIpgZV7PwDaMxgozY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSHA77ElIWEoFj/I/+zVH1VS8vG0+5GVdANYgE8HjwpJhvtiuAFj2WSbofofQIE4g
	 WvIo0CrY9dIlKXrH4rkpl/9KQ8GlPpO7M3uj41+vCesCYHUz8p2lr/B9cFIWuKybQm
	 jRxcFL7TRnSnw2QyTGGdWxQkDNmyFiZxD84+XpfzIf03HZM572DEtIDO5pJllbwjqQ
	 Vr0ZERTJUhfFetzbcyLDPfk9mQM6xfWUiGS5UqcqNoC3sVDy9mgwX129pPRoij2KQ3
	 CkgicusaO/tuvL6ACEH7DdSBNXmuI+2XB7Ex1H0S7mDFJkMoOR5WKi7IPaWh521uNi
	 v2Q63/7ZBVZFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: sur40 - fix use-after-free in sur40_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806080018.10050-1-kartikey406@gmail.com>
References: <20260806080018.10050-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 08:17:54 +0000
Message-Id: <20260806081755.59E2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature free of the `sur40` struct in `sur40_disconnect()` leadi=
ng to a Use-After-Free when V4L2 file handles are closed.
- [Medium] Missing v4l2_ctrl_handler_free() in the video_register_device() =
failure path.
--

--- Patch [1]: [PATCH] Input: sur40 - fix use-after-free in sur40_open() ---
commit e0be966f67bc10328835ca2aa6f5d5b458a14ed3
Author: Deepanshu Kartikey <kartikey406@gmail.com>

Input: sur40 - fix use-after-free in sur40_open()

If any of the registration steps after input_register_device() fail, the er=
ror
path frees sur40 via input_free_device() + kfree() without ever calling
input_unregister_device(). This patch splits the unwind so that once
input_register_device() has succeeded, the failure path properly calls
input_unregister_device() before freeing sur40 and its buffer.

Closes: https://syzkaller.appspot.com/bug?extid=3D683f6c071b5abfc266c1

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 77ec2c94b91fd..4b3a4d5386e4c 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -808,6 +808,10 @@ static int sur40_probe(struct usb_interface *interfa=
ce,
>  	video_unregister_device(&sur40->vdev);
>  err_unreg_v4l2:
>  	v4l2_device_unregister(&sur40->v4l2);
> +	input_unregister_device(input);
> +	kfree(sur40->bulk_in_buffer);
> +	kfree(sur40);

[Severity: Medium]
This is a pre-existing issue, but if video_register_device() fails, the code
jumps to err_unreg_video and falls through to err_unreg_v4l2 here.

Unlike the failure path for v4l2_ctrl_handler_setup(), does this path skip
calling v4l2_ctrl_handler_free(&sur40->hdl) before freeing the sur40 struct=
ure?

Could this lead to a memory leak of the dynamically allocated structures wi=
thin
the V4L2 control handler?

> +	return error;
>  err_free_buffer:
>  	kfree(sur40->bulk_in_buffer);
>  err_free_input:

[Severity: High]
This isn't a bug introduced by this patch, but looking at sur40_disconnect(=
):

drivers/input/touchscreen/sur40.c:sur40_disconnect() {
	...
	video_unregister_device(&sur40->vdev);
	v4l2_device_unregister(&sur40->v4l2);

	input_unregister_device(sur40->input);
	kfree(sur40->bulk_in_buffer);
	kfree(sur40);
	...
}

Does freeing the sur40 context immediately without waiting for V4L2 file ha=
ndles
to be fully released destroy the still-referenced vdev?

The sur40_state structure embeds a struct video_device using the
.release =3D video_device_release_empty dummy callback, which opts out of V=
4L2
internal refcounting.

Since video_unregister_device() does not block until open file handles are
closed, if an unprivileged userspace process holds an open file descriptor =
to
the V4L2 device when it is disconnected, the sur40 memory is freed while
actively referenced.

When the application later closes the fd, the V4L2 core calls vb2_fop_relea=
se(),
which dereferences vdev->queue (located inside the freed sur40 struct). Can=
 this
trigger a use-after-free kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806080018.1005=
0-1-kartikey406@gmail.com?part=3D1
