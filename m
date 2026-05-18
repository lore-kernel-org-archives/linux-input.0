Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CE3E3DB7
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095122; cv=none; b=ERnXSuOeYe3Apj1mXEYLOX/ibgKhSgkUG5M/NvcRrDK+p+3qX3XniAQBwmrzkjd7KtwTxS3TGVR/e0symDfOlM4XTKe7zflpkiUo5DeJ9555mYi/lxIvhkKQ7PdeqiEp1bHfJqLPGx4AoyoxUO/7j22NIdNa4irzFPnQ0YBJD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095122; c=relaxed/simple;
	bh=N+mBa9Qop2DRXCEJaXykcTUTNPqJPKjVhuTJzDs3+Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBNP1Oy76NAxuL1JwoSdz+ohcoAm8f3Ce/eSSIaNabNWPz8UYJ0CjVuwLyMA8mZHZBSXttO9D2eFOD5lHzWaBX3P1FqU68WlgGcMmM6yeKLiu9rCY8mO5zOBisCWUGW6h5ide4iwcE02M0HLWU/Fe74MSQsp3uJTGU/lKY9nbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtiNbayr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtiNbayr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso22901975e9.3
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095119; x=1779699919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5p4hero2Con2BmKZIS8vOF61ZHN0e7aAbx1KJsO8hg=;
        b=vtiNbayrVhfvPUlg45HCUIOWCBpzFDwIkRu/o37TrMurtMPtutoJzBZHyRqaHQJDvD
         t6G4JkhrVrq0ijH+q8RG875GTJFF+TXc4Zi4CEQEvK0YSrp71FOlVmkDIveOEG5iiZa/
         s0b1eKzsP7+XduTsuzvEPu2I5XPlRz0S0IhtZ3L2quQlGRQ7kmFQL+14GTPZmswJOAdd
         O2YRM85mlcKjMZJHEuPRLJGCmzprVPGyG6gzdPgkjmoIWDZGm2jY/462fL96EDhJWGFQ
         Rpku9+hNTOo1DoE7shodoL2tXiVbwSf6gyChnh76jq/sYaxRXACvvkj3h8ruYjw3rApu
         Vd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095119; x=1779699919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5p4hero2Con2BmKZIS8vOF61ZHN0e7aAbx1KJsO8hg=;
        b=ZA2BCoxcpMD1X4BhQOaek2xrTlBCWkfnXjMDPzTdA4VFvE6GB8ltWW3YD31ytbgL7y
         hg8m63kiFpUBy8SpTcgo72sqqtlqqEuH83rajoBXeTzBv99naGQEo2YQsKKxWqig93Kp
         AXmwf1RvbYqYuNHnkzlB8JKzCkruQO8dvVvjhsmqYN+HTKQ/xO57rj+ukDVxVQS/6dtM
         GcuMUHLs0TWfTcBMLYnv89tu1lSQv1acnTqMgvYwjbCqQbU5INi1wK/J/67qGf7ovY9p
         WHBYPILrfEYHH62Hnqh8yt3xEzdjYrBqdDjq+EAJ8WyFNOSZ80kSWHuwT0OeJtSeIrB1
         WA9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zb2QeyNoKTX3cmCQTKeVic+6fbGyiblcly3otnCedSiG+e5BXe+59y6WvMCOJP9Q4BFDIQyfKQ1Hzng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4z3DzcJo62w4jbe4q8Ze52YPuyd/7h23rwZdw3xNqUH9WsQt
	48eCnYzFdzNaBgS3E73tHcVRyJUGQXuFd+81iVvjBK+vZUq5IOQIilIc+gIihftzFiA=
X-Gm-Gg: Acq92OEQsPflVnTNlJToVL7Wlpm9vNQCQDjEnHr7EkJJJBp+jwlGcg+L04jSapfMKoz
	/9/y/IeCGrd5+tRSSNIT4TyyDwMOtiOi5KYK3jFFOGSbQtRpoQDN0pBwhbBPQT7gCv7oZy+yleR
	zTDLwMf+kFueQ6LBNMZxbuV2Ut65jVlqiVqU8KPJ/ste0e97kTScgO1BHlSJFKQp9Z/YsaHZMHg
	gSjN2+Ufbs4kjd2IROeYQGfSIa92rNFVZkOStiXouh4m5zHWynUEAR5fpeJXOouh8u1Y9vuEW7O
	6n9Q9BHHbSczl1LL6zAUGnKYgggjAYizysaSfeVRW79O45YhnP+k634p/eN75jJwC7Qc8GylfLy
	uxotnkevFoP/pmbgWOU6opDcu5A0E8qzcj3ibTo0xF2wiGVmDKjtz3cC6B7n03oav0R1GsPrVn+
	Qt3s3Uo08Q9pCFmdT94EQ7/jnaOpYA
X-Received: by 2002:a5d:44d2:0:b0:45e:739b:3e3c with SMTP id ffacd0b85a97d-45e739b3f89mr5942873f8f.0.1779095118902;
        Mon, 18 May 2026 02:05:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm38419068f8f.25.2026.05.18.02.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:05:18 -0700 (PDT)
