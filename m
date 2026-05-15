Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679D3E171E
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885915; cv=none; b=LvF3KGYlgG3Jn/zk+VxhNg/mjTzUZYUMdlL9otAA0x5/RbfY1CwBx5WpP2rsosxfK06+5uVU0pCiVFhpOIphxbloaTmcPCAzS6GgeJ558mgp/KY4+OEJmZTSMINcS2pTP1q3lO+cFyZqLCIb/iEjaUTOb2fpHkjimju+SA04RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885915; c=relaxed/simple;
	bh=YCcPJH/vYgPQzSl/jsRGZR7a3T07mS4IJqsbO6CFGbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU/pxgKS+Vyr83JEawUS9e34obtM3Un8prAzgzpGJYw9R/cY/IgTrhIgkWrlmJ/rIWPR0ybLhxnMG6Rbm1gNmb+HviPD3zNI46hJV0ss//3C+DoSVtjnT6xqA/8/iUQeG+mXgmVOPYc/fws0M031iFDKOiTUKrZl257MNE7FgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FN46Z9kg; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FN46Z9kg"
Message-ID: <bda702a1-18f5-47ed-8a4e-a01b94829e07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778885911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycnjTqUOfjzmeEfBwBIsxrCHrlibJg0T0GtKO5eKf28=;
	b=FN46Z9kgrU4Kbrry6rzC1hKw5c/BjJWT9JzboldGA6XMR/SAGsv528OaUcjWjUgSQeYBmd
	5K+exPVhr0rkGPOt/yb/c/n4qF/6CBQfTOFh6/xG+dXkoSNGmmEZt0uvPz9elT4wnWFAFD
	bzNYWItnaGOho3LJep+0i0TX7jE83Ck=
Date: Fri, 15 May 2026 15:58:14 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] tools/build: selftests: Allow versioning LLVM lld
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
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, leo.yan@arm.com
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
 <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/26 2:32 AM, James Clark wrote:
> Building with LLVM=... could result in a different version of lld being
> used than the main toolchain for liburandom_read.so because it's
> hardcoded to "lld" in this makefile.
> 
> Make it consistent with the rest of the LLVM toolchain by adding an LLD
> variable to Makefile.include. Keep the fallback for other architectures
> in tools/testing/selftests/bpf/Makefile as it seems like it's something
> specific to this make rule and shouldn't be global.
> 
> Clang accepts either a full path or "ld.lld-15" style inputs to
> -fuse-ld= so this will work with LLD defined the same way as the other
> LLVM tools. However, for full paths, we need to use ".../ld.lld" instead
> of the generic driver "lld", but I don't think the original use of "lld"
> was significant as this is always a linux build.
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
> index 6ef6872adbc3..44ba829e5d4d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>  
>  # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
> -LLD := lld
> +USE_LD := $(LLD)
>  else
> -LLD := $(shell command -v $(LD))
> +USE_LD := $(shell command -v $(LD))
>  endif
>  
>  # Filter out -static for liburandom_read.so and its dependent targets so that static builds
> @@ -258,7 +258,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>  		     -Wno-unused-command-line-argument \
> -		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> +		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \

Hi James,

This patch breaks the selftests/bpf build:

$ clang --version
clang version 22.1.3 (CentOS 22.1.3-1.el9)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg

$ make LLVM=1 -j$(nproc)
  [...] # ok

$ make LLVM=1 -C tools/testing/selftests/bpf -j$(nproc)

[...] # somewhere in the middle

  LIB      liburandom_read.so
clang: error: invalid linker name in argument '-fuse-ld=ld.lld'
make: *** [Makefile:256: /home/isolodrai/workspace/review/linux/tools/testing/selftests/bpf/liburandom_read.so] Error 1
make: Leaving directory '/home/isolodrai/workspace/review/linux/tools/testing/selftests/bpf'

[...]

Or a simpler reproducer:

$ make LLVM=1 OUTPUT=/tmp/out /tmp/out/liburandom_read.so
  LIB      liburandom_read.so
clang: error: invalid linker name in argument '-fuse-ld=ld.lld'
make: *** [Makefile:256: /tmp/out/liburandom_read.so] Error 1

$ make LLVM=-22 OUTPUT=/tmp/out /tmp/out/liburandom_read.so
  LIB      liburandom_read.so
clang-22: error: invalid linker name in argument '-fuse-ld=ld.lld-22'
make: *** [Makefile:256: /tmp/out/liburandom_read.so] Error 1

I tried your patches, and only then noticed BPF CI caught this too:
https://github.com/kernel-patches/bpf/actions/runs/25943477658/job/76267174885?pr=12082

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

