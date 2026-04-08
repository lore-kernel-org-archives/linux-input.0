Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C63624B0
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673419; cv=none; b=Ee1z0zwzsW3US0DLUoERDdF8w7+Bckuw5O2R2fL99UrbtVCZ5rXc4eE2r2kth5iE6zYEGS27TAsSt4GXFAhyobnNnYuFHRzU1CbCZJnktctba9IOF27efjhLVB4Fe2EGmYjOgvrB+6SBGbUZKe584bhY1XvC8j1B/x6ASkuaWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673419; c=relaxed/simple;
	bh=W8QG6v4YVpjutuslb8+RqIsE3hZUYeq5LedpBI5iww8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao6tqNIs91ayYsvHSqE5o5K79hhRG6XAWcq/L4QLjINifn3+57wh7Yw+PkpFa6sMV2ZEcDFdT+rf2hduSdrKdu8WCzoRoyFPGPFmA3nbmdcWLwFv516dCbEbNZ7p3Cy3nr3N/AuvqjYWjpzGlBk3NfeGm6UFWS5fkWobqe8hpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIt+oPoE; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIt+oPoE"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76bc3e8de3so49222a12.2
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775673418; x=1776278218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmHgdAG7IFH0XG56/s4FKP3nrKHnj+wgIcVKXbdVdsE=;
        b=KIt+oPoEhKaUzZnstzc3HBjIdFkwitc/cPpMeW1+z9mCiK/DVK0Nd6+e2z1iMOFkoO
         YYN/dLBD8Ze87dW7TgiHUt/CtK2878psEGU0BmDM/05rc8QNz6P4ZAfPqOcn5/petMrB
         UqEAOC0D5qYr4uQxBrDZq4X0NjPzyYf6Ihg86ZvZnFf5GxAcSssciy6SNzh4IL/b0KqM
         PbZA9rm/ml/cy0WKGxQpSppoZpddzRmC1ftgAK89d8ckg2V2gOuchzgMZ9r67t5iswSw
         39Fj/G3m2+hiNVSdmvmcX10OR8m2pIIyvuSgZ9nedOLcNpe4zXFfaAfGC9mkw7MosHAx
         XVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673418; x=1776278218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmHgdAG7IFH0XG56/s4FKP3nrKHnj+wgIcVKXbdVdsE=;
        b=qdCmA3P+TqJbBsgSB8vQZPX1xhVxx6QKPdHis4a0V3kK+EVy9rVobPbyqpICTVdrHv
         Jc5nHVozI142mHHU7KJ1v5amO3nO6+1/ijviXpSU5p93JFO54yYmpK/tWRp4Rr5WQzsu
         wgcBB5ys8WYcwT2K6odDifblCMqfM2ZoHqa6rQNL5VGzaKWmDWCOxoTvaI7cz4JbUsCk
         RY69rHkHwf0KO2RvvqkbPvJXQdhGvZSg1GEx8MYtFYnm/FVj2ZNGfxbpSEYFRGj+kEaQ
         8vX+cjEUHwiPSYRlb8az9v2JnmATWNvrQhuXsbPaEyLbz+DeYKWE2PHmiTSkYtZdBf8U
         5Q+w==
X-Forwarded-Encrypted: i=1; AJvYcCVEkRdIGVI1E9dljHwaxFwgJKhdNQwrrdEs9SJEO8xqQaA/7Velaxb3bRPc8BOGUtKIjoXCKd56QDsJFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qZjimvjR1naX0Frcqy7PGwCTTXpTsct5IurZ8ylGB+jwKID2
	f3DefYPob39ZZAMEal5DDH1ER3Y1EgVU6zLDAfDH1xKvMiIfDqx4vlEJ
