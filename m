Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF63F54D4;
	Mon, 29 Jun 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722799; cv=none; b=KeWZER6A2eAkMEvrEyt3WyIvirLDPZzET2CamC2DX43wF5AYDVRAN/JrbvU3ck1zHCliVoqBknBnf9KdgOfN9geSt8TCHCjBqJi/2hLcR4dNBFYOd3qTZNV6rsRhHxvUmVtHl9OG3F4qBI11Z9/KlTbFXVmasAhkLSIErbeK5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722799; c=relaxed/simple;
	bh=b4o74GWv0/EIKI+JTqiNROFDz5WaTCGjnEgruqJWQ/k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hNRRvAmyzcMOp0h/rNjJDwe7h7S3M4ruKyRhWQuFvRRPUAnZtWr8jqEd+eVdKnl4BjIlnYyoiYR7bd6/hnLYX8EF8deRp9TTR3BAkHFCdVDgdxpdKRnHug5nnxTDvQ2bwckkfDV/S1mZAqUWtUQyKPdxY6HBIyQMT/s8f04VRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1vJDTLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1vJDTLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417F41F00A3E;
	Mon, 29 Jun 2026 08:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782722796;
	bh=i5EEK4s9sao9TP2ru/Hd7EB+iNYxrgcTTwqFQVnXyvU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Z1vJDTLFih8EaTrp66UvwlQ+Pn79Ua2n6UKJyEXnvT+ThsN1WoAq1g3eU09oJHHJN
	 iotgaO2Rbv+9L7JwdaRunhsii3fHWjJ2w49gEh/Ccjjd+EyWbZieh34j5qCmASZwfG
	 y1Wupq2I7c/CGnsz+kyLDDCyjv28B2sOMe3J0EtkkXRtLEA8q3EVpmafL9VHCWqcut
	 YYiwXwlcsiyd8BCIulltB0dfYngxwuZw9XoMalk4AVdpecyqvkaHq0k6lsvzC2Etn8
	 vEYo2L2XAAa/m/G5MEmbKujfqH5yS2EwwVMwHASjz5iaC9xh2SEjWTEPz+Wr0z6DpV
	 /acAHHLHsCPCw==
Date: Mon, 29 Jun 2026 10:46:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Georgiy Osokin <g.osokin@auroraos.dev>
cc: bonbons@linux-vserver.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
    s.shtylyov@auroraos.dev
Subject: Re: [PATCH] HID: picolcd: prevent NULL pointer dereference in
 picolcd_send_and_wait()
In-Reply-To: <20260517120639.38003-1-g.osokin@auroraos.dev>
Message-ID: <886s5548-p183-3nr0-4836-85968p1non0r@xreary.bet>
References: <20260517120639.38003-1-g.osokin@auroraos.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 17 May 2026, Georgiy Osokin wrote:

> In picolcd_send_and_wait(), an integer overflow of the signed loop counter
> 'k' can theoretically lead to a NULL pointer dereference of 'raw_data'.
> If the loop executes more than INT_MAX times, 'k' becomes negative,
> making the condition 'k < size' true even when 'size' is 0.
> 
> Change the type of 'k' to 'unsigned int' to prevent the overflow and
> eliminate the out-of-bounds access.
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: fabdbf2 ("HID: picoLCD: split driver code")

Next time, please make the shas of commits a little bit longer to avoid 
uncertainity.

> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>

Applied, thanks!

-- 
Jiri Kosina
SUSE Labs

