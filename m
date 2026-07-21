Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126546F49C;
	Tue, 21 Jul 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656723; cv=none; b=nUxUXRFf2PkBq+TN3QEIeRFPDVAASNhpnCpDlufNPgqhh6WGT82QiZAfhXmPcXltSM/VLhlbrnVmCiRCSpqbkArk2Z3aD1cbQXMqfwF0+GzwcDIQ5KU6vLvCQtLMIPRe4KxTCdhIpgF+hYiNUtrnzP5iMiuGp9Y66WrAppr6Fh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656723; c=relaxed/simple;
	bh=GjX66ibjlZtOvmi+F63LPSQ8nqnkJiCYhN30iqDOdaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxvK7724Bc3Fo1u2Xpa2xAjCumBXHq1520dE8reRlq/6KhopwNn2FbI8oYv+6nqBK2q5Dv2SUcvZgqE7uw63ZJtRpx0FI4Upk4DhIcHUs/AQoxVV9RvTnwG3ExotlGUxwHY4ea/bjavq9wDTGHRRcaKOQL629ztFSSUZy2VC6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAml5XoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAml5XoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7841F00A3A;
	Tue, 21 Jul 2026 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656722;
	bh=repMynv4HDQVgPVIv/+dAYmBY70oTENVxSoX+I3IzNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LAml5XoEy1lkruOIT49LJtiHlXOUWOrPjaRMnkqP0Ga4szQo38wwdwBxgi4gfv3EP
	 2bz/XzEUorc8ZiGVTst3NpzzkyhtZDvjPcZF56JB7p2QIkjMv5azxH0o/gdQO7ziLK
	 rUrvNbczBPdH4vjlaTw3/b7Q1AOUfKU2ACHb+b8zOQ8wBQbrWrP5JWPhhd5uCcidNo
	 u/O/FsFwnPq8HjBmST0wxgnAOxKfvyaKzbuN9WF7Hr/IBNCwZ/cPVE7FPxEsAtx2wl
	 su0t1//CFExtf7+BYh9FihUHmTmfvUY3rrVb/iHl2EBsi3UDzt1H+xZWP1a4bdACDS
	 uXqLp42U2Dxgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] selftests: add shared lib.bpf.mk to build BPF
 progs and skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: sched-ext@lists.linux.dev, mkoutny@suse.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, bpf@vger.kernel.org, hannes@cmpxchg.org, tj@kernel.org
In-Reply-To: <20260721174833.1232771-2-ziyang.meme@gmail.com>
References: <20260721174833.1232771-1-ziyang.meme@gmail.com>
 <20260721174833.1232771-2-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:58:41 +0000
Message-Id: <20260721175841.9F7841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The `bpf_link` macro drops `LDFLAGS` and `CPPFLAGS` when linking=
 user-space test binaries.
- [Medium] Hardcoded `pkg-config` breaks target feature detection for `libz=
std` when cross-compiling.
- [Medium] Missing compiler-generated dependency tracking for BPF objects l=
eads to stale builds.
- [Medium] The documented caller contract omits `$(BPFOBJ)` as a prerequisi=
te for test binaries, breaking incremental relinks.
--

--- Patch [1]: [PATCH v2 1/4] selftests: add shared lib.bpf.mk to build BPF=
 progs and skeletons ---
commit 5037b1678e6c542784cb0b94b1da28ba597740a3
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests: add shared lib.bpf.mk to build BPF progs and skeletons
   =20
This patch introduces tools/testing/selftests/lib.bpf.mk, a shared Makefile
fragment to standardize building BPF programs, skeletons, and the libbpf
toolchain. It provides a common configuration and a bpf_link macro for
test binaries to easily link against libbpf.

> diff --git a/tools/testing/selftests/lib.bpf.mk b/tools/testing/selftests=
/lib.bpf.mk
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/lib.bpf.mk
> @@ -0,0 +1,247 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Shared fragment for selftests that compile *.bpf.c into BPF objects +
> +# skeletons and link them into userspace test binaries, without each
> +# subsystem's Makefile re-implementing the libbpf/bpftool/vmlinux.h mach=
inery.
> +#
> +# Caller contract (per-test Makefile):
> +#
> +#     BPF_SRCS         :=3D foo.bpf.c bar.bpf.c
> +#     TEST_GEN_PROGS   :=3D foo_test
> +#     OVERRIDE_TARGETS :=3D 1              # MUST be set before lib.mk
> +#     include ../lib.mk                  # defines OUTPUT, CC, Q, msg,
> +#     include ../lib.bpf.mk              #   selfdir, top_srcdir; honour=
s OVERRIDE
> +#
> +#     $(OUTPUT)/foo_test: foo_test.c $(BPF_SKELS)
> +#         $(call bpf_link,$@,$<)

[Severity: Medium]
Should $(BPFOBJ) be included as a prerequisite in this caller contract
template? If a user follows this example and libbpf.a is rebuilt, make
will not relink the test binaries that depend on it.

[ ... ]

> +# Locate the sources wherever the caller keeps them (e.g. progs/).
> +vpath %$(BPF_PROG_EXT) $(sort $(dir $(BPF_SRCS)))
> +
> +$(BPF_OBJS): $(BPF_OBJ_DIR)/%.bpf.o: %$(BPF_PROG_EXT) $(BPF_EXTRA_HDRS) \
> +	     $(wildcard *.bpf.h) $(INCLUDE_DIR)/vmlinux.h | $(BPF_OBJ_DIR) $(BP=
FOBJ)
> +	$(call BPF_BUILD_RULE,$<,$@)

[Severity: Medium]
Will relying on this wildcard approach fail to track included headers if th=
ey
are located alongside sources in subdirectories like progs/?

Should this use compiler-generated dependency tracking (-MD/-MMD) instead
so developers don't end up testing stale code?

[ ... ]

> +# Static libbpf.a first, then its deps. libbpf may pull in zstd (BTF dec=
ompress)
> +# only when built against it; link -lzstd only if libzstd is present.
> +BPF_LDLIBS :=3D $(BPFOBJ) -lelf -lz
> +ifneq ($(shell pkg-config --exists libzstd 2>/dev/null && echo y),)
> +BPF_LDLIBS +=3D -lzstd
> +endif

[Severity: Medium]
Can this hardcoded pkg-config break target feature detection when
cross-compiling?=20

This queries the host's pkg-config environment instead of the target's
sysroot, which might cause link errors if libzstd availability differs
between the host and target. Should it use $(PKG_CONFIG) instead?

[ ... ]

> +TEST_GEN_FILES +=3D $(BPF_OBJS)
> +
> +# Link helper: $1 =3D output binary, $2 =3D test .c (skels are the targe=
t's deps).
> +define bpf_link
> +	$(call msg,BINARY,,$1)
> +	$(Q)$(CC) $(CFLAGS) $2 $(BPF_LDLIBS) $(LDLIBS) -o $1
> +endef

[Severity: Medium]
Does this compilation command drop $(LDFLAGS) and $(CPPFLAGS)?=20

These are normally included in lib.mk's default link rule. Skipping them
might ignore user-specified flags like static linking, RPATHs, or sanitizer=
s.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174833.1232=
771-1-ziyang.meme@gmail.com?part=3D1
