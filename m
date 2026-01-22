Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9A2DEA61
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087408; cv=none; b=m9dFuEITcS4O3jhDRsqIyA41Y5Di2FMSYYQ32yEFwHWE3YR6KjhrCbpCFfTh2qXp1cSGwFhY4vhu7wAT5FMWVjFsPmzk0q6TmS0p46cGa4O38J9UX+Opdtdo3G2HQiPz07O/1iHvUGajkAimxUu5cFETd5HqDh/HQY2kDZTAQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087408; c=relaxed/simple;
	bh=yrhDq1FKTFkwWit5tdCS3E1v5g1V/whLfFj0w+I9B64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUl0amNTsa7WhStlLrDniBUryzEz48/OMSSoQ9r+fSsyTUqvI7fz4R9Lr3KDs+SJGKeM8fgo2GtqeARIg2ThbCsfbN6hZWaHuqhWOzjubn9jnuc0XDsfw/ME3HGNAGvWGlUcuMLZwJCwEGSNq2qx6LvaNAw810muViofLtdWAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejchuTdN; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejchuTdN"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56352466d86so349420e0c.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769087405; x=1769692205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOJbmAqeybZjyx2TKIYAL6AqeWnXA5ugxQdeE7j7WVY=;
        b=ejchuTdNkYjnSYFuOshxnkusqr0Y5i4NinHSui0LkjzggYn1XLc/THUdfq960QAcU0
         TZF17xJdWtxx40PAZkmdfGmNZ4QEreKMWXXNtv6gXSCjeWO42CLhstgJY7drD8k8p6QT
         I33miznqt5ECuxz6dxA915WZ2z0rckUOj2up6+mBwxZr+jv8m3tU/5G4+RXZXLkuiCl1
         BnlrIIG30NdNitTjPYCD9nEuftk+5D0QBkNh35cCXX4nVgo7FbXCPJVyg4ojKlvt0Wo/
         hSWpKyWWH/igUIYXh/qLrj7hVBiZHXscThAqdUdNoNxxkjhrCY9k+4s3On7m4QxNz50r
         b/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769087405; x=1769692205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOJbmAqeybZjyx2TKIYAL6AqeWnXA5ugxQdeE7j7WVY=;
        b=iGYXgX9dgZz60PTg9r5K8tYfmk+YJV3kpv8jn+HESQvrOlbec3nXV2k1ZlUl2e5I8E
         Xvigx2XOccBnNdITr/fRiZhNP4/Iatew31ej/4VRy0Q5mYe92H2o2GKtrcFHLwn0sJgk
         5wmRpGmj4DXCurPReW5Fizvx6krTac44z8koEpm1aURlTlEw4OgSY2wBD3zu+qA3S9he
         QW0SPiyOy9C7bhBAirDA0Nif1xnnVaL1+g4AO44rEMd8XGvMgUwZenUzrBWCS8zP0y0s
         hIbm2bjBvrbof8Q8ATW/MxCxMzpxk1tVQ+higTllud6LOPuHLqjWgT+M5bnFEcUoXnRa
         DOdA==
X-Forwarded-Encrypted: i=1; AJvYcCUl0C5rcTXJteGgilMvEG8sYtHo7buefTBPpJw+CDysLDKPlVOen2IlFMc6dCs+z520GqAX8TRcdAvj0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRITdzHMXvR/nIcxQweGwoKHxdalOIJ/q1JWE136CjB1g+X3D
	C7euIkHlD6JrfREuixyGYpfMH3W0PXezAlWT4qdv0n+Vf87Kb8vIw2a9
X-Gm-Gg: AZuq6aK1z7ipU1h7gXIDkPwTis9j7jjCz4ptiMPr0/QELJEkqABB/u0BBbw3ekE3ijd
	DMtfcvjQpI3P0R4S6gWdUY6l1CoCSu3K53tJH1momujhkza64Z+hlZpapLWVSt40rZ7koG7M0sn
	rlyRv8IXeQVAVmcVlglxwmMLJjvJ9Pre8m7xz1BNGyuD5zJD0TSK/OjC4QddU5Y4BRx68bXGb5D
	VFa3vMnohEYpT691QYAUshkHisM6jdnRoGZz9PFrDnQcjaHrwSMHkQIVKFBMWXE18j19SlIa1Eo
	6zC81S2V5GztvQkrETrxXp9ps/T6YzSGPjjiCNbizRpmKDISdtpfYO8tdDBPY0f3vZhnPrMOmJb
	cBAxds2xBri6oZSuaTE85PftNCiMp9Sl04hJaKgFwRI3B7mg5J2GjZLFX0hdfOFDJqs/jhvda2Y
	1XcfMyk6G/3Xs=
X-Received: by 2002:a05:6122:311f:b0:55f:c6c9:e4ba with SMTP id 71dfb90a1353d-563b5c43481mr5674295e0c.13.1769087405368;
        Thu, 22 Jan 2026 05:10:05 -0800 (PST)
Received: from sam-fedora ([2605:b100:535:a12c:3f00:2b8a:86ec:9cc])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b70e516fsm4487884e0c.13.2026.01.22.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 05:10:03 -0800 (PST)
Date: Thu, 22 Jan 2026 08:09:59 -0500
From: Samuel Kayode <samkay014@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>, imx@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Input: pf1550 - Remove "defined but unused" warning
Message-ID: <aXIhp_c0zjS9dfWQ@sam-fedora>
References: <20251210211149.543928-1-vaibhavgupta40@gmail.com>
 <wfdhjzhkggp26mwqgvxuanuzjq6v2g4pmc44jz6kx4xwkewwhr@movikefnuvcz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wfdhjzhkggp26mwqgvxuanuzjq6v2g4pmc44jz6kx4xwkewwhr@movikefnuvcz>

On Sat, Dec 13, 2025 at 01:38:57AM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 10, 2025 at 09:11:41PM +0000, Vaibhav Gupta wrote:
> > If 'CONFIG_PM_SLEEP' is not set, compiler throws warning for *suspend() and
> > *resume() function for this driver. Using new 'DEFINE_SIMPLE_DEV_PM_OPS'
> > fixes it.
> > 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> Applied, thank you.
> 
I think this patch was dropped.

Thanks,
Sam
