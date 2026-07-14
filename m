Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DD4D8DAF
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047309; cv=none; b=Fe+3/n6hsFPX/yjgUcUQM3pw/P43U5WpbBZlFIB6nIwqRWmNusnfHqblgpYKukK4CJ2notCTo/QCGAJKDCVIs2amBl8raq+AWN9MC+o1HPBf1QwGr4bex3FGS7q2F+Q3qX4UGUCo8P6I1BHGXqRozuJiRCifSVSwqIwETpDy2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047309; c=relaxed/simple;
	bh=+UZ2C/SIqj6Dtle1yIQ62BUp8tDwxi+DEhc0LgCFf7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJ+1alNnddpU61J3n/LL8b8gSmN7IDsIoqNXHmwaI0S9vi28tPAYltX69lNWMRaJZTLSIdD4CoD09pOxFR9H08RBDV29BLs1TFCUcbAKxH8M0nAh8DvLTDX/sJuhzuVuxn9uRI/aDwrWe3oMCOoKAl7/byLXPjqO6I4szLygw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfk2OvY6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfk2OvY6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso931371f8f.0
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784047305; x=1784652105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAGdTmKiRz8gSXgEL0AxMvGfkn4LlPlutVrGbCWXhWI=;
        b=jfk2OvY6itIAXcb2MHEYmlCw1DRTYcd5IMg8HjTKyj7b8d+cf2jF9cRdMzUdo+X+FL
         HIBxDTQVyHNx3nq5zHhphZpi+9/XqYmFMqA/vrLSPT+np3UW1VUlyDMGEsEsSfBHeLxK
         yCzm6VHhSpnlcBW/HW+3Z+k1QiDBEodhkGDKEFFjg/dcZItkzuuFiHL7JOQ1tCioUc+p
         7qyaw9HlV6+a9mXXh9WmW81Hwtg0BGvQ94ZMN9+DhVHoqd1JL+VvPZhp+3ROPp1w+H8W
         nCXTM4614VmuS8QGXBWzdCcnETsfH1Uk305vkm0WclSp522qa8SkDT8LtIqJhGS0Pl2S
         IuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047305; x=1784652105;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAGdTmKiRz8gSXgEL0AxMvGfkn4LlPlutVrGbCWXhWI=;
        b=SMFZP8SFHcma6X73NlVj5jmr2qu8Na6wcmgBP//aNj+m55S9wLOX5nNSH6O8wnNJi4
         3MuijQEzYBI5W+CA+rg4ZUS/G6FYXTfNYT/WwpmgPgCTviRVGuJzMoJOnHhyzFKAJs5X
         KxjLtSpor/ccSvEh4YyWwWh+hxKrRc4tRjWqwK99Rxb0+8o00vW4YXZCMQalIuu6rkaB
         euz9sB4kDRHVwNt24NdYniNT/sGuXOuL1WuHta/hVKBXGbOiAVRQ/yfvkT9VbTqxo87V
         L4/5S0kGqz6bJy2KmEPe4bIgoeDU9EjcFb5/Idh6fBCOhKbs3pgluSUTRsQZIFDdQXHy
         4FUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqW5MaRLu3ZSUlG3rkkw2zkP+TpE2Dl/02r7FcOQPF86U6/scwihF8yIzfrRDrDVINr4DUUTPzmh4b99A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHsRb1XobtowE3MtHYt1UsbROpMNNqC1rmqVrD5DmOpwj75ADN
	qbXi3bq46RYH5f1Ku/pXy+7SQEVn/G3jgnRYVVMEUlUOQ6SOLttDUnyqg6jB198Nox4=
X-Gm-Gg: AfdE7cmdgU1g7Vw1x3b9BoXmC+OvwhDSqUk/mlHFkQ6aK6QbJ1w9FDRcYCqbbY/7fxG
	Nx7GtkLhJh55eq4sQSJoRRCH36sYCM5E4UbT3Vx1a+hT32+WO4qRahEONCd6wohOJoGzNd4muxd
	cBGayHgIjPrI9isBWFVyuxEKeER+s+1g68H2oSwjyLZWA6qgaWzWn27u8AHHz1aKBqm1Amh7Foo
	MOZimlKEY4z4YqtjP2ja+oGFXU7NMn28WItbjlLfyr9TY8mE+5JfQQPZDpfxDa4BW9FyyG3tKq/
	mWWTSJ3YgqgUamnr4UvC1Ruob7t1KOAGOrhYWZ9KdAIDg6HOToOlAO7PU4b2JGwCx1/3iR5/6sH
	6QDrFpZQ1kGIcS1JaOiKTcgV60PhEWC6NiaIsBpBc5LE8vKq4KH6M6S9eVzE3uuGVTx2UcT5oUU
	T00zwU/kWnYUvlGwD0pV71sg==
X-Received: by 2002:a05:6000:184d:b0:474:3708:c8 with SMTP id ffacd0b85a97d-47f2dcc0d79mr17004061f8f.15.1784047305565;
        Tue, 14 Jul 2026 09:41:45 -0700 (PDT)