X-Gm-Gg: AeBDietwTHS1bNJEp3Vf6KFWkWU1t01O+/8tFnNTxhQ9bzD1eVx9a48NZ+BOtaDvS9H
	K/NWy3tKga0c8NvJgHQr/PZICNc8C20xNk7IgDEGpbUQP5Xcvv4mYrrIxuL7jDjo+HcJuBXrCUS
	Bxv4YS6fc2Le51f/R5vTGv+GE3MqkjE3y+oFeiLnXdxIpA6SZ4BBCuBnIySoWHNBnU9Ldvgipf9
	5gr5GsTWqDuUE3Li9Doi3DHCHa9bzNaXB4sIdfQz95JdOBdtj+5cSglaAKeB8eVrWdJKcKq3lQZ
	p92ig8Ae0f2VRM1Q8zQdW/2Zeu/NhW0V+f9ifOUl5vmAXavuaX25TqKnQu30yFf+s+a0U5444wj
	7M36xsg//F30wV7Y0ByaoUr+DTLbNfYVHzUck0L6EawOOGn9PeoASChUvfK9HglmPtxBXOpB7CW
	6QNrPIWL/LsXsH7ehyKEG7I+WLcAhakPvFQuXk4wxU4DXKL5r5J4Hyomm57KRKlgY8
X-Received: by 2002:a05:7022:784:b0:128:d51a:5161 with SMTP id a92af1059eb24-12bfb76020cmr11560232c88.27.1775673417664;
        Wed, 08 Apr 2026 11:36:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm20588627c88.2.2026.04.08.11.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:36:57 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:36:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: serio - fix O(n^2) complexity in
 serio_unregister_driver()
Message-ID: <adafVyEzfIUKsMgT@google.com>
References: <20260408162849.4639-1-raizudeen.kerneldev@gmail.com>
 <adaJ1MJ-Rg9qeeyr@google.com>
 <CABkOv5cU8D8oo8scTOojvJ8hUeq4nxm6GGuA3GaBvebzdMBYpg@mail.gmail.com>
 <adaWU9rlMKcxLO1G@google.com>
 <adacRNjPg2ChJjAn@raizudeen>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adacRNjPg2ChJjAn@raizudeen>

On Wed, Apr 08, 2026 at 11:49:48PM +0530, Mohamad Raizudeen wrote:
> On Wed, Apr 08, 2026 at 10:56:26AM -0700, Dmitry Torokhov wrote:
> > On Wed, Apr 08, 2026 at 11:21:30PM +0530, Mohamad Raizudeen wrote:
> > > Hi Dmitry,
> > 
> > Please do not top-post.
> > 
> > > 
> > > *We do not have such setups at the moment, but what about parent's parent's
> > > parent?*
> > > You are right. Even though we don't have such setups today, let me explain
> > > why the patch works for arbitrary depth.
> > > 
> > > If we have three ports linked like A->B->C (A is top, B is child of A, C is
> > > child of B) and all use the same driver.
> > 
> > What happens if B uses different driver from A?
> > 
> > > 
> > > C sees its parent B is using the same driver, skip C
> > > B sees its parent A is using the same driver, skip B
> > > A has no parent using the same driver, collect A
> > > 
> > > When we disconnect A, it automatically destroys B and C. So all ports are
> > > cleaned up. The logic works for any number of levels.
> > > 
> > > * Could you explain more about the use-after-free scenario?*
> > > If we collected both A and B, disconnecting A would free B. Then when we
> > > try to process B from the list, we would use memory that is already freed
> > > that leads to crash. My patch avoids this by never collecting a port whose
> > > parent is also using the same driver.
> > 
> > But currently we restart scanning the list, so there won't be any stale
> > entries. How would we end up with touching freed memory?
> > 
> > Thanks.
> > 
> > -- 
> > Dmitry
>

> Thank you for your careful review and for pointing out the mixed
> driver nestingscenario (A bound to driver X, B bound to driver Y, C
> bound to driver X). I completely missed that case. You are right my My
> patch would collect both A and C, then disconnecting A would detroy B
> and C, leading to a use-after-free when C is later processed from the
> temporary list. The original goto approach handles this correctly by
> restarting the scan. 
> 
> I am sorry for sending a flawed patch. I will withdraw it.
> 
> I will try to deisign a better solution that works for all cases,
> includes mixed driver nesting, before submitting again.

Appreciate you looking at the code but I do not think that particular
area needs addressing.

If you would like to improve the subsystem I would recommend you look
into making serio rely on the asynchronous driver probing, removing
custom handling of async port registration. This would allow
serio_register_port() to return errors and clean up bunch of things.

This will complicate attempt to synchronously switch serio protocols,
but I am willing to let go of that feature as I do not think anyone is
actually using this.

Thanks.

-- 
Dmitry
