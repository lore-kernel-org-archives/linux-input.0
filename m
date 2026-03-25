Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF741C2FA
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462127; cv=none; b=uvbLlZmG+jiJ//RqaJdI46SCB6XAO9ICynKsx3GbqFDP4h+H5U1QXbrpWjeNvdrbJvCOer1aaCmgeeBDVrV5CQ5DDfh1z7BOrvZndsIu5oiSi7IgwAZowXNesl5QeE6Zsfhjv78wO8pRJ0C/41LYcqsS9u2A2ygXJwRHPt0luvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462127; c=relaxed/simple;
	bh=4AA+m62a7JQxXTacpd7FQVVcjxswdHf0m2hjvOlNIDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHfnC0CzySMK2GwPunuFsMhkSWZsG2O/4CC0B00FP19B3YbGyiXkNqe3Xv/pO5Fzx7GZtOiBSCSbXR165HNRdNd5ZjeAf+JP002t1QrowPxVYHCBX0O9oryTxU6y/EAQNyHteduap0NnE0RjgaLzs+q43tbNV7nIJ9o45F2Yyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZhm0Oy/; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZhm0Oy/"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so202556eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774462124; x=1775066924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKB5r8ldkjXo9I8tKLwqIrOGcsIw5EUTDw+8JcXL628=;
        b=EZhm0Oy/iYrKKc3SLWr4XNRTBx7RqVenivDF22g+4nV1+GcZM8WYBuxvW3E+say78z
         LDLgWYxppR7f3us3tqwgbPIZdKpOeIU9mbuPnlYZ2uOmhfVaMiH6yG9/sanxOEwXlp92
         I44UGRN+jPT6HK+Ti3NF96MvuAbppilZK/rvj1ePEs7D8ZG0KErQydc4Cy06FsCNCT0T
         eMqqMuAHfzF/S2uAtk7qsr+30/Q3MJprvD8TZrBmatv0pyRnqXdXwtPIrdnbVVkovpm0
         Q5Nx6DbDT2S0W5YHZA6yTEWCqlEGFH1Tn6nPwRixneGtgqdNUrjMB/ErWgUhkVMavBLG
         vlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774462124; x=1775066924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKB5r8ldkjXo9I8tKLwqIrOGcsIw5EUTDw+8JcXL628=;
        b=GRD2+rJXoQ4R3l8WCRRuiMkSQDjOu1J8cIzdPWjag+UDLPaSSbV6gxSC3Wi8s22+gV
         CXF8f2CwsYUGgiWBNnhg8Py3UPx7LB050yHejTgCz06BVsho5xI4N2J6AyXiOSk0lDf5
         WEO9Le39FS9yG6vA/AgjGYCt5q+mH6O01Ftgp+tkWOn3KfxDBK98Kq227lyu+WVoN6ps
         /17GQt001KISpeoeKpZExcfbfK4rhNvEE2Iw+31jG1mJRmq9ayxzrE+7TYBQCYd6s3M5
         i1WWJqKiFyfd3Iv1qhIG4VUtJJ2mTHNpzcoSvgHt1SgzP5pWUBL7ViBlpjeU1sPeGDgX
         Psrw==
X-Gm-Message-State: AOJu0YwDj5Rwoi/Mx9emvGXR7Rvito3yrN86CH+jeTrM1IHOfRQ4HR0W
	h98Nf64LDQizPmp3gde1sP3VLTyDNZY6XJ2fKKgIKd7Sfw8PvNZsC1uBqpkLXg==
X-Gm-Gg: ATEYQzy091bYaCdsEGUTc9I6reocWcM7RQN/kpAM9b/5MlbqmijnJkMso27dVbv4dDc
	dlSTHGS4sLIDr6kszQFG7tdgaT9V3Xg25n3/Y8nddlwyV7a3hG3O3psWxBeMJlq+JyWy5hSPK3m
	wkuE0j3JylYNAP3951Anq0a9F6EB6MsNUaS+pAWv/lxg5hTpPVYyoqCq1LayzXIIJOonZA3IM5q
	RcO7+cwFmXPkBergArM3Dm3x49IbIiM9KMh+dW8clOCdGQKuJLkbddC4t7lR6tes4IRxVm/inlk
	SiEDQgkypqdGDQFcDAvplcdiQXEl2Z1vTn1eF/o2y+LQszQQw3hlLd+E6a7JWhHwA30vaTDs6A+
	bCbBN6qNM2mOyn6v6UXhtA7TSy0mwzjUIJa4YXHaE7olZHDLX1rlI3/ZCEtNfYVoSh655047NRv
	51wOMlXtIddPPFTFoOihLPO5j+62AVLTUlzEflV4ODqRCrzCRofRZnD4JmcusvGNKR
X-Received: by 2002:a05:7301:19a8:b0:2be:7885:31df with SMTP id 5a478bee46e88-2c15d3db093mr1848709eec.17.1774462123653;
        Wed, 25 Mar 2026 11:08:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edde435sm306686eec.25.2026.03.25.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:08:43 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:08:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: aiptek: validate macro key indices
Message-ID: <acQkOfB1UsN7S0QV@google.com>
References: <20260323070311.42849-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323070311.42849-1-pengpeng@iscas.ac.cn>

On Mon, Mar 23, 2026 at 03:03:11PM +0800, Pengpeng Hou wrote:
> aiptek_irq() derives macro key indices directly from tablet reports and
> then uses them to index macroKeyEvents[]. Report types 4 and 5 use
> (data[3] >> 1), while report type 6 reads a 16-bit macro number from the
> packet body. None of those indices are checked against the array bounds
> before input_report_key() dereferences them.
> 
> Reject out-of-range macro indices at each use site so malformed reports
> cannot read past macroKeyEvents[].
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/input/tablet/aiptek.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 6df24cee3c9d..ab5886a9241d 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -676,12 +676,15 @@ static void aiptek_irq(struct urb *urb)
>  			}
>  		}
>  
> -		if (aiptek->lastMacro != -1 && aiptek->lastMacro != macro) {
> +		if (aiptek->lastMacro >= 0 &&
> +		    aiptek->lastMacro < ARRAY_SIZE(macroKeyEvents) &&

I think we do not need to check lastMacro if we make sure that macro is
in correct range.

Thanks.

-- 
Dmitry
