Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56702423A80;
	Fri, 14 Aug 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694478; cv=none; b=Y79Y1prbWnmGYJxTLFrxHTD0M7tzcyiqbfNEyNYQgEVa1csYAdK4Y+GJAtlHyRNtBf1hFWS7TOyKPrGV84eku1vyRvzvg4/cmE/Pkt0m1eujhV4EQOOzZ1Rrve5nzVR2K7D8HXO0/YCkWMkci09mRAbs9MwfJkKcyTwWktC+c6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694478; c=relaxed/simple;
	bh=JokbiO8UjF4fat0+cc7ulERvu7scmmqYEb4icp9V1ng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jhA7+xKxvq7I4yNxWBYUj/RYTfowxdidinfjlMc62Y2xEclHvDRrKYbJEC5sHdJYZpXmSTSQsirxmf0jLGVIASI5S+NLIIysTgtOBCNsJnGLdEy1/DpXZ28ZwjsOfBSFlAgp3ivGw/hF4Op+mPxPpjExWY0LNqgHX595Oz0Ee3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm7autna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm7autna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AE71F000E9;
	Fri, 14 Aug 2026 08:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786694476;
	bh=QcVYP5m5Z2fxMVepfdaGAnjunhh6Uc+168hWIE1Ods8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xm7autnaR5qjk9HsBgM2wmXg7M/MJ05s73htbhFJFZsxOWhWUVDnb3aFGUZwqqAv3
	 JDtKtGbfaIk45+OIVN1JhF8KQYUgIFNR68XZQvnSGxlsQla/dDtX3UUHXh8V4EwBFI
	 BUPxr1Z4sLOzwfFx3iW4NVhjZJ7nOQCJFHyrDvyaG5LXnwoP+I/qfYlUwo1P3LaUxH
	 MUyJWx4Qs0kx3UeqyocCCgGUpGi/wQCAomDjwrUJsqS56rdE4uZCpqUVHMRGHFRJkF
	 rKJ4AMWAf6HIGcE8EKJtguEJHAy2CQLmt0q4yyXQjwCJ6f7xoIYPrmBq9mNQe9tym6
	 m+Dq4pvYEqIhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] selftests: add shared lib.bpf.mk to build BPF
 progs and skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: linux-input@vger.kernel.org, sched-ext@lists.linux.dev, hannes@cmpxchg.org, tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com, dmitry.torokhov@gmail.com
In-Reply-To: <20260814075054.507089-2-ziyang.meme@gmail.com>
References: <20260814075054.507089-1-ziyang.meme@gmail.com>
 <20260814075054.507089-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:01:15 +0000
Message-Id: <20260814080116.62AE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] BPF objects will not automatically rebuild when libbpf headers a=
re modified, breaking incremental compilation.
- [Low] Missing Clang system include definitions for LoongArch and MIPS arc=
hitectures.
--

--- Patch [1]: [PATCH v3 1/4] selftests: add shared lib.bpf.mk to build BPF=
 progs and skeletons ---
commit 73f22930c4ae7eac2caa52ed8b921af4c943e0a7
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests: add shared lib.bpf.mk to build BPF progs and skeletons

This commit adds a shared tools/testing/selftests/lib.bpf.mk file to provide
a common build toolchain for BPF programs and skeletons across different
selftest directories. It aims to reduce duplication of the libbpf, bpftool,
vmlinux.h, and skeleton generation Makefiles currently present in bpf,
sched_ext, and hid selftests.

> diff --git a/tools/testing/selftests/lib.bpf.mk b/tools/testing/selftests=
/lib.bpf.mk
> new file mode 100644
> index 0000000000000..433a26a36960b
> --- /dev/null
> +++ b/tools/testing/selftests/lib.bpf.mk

[ ... ]

> +# ---- compiler flags --------------------------------------------------=
-----
> +# Find the normal system headers that Clang omits with --target=3Dbpf. P=
ut them
> +# last with -idirafter so they cannot replace project headers.
> +define get_sys_includes
> +$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> +	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)=
|-idirafter \1|p }') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{pri=
ntf("-D__riscv_xlen=3D%d -D__BITS_PER_LONG=3D%d", $$3, $$3)}')
> +endef

[Severity: Low]
Will BPF programs fail to compile on LoongArch and MIPS architectures?

The original selftests/bpf/Makefile extracts necessary host definitions
like __loongarch_grlen and MIPS macros.

This new macro appears to drop those extractions, which might cause Clang's
--target=3Dbpf to fail to parse system headers on those architectures.

[ ... ]

> +# Make one rule for each source. A global vpath would also match the tes=
t's
> +# normal C rules when BPF_PROG_EXT is .c.
> +define bpf_obj_rule
> +$(BPF_OBJ_DIR)/$(patsubst %$(BPF_PROG_EXT),%,$(notdir $(1))).bpf.o: $(1)=
	\
> +		$(BPF_EXTRA_HDRS) $(INCLUDE_DIR)/vmlinux.h			\
> +		| $(BPF_OBJ_DIR) $(BPFOBJ)

[Severity: Medium]
Will this break incremental compilation when libbpf headers are modified?

Since $(BPFOBJ) is specified only as an order-only prerequisite and there is
no explicit Make rule for the installed headers, Make evaluates their
timestamps before $(BPFOBJ) updates them.

Does this cause BPF objects to be incorrectly skipped during the first make
invocation after modifying a libbpf header?

> +	$$(call BPF_BUILD_RULE,$$<,$$@)
> +endef

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814075054.5070=
89-1-ziyang.meme@gmail.com?part=3D1
