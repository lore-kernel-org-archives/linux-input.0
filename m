Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21E413249;
	Thu, 26 Mar 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542931; cv=none; b=d1UY9f6pcBolVp8jfJ2WiftkWxEsK681MbUAuCziAXTq1LBty5siF/CYyPEpO/Ux4xjtok7dSxkRLoxADAJrL6bPaW7JbdMWm9+YJ+JAc3eN9SAhxP/Xa3pHZlM4GvBcbfFIa7H9fvmaJqF6jmq0k6JBel/9MW/V3GRZQ6Aku3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542931; c=relaxed/simple;
	bh=Lrz+lrVO5HmRt+J82LPaiYUIKNyWYgywRTQJVMZWAgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b41Pf2SHGCLtCYpFW26zO3qUiXHM81OOnhlBN31zhrLDgh1OTYz7LS2n+r6IxtzrsQRhgXEfAx8fjEGGWN66qIg1/awIouaKmYsS8Jnsh7X4OQAsfpH3l4aNyBFb8vfIPx7UZutmIBH0Of+eBMyyiotbyWNGoF6d8on1VjJtzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwlJ/+sM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwlJ/+sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3DCC116C6;
	Thu, 26 Mar 2026 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774542930;
	bh=Lrz+lrVO5HmRt+J82LPaiYUIKNyWYgywRTQJVMZWAgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwlJ/+sMPcLQazoK1KKsPeK4RZp/O0Kjg+/Bc/+kw0o4VYo1rzP7E5OSQT1XZkLzN
	 l5LgJ/a/lXeImnB8PTvSZqhZhoVYd5HBMWYop40FMKfbDUbEiamKw52HJVi6Pg67lm
	 zKLmm1gOBzR2Z4c4e6BpT/KD33hDHzlQIbv4CRuc3WWyQ+zc3wcxGOQkB+8jXhE3CK
	 jD7sRiOgjp+PxBFDDeI6AnPVZI3n0lful8PZHo3bVfxkwH7NkPaoPi4ZQnCwKS0OUB
	 00c8WuoUzt8d0BhEfufyss7AHLUo1e03zieLWwbCWm5+Iwum+SRqpg6o8nT5altk0y
	 w6O7nSp0DZR5w==
Date: Thu, 26 Mar 2026 17:35:06 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: aravindanilraj0702@gmail.com
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: cherry: Fix switch case formatting
Message-ID: <acVfxor2SwDrufkw@beelink>
References: <20260325161328.260110-1-aravindanilraj0702@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325161328.260110-1-aravindanilraj0702@gmail.com>

On Mar 25 2026, aravindanilraj0702@gmail.com wrote:
> From: Aravind Anilraj <aravindanilraj0702@gmail.com>
> 
> Fix checkpatch warnings by splitting single-line case
> statements into multiple lines.
> 
> No functional changes.
> 
> Signed-off-by: Aravind Anilraj <aravindanilraj0702@gmail.com>
> ---
>  drivers/hid/hid-cherry.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-cherry.c b/drivers/hid/hid-cherry.c
> index a504632febfc..828a3cc67512 100644
> --- a/drivers/hid/hid-cherry.c
> +++ b/drivers/hid/hid-cherry.c
> @@ -43,9 +43,15 @@ static int ch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		return 0;
>  
>  	switch (usage->hid & HID_USAGE) {
> -	case 0x301: ch_map_key_clear(KEY_PROG1);	break;
> -	case 0x302: ch_map_key_clear(KEY_PROG2);	break;
> -	case 0x303: ch_map_key_clear(KEY_PROG3);	break;
> +	case 0x301:
> +		ch_map_key_clear(KEY_PROG1);
> +		break;
> +	case 0x302:
> +		ch_map_key_clear(KEY_PROG2);
> +		break;
> +	case 0x303:
> +		ch_map_key_clear(KEY_PROG3);
> +		break;

Nack: please don't run checkpatch on existing and already merged code.

This comment is valid for all the other similar patches you sent today.

There are many reasons to refuse such a patch, but mostly it's just
pointless and makes looking into the history harder.

If you fix something in the code, then yes, you can also make formatting
fixes, but formatting for just fomratting is going to be rejected in all
subsystems you attempt to contribute to.

Cheers,
Benjamin

>  	default:
>  		return 0;
>  	}
> -- 
> 2.47.3
> 
> 