Message-ID: <b8108271-9e89-46bf-8cd3-3376cbdea6a3@linaro.org>
Date: Mon, 18 May 2026 10:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tools/build: selftests: Allow versioning LLVM lld
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, leo.yan@arm.com,
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
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
 <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
 <bda702a1-18f5-47ed-8a4e-a01b94829e07@linux.dev>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <bda702a1-18f5-47ed-8a4e-a01b94829e07@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/05/2026 11:58 pm, Ihor Solodrai wrote:
> On 5/14/26 2:32 AM, James Clark wrote:
>> Building with LLVM=... could result in a different version of lld being
>> used than the main toolchain for liburandom_read.so because it's
>> hardcoded to "lld" in this makefile.
>>
>> Make it consistent with the rest of the LLVM toolchain by adding an LLD
>> variable to Makefile.include. Keep the fallback for other architectures
>> in tools/testing/selftests/bpf/Makefile as it seems like it's something
>> specific to this make rule and shouldn't be global.
>>
>> Clang accepts either a full path or "ld.lld-15" style inputs to
>> -fuse-ld= so this will work with LLD defined the same way as the other
>> LLVM tools. However, for full paths, we need to use ".../ld.lld" instead
>> of the generic driver "lld", but I don't think the original use of "lld"
>> was significant as this is always a linux build.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/scripts/Makefile.include       | 2 ++
>>   tools/testing/selftests/bpf/Makefile | 8 ++++----
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>> index 380ad84ac51e..5c2d505cba62 100644
>> --- a/tools/scripts/Makefile.include
>> +++ b/tools/scripts/Makefile.include
>> @@ -67,6 +67,7 @@ ifneq ($(LLVM),)
>>     $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
>>     $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
>>     $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
>> +  $(call allow-override,LLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
>>     $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
>>     $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
>>     $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
>> @@ -91,6 +92,7 @@ else
>>     # Some tools still require Clang, LLC and/or LLVM utils
>>     $(call allow-override,CLANG,clang)
>>     $(call allow-override,LLC,llc)
>> +  $(call allow-override,LLD,ld.lld)
>>     $(call allow-override,LLVM_CONFIG,llvm-config)
>>     $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
>>     $(call allow-override,LLVM_STRIP,llvm-strip)
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 6ef6872adbc3..44ba829e5d4d 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>>   
>>   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>> -LLD := lld
>> +USE_LD := $(LLD)
>>   else
>> -LLD := $(shell command -v $(LD))
>> +USE_LD := $(shell command -v $(LD))
>>   endif
>>   
>>   # Filter out -static for liburandom_read.so and its dependent targets so that static builds
>> @@ -258,7 +258,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>>   		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>>   		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
>>   		     -Wno-unused-command-line-argument \
>> -		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>> +		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> 
> Hi James,
> 
> This patch breaks the selftests/bpf build:
> 
> $ clang --version
> clang version 22.1.3 (CentOS 22.1.3-1.el9)
> Target: x86_64-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Configuration file: /etc/clang/x86_64-redhat-linux-gnu-clang.cfg
> 
> $ make LLVM=1 -j$(nproc)
>    [...] # ok
> 
> $ make LLVM=1 -C tools/testing/selftests/bpf -j$(nproc)
> 
> [...] # somewhere in the middle
> 
>    LIB      liburandom_read.so
> clang: error: invalid linker name in argument '-fuse-ld=ld.lld'
> make: *** [Makefile:256: /home/isolodrai/workspace/review/linux/tools/testing/selftests/bpf/liburandom_read.so] Error 1
> make: Leaving directory '/home/isolodrai/workspace/review/linux/tools/testing/selftests/bpf'
> 
> [...]
> 
> Or a simpler reproducer:
> 
> $ make LLVM=1 OUTPUT=/tmp/out /tmp/out/liburandom_read.so
>    LIB      liburandom_read.so
> clang: error: invalid linker name in argument '-fuse-ld=ld.lld'
> make: *** [Makefile:256: /tmp/out/liburandom_read.so] Error 1
> 
> $ make LLVM=-22 OUTPUT=/tmp/out /tmp/out/liburandom_read.so
>    LIB      liburandom_read.so
> clang-22: error: invalid linker name in argument '-fuse-ld=ld.lld-22'
> make: *** [Makefile:256: /tmp/out/liburandom_read.so] Error 1
> 
> I tried your patches, and only then noticed BPF CI caught this too:
> https://github.com/kernel-patches/bpf/actions/runs/25943477658/job/76267174885?pr=12082
> 

Thanks for testing. Yeah looks like I made a mistake here testing the 
various different formats of LLD. Converting it to a full path works 
with both prefixed and postfixed versions, and that's what's already 
done for non x86/riscv so I'll do that.

>>   		     -Wl,--version-script=liburandom_read.map \
>>   		     -fPIC -shared -o $@
>>   
>> @@ -268,7 +268,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
>>   		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
>>   		     -Wno-unused-command-line-argument \
>>   		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
>> -		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>> +		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
>>   		     -Wl,-rpath=. -o $@
>>   
>>   $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
>>
> 

