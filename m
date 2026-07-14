Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE986377AAD
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055032; cv=none; b=bWV54kNZimK7/yK1OfwRiq7mH2DM7ebupIZ/3ncdktMlMlMOHjBG/GgkJv4RTyFfxMFBMI2AxQLD+J5Ubv7jovt/qfbWEqIz60xCaPFQdVN/SbLEO+ZSwWrty4Np7myTVt5KmFCDNgjxolj06jM5Rx48NrXqPQQH2bzgcKs56BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055032; c=relaxed/simple;
	bh=8gV82+0UyXLzRqJEc8152IuhQOWP9zRMXTH7Xpqcnl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e05kdsHZKFmp61mK+sF7/EKNx7AuIs1np+GvHlw04XEmed4Ersi5gdimgra8eLHA18bxZgIwJ5M4BwK8HAprIcHuOtEkxx0481YAvq7yta4MYCSYDf8K5GE4IZiSXuSkTOg+kOOys7H2nTRO4tnfaJxNTQRJHp9DWLM/2bmfX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQoc7Hng; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQoc7Hng"
Message-ID: <13496da8-5a8b-41ef-8467-21fe8fc1b6d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784055015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8TXEVwUzCPMp5B4snUA8uisSOClNLly7wLIZE9Dkd4=;
	b=JQoc7HngQg+B0RPYr1LfAM5p+YrsVIxkBvb52nFoP6iHi2Jx/YN0yqn7AFG6wfIySaC59L
	5SBK8WEm06C8TZBsxyBsXJ3BFU7D/GyT4VmmuEArl9UrFjBQYDAGYx8oo+3kYjK4qngDU+
	iPTb0C4Y5hql0GKxMTt2MN9P6lu6OLE=
Date: Tue, 14 Jul 2026 11:49:51 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] tools/build: Allow versioning LLVM readelf
To: James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
 <20260518-james-perf-llvm-version-v2-4-f12cc4f031d8@linaro.org>
 <c366293c-7bcd-4e28-b3c4-575203403489@linux.dev>
 <a8d4ab9b-b2e3-407c-9898-1b9f7339f448@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <a8d4ab9b-b2e3-407c-9898-1b9f7339f448@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/14/26 9:41 AM, James Clark wrote:
> 
> 
> On 10/07/2026 23:29, Ihor Solodrai wrote:
>> On 5/18/26 2:03 AM, James Clark wrote:
>>> Documentation/kbuild/llvm.rst mentions that readelf is included in the
>>> LLVM toolchain, but it's not currently included in this block.
>>>
>>> Add it so that LLVM=... options also apply to readelf. Users in tools/
>>> were Perf which was hardcoding it, and another was the BPF makefile.
>>> Both already include Makefile.include so convert them to use the new
>>> variable.
>>>
>>> It also didn't have the cross compile prefix, so either readelf didn't
>>> mind opening cross binaries, or it wasn't working for cross builds.
>>
>> I'm pretty sure it's the former. readelf/llvm-readelf are only used
>> libbpf makefile to read ELF symbol tables, which should be arch-independent.
>>
>> We've been cross-compiling the kernel (and libbpf) on BPF CI for a
>> long time. So the unprefixed readelf is already working, and adding
> 
> I think "working" isn't technically correct when you take into account the documented behavior of the versioned LLVM= option [1]. You would get one version of the toolchain used for some of the build and a different version used here. That's what caused the build failure in Perf that resulted in the tidyup, because they're not always compatible.
> 
> [1]: Documentation/kbuild/llvm.rst
> 
>> the $(CROSS_COMPILE) prefix only adds a new requirement.
>>
>> I don't think this change in tools/lib/bpf/Makefile is a good idea,
>> we could potentially break some environments. Even though hardcoded
>> readelf doesn't look nice.
>>
>>
> 
> IMO it's worth the risk for the cleanup, it also helps to stop propagating it with future copy pastes.
> 
> Do you think it's likely that someone has CROSS_COMPILE set but doesn't have that readelf installed? Installing gcc-aarch64-linux-gnu on Debian/Ubuntu gives you aarch64-linux-gnu-readelf, so it would have to be a unique setup to not have it.

