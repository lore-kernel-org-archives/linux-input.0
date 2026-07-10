Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736F432BD5
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722592; cv=none; b=Qd6Qui5Z3KqtOGUtRKVegGpdWhOTwYWxWc+AAGbOF/uvkCFMnTuDDl1wRL2VQndEazDnruqSBJd1tzWIhE5d/4oJTftyiMTPU8VzigkNwXTQKJpsC3izIt/AlyFKqtao3TnvsuaxU28YXDZN+KfTRwJS9uwYfnBLxvUAJ+W2TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722592; c=relaxed/simple;
	bh=qQ1+UdYaWKBAAt8xVVYfI5pl7JNGXYVVPZB6c5TrCwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKr/Bbvgom9stSNH77vAuVnla+qsGzUAT1yfu8rUioSpM6MA0K4Jpv/VdeizxIDakl1KBwnyi5u0pLnGxT2RzFvqBQBp1/KE1lXgdrJ/A4rRF22oZC27DkFZKUU5GCLOpSRtd3PuGqbopEZhvQZAqcv6ExTgwsF4NhhEpfopIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PMtXN0Qk; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PMtXN0Qk"
Message-ID: <c366293c-7bcd-4e28-b3c4-575203403489@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783722588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5xTNgjPT33L9vYmfTBxe5sZNQu6y94sb1E/ogeaGEY=;
	b=PMtXN0QkDyqyIJIXFZ8S2FnEoVYt/F6jtl2IYOvirJwFY/PZdVE0TSwtvZn2Kt6njhaoVy
	sc8C7AHi1mcR+66H4O1Y9jEWHBcZFZ/XrK+FaBKyjIbgm6LqEHh+O1uQYIpPu4LRWVhv1V
	mWKjERgTDyRXf31ttZIieohVwayXSDc=
Date: Fri, 10 Jul 2026 15:29:34 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] tools/build: Allow versioning LLVM readelf
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
 <20260518-james-perf-llvm-version-v2-4-f12cc4f031d8@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260518-james-perf-llvm-version-v2-4-f12cc4f031d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/18/26 2:03 AM, James Clark wrote:
> Documentation/kbuild/llvm.rst mentions that readelf is included in the
> LLVM toolchain, but it's not currently included in this block.
> 
> Add it so that LLVM=... options also apply to readelf. Users in tools/
> were Perf which was hardcoding it, and another was the BPF makefile.
> Both already include Makefile.include so convert them to use the new
> variable.
> 
> It also didn't have the cross compile prefix, so either readelf didn't
> mind opening cross binaries, or it wasn't working for cross builds.

I'm pretty sure it's the former. readelf/llvm-readelf are only used
libbpf makefile to read ELF symbol tables, which should be arch-independent.

We've been cross-compiling the kernel (and libbpf) on BPF CI for a
long time. So the unprefixed readelf is already working, and adding
the $(CROSS_COMPILE) prefix only adds a new requirement.

I don't think this change in tools/lib/bpf/Makefile is a good idea,
we could potentially break some environments. Even though hardcoded
readelf doesn't look nice.


> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/lib/bpf/Makefile         | 8 ++++----
>  tools/perf/Makefile.perf       | 1 -
>  tools/scripts/Makefile.include | 2 ++
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 168140f8e646..180dca9c57c8 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -114,12 +114,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
>  
>  TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
>  
> -GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
> +GLOBAL_SYM_COUNT = $(shell $(READELF) -s --wide $(BPF_IN_SHARED) | \
>  			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
>  			   sed 's/\[.*\]//' | \
>  			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>  			   sort -u | wc -l)
> -VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
> +VERSIONED_SYM_COUNT = $(shell $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
>  			      sed 's/\[.*\]//' | \
>  			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>  			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
> @@ -182,12 +182,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>  		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
>  		     "Please make sure all LIBBPF_API symbols are"	 \
>  		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
> -		readelf -s --wide $(BPF_IN_SHARED) |			 \
> +		$(READELF) -s --wide $(BPF_IN_SHARED) |			 \
>  		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
>  		    sed 's/\[.*\]//' |					 \
>  		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
>  		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
> -		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
> +		$(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so |		 \

>  		    sed 's/\[.*\]//' |					 \
>  		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
>  		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0aba14f22a06..63276bf55856 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -215,7 +215,6 @@ FLEX    ?= flex
>  BISON   ?= bison
>  STRIP   = strip
>  AWK     = awk
> -READELF ?= readelf
>  
>  # include Makefile.config by default and rule out
>  # non-config cases
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index e81e5b479c56..380ad84ac51e 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -73,6 +73,7 @@ ifneq ($(LLVM),)
>    $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
>    $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
>    $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
> +  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
>  else
>    # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
>    $(call allow-override,CC,$(CROSS_COMPILE)gcc)
> @@ -80,6 +81,7 @@ else
>    $(call allow-override,LD,$(CROSS_COMPILE)ld)
>    $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>    $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
> +  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
>  
>    # Host versions aren't prefixed
>    $(call allow-override,HOSTAR,ar)
> 

