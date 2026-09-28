Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B874F5DF5
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616098; cv=none; b=eMd/p2fiiP9OAU9SRc82d9EQ5ZBikVBEPnlAJegybEmkN9mqbEzgD2PWe+YB52i6ENJRcpNs4FYGtHpoYWaWU1FYRjuOqYWQZXnnsfprRSaKRLgJ3DEmJqgiiADsk4H2BU+1GMrctwKA+ARYIYUove9Al/QewQn34qYF3sA7/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616098; c=relaxed/simple;
	bh=IrYNFm/K/aO6d4OhkJL+81xC1YjfrJpfzkatGMmNbhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eRHoanQPVSvJjmCTN35NwNsLE9GJ97jpna4s+9qBMX0Ow//YsmB0+bRNQUbNi4dhoaeQDUx+aF8JcKvBZTRyFiiUj6JTwJDlzdJxlS6bTvFpbe3ELSs5bO3rwGWGEn6OvtArsHXGLzPgIlLd3POApceun34LY/ls/otkLAttiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRjdtXkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRjdtXkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB41F000FF;
	Mon, 28 Sep 2026 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616089;
	bh=BTLaMOWwTlrTwqOFg/3lNlehOHfkZdXg8dHqFxJXbj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRjdtXkzLEQVcyZAxYAjkxOO8LKRPVgQfPlwFdRGIs2qh0roO1/+MdbRWxnoBUZxA
	 1bzJKi/C9RSbwP9tu17teqFT1gIKp390SlosCjGAN0ltYCwkV1pfZXFfr7AZsKjY3l
	 94LAIgk5NVsFBx9+p1Aol1ERF+ChYWQDWsQyNaEN/PfeXEwF19IhipwoWncutsQQiC
	 buTzCFW/CIwJ/8uE6u3ciTCeZwAwxHoAxfTYocngXsx/xM8zOc7Ux/DN+RSD/g14/d
	 U7qcPCgvlAMeJ3nDKO1u4qVMemlL/NBTaHKkibrvXlPKVyJ1yY2fApg29Wv1FhyZfs
	 xCLJysvN7kB0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: fix potential use-after-free in
 input_devices_seq_show
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260928171306.59206-1-habilerenturker@hotmail.com>
References: <20260928171306.59206-1-habilerenturker@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:21:28 +0000
Message-Id: <20260928172128.D6AB41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] input: refcount leak and UAF during seq_file iteration
- [Critical] input: invalid pointer dereference in seq_stop on interrupt
--

commit aa10b9792f79b028b976fdcbe93a1680d11f5f5f
Author: Habil Eren T=C3=BCrker <habilerenturker@gmail.com>
Subject: Input: fix potential use-after-free in input_devices_seq_show

This commit attempts to fix a use-after-free in input_devices_seq_show()
by taking a reference to the input device in input_devices_seq_start() and
dropping it in input_devices_seq_stop().

Closes: https://syzkaller.appspot.com/bug?extid=3Dbc6b37960b1d13f68f9f

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 78c10eea7328d..6d21718a73ff8 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
[ ... ]
> @@ -1124,7 +1125,11 @@ static void *input_devices_seq_start(struct seq_fi=
le *seq, loff_t *pos)
> =20
>  	state->mutex_acquired =3D true;
> =20
> -	return seq_list_start(&input_dev_list, *pos);
> +	v =3D seq_list_start(&input_dev_list, *pos);
> +	if (v)
> +		input_get_device(container_of(v, struct input_dev, node));
> +
> +	return v;
>  }
> =20
>  static void *input_devices_seq_next(struct seq_file *seq, void *v, loff_=
t *pos)

[Severity: Critical]
In input_devices_seq_start(), a reference is acquired on the first device.=
=20
However, input_devices_seq_next() advances the iterator without acquiring a=
=20
reference to the next device or dropping the reference to the previous one.

When iteration stops, input_devices_seq_stop() drops a reference on whateve=
r=20
device input_devices_seq_next() yielded last.

Can this cause a refcount underflow (and potential use-after-free) on the
last device, while permanently leaking the reference to the first device?

[ ... ]
> @@ -1140,6 +1145,17 @@ static void input_seq_stop(struct seq_file *seq, v=
oid *v)
>  		mutex_unlock(&input_mutex);
>  }
> =20
> +static void input_devices_seq_stop(struct seq_file *seq, void *v)
> +{
> +	struct input_seq_state *state =3D seq->private;
> +
> +	if (v)
> +		input_put_device(container_of(v, struct input_dev, node));

[Severity: Critical]
If input_devices_seq_start() is interrupted by a signal while trying to
acquire input_mutex, it returns ERR_PTR(-EINTR). The seq_file core then
passes this error pointer to input_devices_seq_stop().

Because an error pointer is not NULL, the if (v) check will evaluate to tru=
e.

Does this pass an invalid, negative pointer to container_of() and
input_put_device(), potentially crashing the kernel? Should this logic veri=
fy
!IS_ERR(v) before dereferencing it?

> +
> +	if (state->mutex_acquired)
> +		mutex_unlock(&input_mutex);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928171306.5920=
6-1-habilerenturker@hotmail.com?part=3D1
