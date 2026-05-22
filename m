Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95422C032C;
	Fri, 22 May 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439571; cv=none; b=CcDUz5n1V94D4xxs6426B0z03ZBBqqr/BTmMH6+z+zsAwI6tjttixwzgLT5QzJOUOIHHK08Q09Pj8UA6nhsDaJcsE6vMXwXyotcUqXWZ3XHL7jM4XE+2qcTDWSvMo8cEb99KLP9u624YWRDVB/z2nRYmwcQ0FUdCNEVch+JbMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439571; c=relaxed/simple;
	bh=gBHh1td+M7LaKlwkmWShURmV1fJm4rSmWM54uFNQ1EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW74O5ImVCb+mjUL83tcxC0tZ8fK6LMHY18d7YvR0cG0cLYRg+O3AQ/0G2wYTKlCZ7knvcMDRuXbqE6oRzQy4h4an5xBuO5QRjqCEfYbPC1k4Jp0dhd+hvPIOoRCYzmdDwzAjt4rK+tki5+5eF50uKQNqre3W67DFsvOZy6O4lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoREwKNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoREwKNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCA81F00A3D;
	Fri, 22 May 2026 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779439570;
	bh=wOKGd6XLWtCCM3JrTlb35r4UR1a506BP0QJPfc05csA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IoREwKNn0V+o/shiyWNoThDK4fsPtSCJi5TqjowZ0LaQYeEabUAafMcE2IHUNiQDu
	 Ss+fzGwVC6wq/D2x7E3jl/cHLJkBWGr4JYyiXAZ/KQoN+fWa0VCp3U69cb1pSZRftq
	 XB1C1AEn28s+Hh0F2RNzDHF2e/Z2fpzRjuLfVB6J2fiUy6mts4/dyPga/wkVgskQYv
	 ckq0xJko8YkuTV9UU+uWcJBteba0af741mH/XAKziR2a7CRQ8n+avz/ZNC+tpRX73t
	 lfpRelHHXmIsVo+3lqc/9gqzEXTG6gjBV1hOqURu24U54gwupcdAVKC1rs7cdESHl1
	 oBWuFqo6T3leA==
Date: Fri, 22 May 2026 10:46:06 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: yaolu@kylinos.cn
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] HID: core: Fix bsize printk specifier in
 hid_report_raw_event()
Message-ID: <ahAXeobpZTGZBUrS@beelink>
References: <20260522072718.186707-1-yaolu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522072718.186707-1-yaolu@kylinos.cn>

On May 22 2026, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> Fix the following warning during build time:
> 
>   drivers/hid/hid-core.c:2053:43: error: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
>   drivers/hid/hid-core.c:2075:43: error: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
> 
> Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>

In addition to shashiko comments about %zu, it's already in linus' tree:
4d3a2a466b8d ("HID: core: Fix size_t specifier in hid_report_raw_event()")

Cheers,
Benjamin

> ---
>  drivers/hid/hid-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index b3596851c719..c21c58d7bf02 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>  		return 0;
>  
>  	if (unlikely(bsize < csize)) {
> -		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
> +		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %u)\n",
>  				     report->id, csize, bsize);
>  		return -EINVAL;
>  	}
> @@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>  		rsize = max_buffer_size;
>  
>  	if (bsize < rsize) {
> -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
> +		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %u)\n",
>  				     report->id, rsize, bsize);
>  		return -EINVAL;
>  	}
> -- 
> 2.25.1
> 
> 
