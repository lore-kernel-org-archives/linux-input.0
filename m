Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F4404BFD
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722674; cv=none; b=umphSmaReaCZNZ/yEsOwHqGLlZcdjUPaDKhQbMAm2angODtg+MjAdz2mo+Hw4ND+/PzuoFY4/HhhXhPDVukG5Lx5rrUsHNJiFBAvRE2yfItP5v+4sZZUBBsC+6q0jh9L9Zvhql+AX/8HHVPtVqgzekVsUqo47bTiG53Th6cR2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722674; c=relaxed/simple;
	bh=KNU956WbXUTuSnCzMU/9cD+JnhsZzaznC141dmSOsok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLXEVuRTPUMDIFGka4vEURcapcTREOkT9fXsGNfVxxYSsfzKDipJ86/5oUVDe9eLaO8EEnnfsanRS8uGFMBeF/WRq1SJgm4dnl/NOB9aGoRQJb9ybUUoBIqrScR/w50aDVgEz5Ofx+hAsVDR+6Cm+xLYo8oQnjK6V3UnLsUhRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v/h/SoCI; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v/h/SoCI"
Message-ID: <dc6cc14c-3ec8-48ee-8152-f24643679dfc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783722670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoPzMG2SN6nIvki88FrSOBZdQ9DO7hqanhNeX70pujM=;
	b=v/h/SoCIzt0ttRzOTf0222LerJN6TpFZXUrDgl+0eaDO49Meyn7V51LJkPhmIkJ1FcCWyS
	P4WLRknp2ItKTuDgEAhKJHBOI4vK/UuJc+tOA8uAxFXXfWzJ+eLuzgLM6JITt1PyDwU8xP
	uauauAP2P4eUuFfJEIcSonEnsZw7+rk=
Date: Fri, 10 Jul 2026 15:30:58 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
To: James Clark <james.clark@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
 <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/18/26 2:03 AM, James Clark wrote:
> Building with LLVM=... could result in a different version of lld being
> used than the main toolchain for liburandom_read.so because it's
> hardcoded to "lld" in this makefile.
> 
> Make it consistent with the rest of the LLVM toolchain by adding an LLD
> variable to Makefile.include. Keep the fallback for other architectures
> in tools/testing/selftests/bpf/Makefile as it seems like it's something
> specific to this make rule and shouldn't be global.
> 
> Clang only accepts either a full path to "/x/x/ld.lld" or "lld-15" style
> inputs to "-fuse-ld=", so the only way to make it work with both
> prefixed and postfixed paths is to always take the full path. Also I
> don't think the original use of "lld" over "ld.lld" was significant as
> this is always a linux build, so that can be changed to make it work in
> both cases.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/scripts/Makefile.include       | 2 ++
>  tools/testing/selftests/bpf/Makefile | 8 ++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 380ad84ac51e..5c2d505cba62 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -67,6 +67,7 @@ ifneq ($(LLVM),)
>    $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
>    $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
>    $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
> +  $(call allow-override,LLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
>    $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
>    $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
>    $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
> @@ -91,6 +92,7 @@ else
>    # Some tools still require Clang, LLC and/or LLVM utils
>    $(call allow-override,CLANG,clang)
>    $(call allow-override,LLC,llc)
> +  $(call allow-override,LLD,ld.lld)
>    $(call allow-override,LLVM_CONFIG,llvm-config)
>    $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
>    $(call allow-override,LLVM_STRIP,llvm-strip)
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6ef6872adbc3..836e783f0170 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>  
>  # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
> -LLD := lld
> +USE_LD := $(shell command -v $(LLD))
>  else
> -LLD := $(shell command -v $(LD))
> +USE_LD := $(shell command -v $(LD))

Can confirm v2 fixes the v1 breakage I reported.

One nit on the empty USE_LD case the bot raised. It isn't actually a
build failure: if command -v finds nothing, USE_LD is empty and clang
gets a bare "-fuse-ld=".

Since it's unintentional, how about we just add a check to ensure the
linker was found?

Something like:

    $(Q)test -n "$(USE_LD)" || { \
        echo "$@: linker '$(LINKER)' not found - add it to PATH, or pass \
        LLVM=/path/ or LLD=/abs/ld.lld" >&2; exit 1; }


>  endif
>  
>  # Filter out -static for liburandom_read.so and its dependent targets so that static builds
> @@ -258,7 +258,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>  		     -Wno-unused-command-line-argument \
> -		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> +		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>  		     -Wl,--version-script=liburandom_read.map \
>  		     -fPIC -shared -o $@
>  
> @@ -268,7 +268,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
>  		     -Wno-unused-command-line-argument \
>  		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
> -		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> +		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>  		     -Wl,-rpath=. -o $@
>  
>  $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
> 

