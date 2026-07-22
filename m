Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9D3D649F;
	Wed, 22 Jul 2026 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764123; cv=none; b=YsM8PR7l4W2py7P+AaES8WAVgnpvZhA7wbMKNHe9Df8HgdFwn/1a61k/MZ8WFvVpixUXfmU+tA7Xm/8dh8il1IMGrZyOKoHsn/cNrqkYqplFmUwbJs3zii5iFJcIZsnEUp8fTfHJg5u/dAqanq+zRTQIS/5TP6ut4bw8brvWm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764123; c=relaxed/simple;
	bh=Zrb5LB/44WR8lAoSNkg7hcwTaeqbxJXE42E/7cseLy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SWogXqOTB+8kB4Lgzq9iHIpoO1F/In8Cx6vQo/aVlWpRflLuQj157lxdP3SefiVSrQE+Z5CINfcCeFSzrO8wOMBePB9MTdOdvByjTJJrrRUPIZMep99OIkHUYb+8hzHYv3BrkuYy8xrd3Krgnfku/nnoMqQWB5wiBRFekFiDavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czDOSXjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czDOSXjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B271F000E9;
	Wed, 22 Jul 2026 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764122;
	bh=lp1VC+wt8Fig+GTG216JohZMHVxG9ST3vseMYFCFMXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=czDOSXjL38XtKudtnDVwqCyMvNDSXW/wO5NmoSYr5L9zW3oZwIuvXJ4w+e4/tfp5B
	 w6dePX44w0djrfo/3EIxeWRj3gSTVZwTc+cm5sIZxbLSaTaK2cQlzPigrQ6xq0G9rw
	 ndi4PEouaKBm3hP1NShayK1zphooaaQjGv4IB3koirGK+s8VG7ykqbWWhlyWkXb74O
	 J08RJ8zOVgb9jrMD4gQ0nV3ePuuCK+jOcFOkDSv6ZUYXHlaHfV+9/fdzF0PjaOSuo9
	 cXzk7dr8K5IgMJBpuwYfC7yEfkJV+G/26bzB34Uww6DbWH2QY3J9lJyZK9HDwVx/Vo
	 BYog3jEqrBLXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic
 ensure_mem() to grow arrays
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260722233518.778854-2-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:48:41 +0000
Message-Id: <20260722234842.68B271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Strict aliasing violation via `void **` casting leading to poten=
tial Use-After-Free.
--

--- Patch [1]: [PATCH bpf-next v1 1/8] resolve_btfids: Implement generic en=
sure_mem() to grow arrays ---
commit b5970d9bf6b1262c4ad812706df67f4a14ee5411
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

resolve_btfids: Implement generic ensure_mem() to grow arrays

This commit factors out array growth logic from push_*() helpers into a
generic ensure_mem() macro and function. It uses a void ** cast to update
the array pointer upon reallocation.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f8a91fa7584f4..183466ddc5f97 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -201,6 +201,35 @@ static int eprintf(int level, int var, const char *f=
mt, ...)
>  #define pr_info(fmt, ...) \
>  	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
> =20
> +/*
> + * Grow *data so it can hold at least cnt elements of elem_sz bytes each.
> + * *cap is the capacity in elements and is updated on growth.
> + */
> +static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
> +{
> +	u32 new_cap, old_cap =3D *cap;
> +	void *arr;
> +
> +	if (cnt <=3D old_cap)
> +		return 0;
> +
> +	new_cap =3D max(old_cap + 256, old_cap * 2);
> +	if (new_cap < cnt)
> +		new_cap =3D cnt;
> +
> +	arr =3D realloc(*data, elem_sz * new_cap);
> +	if (!arr)
> +		return -ENOMEM;
> +
> +	*data =3D arr;

[Severity: Medium]
Will this assignment violate strict aliasing rules? Because void * and u32 *
are incompatible types, modifying the pointer through a void ** pointer
violates C strict aliasing.

While core kernel code is compiled with -fno-strict-aliasing, programs under
tools/ are compiled with standard optimizations including -fstrict-aliasing.
If __ensure_mem() is inlined, could the compiler assume that this assignment
does not modify the original typed pointer?

> +	*cap =3D new_cap;
> +
> +	return 0;
> +}
> +
> +#define ensure_mem(arr_ptr, cap_ptr, cnt) \
> +	__ensure_mem((void **)(arr_ptr), (cap_ptr), (cnt), sizeof(**(arr_ptr)))

[Severity: Medium]
Does casting a typed double pointer (like &ctx->decl_tags which is u32 **) =
to
void ** here set up the strict aliasing violation mentioned above?

[ ... ]

> @@ -890,17 +919,8 @@ static const struct btf_type *btf_type_skip_qualifie=
rs(const struct btf *btf, s3
> =20
>  static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
>  {
> -	u32 *arr =3D ctx->decl_tags;
> -	u32 cap =3D ctx->max_decl_tags;
> -
> -	if (ctx->nr_decl_tags + 1 > cap) {
> -		cap =3D max(cap + 256, cap * 2);
> -		arr =3D realloc(arr, sizeof(u32) * cap);
> -		if (!arr)
> -			return -ENOMEM;
> -		ctx->max_decl_tags =3D cap;
> -		ctx->decl_tags =3D arr;
> -	}
> +	if (ensure_mem(&ctx->decl_tags, &ctx->max_decl_tags, ctx->nr_decl_tags =
+ 1))
> +		return -ENOMEM;
> =20
>  	ctx->decl_tags[ctx->nr_decl_tags++] =3D decl_tag_id;

[Severity: Medium]
Could this assignment result in a use-after-free? If the compiler's strict
aliasing optimization assumes ctx->decl_tags was not modified by ensure_mem=
(),
it might use a cached pointer that was freed by realloc() during the array
assignment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722233518.7788=
54-1-ihor.solodrai@linux.dev?part=3D1
