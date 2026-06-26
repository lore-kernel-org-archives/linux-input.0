Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063053A8746
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451687; cv=none; b=F+ewzcNGiOQZ5/B4wKAPjjnXp1SzSx+O5mq6FN6wqFZLnDJzrEqo7gF7cbU56oEyEeCtv0XB5XGiK2mIt/QCELqCh5NMEmBS0l8Znct85yP0qejEgxOl/axaJbrYB7mqweeH/hA4Pc4X8yig7K6FSaMJn2GSiISiPPO3weMVY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451687; c=relaxed/simple;
	bh=aMDKvuzerWFzolZp0y0xTVAEvZ3EL4CbacA+SoUXpi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ouYin/uU9HpCGkZ56xM7TJPtXI6zUpVsTVYFbpT1vx7hXHpGoBrCAl4t56BFXDgOevi1P6MBRp/LWzRqXjhzV5tP+s3iKQR7dhjUXbrt83GT+fLrhpf09olRw5xMPSNWpAbpG4WdxjYLs2WWCszOm06HuaVzoRxNdsu6GTLI3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvb9gBSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvb9gBSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55FB1F00A3A;
	Fri, 26 Jun 2026 05:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451675;
	bh=YQXSPc+eUuO1COVHa2Y86nHNqW4qIvrqbllAL88WPdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wvb9gBSgUjPYfMG1hbC2PDyffikOiv+RE/WPv+WPOMIZ/tuyb6m5blPUL8tZaRQ78
	 xesnNIKqisd5fR0hTutGJ1tlORgc2kHS4SylBOR+gHlyR2QJudpTvc4lBpZyF0APsW
	 n8U1bWKshGHkHYiV+CM2T9kNWmPam5QDSpyOXTpCf7h725y8AtarSCfup5/Qjsq2Uk
	 Q1TgcPMeqNLzQ+qG7UiCIEy1IYtf7tNahQkAn73NesRUcuGQkvPiPd57KrjjLoQbnv
	 d9gUvl9YBuzb87tyYLh75zZg7kTFvlYBlfx2MPdfz02P9lEhydmETqozzaPqT0/kWW
	 hZzeu0O6+ZDmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] Input: synaptics-rmi4 - block s_input when F54
 queue is busy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-5-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-5-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:27:54 +0000
Message-Id: <20260626052754.C55FB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using `devm_kzalloc` for a structure containing a V4L2 `video_devi=
ce` with `video_device_release_empty` leads to a Use-After-Free on unbind.
--

commit 49068cdcddfc12eacb30d46e9f92bd95fd14648f
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - block s_input when F54 queue is busy

Changing the input (diagnostic report type) mid-stream changes the report s=
ize.
Since V4L2 buffers are allocated based on the size at stream start, changing
the input while streaming could lead to a heap buffer overflow if the new s=
ize
is larger than the allocated buffers.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index aebe74d2032cd..e86dfc9ce7d9a 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -445,7 +445,12 @@ static int rmi_f54_set_input(struct f54_data *f54, u=
nsigned int i)
> =20
>  static int rmi_f54_vidioc_s_input(struct file *file, void *priv, unsigne=
d int i)
>  {
> -	return rmi_f54_set_input(video_drvdata(file), i);
> +	struct f54_data *f54 =3D video_drvdata(file);

[Severity: High]
This isn't a bug introduced by this patch, but could this f54 pointer
reference freed memory during a device unbind?

In rmi_f54_probe(), the f54_data structure is allocated with devm_kzalloc():

    f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);

This ties its lifetime to the physical device rather than the V4L2 character
device reference count. The release callback for the video device is also s=
et
to a dummy function in rmi_f54_video_device:

    .release =3D video_device_release_empty,

During unbind, rmi_f54_remove() calls video_unregister_device(&f54->vdev) b=
ut
returns immediately. This unregisters the V4L2 device without synchronously
waiting for userspace to close open file descriptors, leaving ongoing V4L2
file descriptors pointing at memory that is about to be freed by devres.

If a userspace application keeps the V4L2 device node open, would subsequent
operations or closes (such as vb2_fop_release) attempt to access the vdev a=
nd
queue embedded within this already-freed f54_data memory?

> +
> +	if (vb2_is_busy(&f54->queue))
> +		return -EBUSY;
> +
> +	return rmi_f54_set_input(f54, i);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D5
