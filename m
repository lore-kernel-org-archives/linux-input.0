Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F553A8FE3
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950263; cv=none; b=RgLakjDgrwl0QvaHvp/JwFM3Ttx7Pjan+AYJxDAomXHRoCEUFdZqBwo8XKa5EY10oD86ivthdzMg3qFWdKyURZMbpUba08ao+NYNs0iIcrjtKiqG2v50Sl++GOAmHw3gJwCcBRP6BGCyTIpwRkvRE9z1ih+dAI1DTIsh6moTzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950263; c=relaxed/simple;
	bh=MRIjzUtKPjhDdOPrmWjXbF6rNgOgorS3NZj2hSIfGJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7XxZd9JlNONKGRfNdfnMsDziOw5Iu3eTNrYDPZ5LfmW7l/ER8mY5IeJofkh00Qiu5wBsHI9l4jb1JejBLuLIi+oUWJTxJfP5bAZy423O6vfhrM4J4aUAtUc+QqmScDk7KGWGOe1sKvrkSGtG1szqu5KxS7kntNXlLaiO2L/j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZC41xmrA; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZC41xmrA"
Message-ID: <610057f2-eeaa-4007-a3bd-68d8b034d428@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768950249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMJno6taLhYyV3AW/4a40zvupgewOKMSPLb3dlhArTo=;
	b=ZC41xmrArx4vp1zMbkyuGLj2kYyjU0OUhEK6/vO96ygA9G5HUQM1fxs7KRPYMSWkl+WMPX
	s/HzisVuM50k2ClFJz84n4acv2JGR+wulFeiO9nh9gnkLneuJMV5SxGMI3ChgHRSVFD0Re
	4lZW+H/2jQq2uUdNmHLoAOk4ffs5MGg=
Date: Tue, 20 Jan 2026 15:04:01 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 07/13] bpf: Migrate bpf_wq_set_callback_impl()
 to KF_IMPLICIT_ARGS
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com
Cc: yatsenko@meta.com, tj@kernel.org, alan.maguire@oracle.com,
 bentiss@kernel.org, jikos@kernel.org, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260120222638.3976562-8-ihor.solodrai@linux.dev>
 <e8677fdf7cbe2c1174d7047c51f02516d92a91f9a649a30f0041e0f4bfc0b0a6@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <e8677fdf7cbe2c1174d7047c51f02516d92a91f9a649a30f0041e0f4bfc0b0a6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/26 2:55 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> index 2cd9165c7348..68a49b1f77ae 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -580,11 +580,6 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
>>
>>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
>> -extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>> -		int (callback_fn)(void *map, int *key, void *value),
>> -		unsigned int flags__k, void *aux__ign) __ksym;
>> -#define bpf_wq_set_callback(timer, cb, flags) \
>> -	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
> 
> The old bpf_wq_set_callback_impl declaration and bpf_wq_set_callback macro
> are removed here, but there does not appear to be a replacement declaration
> for the new bpf_wq_set_callback kfunc.
> 
> Test files wq.c and wq_failures.c include bpf_experimental.h but do not
> include vmlinux.h. They continue to call bpf_wq_set_callback() after this

Looks like AI failed to notice, that vmlinux.h is included in
bpf_experimental.h

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/bpf_experimental.h#n4

So the old extern declaration of bpf_wq_set_callback_impl() wasn't
necessary too, although the macro was.


> change. Without an extern declaration such as:
> 
>     extern int bpf_wq_set_callback(struct bpf_wq *wq,
>             int (callback_fn)(void *map, int *key, void *value),
>             unsigned int flags) __weak __ksym;
> 
> should these test files fail to compile due to the missing declaration?
> The kfunc_implicit_args.c test (from the earlier commit in this series)
> demonstrates that explicit __ksym declarations are needed for kfuncs that
> are not obtained from vmlinux.h.
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21190053819

