Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E2466AF6;
	Wed, 22 Jul 2026 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763840; cv=none; b=EBtCsDvPQNN+I9oM+nKBz6Euz99WdoJ6n31unhCB1rKSbvdtoPxZo0hd1/rXGozXCqMaQi8YDyU/TYYlrBTvjQlGGBxAu+KlDDVDCP1f4FntAOSYblDkNuAeK6G6NcSFdC0+3oJgxaJf08oCf9D9/SSom/KuE5vYvBFpgHKLpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763840; c=relaxed/simple;
	bh=D62IP+KLQlfmJkEusjxeB5k2yeFnAC73q8/4latkJNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLFuL1TCGFzpVfQZGFfwFnjNUml4I2Azw0SFkh5Q0j3X/yw7NawjoQ+02bn0qEYZloJDEP+foD9ZgTYJG/+Vq1/eE8OP4/49AQmnAmY5QfcRyyUvDm2Qhn0acY8sgarDnBJT7tl6puYcgXj1u6lhDt5GFDUI5bBlReR9KzBIN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyI8rj5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyI8rj5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA721F000E9;
	Wed, 22 Jul 2026 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784763838;
	bh=YDKYMXDbHU9Sh6MZvKhG0tVgg5rtVV6djkY6spSkmU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oyI8rj5+3HE0YalCNi5FbSaCKSZ3a6fU+sbyxr44S8bbtOztiQuth+z1G7TlJVWis
	 iGso6Z0YGQGCDl2vEB00XeEDQcsW9j1/1nwxs/5J8Z4Njf9fwDCTTeaNsg0LS4I28c
	 HU7/IIFredbin+mMyct6Ey615LopoPHkUZCgGkbZ09dhqB4yNMjDELsrfQ/EomvPuL
	 sQAvosmi5e2LZcC4df9gRZvrO4Ncv1i5v/dg821ul95/OJO2xgocO98fS6yy+/DrPW
	 Ilud3cELufUiZE6BtfrAN2FnkX5fNEGcmTDpF3bQYHzQjE27sHQ/OhdqcD1Gmfkr2T
	 1Y4xKvGbSxvBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/8] libbpf: Export
 btf__find_by_name_kind_own()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260722233518.778854-5-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:43:57 +0000
Message-Id: <20260722234358.4AA721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly exposed public libbpf API `btf__find_by_name_kind_own(=
)` lacks the `libbpf_err()` wrapper on its error return path.
--

--- Patch [4]: [PATCH bpf-next v1 4/8] libbpf: Export btf__find_by_name_kin=
d_own() ---
commit 60b04eac1753190ac945126aaca0759082942bc0
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

libbpf: Export btf__find_by_name_kind_own()
   =20
btf__find_by_name_kind() searches the base BTF before the split BTF,
so in case of a name collision between base and split it always
returns a base type. Tools that process split BTF may need to restrict
a lookup to the split's own types.
   =20
The internal helper btf__find_by_name_kind_own() already does exactly
that. Make it a public API.

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 1a31f2da947f8..587172c0de089 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -172,6 +172,8 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *=
btf,
>  				   const char *type_name);
>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>  					const char *type_name, __u32 kind);
> +LIBBPF_API __s32 btf__find_by_name_kind_own(const struct btf *btf,
> +					    const char *type_name, __u32 kind);

[Severity: Medium]
Since btf__find_by_name_kind_own() is now a public API, shouldn't its return
path in tools/lib/bpf/btf.c be updated to use libbpf_err()?

Currently, it returns the value from the internal helper directly:

tools/lib/bpf/btf.c:btf__find_by_name_kind_own() {
	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
}

The libbpf public API error handling contract requires all public API funct=
ions
to set errno using libbpf_err() directly on their return statements. While =
the
internal helper btf_find_by_name_kind() currently sets errno indirectly, re=
lying
on it could cause issues if the internal helper is later fixed to return raw
error codes.

Should this be updated to return libbpf_err(btf_find_by_name_kind(...))?

>  LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722233518.7788=
54-1-ihor.solodrai@linux.dev?part=3D4
