Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817313328FD
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060537; cv=none; b=Y5HJR5YPsgGusDK2lCXHbpb4t7vAtDvYmtrQpTL+MzyVPF6GqNnZTmN+dJZWYdasWUDNuDi55EjAT5n/UgS7aVtKoAYwjx6CeUMQxFIP+DQTR1PDpAITu/oUWyqtJAZ/aa0azBedxDRHj2/245oFxevfZsBAIjSulxvm/bNgrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060537; c=relaxed/simple;
	bh=eEznR8syPkJOrRU/GYCTPgqrI5JczG8KDcC89fQ8tA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI3rVrOi9XT3YReQ3mlA8yq878EFN1YyW8T++dIOWXuWpT3ZllMKRoKaO47Asa4YUhHaa8/0DdxP5E2fPsfXoVpt4KpSoqG+Cb+b99p4LDgjTPXQ3e9Sa3o/2K6eY8WmCuah8oo+RdYvg35np8X3wfEjWhyUw/qUCf4Z3eJaq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pttmuz35; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pttmuz35"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128b9b7e3edso5289721c88.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060536; x=1775665336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+yQCMr4xhDbSLOpznXHVtBGjZR5IN7E32vmlNU3HZAU=;
        b=pttmuz35t+WSPGc0FnOnmWXe7x3enLVmZ2qukvgt5c2+D000nxHBCe7nS72joPOBvs
         rrJsUOuILTsf5a5Pd3DFjFy+7U7iimqObBOe2n7VEovGZfYwbbA6RCSyITuq1XJx+LeX
         BcUR3E4Nr2uDOTfDmyePjxIGxBhftUbj/ucIJh+X0bFu3SuoU6eA8MZYFy40B2+Gqdc0
         kRy4/BdCwSl59ORhNK9AdYLCUE3xQPXf062+ipyHtVo25JhVX2GkVc7mn4giT/fxibs1
         xpV/Qdu67ZNZQIdCgz+Vol9lgvG937cpwH4VtSxcBlbOVrZmhi+97YX3dTXwD/yeBtOV
         k7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060536; x=1775665336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yQCMr4xhDbSLOpznXHVtBGjZR5IN7E32vmlNU3HZAU=;
        b=Bdz2m4LM0cZpA3kuYwp42NAtEv4Trxw5Ofys/uAZ2zFFwcNRjmYr9MAs3r7q9N1b7U
         M/hAQBpTJWELkymPYcTOq6A15yCNJqXdOMtNEN2QJKZ7NK6NsvHb+jptMsa50R4h4evY
         1L/jIwOd+Kg96MzSbkbG4qV+vXAmK95FpY79LfgcVXRAhaBl7nobGyfbxf2o9y+rvbXT
         9mijYeBxIc41PcpOnIxVV7kA8gc6NBpbpXnP42AQKszdVmP46QhlREdENREM+Nhfdd6f
         7Sn9n9U4PyHm34rSp28hl29zL6la+oxCtaLYdqSrZLrWBRvnTy+sOVtzSTc9ovVhEgnz
         ih4A==
X-Forwarded-Encrypted: i=1; AJvYcCUag9hiz+1ViQZm2W+BQSEKyiWC1ca2wu1UcqW9YP6y05vfA0ydqJur0sGKKlMlMYIOrqSt/lqLFccjkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtWLOKPsPdQOcY0IO6hCregsAdJo0HNHSR6oJj5l85epz19sz
	lXySB16x2qwFjFq1ZbF78Gt4H+x9cG5Ajmlbrika8jXktr1AlGZWhAZJ
X-Gm-Gg: ATEYQzwSL9+mSp9s2XHrbqukDuQTnQwuzFwiKq3ZLSge7kytzax4BEFcYOCwFHuL7P6
	n+tlw0R+Rs07g5J4/s9hGLIQpGjhed/njjBwGOY/j3ZR93DbO++tBsgjyTKslR3uWPi6r9DvI+Y
	duzQQigWHkGB8PcosSHZuWvoK6df87sUclk4UiOQJa4G/clJ9Ly4G5N8wMBjSYP055wRddZfB9j
	AiEVYI5zhlsHjaCjSOUtXdmOewANeLIiJWR/QgQ96KJC7Am3O3PGgwXoLStIITqtwiQbLHgPf7J
	1epuQgYaqxDrY9SOp0qdSHALEvqVqbJJ9rdOWtvf/4RhNPOwL7ivkB8vsv21/Im+Tir7BptZxh/
	vvLwFEThZQ66wzoQewjMkyzpqrGpQ4GIkz4GIZp0fB9iMOyIw1//RHpMtvDVGBG1kzPx8QIVEXd
	3JbztHvFGSneCHHLni1k+M49baXe1b8z/9bBQY6+G95tL0raw7U0DaV6HS9MI+t3os
X-Received: by 2002:a05:7022:48e:b0:12a:6ab7:3f73 with SMTP id a92af1059eb24-12be62ec33bmr2441593c88.0.1775060535628;
        Wed, 01 Apr 2026 09:22:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5f38:4c97:ec41:caa0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4de78sm240597c88.2.2026.04.01.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:22:14 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:22:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD
 to i8042 quirk table
Message-ID: <ac1FzV9dmb_JDXxo@google.com>
References: <20260223142054.50310-1-wse@tuxedocomputers.com>
 <aZzMe2-4IqzIg3HS@google.com>
 <11135d8c-ef30-410a-a94a-4e11e062c27b@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11135d8c-ef30-410a-a94a-4e11e062c27b@tuxedocomputers.com>

Hi Werner,

On Wed, Apr 01, 2026 at 05:48:20PM +0200, Werner Sembach wrote:
> Hello Dmitry
> 
> Am 23.02.26 um 22:54 schrieb Dmitry Torokhov:
> > On Mon, Feb 23, 2026 at 03:20:45PM +0100, Werner Sembach wrote:
> > > From: Christoffer Sandberg <cs@tuxedo.de>
> > > 
> > > The device occasionally wakes up from suspend with missing input on the
> > > internal keyboard and the following suspend attempt results in an instant
> > > wake-up. The quirks fix both issues for this device.
> > > 
> > > Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > Applied, thank you.
> > 
> May i ask you where it was applied?
> 
> I can only find the former patch https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?id=aed3716db7fff74919cc5775ca3a80c8bb246489
> for the InfinityBook Max 15 and not this one for the InfinityBook Max 16
> (both patches have a nearly identical subject line).

Isn't it this:

https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=5839419cffc7788a356428d321e3ec18055c0286

?

> 
> Also I forgot to add cc stable, if the patch is not yet applied, can you add
> it before?

I added the tags to the commit above (unless it is not the right one,
they all look very similar).

Thanks.

-- 
Dmitry
