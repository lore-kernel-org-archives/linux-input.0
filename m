Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778282BB13
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767896; cv=none; b=QW4/raFHEA1gzZQS04/jdklTyU4WCn6MYpP9g21lrcFAnu2IEXbcZc9fZi6OUf3xCRDX5ApU04h/eEpQJ0RanMJMjfd1PiIlPt/K1AaXiXuLM3BTwcJul9mRDXjaYfYf3ts1Wz1VrlALqG2wATaqJeeOp+n2Q4vuDox1eRwp0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767896; c=relaxed/simple;
	bh=HGUXHalWp8l0xvm1E8pX9J6mPOzulxhOOI7xc1FVb/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zldg0x676w+Pkk1kqAafycwEIWdtE/8MS1YMovNyL05WKMzW9P6dqNoNuywJabR1zfv8+i6Smu627+PR9/zMWOGVwyswQpQAi5MQbdJQICbw0pDi1JQSlTlcexjfBdN72mLuhurDl3u8bYfoSu0/C4iiv7pwM7d2NkhLb22gtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aOX5KQdD; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aOX5KQdD"
Message-ID: <d4896c9a-fe31-4c1b-bfa5-3a17d18a10fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784767882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNpyNv0ICSBsPTntcujb5nsTOyzqh9djecQmrrIOoSk=;
	b=aOX5KQdDVaLshQjM+asZbKKriNNEEqKnBGDIh1V+BjIXKVSJO8He9yXK6nk3hGAxv900ug
	aMv4+X43CriaCnUwKtq0J3qiulkxNDFn0xo2gLtmBkQWzjIa+Ta992luip8Vt5E6J/OQt9
	u7lViFMOdCLAMBUhF5WbpSBmFx1MgcM=
Date: Wed, 22 Jul 2026 17:51:17 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfuncs in
 a rbtree
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org,
 dmitry.torokhov@gmail.com
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-4-ihor.solodrai@linux.dev>
 <20260722235024.C478C1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260722235024.C478C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/26 4:50 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Silent dismissal of inconsistent kfunc flags during deduplication.
> --
> 
> --- Patch [3]: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfuncs in a rbtree ---
> commit d91e5d0dd32a660902e686ef89cb30a196dda160
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> resolve_btfids: Keep collected kfuncs in a rbtree
> 
> This commit changes the storage of collected kfuncs from a dynamically grown
> array to an rbtree keyed by BTF ID. This allows for efficient deduplication
> when kfuncs are declared in multiple sets.
> 
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 3198198b03a78..de4986e1bc3d1 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
> [ ... ]
>> @@ -979,14 +978,48 @@ static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
>>  
>>  static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
>>  {
>> -	if (ensure_mem(&ctx->kfuncs, &ctx->max_kfuncs, ctx->nr_kfuncs + 1))
>> +	struct rb_node **p = &ctx->kfuncs.rb_node;
>> +	struct rb_node *parent = NULL;
>> +	struct kfunc *k;
>> +
>> +	/* Dedup by BTF ID: collecting the same kfunc twice is a no-op. */
>> +	while (*p) {
>> +		parent = *p;
>> +		k = rb_entry(parent, struct kfunc, rb_node);
>> +
>> +		if (kfunc->btf_id < k->btf_id)
>> +			p = &(*p)->rb_left;
>> +		else if (kfunc->btf_id > k->btf_id)
>> +			p = &(*p)->rb_right;
>> +		else
>> +			return 0;
> 
> [Severity: Medium]
> Does this silent return effectively ignore conflicting flags from subsequent
> declarations?

This is deliberate here. Flags are checked for in the patch #8

> 
> If the same kfunc is mistakenly declared in multiple BTF sets with different
> flags (such as KF_ACQUIRE vs none), returning 0 here without checking if
> k->flags == kfunc->flags will silently discard the incoming flags.
> 
> Could this cause critical security flags like KF_ACQUIRE or KF_TRUSTED_ARGS
> to be unexpectedly dropped depending on the processing order?
> 
>> +	}
>> +
>> +	k = zalloc(sizeof(*k));
>> +	if (!k)
>>  		return -ENOMEM;
> 

