Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94614340A6F
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934133; cv=none; b=QD3dIcXDrXgBX59jWtV2XuvnIpgODuRnEBEEYvIDbc/GaFpfyGQQEvB21GwT+TpwVOU9ezeCNA7pdevE+Wk4hE+rHdJswYRCBK2P90BjUPs9IhyzoJSrWV5lvmRcU6NRTWj2TNE811NmQszB86Q2/+O8PiLMJGWXGt6aAeJYZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934133; c=relaxed/simple;
	bh=3yGAGGw5eWKeXtAk627Ima8Gs9AAiwJMGypUvWnlvYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP6nzVga73PG9nWMn10ATHtm5DJ6zvK83aR1Njp2jmjXTdRQUbL5ULFi9//ZCUwzS3AcSVvpoXYianAYd3QAkJNC9xwcPZbQNeqAi2lAR+a19R+zWbASH2zkLqVIKBiPxN7z6J73HgQgeSdzXzx4g9XvLxur/46lORM3Ps+liF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uX7T5YOC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uX7T5YOC"
Message-ID: <74fbaa99-024b-4e42-bda0-99ae792d565b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768934119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLPdwWhpS0HfKC6t7quQPU7Dg+w9SU30pGQamQFfJ0E=;
	b=uX7T5YOCVxExz4iuE0ffYSfWjc7vimAiDySGGUFu+5hk0i2U2XKKLkj0k93Jx9Oi+fdKB/
	s+bCqaGRFqMNCkV/mlj4vX/zyxiENhXkOMerJEp7mXP92Aa469YgM3JsjzFpzZwD3ReqTt
	1HmmukJIA9da3FjgPmndXOoDJqSAE9U=
Date: Tue, 20 Jan 2026 10:35:13 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
 <20260116201700.864797-5-ihor.solodrai@linux.dev>
 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
 <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/26 10:19 AM, Eduard Zingerman wrote:
> On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>>>> @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
>>>>  	if (obj.efile.idlist_shndx == -1 ||
>>>>  	    obj.efile.symbols_shndx == -1) {
>>>>  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resolution\n");
>>>> -		goto dump_btf;
>>>> +		resolve_btfids = false;
>>>>  	}
>>>>  
>>>> -	if (symbols_collect(&obj))
>>>> +	if (resolve_btfids)
>>>> +		if (symbols_collect(&obj))
>>>> +			goto out;
>>>
>>> Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside symbols_collect()?
>>>      To avoid resolve_btfids flag and the `goto dump_btf;` below.
>>
>> Hi Eduard, thank you for review.
>>
>> The issue is that in case of .BTF_ids section absent we have to skip
>> some of the steps, specifically:
>>   - symbols_collect()
>>   - sequence between symbols_resolve() and dump_raw_btf_ids()
> 
>> It's not an exit condition, we still have to do load/dump of the BTF.
>>
>> I tried in symbols_collect():
>>
>> 	if (obj.efile.idlist_shndx == -1 || obj.efile.symbols_shndx == -1)
>> 		return 0;
>>
>> But then, we either have to do the same check in symbols_resolve() and
>> co, or maybe store a flag in the struct object.  So I decided it's
>> better to have an explicit flag in the main control flow, instead of
>> hiding it.
> 
> For symbols_resolve() is any special logic necessary?
> I think that `id = btf_id__find(root, str);` will just return NULL for
> every type, thus the whole function would be a noop passing through
> BTF types once.
> 
> symbols_patch() will be a noop, as it will attempt traversing empty roots.
> dump_raw_btf_ids() already returns if there are no .BTF_ids.

Hm... Looks like you're right, those would be noops.

Still, I think it's clearer what steps are skipped with a toplevel
flag.  Otherwise to figure out that those are noops you need to check
every subroutine (as you just did), and a future change may
unintentionally break the expectation of noop creating an unnecessary
debugging session.

And re symbols_resolve(), if we don't like allocating unnecessary
memory, why are we ok with traversing the BTF with noops? Seems
a bit inconsistent to me.

> 
> [...]

