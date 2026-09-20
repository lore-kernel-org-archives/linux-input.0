Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F13CB8E6
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876931; cv=none; b=IaHSanhtSuv00tQS273AjhQlwL8VOjcANfdAu7wk6HArJHF9DE7/CuRtWELqIdbhPiVf6UG2FfHOp9s3QCdIcxH5LbcrlmxhU07xbXBLP7XqapiMvbKcT5up09NcWb5W5doOP5M/tYGHJ82n9iTq3jWvTOX31VXEXJ6/aUjG7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876931; c=relaxed/simple;
	bh=ja62orH3qdNuVp1tYwk+qTD0ossolEOh5lI5xEbsuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TInpxqND+IR0mpxSi64QaNZvzWc+EqCyECjFIrPvnVoEY3Ql7PErZGssO97iwmeBRaUjo7aWOhhkWmvvHGaSFJhCf/uPo36Ui0YYb1q+9Zt1bZuxXAKNzoA7jTqJ24PENUlO616Ao8igWM2L4BdDFPguQhtnLUbABMvieRnJkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrk+SCGg; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrk+SCGg"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398cb5615deso2310482a91.3
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 21:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789876929; x=1790481729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5QJaKEYYa0kSl1fGgyUvaM13oMrnXDQtarpxehh6V0=;
        b=Zrk+SCGgCGFgcMzbjqY6qnVzwygZRCi10K/rH+xgqiRWb5lxmvdsL8ku5dZkkd8zsx
         DQcMUoS2pXmhToQeWXrzlnBnnlS1i/d2bb53cZEZ4iQoaXTl75YdE/7sSq/XN2VMxh46
         9S+Yz7g4SNeXbMbZ5MpEb0fSZH9v6Ebi+R4NHCCcawbFFKgxXr7FEy+Fu8RqfcZ5BuM/
         X3bxRv5NsfpslIwrcGpOUXpolXSz38CyShy2lI7+hVVFCPfxbhybh6ALM0+0iM2pGYKG
         Q7DYS42bFDWnUtcoQapJd/b5lbWigtWB2jpJXpy4FWaoOlRKZ7yS8aYUMNFQEW/qCKQh
         PWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789876929; x=1790481729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5QJaKEYYa0kSl1fGgyUvaM13oMrnXDQtarpxehh6V0=;
        b=nRCVdYRPQ5AiwkewtJhJY3i86+SG5fwzZCqXGEpSQ8l6peSm5+L/9j+sDdc+AzKWIr
         JORrBuPuW2/xGUcfv3T1h+4CrARTMc0A7T+eY3ti8GaQCkE19GChmcH0LTzCd+ey/rr2
         8k58LaFZ91nvDJl/HowQLhUW11eSHTJpml7Ppw+70kbt3XV4beCj3+wRSlUSqUFW/JQi
         qbWuivpBiN6LDloMQsouhDqHtJs9c3z/ryccOyqd2zBRqU3nbczTp+xP3oY4UAv2I0nw
         6AzyWVmOWH7KyJvGXqwKyxYS+JUo8J8h4GGpVUwVuafkMiMnRC/i6qvrQFx3nCGWXvEr
         x6vA==
X-Forwarded-Encrypted: i=1; AKwUvBw1N8rmIsnAIrXsLVIomQSqPHl+DYNbYE3kg1APxfKfw1LFyto0DBuuidp3Mqi2vkqqDu3pB1pTbDwQpw==@vger.kernel.org
X-Gm-Message-State: AFuF++lB0EnXxoU4zh0w74nmam9TslawI3XmBMDM7dEZUgApVYW3DOUq
	hwifmUNluQ/WWl/qLViCJU8hwZlYTtiV3McDWBgyCMwLOFWglLqqTVdk
X-Gm-Gg: AYBFou2W0VvIzyNRlFF5H6Qz8pQVMzOCF3g/Bre3Y9X8ii9fLvaWegNu7NoaBT6GUYZ
	iMrqfKEVH6TYrq7td/WBuZHMy2W2B2nGieNfhW19KbGEYLigsCN3jAMzM4jdcjVyuykfzl6SehK
	Ju/WG0VLi8ZKTy/Tm/miN47/cz+a5N6ofQ6qoC1a0eU/OtCeGy2SyfDMjMTnezYXswj1Bw3gBZ6
	4EQWwmdGH95bRb/K8/JKvMr4K5hYqsg7E0DaeOS7MT+3h22sTtMg9yp6tEcIKnOucKrNk98dO5g
	kREnMJwM5kvp0bO3955248hBgddRFsoVARF40rZtv/orkimjlyTPUcYVtaWXEweVQkIjVSmtLJA
	/uUe1ho6+p6wHppcEwD1cXbRT8hQgaP/hEKPB0rNL00mh3Oyz243c8+FgqecAGjCGhoOiA3DJj9
	/2JR+mPdy+3lz5UUT/v/Gb+0LMbXVGSsYop8Ngw0F0b2gMCA8f5oAjKpIDwApNK7DIsvOxTL6PN
	FeYIZK6Ubj/ilzdTPPKBMCNZ8nZnYMBuRVj491/
X-Received: by 2002:a17:90b:2882:b0:39e:4c81:6c95 with SMTP id 98e67ed59e1d1-39e54f3d98fmr11714645a91.27.1789876929055;
        Sat, 19 Sep 2026 21:02:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7836:19f2:c781:88b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3318c49dsm9418565eec.22.2026.09.19.21.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 21:02:08 -0700 (PDT)
Date: Sat, 19 Sep 2026 21:02:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: jayakumar.lkml@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - validate index before storing data
 byte
Message-ID: <aq9aQzLGtt0MNWjJ@google.com>
References: <20260919192152.271808-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919192152.271808-2-meatuni001@gmail.com>

Hi Muhammad,

On Sun, Sep 20, 2026 at 12:21:53AM +0500, Muhammad Bilal wrote:
> w8001_interrupt() stores every incoming byte at w8001->data[w8001->idx]
> before the following switch on w8001->idx++ has a chance to detect an
> invalid packet and reset idx. The switch only resets idx for the
> specific packet lengths it recognizes; once idx has advanced past all
> of those (W8001_PKTLEN_TOUCH2FG - 1 at most), any further byte falls
> into default, where idx is only reset for pen-only devices without a
> touch_dev (the ThinkPad X60 workaround). A touch-capable device fed a
> malformed or overlong packet therefore has nothing to stop idx from
> growing without bound, and w8001->data[w8001->idx] = data runs past
> the end of the W8001_MAX_LENGTH-sized array.

This analysis does not match the code.

w8001->idx starts at 0 and is incremented by 1 on each invocation via
switch (w8001->idx++). To advance past W8001_PKTLEN_TOUCH2FG - 1 (12),
w8001->idx would first have to pass through 12, which matches:

	/* 2 finger touch packet */
	case W8001_PKTLEN_TOUCH2FG - 1:
		w8001->idx = 0;
		parse_multi_touch(w8001);
		break;

Unlike the shorter packet length cases, this case has no conditional
break and unconditionally resets w8001->idx to 0. Since W8001_MAX_LENGTH
is 13 (matching W8001_PKTLEN_TOUCH2FG), w8001->idx is always in the
[0, 12] range when entering w8001_interrupt().

As a result, w8001->idx >= W8001_MAX_LENGTH is unreachable and the array
store cannot go out of bounds.

Thanks.

-- 
Dmitry
