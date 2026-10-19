Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429544;
	b=yV8vshw/pEG2E+Ttgm7JnI7yfulCGPKKicIbwomSOvWuHP28HoyV8kn/TjWWCjFAd4Ix
	 JShUeTs4T3kbmhyiGLYSFxrdaq7UukEqX9ccb8c/Ap1oONsNZVi7yeAVMxyONOlvVRE+7
	 0Vxzq9tZ2tXPaM4tpBJHnOlgmLjbKtN+CKmDcxhw98+gxUxjn0WA4vvfqfEE6WY45aj8b
	 X69oPPPZSyFh8ay+0QtUGF94j9MLuZ0EcNPWsd1OTLYTvGMI3wLbzhaAOy77lsyJc+NGb
	 YOHHLxL/cY0lBO481qmv9myJIzgFRlXAotZKt0MzjTki3rZX1HLjOQfbJ9/fyAgWt7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FSJtwXLcdIJW7noyswvjG5QUl+f0iRegZH7Sj/VXj8w=;
	b=tWH+cPWzSDiMdKO/koS0X02yCXWT0QVgXxfv5aXsnW9+nkFTmJNHNjm8W4XUC/gkBmBv
	 0ora3cn3Wj5eaa3Kjv/5nD5qgqRcECJ0fXSvCT2txJL+2Nwwe1qA87HtiapZkyt6yLtn+
	 c9EgXJ7uIo/IW8p6Yt1DLRPRclG6YJRVFWXTMMv2tItcWcLibXewHz+a/4LhyTBbi3kwI
	 lFNo57tsJytNaoJVIId+qX21bYfZlNu0W2QFZQF/HUtXlET3xIXjPhGoo0/xNJ4T8RRrV
	 IaQ6WwQhxl/XHHGrw4sugJ6mm1RwAQM8gs6m9XGH77fJjUzakpTMAB9sVJOExbbZNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTt7R2l2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22636606A31C
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTt7R2l2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CE51F000C4;
	Mon, 19 Oct 2026 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792429543;
	bh=FSJtwXLcdIJW7noyswvjG5QUl+f0iRegZH7Sj/VXj8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTt7R2l2J/8R1KpKk0B/qNrJI1gpETHHm6qZ9E4j20gE19wRD/bQv00X1rlmo96kj
	 SM6/1SkO4KdsD+LMoN3PsJtpMoh5G9LML/AcUq9V24cejQYtFno+9pCNv+50+VWGb+
	 AaF/BPYQgR6LRcLh/YM39fYKr5KMXyPkCElIEAV+aYdysyUZdrxWsfhm6+2LQhx/e0
	 xA3yOPjrx8p1qJ47y/ryras6NtAhKUh+k1sxrBPM1806cuRFPNLZL1R3xN5a0agO2w
	 NPg21Rv0fYin+esLfqz+sLF198LGMhh3tjbkZpCByUhHwsf5Q9R+jLJyzbQznC9nHX
	 JCuarg6+H4g6A==
Message-ID: <sashiko-outbox-177991@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] HID: roccat: avoid unlocked report buffer access
 in roccat_poll()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019165251.280027-4-dmantipov@yandex.ru>
References: <20261019165251.280027-1-dmantipov@yandex.ru>
 <20261019165251.280027-4-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:05:43 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: roccat: lost wakeup race with disconnect in roccat_poll()
--

commit e86b9d12f982ba8791907476cb41c22aa8fe25df
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: avoid unlocked report buffer access in roccat_poll()

This commit acquires cbuf_lock when checking the per-device report buffer
indices in roccat_poll() and moves the roccat_device_available() check
before poll_wait().

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 098dd85aa036a..2782fb5773d9d 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -160,12 +160,18 @@ static ssize_t roccat_read(struct file *file, char =
__user *buffer,
>  static __poll_t roccat_poll(struct file *file, poll_table *wait)
>  {
>  	struct roccat_reader *reader =3D file->private_data;
> -	poll_wait(file, &reader->device->wait, wait);
> -	if (reader->cbuf_start !=3D reader->device->cbuf_end)
> -		return EPOLLIN | EPOLLRDNORM;
> +	bool avail;
> +
>  	if (!roccat_device_available(reader->device))
>  		return EPOLLERR | EPOLLHUP;
> -	return 0;
> +
> +	poll_wait(file, &reader->device->wait, wait);
> +
> +	mutex_lock(&reader->device->cbuf_lock);
> +	avail =3D (reader->cbuf_start !=3D reader->device->cbuf_end);
> +	mutex_unlock(&reader->device->cbuf_lock);
> +
> +	return avail ? EPOLLIN | EPOLLRDNORM : 0;
>  }
> =20
>  static int roccat_open(struct inode *inode, struct file *file)

[Severity: High]
Can moving the roccat_device_available() check before poll_wait() without
re-checking it afterwards cause a lost wakeup on disconnect?

If roccat_disconnect() runs on another CPU after roccat_device_available()
returns true and before poll_wait() adds the caller to reader->device->wait:

drivers/hid/hid-roccat.c:roccat_disconnect() {
	...
	if (!WARN_ON(!atomic_cmpxchg(&device->exist, 1, 0)))
		device_destroy(device->dev->class, MKDEV(roccat_major, minor));

	if (device->open) {
		hid_hw_close(device->hid);
		wake_up_interruptible(&device->wait);
	}
	...
}

the disconnect wakeup fires before the task is on the waitqueue.
roccat_poll() then registers on reader->device->wait, sees an empty buffer
(avail =3D=3D false), and returns 0, leaving poll(), select(), or epoll_wai=
t()
sleeping indefinitely on the disconnected device.

Also, in roccat_read(), unread events in the circular buffer are drained
before disconnect is reported:

drivers/hid/hid-roccat.c:roccat_read() {
	...
	/* no data? */
	if (reader->cbuf_start =3D=3D device->cbuf_end) {
		add_wait_queue(&device->wait, &wait);
		set_current_state(TASK_INTERRUPTIBLE);

		/* wait for data */
		while (reader->cbuf_start =3D=3D device->cbuf_end) {
			...
			if (!roccat_device_available(device)) {
				retval =3D -EIO;
				break;
			}
	...
}

When roccat_device_available() is checked before reader->cbuf_start !=3D
reader->device->cbuf_end, doesn't roccat_poll() return EPOLLERR | EPOLLHUP
without EPOLLIN | EPOLLRDNORM even when unread reports remain in the
circular buffer?

Should poll_wait() remain at the start of roccat_poll(), followed by checki=
ng
both the circular buffer under cbuf_lock and roccat_device_available()?

([`drivers/hid/hid-roccat.c:160`](drivers/hid/hid-roccat.c#L160))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019165251.2800=
27-1-dmantipov@yandex.ru?part=3D3
