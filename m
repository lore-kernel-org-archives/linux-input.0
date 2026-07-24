Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D4484237
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937586; cv=none; b=q9H5+myT/C9kTXPuYA44+silm0xEKUgqgL3OCSixjOxw0qUUJUiygfNKedKGicd9Tp9147pskwiTq73rX8aVuGv3upuninu6xIdxiY/MK/eXRPLJ/L8eNP7utlP6eZ49IGXes/xVkOl2ydIt+SydQgtLeTPbvkJOMB0WGxb37RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937586; c=relaxed/simple;
	bh=6g2P92LnSTMEc9u55dS6d7CPcAA1BZpmHmRQqM9EJFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhQueqLgRBWfZmxEda5ivfAk6dB5zg8cXUxM6PzrXpxFupky4br8TTcOhglxRJ9S5CkPh34lNE8EeU/1hZ8PvPx+LSvkXqxC1bIOMGL/TBqLD3TrI8fQ+J2q079JoDBiyzs8Ij5wjiU5dwJiOMxw6YAmmb8vh3JDbj3HxiHUkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qb71Keu2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qb71Keu2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so923121a91.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784937583; x=1785542383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kHpr2vY/Ca1GMVlUGShPHXsBqctbPxNgTkcfcAefXA=;
        b=qb71Keu2OjIdE8mba2yOV7oDbwGSAvNJvXI8Mcu8rLth+UiT/7sX07UitAnsS89SEW
         +t/Twr79IxF/uZX0378rFs0Mo3feqgxw7scc1bmMzKULI0nZda7YH9++E0Lp91tIeSrv
         Ls5JRjxN84JAdHYdLhNNWj9Al5k/anMrFHJ4ZQ5S5xgz/4r1qc8gtXBYwv5Cp+FkwD6L
         1Mv8/zXeZK9FupBzejt67p4xMCDn3xTlaNCJzmhOwxxo+wCwT9VbAucYxwW8kJkZg2Uq
         5DQjNuuO47zaBTEhkpIsJgigjanNcVX9VULFY7ST3DwP2lhnd92MHvnB2VlbwF+8YPH0
         P+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784937583; x=1785542383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kHpr2vY/Ca1GMVlUGShPHXsBqctbPxNgTkcfcAefXA=;
        b=aRdnmuBVcAGQl8sB+QaPAbvndlrfcP6Rwa0l6gwRNBjqScKERHN4xJ9UMKUqlBzc4u
         mPGcZMkwvKXwpMbUsgOaVcVB3UABzYUWdDPIdj3C9FivPHchiWqzqUJPxUse8zo+R/jd
         4/H2sh/9OgRvea78o/RLLl8mXQuWyGNox/0VvtYDra/TojHwrvEZII62QX3x3dVRGaX0
         L96wJVNW2qRGGYvIkw4PkYfe9ECGeUg+rKATPpocUArTqZB3LViqG019OSKnCAF6dIjx
         FnUyxtgFKsmfPyolnLVgN4aPr5vvpaOmr0kqYynrs8e4tOu3gXN9eKt+47jsia5WcEkj
         sUiQ==
X-Gm-Message-State: AOJu0YwN0b5fCZll5F+Dpo2n6YW6Z6hLiZaGRGrt7h3cRxEURlNk3jJ1
	sW5rmar3D92GYoCwn+ZZdZg2gGJBEx2qesZaxH1yso7v/VEdLryf6o4+
X-Gm-Gg: AR+sD10tWW42XXiKb3thswgR/E8+Ljfvv46wA5jDPKxrhk1y+lh6C4QGND6WRCDAa1o
	3URlIANCabOl71QBrKEks0V5P8Q1AfyyWQWjxD8a80U4PBIqTfJt8vHvlWNmyY6MLpf2A0M72cs
	cjnec8ELJd+MCmKgp3jV4QhZql1nTLpfng16Eo7GG+9CHmdA1J5JmNd4hf/rWZMJdWCXsjvwbX3
	9MTooSOJ8ooTtuvv2jr+THXWHU07Rt4/h3c5/KARZTaiRKljOahe1dBf8KJdmp613A+Slq5suuk
	R6Jvgf3rj3Tjv/6MWKMg2r0j0Nd66PP42WVlQ1NV4FxkiM85nq0DpGQ5isssbx4Uuc4zGEnI96i
	l2kCTdH2S3iTQ607zaM9juAjM2MMvvRYgnzhbNxmTvb125xXtb64pBD817YWGoao7q1IzfHcmph
	Ymf/OTvhQQB6XNgjgTgy2B0ejK/5KzsC8jO1SF1VVzzZg=
X-Received: by 2002:a17:90b:560b:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-38f2939ab77mr482411a91.9.1784937582740;
        Fri, 24 Jul 2026 16:59:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm47799605c88.15.2026.07.24.16.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:59:41 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:59:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH] Input: iqs5xx: validate firmware record destination span
Message-ID: <amP8Z3TxA-BJq9QO@google.com>
References: <20260715083850.32155-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715083850.32155-1-pengpeng@iscas.ac.cn>

On Wed, Jul 15, 2026 at 04:38:50PM +0800, Pengpeng Hou wrote:
> The firmware record parser checks that the record address starts within
> the programmable map, but does not check that the complete record data
> fits in that map. A record near the end of the map can therefore make
> the copy to pmap exceed its destination span.
> 
> Check the record length against the remaining programmable map range
> before copying the record data.
> 
> Fixes: 7b5bb55d0dad ("Input: add support for Azoteq IQS550/572/525")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied, thank you.

-- 
Dmitry
