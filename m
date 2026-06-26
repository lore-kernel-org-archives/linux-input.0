Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C803905F0
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452041; cv=none; b=e/WgWfM69aNOsdcRdquyL/R7NIcAoUZ4KmCieCVUvt5xVuNM8tsW7QZpUicaMsSOq0hcVI05HSh8WqR++ixZWuQ5YufeWEomoexmC5piOrSgXqerLR6vC63NIajO5dZnRzK6MUI4YTYEEzqjScpLXdq9T5rzsLV4w/hdNjnwauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452041; c=relaxed/simple;
	bh=A8DkbKUeZ1lr09wsxHntZBu9hmzgbWTRS6/pKhKUFAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tN2FBGa5kRKxNmg26pTytST+yNe2Ni0RLvusKO0j52W65HpKgPe0Y44s0zHXfy6393mukQA2Obr86MeTsvbs2YTHpL4fzyYfbfQcJr9siJ9vbOy49qc0rCDlEgGfrxwvL6hTkD9jyiqQn0UsZOBj4rIkheOnJ7k5dWEDi1inFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoVfWeZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoVfWeZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF91F000E9;
	Fri, 26 Jun 2026 05:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782452039;
	bh=Tq5OM8b+XOgs+fIjkAM8J4XYLty0aiYdISFGidwQrhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoVfWeZ5bpbbQtvN+mt2CmcXLPtweU8tvwq1pvRsVt1RtoA/CYfxTkattvlUyM8gJ
	 2PZ3nSRlvHSgMpmDV9cXowKh9sm9HsvuNsm4/S7a9zfGddgT6FzpehvIDWMlSOA5yf
	 uEwJGUEu2BapGXb+K49RwfSjJYpArJxj+B/K7/cw+wJEu5uyvO4Xuyrx3cf4h9s9ga
	 4rN6JMB3EJQFc/jTwm79oQISvoxUdl5reqpIwLfSaJ2srSuZ1rw/XmpxuCc0F8BGNB
	 1OYSbvgGC9/pUNwJIWK9WvhGNMekfzxIuIaFvorYOfa6lMaaWD/ZuofvSym2UniDXj
	 oESyce8lxNzsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] Input: synaptics-rmi4 - use __le16 for FIFO
 offset in F54
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-10-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-10-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:33:58 +0000
Message-Id: <20260626053359.39BF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The struct f54_data is devm-allocated but embeds a struct video_de=
vice and sets its release callback to video_device_release_empty. This caus=
es a Use-After-Free (UAF) upon driver unbind if userspace keeps the V4L2 fi=
le descriptor open.
--

commit e9522f5af1c14ea69a1ea7da84dfd2f3170f97d8
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - use __le16 for FIFO offset in F54

Instead of manually splitting the 16-bit offset into a 2-byte array,
use __le16 and cpu_to_le16() to serialize the FIFO offset in
rmi_f54_work(). This is cleaner and more portable.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 5d045ece3c2f2..3eeb189be18b3 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c

[ ... ]

> @@ -597,12 +597,11 @@ static void rmi_f54_work(struct work_struct *work)
> =20
>  	for (size_t i =3D 0; i < report_size; i +=3D F54_REPORT_DATA_SIZE) {
>  		size_t size =3D min_t(size_t, F54_REPORT_DATA_SIZE, report_size - i);
> +		__le16 fifo =3D cpu_to_le16(i);
> =20
> -		fifo[0] =3D i & 0xff;
> -		fifo[1] =3D i >> 8;
>  		error =3D rmi_write_block(fn->rmi_dev,
>  					fn->fd.data_base_addr + F54_FIFO_OFFSET,
> -					fifo, sizeof(fifo));
> +					&fifo, sizeof(fifo));

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
lifecycle bug related to how struct f54_data is managed.

The struct f54_data is devm-allocated in rmi_f54_probe():

    f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);

However, it embeds a struct video_device and sets its release callback to
video_device_release_empty. If userspace keeps the V4L2 file descriptor open
during driver unbind, devres will immediately free f54_data when
rmi_f54_remove() completes:

    static void rmi_f54_remove(struct rmi_function *fn)
    {
            struct f54_data *f54 =3D dev_get_drvdata(&fn->dev);

            video_unregister_device(&f54->vdev);
            v4l2_device_unregister(&f54->v4l2);
            cancel_delayed_work_sync(&f54->work);
            destroy_workqueue(f54->workqueue);
    }

Since rmi_f54_remove() doesn't wait for the video device to be fully
released (or synchronize with in-flight V4L2 ioctls holding f54->lock),
an active ioctl could sleep and wake up after the struct is freed.

For example, if VIDIOC_QBUF blocks in rmi_f54_buffer_queue():

    if (!wait_for_completion_timeout(&f54->cmd_done,
                                     msecs_to_jiffies(1000))) {

Could this wake up after the driver is unbound and access the freed
f54->data_mutex or f54->sequence?

Does this violate the V4L2 lifecycle contract, which requires that memory=20
backing a video_device must not be freed until the core invokes the .releas=
e=20
callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D10
