Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92731717E
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097678; cv=none; b=GygUspWMcgANmlcGfkwkpFZ61ERoyFkM5wD/mc0yPcHupPxFZnZmGsVUrjHvd1TvjBcjAsEQWXD4qQEjwjxYujxT2j14ugNUW0gRPBjaKdzl6Xja/f/B6USXA9cgaQzRSDTaFAc8D6JpboP1CgcJdqlVsa1A3sb3dVg/ByP3n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097678; c=relaxed/simple;
	bh=kQwAY/l0CYICe34k0IpNyn+TG1YD4kxDzsA4u0x5DHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMXvFXPjPsB+VW3Xnt++1yvT/qQRaDxqmWB3QNaTnmmMzYjq4mNFvoL6IoltRwOY59CSpAiTL2VnjJrSVPzBu94vgcLxYVUgNS5AfdelnhBi91ko5yts8OJRF9e+bxs+c54yUAo2fjQd0IJikS5a+W3ma5kqtCv78p5uhmc0Yng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLrwMiH4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLrwMiH4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso16877895e9.0
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779097676; x=1779702476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/EO1D6TrcoAaYAZG0MsX8/FpcPXBdwplKszfXP85PU=;
        b=OLrwMiH4CQtgKscf4/rdKN+2eUNFBwGtIQoIjOQYGsQF170r3tnj1mx0+nuoV0Pp+c
         C32LKxRuFq14cKbZ9wBBnDo0v2eXxJnuKXsXWJ5vjmm7Hg7Oef85al4yfax/KSUwz21w
         c4zdR8W+dV/SJjIOI6sAmfhngxRAtIIcWEX8G+a9B5Vm/Q9HjUwWzglyXVDNnp4g62Fj
         Z0OvszHSolcGTOXOOtutb742fX+BkxOH33esJoJhpUZTl2UyN7Bo4I2PS5G6MPS1SnZw
         nDc9VugIjDR9gsQxfMdeAI3kniNT/VHEozB6shE2A7NpHf31i0khh5PQ+12RrdVKn2lt
         T04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097676; x=1779702476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/EO1D6TrcoAaYAZG0MsX8/FpcPXBdwplKszfXP85PU=;
        b=f2zx2cwRRqX3u93kT+xDCiGUnCLhHQ8UEn9xZX/EPGVpS6s6ZGEwDfmWgUzFqDzYr+
         DoCbtTs1FRpNwka/QJBv7AAdUBbIlaEhrl5VKXeIrjeFrHpBoykk5p93IHTMu3W0xaP0
         dHxBWrpici2cQgpvTpY2c4Za4stw+dt9MPIB5ubNqFDkzTj0OmOyCVqtvGmlkmBRa0oU
         DGMXlgtI4w6geZmX/nzYEyWBrnciUnJj2OhDvl2w+dldZBFF91LHM7GySsjOV1tQnlVI
         0g7b2gYCMz7Dn1fO2BVacXXk3VrYEYVAWX4YTl8jibHrtI/G1/eWU/Lobp0a/mL8JJOK
         Q+Qg==
X-Forwarded-Encrypted: i=1; AFNElJ9mgBbPrlKtUAIwoZut0gqUgMHw5iuB1pjXRbuhK0CZGBT6F1HQkQneHiI8nq1nja4ZQvKLGiEIjNcDHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfzhd9BZ7Pv8V7nUQJZ9KM16ULOxqs7iUds2I4E8J609U9A503
	K4CLk3N07lYKelgFstVzlCD6dNFUvgscRfrkcx6Rs6kyviCOj+1mFS3WJ6r6V8oEhIM=
X-Gm-Gg: Acq92OFuUXMtzEA1MONIhSh047lNHd3vSWRjJUSV0fTasC7OjtG2SQpafkLrcKXwVRK
	brqoplVSs/aT7JkxWCHKVH6bfFjILSx1pjaHOgwJf8hK9xRgBS3t+2w/P7nrN271fnGPPdH7OJe
	Z3Y4q2tdXfI9G8DGD5eh/j2CinyX69vUDtbAaQLmaSK/GJgTcxKhP8IR6yPwVsKUj130bqN8bIy
	wgu2xgiBQ02kinBkYR7emHAy9l7DpoKBSUEJHcjq2pnSoibes/f0B0g8ZrJui0q6tALnhjWzXsI
	iaSI3ctHCMs62BwKGlu5hXJJmTyLXe72sI8Plm/uEpEn9SLB1lE2bQjaNLiGNJW8oIsbYH7LnnH
	4oVm/UHArVNRSwJ9+znNbghMZkr41iRZkHhUUe9KQ4kU6yeaxco8+wsquKHv950Bi/t2Jx84j9y
	ESpHS92jujHVCVEV4kgg0PONpfXa6U
X-Received: by 2002:a05:600c:34d4:b0:48f:e245:394e with SMTP id 5b1f17b1804b1-48fe631f631mr226307655e9.27.1779097675702;
        Mon, 18 May 2026 02:47:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm58005165e9.3.2026.05.18.02.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:47:55 -0700 (PDT)
Message-ID: <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org>
Date: Mon, 18 May 2026 10:47:53 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-input@vger.kernel.org
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
 <20260518093237.90640C2BCC6@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260518093237.90640C2BCC6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/05/2026 10:32 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Empty USE_LD variable causes clang build failure in selftests when ld.lld is not in PATH.
> --
> 
> commit 371ca22c55bb0fa6502ac06f7b33d63418ad16ff
> Author: James Clark <james.clark@linaro.org>
> 
> tools/build: selftests: Allow versioning LLVM lld
> 
> This commit adds an LLD variable to Makefile.include to allow versioning of
> LLVM's linker, keeping it consistent with the rest of the LLVM toolchain. It
> modifies the BPF selftests Makefile to resolve the full path of the linker
> using the command -v shell utility.
> 
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 6ef6872adbc3e..836e783f0170e 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
> 
> [ ... ]
> 
>> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>>   
>>   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>> -LLD := lld
>> +USE_LD := $(shell command -v $(LLD))
> 
> Does this cause the build to fail if the toolchain directory is not in the
> system PATH?
> 
> If a user explicitly specifies the compiler using an absolute path like
> CLANG=/path/to/clang, but does not add the toolchain directory to their PATH,
> the command -v utility will return an empty string.

If they don't use LLVM= and use CLANG= with an absolute path then they 
need to set all the tools with an absolute path. That's the problem that 
setting the path with a prefix for all tools with LLVM= solved.

I suppose this could _technically_ be a regression, but so could adding 
any new build rule that added a new tool that wouldn't be set in 
someones existing build command. Being that strict would mean we can't 
ever add new tools so I don't think this is an issue. And I don't think 
there's a way to solve this and also respect the documented rules of LLVM=

> 
> This would cause USE_LD to be empty, leading to a malformed argument like
> -fuse-ld= being passed to clang later in the Makefile, which then fails with
> an invalid linker name error.
> 
> Previously, passing the hardcoded lld allowed clang to natively resolve the
> linker relative to its own binary location. Is there a way to support both
> versioned linker names and absolute compiler paths without relying entirely
> on the system PATH?
> 
> [ ... ]
> 

