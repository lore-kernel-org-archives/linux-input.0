Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454031283E
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110659; cv=none; b=jepMmXwfLCEtZoUhDmapYDH+GrWP/DmVIRLL947z8524vRLct/gMX9rcH10xTCQMTFJHSEewGbAuQPiq+WTtQlAD7vrGR8E9WZkHBoIomboW8fmMeutZyZ5x8EeswFgN/5udLUk2WTyET/tdivtQPR1N3CGLnpevKFiaPBt7Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110659; c=relaxed/simple;
	bh=mPEW3CnNtHzPk8zBkPy/ywdNcQQvY53+6mol56GVK44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml0tcOO8Y2X1+BXYY9eKmgp79vHaZCGHIU+6ClCkRdujA+7nICKYBgSua98njslhYjFX8pqdaOJxHher5iR/GQXu2DigGlWYRPSNQ2O+2evl7eQ+ViLXHBJDec3FDmj6cDxQV4eiExsWMm50E1ixpNN5qwxbwZ+XOFyeSkWLXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTiz0Mhi; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTiz0Mhi"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13721dfd471so9039413c88.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781110657; x=1781715457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1sXr/vhMEr0lILXdap+oJzs/4So97bK7XSSiLeEKlJo=;
        b=HTiz0Mhi/zOsX8nj/vuEq2BUDuAQxFEoeIX/8AFx3LbtvkcPwc+FP8uC6tZbJm29Gu
         zyqNIUPnUCVmXOIVR7GTvYOP79fKZGU4l7mbOossolip0+DFRGod8PU+K/2xUvvvjBGQ
         G/8bAfmUtlO1RJRs4OGBQt0pFsb4e7MVDQShVJ7yj2HqZ2pGIFp6YYpFnMpAq14aH1Q5
         3jcH87KyqKH4fpn1enVkaffjoGtqs7wx22kqurKHSKXJB//Qaaty4z/m/8ekkc6H9ODm
         9azu8pPhKI8g3u5La7HNr0BA1bpPj9agM+EcurEqGf08cxmRj6GYrVM/zrnWYhBRwFQ4
         NXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781110657; x=1781715457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sXr/vhMEr0lILXdap+oJzs/4So97bK7XSSiLeEKlJo=;
        b=TMGn0u7vxGRqWFXt6gi5C5EaK9cHDkN2s6I/xzYn9x8sIEl8fMxYbfTB5ieet5Xrr8
         DMFIMGsP8wvsJ/B/KaDn+lHd/ArRv6n7qwFuJgRwxUdoufoB2w14C4pnSf58JqAKZZqC
         aiDCVVJRkCI3wEHHDBNndMVJ1NGnALpAAAw4t3nERP79PXIG/cTT69Sy3LO2shmeFew9
         u3xpOV/ySMmqYhGq0J8GNzi2LFz88x3eItWWU3xl/06ny+sSM6bRAdv67Jmt+8lA8P0Z
         arfr6e8ItFCa8qqOF22kuYFvb/8LLeJk5Xo7xZheNp7Fy4ByJIVSDXfp7K+2NoyOWHPj
         Y3Ug==
X-Forwarded-Encrypted: i=1; AFNElJ/CbEp8xZvZCXw/0xNA/YkVY+EUcPAwYnwdKg8QxFA71T6wM3i319OchZnr69tYgSaZpcLjQYCwr0NMow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfWvDMHbaCHHapcFlSCDM/V5Cq4M+DTuJGy94xbkffBoqU0Xz
	nCvpevoYgK8CAiW/Smj+DOa2IHe774yc3PTjxwBnX6KDTzeE5/fSjLxZ
X-Gm-Gg: Acq92OFdLzu6o9Yo5XLa0IpEimYn9oIVc4lnbg0F1KRdpHNyAAd0T3VV+dHaskC5L0E
	ZYUVuZWLnuXFSWQcCW8cMW6Q8qAsdlXBWhxgJlotT1qg0nocmMnfrpp1owY/s48DCUD5xtMU9nh
	ST/gouQgIye7/cGwkTFVNwWxCfukUNqjMPaM9MsvsjnNQhtKFsJpbiiPH5caWaU6rbbm326Yqaa
	r7Qu5Nnsa/wo/yPifG25WJLn47RJL8M1XlX6LWHPYRa0haff0/cdbo1vsyNL9K+Ib0GrHH/mdAH
	6VqMinuPDMkxJYqFxRAtqu6atN4PaN9IvLFdx+6f/4Q/oo0Dkzftz4mLjg4aDYd09zV5Fo24ebk
	ZTRvmzgl0ebqvqRR/omixSlrGFbcJngtTF5LJtZ9/4pTzhTE7kMa5WzNDfYjxPnkLtywdr5nQnc
	JBGdmtQct/ACTWW8llPxMnwtrg5FUPybTnFSPR29RUvTkoyQVmwwldJCrrY5/KyhgDKaNZZp2D5
	Ls=
X-Received: by 2002:a05:7022:62a9:b0:136:6883:c4bf with SMTP id a92af1059eb24-138066a56d1mr14354458c88.15.1781110656974;
        Wed, 10 Jun 2026 09:57:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm15151201c88.13.2026.06.10.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:57:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:57:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Kees Cook <kees@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>, 
	Christoffer Sandberg <cs@tuxedo.de>, feng <alec.jiang@gmail.com>, gongqi <550230171hxy@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Input: Drop unused assignments from pnp_device_id
 arrays
Message-ID: <aimXUT-B6SugrVde@google.com>
References: <f987c14dea1d3236d3889e5cf96c01eef6a2445d.1781016727.git.u.kleine-koenig@baylibre.com>
 <aij_gj5W1dylcbrX@google.com>
 <ailQutR_TfyCQ-SP@monoceros>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ailQutR_TfyCQ-SP@monoceros>

On Wed, Jun 10, 2026 at 01:58:17PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello Dmitry,
> 
> On Tue, Jun 09, 2026 at 11:12:49PM -0700, Dmitry Torokhov wrote:
> > On Tue, Jun 09, 2026 at 04:53:25PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > Explicitly assigning .driver_data in drivers that don't use this member
> > > is silly and a bit irritating. Drop these. Also simplify the list
> > > terminator entry to be just empty to match what most other device_id
> > > tables do.
> > > 
> > > There is no changed semantic, not even a change in the compiled result.
> > > 
> > > Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> > > ---
> > >  drivers/input/gameport/ns558.c        | 46 +++++++++++-----------
> > >  drivers/input/serio/i8042-acpipnpio.h | 56 +++++++++++++--------------
> > >  2 files changed, 51 insertions(+), 51 deletions(-)
> > > 
> > > diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
> > > index fdece6ec1df3..f70a96c4f1fd 100644
> > > --- a/drivers/input/gameport/ns558.c
> > > +++ b/drivers/input/gameport/ns558.c
> > > @@ -148,29 +148,29 @@ static int ns558_isa_probe(int io)
> > >  #ifdef CONFIG_PNP
> > >  
> > >  static const struct pnp_device_id pnp_devids[] = {
> > > -   [...]
> > > -	{ .id = "", },
> > > +   [...]
> > > +	{ }
> > 
> > This goes BOOOM! You have to keep empty .id string as terminator.
> 
> How so? Given that my patch doesn't modify the resulting ns558.o I doubt
> that. If .id was a char *, I'd agree, but it's a char[], so there should
> be no difference (and the compiler agrees).

Sorry, brain fart on my part.

Applied, thank you.

-- 
Dmitry
