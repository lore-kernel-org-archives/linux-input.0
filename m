Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1633B8D7B
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451894; cv=none; b=oeQWiRYoDqPo66eZk6aoXoNy3NYbarwR6UfcexjNQrmAw79c3H3sZgdIWvEqIJfC9+b8cvbTWJHjT6tDtWBmu7dFC8zaXqZyAe7AvLcYNDAJ3l/zMDJ1R8hQVmwc9TYlSFXuEpZAElTKrSoSBzHVYRzRXlOcqL1UDAMHD2Z41ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451894; c=relaxed/simple;
	bh=S2AUra3+czbmD7fh400Qm5PYaHYXFhy5g4RtKycdr10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m0FCF84tf3yLzPiXycog0wH51++Uyj99Q4d4pMW4bNGgN/m8oL62egqSvxZzkO354uHPB7oi3Ww84UIWYxsMbw8ypJNNply1PCpAgSUqMPjsSkWl4S6FON2rZaio1DtGdt1jvR1+y9d00Wt+5POS/8uC42xIQxguQiV1pt/zdcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJbX4Y4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJbX4Y4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573C01F000E9;
	Fri, 26 Jun 2026 05:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451888;
	bh=x+PSE1BzAwIHYGfvVIZmDcWt9zYbQHvmHedwappO1nY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJbX4Y4BoTGOhzVz136XG8CHLPyMmQEy24A2Xv8/M0Fiq/nu0hg7Z0o3BDERS41Ld
	 iw+Hrt2c8tbdLkWMHSBP3nmagC1Xd/Dq05PSPaduMIrsdfr8Ty4FU36f/e+0phvz9n
	 JBNxJgrKB2dUFoDhg/YjI3JY70NrtMBNI+An4CYesC/1RyokQXtPW2o5pFWW1iIF/P
	 amNqXyjXPS0LwCUWtzmejdTX4r8rrSGa2rlD+PsPXMb8UHFSfzSC6FiBZ+4uKjjA8W
	 Rb9uexlElY2jnLAitXx7b2Vl2MQoZv1WwQ5fanHHi07C2z+j/P6/GwjWX23b2QNEpO
	 9lHmsPFSjD5FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] Input: synaptics-rmi4 - bound the F54 report size
 to the allocated buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-3-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:31:26 +0000
Message-Id: <20260626053127.573C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Devm-managed V4L2 video_device leads to Use-After-Free on deferred=
 file close.
- [Medium] Missing vb2_queue_release() leaks videobuf2 resources during dev=
ice unbind.
--

commit 7c7a1b6617a82d10a8cfe2c055e62e4a1c8fe287
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer

This commit prevents a buffer overflow in rmi_f54_work() by rejecting repor=
ts
that are larger than the allocated size of f54->report_data. It records the
allocation size during probe and ensures the report_size does not exceed it.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 8eac320c43e35..75839a54656b9 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -104,6 +104,7 @@ struct f54_data {
> =20
>  	enum rmi_f54_report_type report_type;
>  	u8 *report_data;
> +	size_t max_report_size;
>  	int report_size;
> =20
>  	bool is_busy;

[Severity: High]
This isn't a bug introduced by this patch, but looking at struct f54_data
which embeds struct video_device vdev, can its devm-managed lifecycle lead
to a use-after-free on a deferred file close?

If a user holds the video node open while the device is unbound,
rmi_f54_remove() calls video_unregister_device(&f54->vdev).

Devres will then free struct f54_data immediately upon return.

When the user later closes the file descriptor, will the V4L2 core access
the freed video_device to decrement its kref and invoke the release callbac=
k?


[Severity: Medium]
This is a pre-existing issue, but does rmi_f54_remove() leak videobuf2
resources during device unbind?

The teardown path unregisters the video device with
video_unregister_device(&f54->vdev).

If userspace requests buffers (e.g., via VIDIOC_REQBUFS) and the device is
subsequently unbound without the application cleanly releasing the buffers,
will the driver leak the videobuf2 kernel resources and allocated buffers
since it fails to call vb2_queue_release()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D3
