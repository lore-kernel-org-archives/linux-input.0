Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0E1AF0BB
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772411119; cv=none; b=rpBEKxqJ7RtuRKX4P+QOAQDZhkV0GbQieIj7xncwMb62NgzSuBAOlfODle+72oBUGqrLc3DqZwZn6jtxndt5SNBcHeNGaP0rXSMv1pwv6mdY8sT9fQR4MyXVFfrJHoXz59gZxakT2k1WiyxQtlkNX2ffEt+pa99lIT8qsfDCvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772411119; c=relaxed/simple;
	bh=S4rTdR6Sn3CyItxBXI7nuVvd+WyWl9xvd1Fxs5IpwL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzD7kG7YRuKIP7NgBdGJE3APQy3gkgwTGjB4FjqduWOJ82yMhNU8Cj/yZoxeShyHwLkKezcLOGiGoBwVzVD7eE1jQOkVLb/t0bugrYEg08NugmS3i0H68jFligvvUTSgh9IWTR/7l2X3iI7PZGxlcjPAksR7GLzhv0CsDGaIEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLMNGgkj; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLMNGgkj"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1270ac5d3efso3574240c88.1
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 16:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772411116; x=1773015916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLTyL9xtg5mASnZ4TamkxWcWgMRXeEhDGS/pwG+nNf4=;
        b=cLMNGgkjiHB0EY4bE5GhUFDB4g1FpSGCvH5QJAmFUOCeEMkPlB0v2zwUUpWTLrJLkJ
         WTv+TBRjWFWXyJhw4HOxtYEDqs8RsQ8Y+kQy+8NYj0U7yy4qMAMJADPv1hxZypUpiBV4
         Af9yEkCjpb4yurEXF/8aJZn4ivHfE9oFSoBFCb2WAsamtDbQLl+GPlI8MAlVY7yXfB9z
         IkpYfPOoBcLeLP2XUG9IPB1IojmxvqTL+0knYSV6Wk10mTvo+9VOiw1nYkuZ3U21BDgU
         MOGu1QqmXPjUwd/Tj5sFbhCiJZ4bPdX7mnZUYX8v7Fb6qd6u9S0P0A9Q9hJbF2mFlWmD
         djEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772411116; x=1773015916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLTyL9xtg5mASnZ4TamkxWcWgMRXeEhDGS/pwG+nNf4=;
        b=nv8eyae1+SGBkp9sOw4I4rxfcGU3LFcax8Sys1y+FtZt9CFrAMVcxE+lQqKL+4gBSg
         AsIUIDlQzwoZPoRiZaauUVi1o7YiGMyeOLzJfJyxJy8jU9oY/8CPHeZX1yVVvuNGcSme
         uohtwyr212p4i3Pzp7Tst11YBRHckGsntzM6UiLaRQitu/YqYRPPAR92t5coGaHVSGhd
         6vQaxCbhJ1z6yZA2r+4X+RBu8SiTKXW851MquySsVJ4emMropmU5DcT6JNkyvX82K52A
         thbJ5jASkIN9b0LbiMm8y7MEBxYUPvpt3Rg2WN900Wl3oz+73FZSop3Vm432Cj6OALMF
         jbWw==
X-Gm-Message-State: AOJu0Ywnv0YFvgqQRLnjEUTEHmOeU7gl2fiVtqLraR+yvmMN6cw/uSi/
	HR7RJ3re+dwdB1WRK2te4WpfFWo0PGhoNoRHVJ7n5BdJ/UtJa7Vhab3R
X-Gm-Gg: ATEYQzz6I2HREHrc0JBVNjnhWMog8Dyq2pf6NExnXM9IyuI8MeQfLqX8O3AMI1Q25A2
	fUIfHB5f/SAqQKxch3VC9FY60RJxVjQ3m6tu+aWN/04XU1u4jzZat2RWQW2v31gT3a1Dzfz0xYs
	3oWH9mE6Cw/GDWwS2L4vsl/IFjulYCq1dy4bZ3ePk45UufUt1Q0Ii/ybUfD3yAkpcBQPttO2IKw
	wEKK6GHW02Jf/6XDHZNBEZ+5NWp+LxHvBCqV471d53jtTVkXgGzR9ZR5jzxfVnr0vk668AOQa8G
	OHnFR7jXOFOnKzsPyTC3so7BlQz5QUkoIGkqS4zD62xFgnigrA2kEJOWMFeAHHNaCIX9CL1y7CQ
	j6bti18IRbICaOyILXCqOlr7l9ljU5NRsPGfWWUDzCW32zcVPtlKjIAMSePQHJabDRQNXHq75el
	dKetNncizl9aprPxpQz721Aetq8QmjU/+CIkDCxCw+FvBUNWf/7T9erhuCfC++oZrC
X-Received: by 2002:a05:7022:1e05:b0:11a:e610:ee32 with SMTP id a92af1059eb24-1278fbff7dbmr3779423c88.25.1772411115868;
        Sun, 01 Mar 2026 16:25:15 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:864f:8513:57d0:4064])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm13884010c88.3.2026.03.01.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:25:15 -0800 (PST)
Date: Sun, 1 Mar 2026 16:25:12 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Josh Law <hlcj1234567@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Law <objecting@objecting.org>
Subject: Re: [PATCH v2 1/4] Input: elo - fix style issues
Message-ID: <aaTYvqdymKquoVWJ@google.com>
References: <20260228195258.2468296-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228195258.2468296-1-objecting@objecting.org>

Hi Josh,

On Sat, Feb 28, 2026 at 07:52:58PM +0000, Josh Law wrote:
> Fix array constness and spacing issues reported by checkpatch.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Why the difference between From: and Signed-off-by?

> ---
>  drivers/input/touchscreen/elo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
> index 434b9b47e964..40ae132cde21 100644
> --- a/drivers/input/touchscreen/elo.c
> +++ b/drivers/input/touchscreen/elo.c
> @@ -257,7 +257,7 @@ static int elo_command_10(struct elo *elo, unsigned char *packet)
>  
>  static int elo_setup_10(struct elo *elo)
>  {
> -	static const char *elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
> +	static const char * const elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
>  	struct input_dev *dev = elo->dev;
>  	unsigned char packet[ELO10_PACKET_LEN] = { ELO10_ID_CMD };
>  
> @@ -273,7 +273,7 @@ static int elo_setup_10(struct elo *elo)
>  
>  	dev_info(&elo->serio->dev,
>  		 "%sTouch touchscreen, fw: %02x.%02x, features: 0x%02x, controller: 0x%02x\n",
> -		 elo_types[(packet[1] -'0') & 0x03],
> +		 elo_types[(packet[1] - '0') & 0x03],
>  		 packet[5], packet[4], packet[3], packet[7]);
>  
>  	return 0;

Thanks.

-- 
Dmitry