Fair points.

Still, here readelf only enumerates symbol names from already-built
objects to count them, so a version or arch mismatch shouldn't matter,
and didn't so far.

> 
> It sounds like maybe you want this bpf makefile to explicitly use 'HOSTREADELF', if you're really sure it never requires arch specific stuff? If we added that it would fit better with the rest of the cleanup. But I think 'READELF' is less confusing and take the risk of some build breakages.

Yes, that's a good idea.

So maybe something like this in Makefile.include:

  # if LLVM
  $(call allow-override,HOSTREADELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
  # else
  $(call allow-override,HOSTREADELF,readelf)

and use $(HOSTREADELF) in tools/lib/bpf/Makefile.

Thanks.

> 
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/lib/bpf/Makefile         | 8 ++++----
>>>   tools/perf/Makefile.perf       | 1 -
>>>   tools/scripts/Makefile.include | 2 ++
>>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>>> index 168140f8e646..180dca9c57c8 100644
>>> --- a/tools/lib/bpf/Makefile
>>> +++ b/tools/lib/bpf/Makefile
>>> @@ -114,12 +114,12 @@ PC_FILE        := $(addprefix $(OUTPUT),$(PC_FILE))
>>>     TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
>>>   -GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
>>> +GLOBAL_SYM_COUNT = $(shell $(READELF) -s --wide $(BPF_IN_SHARED) | \
>>>                  cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
>>>                  sed 's/\[.*\]//' | \
>>>                  awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>>>                  sort -u | wc -l)
>>> -VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
>>> +VERSIONED_SYM_COUNT = $(shell $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
>>>                     sed 's/\[.*\]//' | \
>>>                     awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>>>                     grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
>>> @@ -182,12 +182,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>>>                "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
>>>                "Please make sure all LIBBPF_API symbols are"     \
>>>                "versioned in $(VERSION_SCRIPT)." >&2;         \
>>> -        readelf -s --wide $(BPF_IN_SHARED) |             \
>>> +        $(READELF) -s --wide $(BPF_IN_SHARED) |             \
>>>               cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |     \
>>>               sed 's/\[.*\]//' |                     \
>>>               awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
>>>               sort -u > $(OUTPUT)libbpf_global_syms.tmp;         \
>>> -        readelf --dyn-syms --wide $(OUTPUT)libbpf.so |         \
>>> +        $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so |         \
>>
>>>               sed 's/\[.*\]//' |                     \
>>>               awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
>>>               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |         \
>>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>>> index 0aba14f22a06..63276bf55856 100644
>>> --- a/tools/perf/Makefile.perf
>>> +++ b/tools/perf/Makefile.perf
>>> @@ -215,7 +215,6 @@ FLEX    ?= flex
>>>   BISON   ?= bison
>>>   STRIP   = strip
>>>   AWK     = awk
>>> -READELF ?= readelf
>>>     # include Makefile.config by default and rule out
>>>   # non-config cases
>>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>>> index e81e5b479c56..380ad84ac51e 100644
>>> --- a/tools/scripts/Makefile.include
>>> +++ b/tools/scripts/Makefile.include
>>> @@ -73,6 +73,7 @@ ifneq ($(LLVM),)
>>>     $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
>>>     $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
>>>     $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
>>> +  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
>>>   else
>>>     # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
>>>     $(call allow-override,CC,$(CROSS_COMPILE)gcc)
>>> @@ -80,6 +81,7 @@ else
>>>     $(call allow-override,LD,$(CROSS_COMPILE)ld)
>>>     $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>>>     $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
>>> +  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
>>>       # Host versions aren't prefixed
>>>     $(call allow-override,HOSTAR,ar)
>>>
>>
> 

