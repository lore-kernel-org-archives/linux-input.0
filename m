Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46568225417
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510666; cv=none; b=JhcnhA9LNW0Js6/i0i8E7UdFE4/NrIFBeASfB8FR7pgULK8e9anqnrBM4Akm9OIJnqaiKGqUqmTnpG++3ZLaYd+46UCV4dsYrMqD5DbbOmV1lSBaHat+vnYOyswEe/EIitKwkUxVnwcJWLTsd1SgZrb5rvejjBygmDwc8eVl3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510666; c=relaxed/simple;
	bh=ULJ2PmjfjsOPWdN3BPeDlpW2pFapgckIJX3/NTJ7mPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjLZlffs5795nSN0s+8OTTyJHCVA35UrrnZsqsz70zFxpTCdizHdLWJJaBIbPEWFpYiUSAxtbnrhl4n3z/JF29OFd1QwDo/9yA1Zl0bkNFBpVmyWZlfqIP5eJDMBIzLcEND6UUsTp5zGIgxB9JqLUOwfeYVCBT8rGa24kCQJRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O94wKJM5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O94wKJM5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso7463874a91.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 18:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784510664; x=1785115464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZoPiFlw7qfVfq2IDq2halA71gwS1va2QMJF7MLCCNiU=;
        b=O94wKJM5UteGgqZUlQblA4rmuAQT7qCeFfD/7s2V9w4xHdM0LsFXXsHhtenskladc9
         a5zbf5Tl4V6r/mWYe+MDJdKRDJZdX7x8WuJnLSF8Hq3/5tZ9pFU/IrRRgpmwi3036/3p
         VBJRVXBeX1Dq/Ez+IchkSDTIR7rj1edQsI5XufI+jRh4Ey8dnf/M4UY8WiSoIS7Vzw7D
         GJrt489teoDfoUrInTgjH1QeWzB7dGblbPe46uxLd0bFVCtWoPGqiQs7K0WhyjbsGLmG
         GCvK37JNOQ/uux84IOWCRN/szHCwwFyE6VXsl+4wY85wj7VoAjR5sOhvftAxTOGHloDW
         bBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784510664; x=1785115464;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZoPiFlw7qfVfq2IDq2halA71gwS1va2QMJF7MLCCNiU=;
        b=FflkneGTk3VkorID9JMwBN1PArEMVJL9g46duNz5YcCYJ2SPWV/KMIYF+0movBNd1O
         Mp/3i4Gjv/Bh3VI6AHjpNB8Nkq01I5vdniM4Q1Hci/+IJzGVH8hB3GUKzeRxr5tAE6Db
         +QoiXJg7unhn9v8OZDSGfkHr9U2CzZlYFFva9IyugsJNSPQhaqmEY8zqGZ+nrlbTtDS0
         QK4OkNFXcEfCCMvIji55RsNaONUnD/hbmxCxlXceQmxHPzJuj7Zg8nyidKWjZcCeyDoP
         VQpSv6ZLfMmqUOkPzbjfB77gBLXNpCWC79hBagJ0N/03aquMc0h7PMpBn838dZBSypUW
         yF7g==
X-Gm-Message-State: AOJu0Yy8VbauVpAL+AtXuxlDcHJAdq0ZZ3pMbw3uwNWEYIizPplZqCis
	WlfLAFE41MHFitPYXjsAP8AbyISbvgz31a4BJ4uzqu8J/Xxg6AnE6VsN
X-Gm-Gg: AfdE7cnzw1wH8ipf2ODV2WxQYYBeRvRibAqhLo4DexVr+0tt1XtKmE5qcRzb/rNhMT7
	Lf96DaRklzL1YbYlivX/2R+Rd2CxdBQyrGr2EWqvJqrxS4OPNJQpNTFAVHaQhjKIuNiSv5UvtDX
	QdKtCBvX2UT/2NYt9MQLNLLvLCWesU9k6RLIRfPIQZtTJZTi6wV0nIDhm67hnNH8VHFE2qShDWB
	Q32HOpy3X8+aiXsWsj4Bsxb95CR1bizR6qjvTi00DctqaiBUCnTB7sKGl+YpLvlJf5NjVxlwQxo
	JgSu8FLjfehsOYBZlRx+joUHU03k4+QqWjelA4gvHLE1MFichHm5kBS2PgsLvE//jaQ9x8cSjsv
	LT1dlAGXPvUeeOEyIHiJA+t3I8Gsbsqfai/8AE8BP3sWEhwPVFgus9pBb8Psa2Ya0GM2bFi8HyL
	8fvhc/2gsfW9fUn8GZXqxcvn4v+nM7mQFTCn98qMEPRkXqI2h10mLzOA==
X-Received: by 2002:a17:90b:4ccb:b0:387:e0bb:57f5 with SMTP id 98e67ed59e1d1-38e4b57c2edmr12738677a91.38.1784510664483;
        Sun, 19 Jul 2026 18:24:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:345f:e51b:3d0c:4546])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm26355570c88.1.2026.07.19.18.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:24:23 -0700 (PDT)
Date: Sun, 19 Jul 2026 18:24:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bivash Kumar Singh <bivashraj750@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v4] Input: gunze: replace deprecated APIs and fix warning
 style
Message-ID: <al12MNI0HbNLEi3w@google.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
 <20260719173700.4942-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719173700.4942-1-bivashraj750@gmail.com>

On Sun, Jul 19, 2026 at 11:07:00PM +0530, Bivash Kumar Singh wrote:
> Replace two uses of simple_strtoul() with kstrtoul() as the former
> is deprecated. kstrtoul() requires a NUL-terminated string, so copy
> the packet data into a local buffer and NUL-terminate the X and Y
> fields before parsing. Initialize x and y to 0 so that if parsing
> fails the coordinates fall back to 0 rather than reporting garbage,
> and BTN_TOUCH is always updated regardless of parse result.

Please stop forcing use of kstrtoul() where it is not fit. If you want
to stop using simple_strtoul() then add '\0' when receive '\r' in
gunze_interrupt(), and use

	if (sscanf(gunze->data + 1, "%4u,%4u", &x, &y) != 2) {
		dev_warn_ratelimited(...);
		return;
	}

Thanks.

-- 
Dmitry
