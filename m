Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08886369D66
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007609; cv=none; b=I92EDzSHX6EJfxhio/GgRzpLtuopCjdNDr23y0wGcjmisXnQj2ndeqcPI8wHzdajUa21n1Z6+3BR1Uh/tXUBiqjzjpXq5CMe3BTB8u+067ZtcgFqfOXfvkTXAUbj6pY7P4G6Zj6ITc7oj+cBop39w+5pdq3A9oOitbpWY4Tuiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007609; c=relaxed/simple;
	bh=YsokBT9eFCV3CfHCgmNaqagx+Bh1+qcugK+hkEsl6As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOWOLxNQRHvArWJ7ZyOqKKP+7Mu9JNkItELDx3Avh7LfxCSMYsX6DiOR6tM78+3/x8/i7Es+B21ikjy/6WSAyvg7AuNZ6/qZ//bVx1DrpfTsfLuY/76+K2iAGDfnvxiDkzAP8sf6Lb2Jt/qMlzciLrsfHtgfdnmhcYfLAmpyQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFLWy/0n; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFLWy/0n"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so2874874a91.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790007607; x=1790612407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lng9J8cl9n0YFW5Bwkq4qc0T7LpY93jg7ENgMgRtrQQ=;
        b=CFLWy/0nIV3G+FcbfhLtuoZ2jBmCyctkdbOsz8rq49om69I+3xQAsUDy31SO+NiAo5
         Luggx0tfenoX9OS2J7IcnQ+bdfZ4A5CWmDimVs+4KxW9YhmkrlZFpGa56G02QsAdv2tr
         jJAvH7QYU3fuP7YgsXNRX03iNugkYjj8ZdoWUdUEMrQZg9aZFz2WUJkGl4ni+RCnuncW
         fbhPDf3zyStLJ0uvcaWBS48PFwNvPyKmiyaGTwf2N+6XR+ze91bZSVcynJTk/ZR+D+/7
         0IEhJPJuR7qlNU8TbhWRtDCEqhzJLnEj1aanOV0V5gPKr36DbgM5sJ7jQr/YQhNplD3Z
         yCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007607; x=1790612407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lng9J8cl9n0YFW5Bwkq4qc0T7LpY93jg7ENgMgRtrQQ=;
        b=vcf9jPOPl9MhLOIKcV24ts4GdyVYPjRv0ww/Yj5xYe2DlR2bcyv6SrwtTigJ01ypwY
         SEM6JCf3uCBPoAWLA4SX9PaIi34wacawDVKLGkeVqJ2+UAh7rFFseFAkdSkKckwUg2FT
         DsIf6ysrfBLXdfcmhuHCehEtb+VIybc7wmE7qhSxhYZuj5lITWqfcy5E+5otDOmbptts
         nbx6So79Yfk63wxnrxQ2z7wqEoq11TvG3XDr/V1oxGqr5kBIlpJ7Y2jk5VpXTc77QWFN
         6x0EY40I7PcrmYM/RmlfshKq16AMJJPiAlvw/YhGPBW4woA4cc2Eq2vpofeFSRmgKAjj
         H2WQ==
X-Gm-Message-State: AFuF++nCPQyztscscM4VVzL035MQ+a0a8y98OYhnXQuh0goUk+pBdUgC
	thbzIiI8ekwICn+mlYMOGm94m1S/sUnJ2Jq8XmoP700ntILxlfX/xlGl
X-Gm-Gg: AYBFou2a+3Msea6V/oeShirNLeT2ZXxlFMid+5wxNLTpMoKPqF/AA8FcEr8yQ6juVUn
	drHFHlHGDZJtMaW+ACbPVUd6gpI7a1FIZycXzEUXaYwmEVzjzfwYpEICl5s27Qvqz/ZKi+xUm6+
	Qq4FPdqOSvs7JcNxn/EzKMKPlufHujHGMpIVy3K4AIr0E5vQhIzpqVZKec7kGfR0qUg2WnovOku
	MJdLBLKtFZL5FyH9DECV5fZnWtnOqrKqwEaXc1gVBuGOHA+QH682AliIU0VImy3H+HE+bBIs+i7
	2FowpNkIdnH5z0tSljcbAmkzMLofmQCyarUCgPMGEdcMjpq/+zMewSVidjeIeHgdXMUxKO45nGT
	6PCXSchydq9kWaGCcgPK1ze34CUEceLPsM+vUVFQolaKfQDraZIELVmZP4L/vyMhOfqmR26VVZ7
	4wF/HdG9pblV42rsw0SJgTPPeHokjvRq8ExtFFB4e3sApEY8JRglnl/42tKVruxUQ3TXbyA86HA
	Wxbp3tSncWWSiU0IJE5luVUppdX6Qmzf5MlclDZOj2L50tlLtIr
X-Received: by 2002:a17:90b:3ec7:b0:39e:6c6a:4b65 with SMTP id 98e67ed59e1d1-39e6c6a5463mr10817094a91.47.1790007607182;
        Mon, 21 Sep 2026 09:20:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e1a7:4f7b:11d4:34fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0320b6ad5sm4352436a91.0.2026.09.21.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:20:06 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:20:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: linux-input@vger.kernel.org
Subject: Re: Double tap to wake optionality
Message-ID: <arFYaZ-bXFMt2rlu@google.com>
References: <4f9e942c-823e-4ab1-81ed-184b5f8388d6@ixit.cz>
 <aqcxlFLHh3V5vQvt@google.com>
 <2e1d1610-1d16-434d-82aa-54289ffd0eb1@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1d1610-1d16-434d-82aa-54289ffd0eb1@ixit.cz>

On Mon, Sep 21, 2026 at 01:19:15PM +0200, David Heidelberg wrote:
> P.S. There was some discussion in the ML about letting panel blank and
> toucscreehn interact, but I cannot find it.
> 
> Having the handling of the panel off -> TS autosuspend workflow in the
> kernel would be pretty nice.

I think this is the "follower" model - a touch controller integrated
into a panel that is being powered down together with it. There was a
patchset [1] in the last couple of weeks but I have not had a chance to
look at it yet...

[1] https://lore.kernel.org/all/20260911133234.736A21F000FF@smtp.kernel.org/

Thanks.

-- 
Dmitry
