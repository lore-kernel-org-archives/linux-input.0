Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC7470E96
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767587; cv=none; b=YlACqHJLPKB3xMtiCYWRoKv1j3VWZJ6NcmkqnJoHr8O8po1Yvy2Goirdfhzka//Hh5fYnoSxdbw2Rytv+vkitc3vmyDJiYxJxcjbSrptPqNOaxp7UqyixSw65YwoMCVZEYxaRBRCkcQZJaQHaycwoheAo6/cgI4DeXfkEo0Wbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767587; c=relaxed/simple;
	bh=hxPIcRUbXtfAOVlNZ1zi6My2FdoSWRy0nLyFNrJNglM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPG4Vgak+AltKFzhYsd1ACvmIFcmKgJXvRzkfyoN9ye7kxwzLkEddSs8ufgDGSbbpoVLUD2unZampcoH/IGNbMAGqScMUueM0F47WNvEeUj4AmKteWbMN+VkSsC6gKsfg2ycAhzjrndPI6b7ILpQH6ojyNDlFuolkOTzrNqC+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q0tObUOo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q0tObUOo"
Message-ID: <35ae0ca4-2e64-410f-93d8-6c343efc744b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784767574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRQuDCc1Jocf/BKLARO6vSceQWe6fccSo1RzB7xV9NM=;
	b=q0tObUOoFwqK1sonCzzVPuCEIoPuRc3NWeefto8fHHphVjvYp32bGuQQJ0nRvpJQFtPXMq
	GT6gzLMLOTpFyLEK0huzUEnVYRXo2QapH5GifoA4ym/qCMWdJmJ5zbnjCDPvMTKQuoIDk5
	yjqYIWi5cD8hpE9T2T4BovQXJfMZawA=
Date: Wed, 22 Jul 2026 17:45:33 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 4/8] libbpf: Export
 btf__find_by_name_kind_own()
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org,
 dmitry.torokhov@gmail.com
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
 <20260722233518.778854-5-ihor.solodrai@linux.dev>
 <20260722234358.4AA721F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260722234358.4AA721F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/22/26 4:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly exposed public libbpf API `btf__find_by_name_kind_own()` lacks the `libbpf_err()` wrapper on its error return path.
> --
> 
> --- Patch [4]: [PATCH bpf-next v1 4/8] libbpf: Export btf__find_by_name_kind_own() ---
> commit 60b04eac1753190ac945126aaca0759082942bc0
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> libbpf: Export btf__find_by_name_kind_own()
>     
> btf__find_by_name_kind() searches the base BTF before the split BTF,
> so in case of a name collision between base and split it always
> returns a base type. Tools that process split BTF may need to restrict
> a lookup to the split's own types.
>     
> The internal helper btf__find_by_name_kind_own() already does exactly
> that. Make it a public API.
> 
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 1a31f2da947f8..587172c0de089 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -172,6 +172,8 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
>>  				   const char *type_name);
>>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>>  					const char *type_name, __u32 kind);
>> +LIBBPF_API __s32 btf__find_by_name_kind_own(const struct btf *btf,
>> +					    const char *type_name, __u32 kind);
> 
> [Severity: Medium]
> Since btf__find_by_name_kind_own() is now a public API, shouldn't its return
> path in tools/lib/bpf/btf.c be updated to use libbpf_err()?
> 
> Currently, it returns the value from the internal helper directly:
> 
> tools/lib/bpf/btf.c:btf__find_by_name_kind_own() {
> 	return btf_find_by_name_kind(btf, btf->start_id, type_name, kind);
> }
> 
> The libbpf public API error handling contract requires all public API functions
> to set errno using libbpf_err() directly on their return statements. While the
> internal helper btf_find_by_name_kind() currently sets errno indirectly, relying
> on it could cause issues if the internal helper is later fixed to return raw
> error codes.
> 
> Should this be updated to return libbpf_err(btf_find_by_name_kind(...))?

Ok clanker, this is embarrassing. Read the code around the diff before posting.

btf__find_by_name_kind_own() mirrors btf__find_by_name_kind(), and 
both return btf_find_by_name_kind() directly.

And btf_find_by_name_kind() helper already sets errno via libbpf_err() on its
error paths.

> 
>>  LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
>>  LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
> 

