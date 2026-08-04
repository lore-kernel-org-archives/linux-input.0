Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4433E8C46
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808458; cv=none; b=ZlCZLFlCnJ/ipR+Rz+1GHSXn/hCQVrDmhrg24L+YF27EthrO+Gy3GOgoigkgemY0oLM+jhXtfqznENPlJl6Q5OyYH8QiK3bKuL4YOS1ft37Ax5X/RhkZ9r88Z1AQwlAy4F8+seeKZM8bKtheaxZVUchrjYt4VJbjxOV4MG2QVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808458; c=relaxed/simple;
	bh=CIYORk3ey3T8sngE536gN4gtzdccCTz3grxTUxvQcZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccx3yXa/2bxdiuE3/mbMUmyTPqxFR3FXw9vm8NRuZ2tz/CyzPVzzRbnnQKLHMWTx1Dza+hGLzwbSO45x8tU6iSrc4rOw/eFAKdCvujyYm5tujzLsqEOV8xZqCHeEaqZwinHM2UxP5B7KozO5UFtxEVAjXNRf5lwZpnacoGngej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfLb4bhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfLb4bhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04CA1F000E9;
	Tue,  4 Aug 2026 01:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808456;
	bh=h1naQ7yirYUYulSw3bUBQcdDsQS1p6WtmVl5Z1nkxEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfLb4bhM8pFIWIIIH1dJzjiItha4r2uw2JFWCIjVnucCd9pCHuJGjKJXjXLylWVGd
	 9aLW4uuEApRLl4KdPkqjJG5Nckum5z3P5AKboxhntxyeGXjQKMaE50ASFaR6q/duwP
	 5+FadyIUdTW7N3NuoOjOaFCmH7KXKLOMkwOuJ36vxkWOEAYzNADVjqBHkg3I3RBzFo
	 tedDSjguezNYoXgm5V8NrLhIRYtdasePFZpvJZb6kF7aIGbykgFvu5KqSErmxnQzFz
	 dVhyXZHYUouygCPHXBR4E5sG3ZbZBvNb9G+NyKYE7hIjqHwu+1zEUOGE60r2F0h5Zl
	 MoO5moTcl0pow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: evdev - sanitize event type index when fetching
 event masks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <anFCAfvxwXB5eJF1@google.com>
References: <anFCAfvxwXB5eJF1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 01:54:13 +0000
Message-Id: <20260804015414.E04CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Spectre v1 mitigation due to misunderstanding of specul=
ative execution on branches.
--

--- Patch [1]: [PATCH] Input: evdev - sanitize event type index when fetchi=
ng event masks ---
commit e9eb78cd8dbba1d32ef31f1eec9a5c00e54b5aad
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: evdev - sanitize event type index when fetching event masks

This commit uses array_index_mask_nospec() in evdev_get_mask_cnt() to clamp=
=20
out-of-bounds event types to 0. It asserts that this is sufficient to preve=
nt=20
speculative out-of-bounds memory accesses in functions like evdev_get_mask(=
)=20
because the returned count is speculatively forced to 0.

> We do not need additional array_index_nospec() calls in evdev_get_mask()
> because evdev_get_mask_cnt() speculatively forces the count (and
> resulting xfer_size) to 0 for out-of-bounds types, preventing any
> speculative memory access to client evmasks array.

[Severity: High]
This is a pre-existing issue, but does relying on the returned count being =
0=20
fully prevent speculative out-of-bounds accesses in callers like=20
evdev_get_mask() and evdev_set_mask()?

When CPU branch predictors mispredict the conditions checking the count, th=
ey
do not wait for the condition to evaluate.=20

For example, if the if (cnt > 0) branch in evdev_get_mask() is mispredicted:

drivers/input/evdev.c:evdev_get_mask() {
    ...
    cnt =3D evdev_get_mask_cnt(type);
    ...
    if (cnt > 0) {
        mask =3D client->evmasks[type];
    ...
}

The branch predictor will speculatively execute the block using the=20
original, unclamped type variable, performing an out-of-bounds read on=20
client->evmasks[type]. The retrieved pointer is then accessed by=20
bits_to_user().

A similar pattern exists in evdev_set_mask(), where a mispredicted if (!cnt=
)=20
branch can lead to using the unclamped type:

drivers/input/evdev.c:evdev_set_mask() {
    ...
    cnt =3D evdev_get_mask_cnt(type);
    if (!cnt)
        return 0;
    ...
    oldmask =3D client->evmasks[type];
    ...
    bitmap_free(oldmask);
}

The speculative read of oldmask is followed by a dereference in bitmap_free=
(),
which creates an exploitable side-channel gadget.

This pattern also appears in __evdev_is_filtered(). A mispredicted bounds=20
check can lead to speculative out-of-bounds accesses for test_bit(type, mas=
k)=20
or mask =3D client->evmasks[type].

Do we still need to explicitly use array_index_nospec(type, EV_CNT) inside
these caller functions to prevent the unclamped type from being used during=
=20
speculative execution?

> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c7325226cb866..32804d6965340 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c

[ ... ]

> @@ -67,8 +68,10 @@ static size_t evdev_get_mask_cnt(unsigned int type)
>  		[EV_SND]	=3D SND_CNT,
>  		[EV_FF]		=3D FF_CNT,
>  	};
> +	unsigned long mask =3D array_index_mask_nospec(type, EV_CNT);
> =20
> -	return (type < EV_CNT) ? counts[type] : 0;
> +	/* Returns 0 for out-of-bounds types, including speculatively */
> +	return counts[type & mask] & mask;
>  }
> =20
>  /* requires the buffer lock to be held */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anFCAfvxwXB5eJF1@go=
ogle.com?part=3D1
