Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AA2D9ED1
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944091; cv=none; b=Gek4upfNHHCg4d4/3v+cvBKRW99P/Q4d4LcB7mWlxfCJiFFrEvGhywDQEscxqLxe9IL2bMF2GNXOT7R1v8ANJjTth6gZ5Yx/zwRb6zOQf0/l4uAH+ofO9hw7z/Kpnv6reNk12PfyVVL1lpOtDSW6ckoVvRALfW1A/BJs5pcOFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944091; c=relaxed/simple;
	bh=AXyI23fZZwh2b8vPdu0KkQJ+N/kw5xuHTiLpI2hv7gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFXtQAD6iEViKRSpOBSctOXPrCCOq6I+EFQPuA3xzdi0ha8BGR3LeusyZPW0mLOXBth3F19KzBRAVrGp6+L9l77q1qkxt6DtHa/6ss1FrWR8sQVYiZR9o5L42a64zE+Ej0VAPnhzh64za8VhI1shr1X2sK00T6soF7hwUZYDH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1GZMCtg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1GZMCtg"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1021121a91.3
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784944090; x=1785548890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bj2mlpOx/UfegPR8kA/h6tXZ0F3qUGEeJSQD1+N/Uj8=;
        b=V1GZMCtgsX/dbQlcWLt3Bi+sZSzPPpIVsoJ0xuamouPepW36UMwsehkHNqJt3h91Y3
         iyM9UeAlWiyXY1YQG/eaZLW1vK7OyVAqXkhGgtt9Et10WMuGAxJnr11ZRik722aHAG2/
         ZUQcOEL3i6Q79M89+KgsNE14cCLNBE/Ms0bfcx2sbSHGjXGDWoUbbA+vSTMfpHuO9JaI
         m7oHWDnksTCDtvVpE5KmxMCLxLrkfFHjcLYPHd9vawqu+YtwRCutddu3FkfOFH0wWKNs
         k7IcmXcD96yyUIcHl7uXNqrNkrTCH4wDRE8UeuLo/WtWcIZsh8iuCiShF0HiCffur+pN
         YTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784944090; x=1785548890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bj2mlpOx/UfegPR8kA/h6tXZ0F3qUGEeJSQD1+N/Uj8=;
        b=SMpZAy6WJDKsPG81uH2wFQZFcquGhp7d/4URbbgBCx7tsfwoLg7n3yR1R+bqXmJTJt
         p6H9sMVJ2SsBDkcBZz2mQIyN4qWciD5uTMIXEbb/aVXWKPScerjP0aikPjOyUVhhmvnX
         CtpYQaV7bZcEqNii9PZfyfjuoCUQDKQb23HJKubcjZi3oK/rkyD1eovnN6tzGHdNMPu5
         /GJFEH5bl2prBrMNuqVzuxcifqR/JIghWkuO+ND50+IOAyI0P+Ly9bRkPAVSSTgcKwXk
         JWwMXiXRX0kZQLSBQhwaLFcKpaBx4Z0hkjgSYnfbyEICBgYZuAOOdm8RCyEJ3wg8Kda1
         Ml8g==
X-Gm-Message-State: AOJu0Yyuer1yBDSlT8U7U3IYtUfrMkR/rPKABEgraoYNYnB1XxRwnRls
	dQCIEsPQYJ0bC2RVDnOUA+zH58ZzsMwGIiE31HtXeq1YjUim2r9s42sX
X-Gm-Gg: AR+sD13tPMAOtwrXr8Ku8UU0Jjhcrsy9d1DqZAlgKArDKM08tjhcusPgQSWfBYhm28w
	FqXcPFj7ZCAnwgQjJNVgUKYb4nsdRzQQqgBTKuZS9M/sOOgr/bEbdO/ToQK3UK8luJ9m/Kq4EaG
	FPwtU+hU38toLj2XrhAJ7ulkdVCwRhmAyyxQChM/CPwcBr0abnGZJhx5KTE0taWLFe9e0uUw1ci
	/pIMu1zCb7w+dJVSFRVYzYYyxRM727ETHTKCqbW55wRgd0tYc1ynE16CCj4JQRJY5Aumfoj5++B
	gYWjvENObt7ge0i+5AZtjXiZZ7jp/7AUwEsOyOnyPFAz5tY2sdDW99cVpXJnCwceH5M2vVRBNmi
	P7ng/zw9eMRLV2nLy9CztM27OPa9EFsaHAJ9AfP4DydZjZEFJ1HkwshtOPRKqMw/yoVM9R112O9
	JMjSNxZCjf3uw7j+VSvnuxneYwlpmDMXWCTuw7ZfIyl78=
X-Received: by 2002:a17:90b:4f8b:b0:38e:7eb:d07b with SMTP id 98e67ed59e1d1-38f2975c750mr691423a91.34.1784944089616;
        Fri, 24 Jul 2026 18:48:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm50914983c88.2.2026.07.24.18.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:48:08 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:48:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
Message-ID: <amQVsmuy3cgm-i5M@google.com>
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
 <20260720090851.230244-2-phucduc.bui@gmail.com>
 <al5V0Ym6zCGqPqJI@google.com>
 <CAABR9nGCv3J0cZCb8MYVYXby6HZhoMbpfKdsNeTxFJS3dzuNwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nGCv3J0cZCb8MYVYXby6HZhoMbpfKdsNeTxFJS3dzuNwA@mail.gmail.com>

On Tue, Jul 21, 2026 at 09:20:30AM +0700, Bui Duc Phuc wrote:
> Hi Dmitry,
> 
> Thank you for your feedback.
> 
> > > Use dev_err_probe() for devm_clk_get() so deferred probe errors are
> > > handled correctly.
> >
> > Same here: in what way the does existing code handle deferred probe
> > incorrectly?
> >
> This is the same case as the previous patch. The current code uses dev_err(),
> which logs an error message even when devm_clk_get() returns -EPROBE_DEFER.
> Since the probe will be retried later, this leads to unnecessary log spam.
> Link to previous discussion for reference:
> https://lore.kernel.org/all/CAABR9nHHe1AzWmqhV0d5p87qfSsBk2O7bYj-Weowyr=99wtNNA@mail.gmail.com/
> 
> Would you like me to send a v3 updating the commit message to be clearer,
> such as: "Use dev_err_probe() for devm_clk_get() to prevent log spam
> when probe returns -EPROBE_DEFER.""
> or keep the current patch as is?

Yes, please, since the handling of deferrals was not broken. We just had
some harmless extra logging.

Thanks.

-- 
Dmitry
