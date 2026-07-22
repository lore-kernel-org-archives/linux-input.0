Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D953233D9E;
	Wed, 22 Jul 2026 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764226; cv=none; b=sQoaobiy+I4wYZHGFKX8zG9hOty+KYYalNlpx5QQFkCTitQ9TkWYKTu8+xwenVY2empCOj7hCqqBtETUPs7X89K2FblIcbIWTtMKSA9nt10QNqf7dk1YJYArjZl0BfvahDvdAE+8W9vgLCB5EN9zTSh7tpLc9f5lZzt5HwJaAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764226; c=relaxed/simple;
	bh=OakQWVhdF10RS3kh92NxpUZZff0+Sl09gvPYccKiZj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/EzD1yPrhv80muIhzUdJPZkE2F7e7j5gS7K+2FJWj7ZsnKgad0NqhdrBNuEB8JGkt5gjhbK2WoWpji/42oxtyKPez/g3hjNbX8cTAf5TpiXUL2xa9Pzl2O3PBFvqLV/Db2kr4yCBdnV/wxYP6tv0UeNAbKQKp/rL0Fc3Q2SiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhvvAEUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhvvAEUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C478C1F000E9;
	Wed, 22 Jul 2026 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764225;
	bh=eX+dPuMrIFjKW72Pu/1PMw+e+pkWBgKsM1INZa44JW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhvvAEUtidZNdpFdpoUtCxU+noyAuQ1K9BVwS4LVJMpWepBxRmA2r5Nbsg6JeW8kl
	 rnxM3SbKbK9eB5/mwoStoYaDNdugWK/Yp00+0SiYnlWhU+rvyrKvEGvZHWtLT9aFr9
	 i8L8PkqdJLijU6B8Kcr+6mICR6D3otHi2H5IiXtTZuUtmVhKcxfpQgOgwbTEfCm8JN
	 Qi/1z7VKpQ4bV5HzXvQWPpvYTVMWyzhXSmm8343oRCXibBQJUHW0qK8jpnPfAyuFc3
	 NJEMf+Pas8QnFAoN12ZKd5UKeLdKbud6qOScBjOlL8A4Io+Gauu/Ry+XEDhoVufQWZ
	 zwucegS/yrsXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfuncs
 in a rbtree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260722233518.778854-4-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:50:24 +0000
Message-Id: <20260722235024.C478C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent dismissal of inconsistent kfunc flags during deduplicatio=
n.
--

--- Patch [3]: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfunc=
s in a rbtree ---
commit d91e5d0dd32a660902e686ef89cb30a196dda160
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

resolve_btfids: Keep collected kfuncs in a rbtree

This commit changes the storage of collected kfuncs from a dynamically grown
array to an rbtree keyed by BTF ID. This allows for efficient deduplication
when kfuncs are declared in multiple sets.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 3198198b03a78..de4986e1bc3d1 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
[ ... ]
> @@ -979,14 +978,48 @@ static int push_decl_tag_id(struct btf2btf_context =
*ctx, u32 decl_tag_id)
> =20
>  static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
>  {
> -	if (ensure_mem(&ctx->kfuncs, &ctx->max_kfuncs, ctx->nr_kfuncs + 1))
> +	struct rb_node **p =3D &ctx->kfuncs.rb_node;
> +	struct rb_node *parent =3D NULL;
> +	struct kfunc *k;
> +
> +	/* Dedup by BTF ID: collecting the same kfunc twice is a no-op. */
> +	while (*p) {
> +		parent =3D *p;
> +		k =3D rb_entry(parent, struct kfunc, rb_node);
> +
> +		if (kfunc->btf_id < k->btf_id)
> +			p =3D &(*p)->rb_left;
> +		else if (kfunc->btf_id > k->btf_id)
> +			p =3D &(*p)->rb_right;
> +		else
> +			return 0;

[Severity: Medium]
Does this silent return effectively ignore conflicting flags from subsequent
declarations?

If the same kfunc is mistakenly declared in multiple BTF sets with different
flags (such as KF_ACQUIRE vs none), returning 0 here without checking if
k->flags =3D=3D kfunc->flags will silently discard the incoming flags.

Could this cause critical security flags like KF_ACQUIRE or KF_TRUSTED_ARGS
to be unexpectedly dropped depending on the processing order?

> +	}
> +
> +	k =3D zalloc(sizeof(*k));
> +	if (!k)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722233518.7788=
54-1-ihor.solodrai@linux.dev?part=3D3
