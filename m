Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59793A168E
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753629; cv=none; b=Rcq7X2KQsbEjDVme1XBdavIi5bUpyXIdVdXmKfy2qgCaHlGxx2CL6m4m6qSrF1+UtD0mmyFtNw3zgftvb2Sc19jDGRPi65t9YuvpR/sa0+NS3NPrngswmlqPezHSL8sQfeyEVbNq1Sjq25AejVd0O0jQ4USEjTsERF98MisRbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753629; c=relaxed/simple;
	bh=S63hhfRsG+j7Ng7WAsaWPKCUXZm8OcvpotlPU06841E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4pt9yGwue4ewyXLUW8ZwWFhZGdECBUyJX2BDTcMjHc4mpsxuo4o9YssFQM1qPY3Gd6RiOwvXMQLQJs9QA1Hgn00ERlg9lrkHLuTgvy2EgoTfrg3UqsVSgXQxt7g9S/FrIOF0cawLSVd/tbEMeEj++aAdYlPB7Vk7gusge8lGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kXk84CXV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXk84CXV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso81792885e9.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778753626; x=1779358426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTuf5ZCIu9Za2DpjjkJh2zWkoI+wGsi6ZskT4v9wl4s=;
        b=kXk84CXVoS0j6+VXmfY3VQFCK7GZbs9ylgjLfQDU6R7JQ41uHZy3ffNotVPPyA0/nK
         AbYiURa/ZpsZ9nQGSd81+UpvEumtN0lbK8ykKrGac54BWD9z9GgT4IyiG1a2oY7UJZsH
         104h3HC14vYrjqdHlqdvEoSxN10KXmWKaoflq3Sg4bFTZ+giIpefVI8uMfptitYOYVn9
         iTylrU23Lr3Valt7CF/PXJa/6Ki15lONjL2usE9EGLlJCzZ3+B/1am0U6nWasuM/AXsN
         m/cCzZSLZ9ePM3oT3Hz9g5dPNROSYLZWGoOC1AOtIyrJE7JOLSoQOMoTB+uvtSg/NtrZ
         DiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778753626; x=1779358426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTuf5ZCIu9Za2DpjjkJh2zWkoI+wGsi6ZskT4v9wl4s=;
        b=C95m/vYZzIU14KHzpEKH3YxpSq/wmt11/PxWDyv0B8aQn1pE0Z/cRnUMnp3T0JpD6l
         65dHNpbyI+deGHdABYJJrBcDsjPmA5Chkw/tmL520/WKQGqVGGjz0fCPa1sMjpHXMciF
         Bz7mBupQQYKJZIEqGaOKLK2e/8ZOduFa4p2V0Gs4+iha0t4HOdNjyJGcNNZ61zSjfpFL
         1lRdZnFhuHE455j4Uu4EfmCgTjiNVEzQ2Vf8Aac5RlbBpTBLY29ARDfBv0AN3JT9QxH2
         2kGsaKzSBYQ1Lj5J2tXwiMfRGfV71wGa2bYhP/DPZpdtnZN4kTzYZmmf/toj/hNaO8K/
         /GBw==
X-Forwarded-Encrypted: i=1; AFNElJ8EuoDy7RgTXbw63FvUGSP6Vg20Aprqt4QGmhoa3oWwSh06M44j76a1zz/5dSJr6zyybjChtXSVHbSbPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOCdMgrPh1m+mF9AFNqPETdVbj8SuyeG58nikaSES6oyKRey/
	Qrg8TQ0pkaE8BQYzxKkjyoXnSTfvdgb9EDCrBW3444Sb6oQ//CzZGfW3XlTGaYSTOC4=
X-Gm-Gg: Acq92OHlqzXG1AUQ4qCGaQYpSBF3cypR93tIKK3x+V1Z1rL/nFuvFNQKHLthJIs7Q7y
	fGm+tugFY4JrZ+zo3wzPtvrFGfnJqH083ib+7akM4Nke/++fyGCldx6UNyHg7/NqoapzI2wABHD
	3TW1kyY2Ts4ZyWrw36LwCEFhKG7Q6PUcadhgCb7h2zIn94QC1hymcl7BKrmLJOPnCyokxq/Btjm
	/5Dkhz9YNt5QAr9/GcPcai9BGBMtXz21CFIvQefR0vj9dDUWiFCDg8IQAxSrR7k62AZWwtJP90F
	fSp34V/vb57vG7jPzUKMwh6ALZqkARdiq595l1sxpaZbVl+Y+//Q4hGJeX/r0BTiWPbdEq7vnRE
	vua6dSDhi9Sia/jqYmDZQv20guVH0SPfYBa94bGyuqkTK/5KfoyRpWSOdS1IZ+B/xrIJh5xKqn4
	aHADdJSsRWTJf5eXk3Jo5AxuDyW8DT
X-Received: by 2002:a05:600c:19c7:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-48fe24879f6mr3970735e9.10.1778753626408;
        Thu, 14 May 2026 03:13:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd648a7e5sm55592095e9.3.2026.05.14.03.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:13:45 -0700 (PDT)
Message-ID: <628c0904-08b2-4b93-a90e-456a073ecf73@linaro.org>
Date: Thu, 14 May 2026 11:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tools/build: Allow versioning of all LLVM tools
 defined in Makefile.include
To: bot+bpf-ci@kernel.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, leo.yan@arm.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, jikos@kernel.org, bentiss@kernel.org,
 shuah@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
References: <20260514-james-perf-llvm-version-v1-1-6cac1a9a4c8d@linaro.org>
 <998802d0c3bb407e9bcc61e4fe6db2e3eed7ac06c7c6eca0ed0dd5409a8c2801@mail.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <998802d0c3bb407e9bcc61e4fe6db2e3eed7ac06c7c6eca0ed0dd5409a8c2801@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/05/2026 11:02 am, bot+bpf-ci@kernel.org wrote:
>> tools/build: Allow versioning of all LLVM tools defined in Makefile.include
>>
>> The version of LLVM tools can be given on the build command with
>> LLVM=-15, but this isn't applied to all tools. For example $(CC) gets
>> versioned, but $(CLANG) doesn't. This causes a Perf build with LTO=1 to
>> fail with an error about mixed clang versions:
>>
>>   ld.lld: error: libperf/core.o: Unknown attribute kind (86)
>>     (Producer: 'LLVM18.1.8' Reader: 'LLVM 15.0.7')
>>
>> This file has two "ifneq ($(LLVM),)" blocks adjacent to each other, so
>> merge these blocks making it obvious that all tools should be versioned
>> consistently and there is nothing special about each block.
>>
>> This also reveals that ?= and "allow-override" are used inconsistently
>> between the blocks. "allow-override" is technically only required for
>> builtin variables, but isn't only used on them, and doesn't do any harm
>> if used on a non-builtin. Make them all "allow-override" for
>> consistency. The only functional difference this will cause is if there
>> is a file level definition of one of the variables followed by an
>> "#include of Makefile.include" which will now overwrite. But this isn't
>> done and in a later commit some of the duplicate definitions will be
>> removed for good measure.
>>
>> There are also some other LLVM tools that are not defined here and will
>> be moved in a later commit.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> This looks like a bug fix that corrects inconsistent LLVM tool versioning
> introduced in an earlier commit. Should this include:
> 
>    Fixes: e9c281928c24 ("kbuild: Make $(LLVM) more flexible")
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25853166705

I did consider a fixes tag, but the only real bug is with Perf and 
LTO=1, and building it in this way has obviously never worked, so you 
could also argue this is new behavior.

I think it's quite and edge case and has some risk to break other tools 
if backported so I left the tag off.

