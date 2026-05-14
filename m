Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC0F342523;
	Thu, 14 May 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784344; cv=none; b=pTisklQOmDp1QInMg8n7jXItELrU5BhbadqUs2FF0V3CoDZ+dssXoDiy8V98iTZxceViI0j6UkuRxqkAQMmTdIQ92NA+CMziyYzeMzsHr2KjGe4Xh4Dj10mnu6aD7liGANfeTS7YkckUXHM2xLLw4sFcxgnoSmW//I3w3yTbytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784344; c=relaxed/simple;
	bh=h5NvIKEROpxk8tQsVZfo9Q8scTuE1PnCdvU+OQXEZmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJjTcL+aKtZrRWdEwW0qEyyakQauz6HUVf+s2N4VwgIB9eU0jrRS82mtu3b0c0ZDU2kct6/OCgT3BYocqcuE7zyA/us8O1zns3Oq/3XqfcmJu79frV0CTVz1YtYsTwCBF6UsC+dQnc1nYTui4TZgpUF0UtzcW39BH4bIwFCXNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdYwcARa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdYwcARa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6400C2BCB3;
	Thu, 14 May 2026 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778784344;
	bh=h5NvIKEROpxk8tQsVZfo9Q8scTuE1PnCdvU+OQXEZmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cdYwcARan3Lj3haDRmDWeCqxZM0oywJC4ZdslmqOdtC7eAg9oaeR52e4spxDG5Z/g
	 WzpaPPOlUtWCFjTqeMFncH5xxyrvyFXYkHskd1V7lY6T3F68z1HnLsxBI9DgbMWhw7
	 Dwin+Ir+jp+C9OB+K9Fv1YYK1Qw9OgLJ2tAHwkbUd3DVBvPbAwIYXNgCcFS6CnbB8P
	 zmA7ZBG1OSKJ9ekpZxIF4kyVi5GSlzfqWDEQ8//iTIqhwAbyNUJkZc8HUzs9e8GGN7
	 sg5oTLVrvy2WF3uO1iJSn+xNhobDoXLM1Z2jEBkW63TqYgHIxa2cRYftTQOGmne6b0
	 Dd5a7Ebuq1KMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] tools/build: selftests: Allow versioning LLVM lld
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: dmitry.torokhov@gmail.com, bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 18:45:43 +0000
Message-Id: <20260514184543.C6400C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `-fuse-ld=3Dld.lld` breaks compilation of BPF selftests with=
 GCC.
--

commit 18e1876d18fad631b521da817483ba47293a9020
Author: James Clark <james.clark@linaro.org>

tools/build: selftests: Allow versioning LLVM lld

This commit updates Makefile.include to add an LLD variable, matching the
rest of the LLVM toolchain. It modifies the BPF selftests Makefile to use
this new LLD variable instead of hardcoding lld.

> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 380ad84ac51e6..5c2d505cba62b 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
[ ... ]
> @@ -91,6 +92,7 @@ else
>    # Some tools still require Clang, LLC and/or LLVM utils
>    $(call allow-override,CLANG,clang)
>    $(call allow-override,LLC,llc)
> +  $(call allow-override,LLD,ld.lld)

Could setting LLD to ld.lld when not using LLVM cause issues for BPF
selftests compilation with GCC?

>    $(call allow-override,LLVM_CONFIG,llvm-config)
>    $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
>    $(call allow-override,LLVM_STRIP,llvm-strip)
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 6ef6872adbc3e..44ba829e5d4dd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
> =20
>  # LLVM's ld.lld doesn't support all the architectures, so use it only on=
 x86
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
> -LLD :=3D lld
> +USE_LD :=3D $(LLD)
>  else
> -LLD :=3D $(shell command -v $(LD))
> +USE_LD :=3D $(shell command -v $(LD))
>  endif
> =20
>  # Filter out -static for liburandom_read.so and its dependent targets so=
 that static builds
> @@ -258,7 +258,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c ura=
ndom_read_lib2.c liburandom
>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>  		     -Wno-unused-command-line-argument \
> -		     -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-id=3Dsha1 \
> +		     -fuse-ld=3D$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=3Dsha1 \

When LLVM=3D1 is not set, CC defaults to gcc. The Makefile uses
$(CC) ... -fuse-ld=3D$(USE_LD) to link liburandom_read.so.

Because USE_LD evaluates to ld.lld, gcc receives -fuse-ld=3Dld.lld.

However, GCC's command-line option parser is strictly hardcoded to accept
only specific linker names (lld, bfd, gold, mold). It does not recognize
-fuse-ld=3Dld.lld or absolute paths, and fails with an error like:

gcc: error: unrecognized command-line option '-fuse-ld=3Dld.lld'; did you m=
ean '-fuse-ld=3Dlld'?

Does this regression break the default GCC build of BPF selftests on x86
and riscv architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-james-perf=
-llvm-version-v1-0-6cac1a9a4c8d@linaro.org?part=3D5
