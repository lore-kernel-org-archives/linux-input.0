Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5894F392B
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615373; cv=none; b=ZPtsGgsqlmLPshbETMm++qVo1jAXoJVUHibaebrU/5vaZnyZfW+amku0oTvYoh5Vev4BxLKNo7IDF8zhEZZGD20eiWQ0vUAjc8qp0z5Z+bWjw/5Xo6g7vORCE/ypWwhfrpC+QpxEU4Qwlag37ZoK3q2y4K26srcGrV3JP9ybKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615373; c=relaxed/simple;
	bh=XkN0YboTBpbSBkmEOy1sBUaA6cc6mPVPnPHKulShpkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ckD5rLO8PZcj80mGq+Y96vSrQ0bDWZId2TMsskg2+9mDy3Rp0bwDYfbM3SWOkTySaiO41Eg1ryYBt5Ionj9mobJrVObMuK0xqwG0B/3gdnOFZSU5noGQhVDHcEhDF92Qak35leBUiLSfgawirfc6YDufMJcpPeMBt8ozJsbM8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFC8QYHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFC8QYHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D321F000FF;
	Mon, 28 Sep 2026 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615370;
	bh=53AWMs8QGR2dbLgt78bPavvPk96BnQwhoPBXvFnJ0Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFC8QYHu2OqLq1qHrWTYwxvnic7FAs6p+nSrb65nS42iHD1Kup4zq3i18Q/7ydmAB
	 ICxTX4PcYrv8LWeXSzHv6VRMvBUZxMkdTQcZZ4ALCLtfrQy0/gC/DD3riPGfUD/08Y
	 vLIsdCHAqAizH18aShwPfa14aUF2RbPYURmVdota8FZf5h4Nn+DnilNPcEoE3+AP0C
	 Zi4YHtN4FbIa/x7woKtc9RcBxZfhJjrA1qupiZnWvBX3Yug5OnHHF63GgOdlVfRaqh
	 G97ExydEjPdvlHRIJ4ma1jjLt17ZL+65/5t397hRdTVM0rV5a2XZ/wTc35X7qf2Xn4
	 iBiI9uNA1MGwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: fix potential use-after-free in
 input_devices_seq_show
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260928170051.58695-1-habilerenturker@hotmail.com>
References: <20260928170051.58695-1-habilerenturker@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:09:30 +0000
Message-Id: <20260928170930.C1D321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] mm: reference count imbalance in input_devices_seq_*
- [Critical] mm: invalid pointer dereference of ERR_PTR in input_devices_se=
q_stop
- [Medium] locking: unnecessary device refcounting due to flawed concurrenc=
y premise
--

commit 0ec10a6d37b0ca4c2e2e4d84fe21437f9040399a
Author: Habil Eren T=C3=BCrker <habilerenturker@gmail.com>

Input: fix potential use-after-free in input_devices_seq_show

This patch attempts to fix a potential use-after-free by taking a reference
to the input device during sequence iteration. It acquires the reference in
input_devices_seq_start() and drops it in input_devices_seq_stop().

> The input_devices_seq_show() function accesses the input_dev structure
> while holding input_mutex. However, the device can still be freed
> concurrently, leading to a use-after-free.

[Severity: Medium]
Can we re-evaluate if this concurrent free is structurally possible?

Looking at __input_unregister_device(), the device is removed from
input_dev_list strictly inside a scoped_guard(mutex, &input_mutex) block.
Because seq_file iteration holds input_mutex for the duration of the loop,
unregistration and freeing cannot occur concurrently with sequence iteratio=
n.

The devices in the list appear to be inherently pinned by the mutex.

> diff --git a/drivers/input/input.c b/drivers/input/input.c
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
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
>  {
>  	return seq_list_next(v, &input_dev_list, pos);
>  }

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
Does this introduce a reference count imbalance during iteration?

In input_devices_seq_start(), a reference is acquired for the first element.
However, input_devices_seq_next() advances the iterator without releasing t=
he
previous element's reference or acquiring a new one for the next element.

When input_devices_seq_stop() is called, it drops a reference on whichever
element the iteration halted on. If iteration stops on any element other th=
an
the first, the first element's reference is permanently leaked, and the fin=
al
element's reference count will underflow.

[Severity: Critical]
Is there a risk of an invalid pointer dereference if mutex_lock_interruptib=
le()
fails?

If mutex_lock_interruptible(&input_mutex) in input_devices_seq_start() is
interrupted, it returns ERR_PTR(-EINTR). The seq_file core passes this error
pointer to input_devices_seq_stop() as 'v'.

Since an ERR_PTR is not NULL, the 'if (v)' check passes. Does this cause
container_of() and input_put_device() to dereference a garbage pointer? Sho=
uld
this check be 'if (v && !IS_ERR(v))' instead?

> +
> +	if (state->mutex_acquired)
> +		mutex_unlock(&input_mutex);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928170051.5869=
5-1-habilerenturker@hotmail.com?part=3D1
