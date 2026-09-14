Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB71A9FB7
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348738; cv=none; b=DYmvnwlhp/lmS3hR0vCdmaP4mFDP0O/l+bovhRXOgTvRVd8Jlu1lXzsYcfc0dYu/iUo0B5rXyd8q2RjbbHf9EQoxDgFpvj14SiBDoIe6vXhihvhI1irxpCSsyRxx9UNoCwFmnfdobJcaPQhLSBVRny5Ee8LHsgt/3H0KuFGPSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348738; c=relaxed/simple;
	bh=S4Czo7uLaPCl+8Nwr7deQ8dkI3BVQlUw88tCxmvRZTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJVpDIrtXu22WdhmKkIhDEvkpR2VJjokVlIswscDt0u9jtOP8IjkNBpM5yYZiYHTpmf4lqAyfqbIl+WvyS384P8/AaTNh/edrxF084BdLy8Aodlcdf6nAxm7A3Ls++R/3iD6+V8ErfQ2Nhml5rqPF3BiBaaHbIDXPcjT11wwuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhfNdJNV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhfNdJNV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2399814a91.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789348736; x=1789953536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqBxOmWaZHPQ+R4D4QAtlbH6s7C0J46+dx/pSHVm80g=;
        b=AhfNdJNVxskwNNjV+9DBSX2Xb5S4eEQ4yYtYf6oqMQ3VlFryBFwscQXXnJhTO5DYRu
         etq1aibtr53xcGl4X1uohRfzc0KdTrXOS3YufXtIgQvMbjy39gfEkC8F7dDhrhzLvLEa
         lpYwxKfPlpilHmeRfO1t78jnh5/Bx9Z4glSf6fYRwV/kSgv1tvt+V9/mgz+2bdYL3Z5+
         d5F+62SR1acQ2UXw5jJU6kP2ZBORV6ofPXbSAkN1yXcwfWqBfYvZ50Xket2nCz5TTfgh
         wwnByeGuVHdvMjBN+fSP9eB4M8Gsl2HP8B6OFYeHgjBEdojkQBmJRFH7DGIjr0TgzEAb
         fO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348736; x=1789953536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqBxOmWaZHPQ+R4D4QAtlbH6s7C0J46+dx/pSHVm80g=;
        b=a5WTD9+FZ/P96VsWZgXB8YFFMENEX9U0cyZFTrasx5zoKjL2lEUKfu2K5f2gji8fQn
         qdzv6UUL2TvUdb3kWWwkOYRa1Ux6tnRveIlMcwYnv076ERwbcmCbOFFXmgvmF/26JYSj
         Zh/2bV93TQxTYCuUDHH2C2mJP/lDml1TGdb5VWz3JUX0PH83DtbdX96QTfcEbPXt1R3j
         xdpYF3vrsKOufpVQua3YmBaHHJWPyx328NmZZt9vO8QQgfO91EsILdVESri2zvP+cbMV
         kCDqKfmeOJkKKc0Gx530nRWQ6vjdmd7HaMQaLfcAnah9otHWlzcbLiJQ9J2N2z5B/Wc1
         IoPQ==
X-Gm-Message-State: AFuF++nmoNTpjeoTDnfa5fyOiUIaxo3fiD8h0GPD2GyfF3HbWuMyOcO+
	3BIVL9XNmEU2osdxKG0yRZ+nYbEOIVhxetgTl/M/AXoomO0NlO9wps38
X-Gm-Gg: AYBFou3lQVU6g+JJf0rUe1wNRU/fJzAxmta9PvhfK6EDwdW7Ar0Kt2miqDwz2SbjkW0
	IFDh/tbuL33G+2fBqaruLCsRRwsb7gdn48n5j9k9DVWBzZxMho9D70SlLf9NXqErgfmsbGNTzIf
	OFuJiP8qBNJ7OIRkthOKjZJ/KqXJX4YBB9s5g48xMVFLruWhqmkSKsP2mhAXRgcYg72ZSbZaxz9
	QZ0of8rzEjVgc9mNiHKljsBZHx0V1BbPKN3/SzjAlfI5tgQle7eD9n09LxZKeNmYdmxvMI5tFQM
	MGrVQ8OvX6FMqlppEaww1p/EH+2BcALJEt1lVS064Av5MM9Nwm9BBldjD9rYVTKTVEZksQcZY1G
	UjS1q/kV/ByeJVQkvBxslHcEWgS1s99IxBb5v7vkILb+eI2c4lHNhPHKo1afrDOSYjrIr+s3pbs
	Enmwe8qS9tDlz9LVlkq1hXc56NjuwWruzbekLJdIKDVEFxZVsTIqulKLf+76SvLcQWrG9uJROpc
	9EBxfOzBfFXao7FrXRSbCHfblgcXiNHIuAPpUg+EPZrDPkMGs45
X-Received: by 2002:a17:90b:2e0e:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-39dec056382mr1000824a91.16.1789348736340;
        Sun, 13 Sep 2026 18:18:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed295esm25517357eec.15.2026.09.13.18.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:18:54 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:18:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] Input: tsc2007 - Read "ti,poll-period" as u32
Message-ID: <aqdLRrHQv6GdBTW9@google.com>
References: <20260831194352.1185860-1-robh@kernel.org>
 <apXaYJhFnC0UCHb0@google.com>
 <20260831231829.GA1244140-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831231829.GA1244140-robh@kernel.org>

On Mon, Aug 31, 2026 at 06:18:29PM -0500, Rob Herring wrote:
> On Mon, Aug 31, 2026 at 12:51:44PM -0700, Dmitry Torokhov wrote:
> > Hi Rob,
> > 
> > On Mon, Aug 31, 2026 at 02:43:51PM -0500, Rob Herring (Arm) wrote:
> > > The "ti,poll-period" property is documented as a normal uint32 cell.
> > > The driver used a u64 helper, which makes the helper type disagree with
> > > the schema even though the stored value is still small.
> > > 
> > > Read "ti,poll-period" with the u32 helper matching the documented DT
> > > cell size.
> > > 
> > > Assisted-by: Codex:gpt-5-5
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  drivers/input/touchscreen/tsc2007_core.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> > > index e4d7da0f4434..e2f49b37e18c 100644
> > > --- a/drivers/input/touchscreen/tsc2007_core.c
> > > +++ b/drivers/input/touchscreen/tsc2007_core.c
> > > @@ -221,7 +221,6 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
> > >  static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
> > >  {
> > >  	u32 val32;
> > > -	u64 val64;
> > >  
> > >  	if (!device_property_read_u32(dev, "ti,max-rt", &val32))
> > >  		ts->max_rt = val32;
> > > @@ -237,8 +236,8 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
> > >  	if (!device_property_read_u32(dev, "ti,fuzzz", &val32))
> > >  		ts->fuzzz = val32;
> > >  
> > > -	if (!device_property_read_u64(dev, "ti,poll-period", &val64))
> > > -		ts->poll_period = msecs_to_jiffies(val64);
> > > +	if (!device_property_read_u32(dev, "ti,poll-period", &val32))
> > 
> > Do we need to handle -EOVERFLOW and keep compatibility with device trees
> > that used /64/ to match driver implementation? Or we expect that there
> > were/are none?
> 
> I suspect there aren't any users. Nothing upstream for sure and there 
> never was. We could probably just delete the property.

Applied, thank you.

-- 
Dmitry