Received: from [172.27.236.80] ([212.187.182.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm8766325f8f.15.2026.07.14.09.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 09:41:45 -0700 (PDT)
Message-ID: <a8d4ab9b-b2e3-407c-9898-1b9f7339f448@linaro.org>
Date: Tue, 14 Jul 2026 17:41:43 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tools/build: Allow versioning LLVM readelf
To: Ihor Solodrai <ihor.solodrai@linux.dev>
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <c366293c-7bcd-4e28-b3c4-575203403489@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/07/2026 23:29, Ihor Solodrai wrote:
> On 5/18/26 2:03 AM, James Clark wrote:
>> Documentation/kbuild/llvm.rst mentions that readelf is included in the
>> LLVM toolchain, but it's not currently included in this block.
>>
>> Add it so that LLVM=... options also apply to readelf. Users in tools/
>> were Perf which was hardcoding it, and another was the BPF makefile.
>> Both already include Makefile.include so convert them to use the new
>> variable.
>>
>> It also didn't have the cross compile prefix, so either readelf didn't
>> mind opening cross binaries, or it wasn't working for cross builds.
> 
> I'm pretty sure it's the former. readelf/llvm-readelf are only used
> libbpf makefile to read ELF symbol tables, which should be arch-independent.
> 
> We've been cross-compiling the kernel (and libbpf) on BPF CI for a
> long time. So the unprefixed readelf is already working, and adding

I think "working" isn't technically correct when you take into account 
the documented behavior of the versioned LLVM= option [1]. You would get 
one version of the toolchain used for some of the build and a different 
version used here. That's what caused the build failure in Perf that 
resulted in the tidyup, because they're not always compatible.

[1]: Documentation/kbuild/llvm.rst

> the $(CROSS_COMPILE) prefix only adds a new requirement.
> 
> I don't think this change in tools/lib/bpf/Makefile is a good idea,
> we could potentially break some environments. Even though hardcoded
> readelf doesn't look nice.
> 
> 

IMO it's worth the risk for the cleanup, it also helps to stop 
propagating it with future copy pastes.

Do you think it's likely that someone has CROSS_COMPILE set but doesn't 
have that readelf installed? Installing gcc-aarch64-linux-gnu on 
Debian/Ubuntu gives you aarch64-linux-gnu-readelf, so it would have to 
be a unique setup to not have it.

It sounds like maybe you want this bpf makefile to explicitly use 
'HOSTREADELF', if you're really sure it never requires arch specific 
stuff? If we added that it would fit better with the rest of the 
cleanup. But I think 'READELF' is less confusing and take the risk of 
some build breakages.

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/lib/bpf/Makefile         | 8 ++++----
>>   tools/perf/Makefile.perf       | 1 -
>>   tools/scripts/Makefile.include | 2 ++
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index 168140f8e646..180dca9c57c8 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -114,12 +114,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
>>   
>>   TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
>>   
>> -GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
>> +GLOBAL_SYM_COUNT = $(shell $(READELF) -s --wide $(BPF_IN_SHARED) | \
>>   			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
>>   			   sed 's/\[.*\]//' | \
>>   			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>>   			   sort -u | wc -l)
>> -VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
>> +VERSIONED_SYM_COUNT = $(shell $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
>>   			      sed 's/\[.*\]//' | \
>>   			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
>>   			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
>> @@ -182,12 +182,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
>>   		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
>>   		     "Please make sure all LIBBPF_API symbols are"	 \
>>   		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
>> -		readelf -s --wide $(BPF_IN_SHARED) |			 \
>> +		$(READELF) -s --wide $(BPF_IN_SHARED) |			 \
>>   		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
>>   		    sed 's/\[.*\]//' |					 \
>>   		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
>>   		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
>> -		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
>> +		$(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
> 
>>   		    sed 's/\[.*\]//' |					 \
>>   		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
>>   		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 0aba14f22a06..63276bf55856 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -215,7 +215,6 @@ FLEX    ?= flex
>>   BISON   ?= bison
>>   STRIP   = strip
>>   AWK     = awk
>> -READELF ?= readelf
>>   
>>   # include Makefile.config by default and rule out
>>   # non-config cases
>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>> index e81e5b479c56..380ad84ac51e 100644
>> --- a/tools/scripts/Makefile.include
>> +++ b/tools/scripts/Makefile.include
>> @@ -73,6 +73,7 @@ ifneq ($(LLVM),)
>>     $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
>>     $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
>>     $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
>> +  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
>>   else
>>     # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
>>     $(call allow-override,CC,$(CROSS_COMPILE)gcc)
>> @@ -80,6 +81,7 @@ else
>>     $(call allow-override,LD,$(CROSS_COMPILE)ld)
>>     $(call allow-override,CXX,$(CROSS_COMPILE)g++)
>>     $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
>> +  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
>>   
>>     # Host versions aren't prefixed
>>     $(call allow-override,HOSTAR,ar)
>>
> 

