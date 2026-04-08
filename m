Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4003D88F7
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672396; cv=none; b=FRe3Z9Wu8a1UJTW4L43MJbSrbtLga+2/4lJ+j/UzoYo11d6YXWmZa9AWpDuI9tApkQqwXE9OITkm2gY3QjMosYz1KHo6YXa1robYgMHCokzWN2KCteoFBXvPYwf2G2b/J+S67gsKmItvQ2C16YHZM6SS/x52AVwO8BWcilUqbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672396; c=relaxed/simple;
	bh=2Ju/ukdHeFdJOK4wCNooq4KsaMzuv1Wqljc2xbtdj+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd0w5UCRzUQ06t6v6qWU3FyESdPKTQRsooIJ4AGDblyyazIl/fRHxQa3uNO+5Hk4cJSxXvK6rd7J379gv7gl3hOuMAofyL/cSBX7dbgJ/S/QzlsdU/r7pFkxDRYGZgrWKd/EZEafgknTJ7NbS+PI3752tXjH2vi9I2Eo6rJazsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp1EBnsB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp1EBnsB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d95017a68so48318a91.3
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672394; x=1776277194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbWIg/vH8cYwEt+dxuazBOhpOULH15nGbf1odlpJ93Y=;
        b=Gp1EBnsB1vw1kGjJMET6d+AIut8wk/aKUzIYJQihNUEue3/anBsh9VlZ+o64X4c19p
         Q+v/jVOYop0QYKHUBUWA1jqPuqkxEAgM6X3Y8QTtx4P3NFaqiJw5G7F+GN+09o1gUUos
         4skTAh1CkPmCDgyvYuC5N0r2p8cuag+gN90S9c64qODcCvPO1UYff53vZJajhXIx4/Zz
         iF95ZRGLrymSyFyIbCII1gtWzgx1HA1oQDAvT8EVeybRsZysQJKvS3whspavDvzG51Gd
         QRO09O6Yl1kTuItZ7tA/NyqMBrlireKC43oQo9wjmgUyVAIfSWUcQFb49i4PS6y8bXrT
         EKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672394; x=1776277194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbWIg/vH8cYwEt+dxuazBOhpOULH15nGbf1odlpJ93Y=;
        b=KNKnzmjZaPcm1o1PafC8UXCo4xRVcpDGXjz03ajx5ukkNOlEBEtlzSxL8oQ2JRMtXp
         rF7GF9IQCvBQ1twZn/IYo8g9yyBU/pEFxpRcWu8R22TzsrBnHuXbs2mMQgXqaXkOK8i2
         m0MLlZ0nsG5PyynKYlQVDMZQvxVUdmjtnulTdCX2gYm3PXi41BB+rpmc+XDfmpHQrKc0
         zVesKg45R/G948ysjerMeFFI/P4KGJXyY5f8de/iowvChGFDYhQuc5/HnFzXxkOfdOUy
         QAGulKol9TB8HoQIPDXC0FhK7n2wz5TNdSNSXI9DaeoTp6wwrdmFt8Un0Vvrklj2Qod5
         z+pg==
X-Forwarded-Encrypted: i=1; AJvYcCU8d6rO5Dl0t8/QPGW9W09+nJAs7ZDEbydfQNu7vS/jJH1ISWDv/TSdaIY28SvKMfN1iPRaIxjcDufQaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVHIzRiwQPsk+riLkzMJK5oVibX5TV6COsP87Nip2YRM4hcKd
	Xr/Z/9oQv/TZyuiS1yU7gQEuIAeVPXTs4Pf8bV/uZ8vjo6PyckmfjFfuBbPsyG4b
X-Gm-Gg: AeBDietyz+tAFfFipPaDt0TKP3YG4Y8XFd9wxlOWmQ7Sujf04FlI9Cj1ANdZzCMRI+L
	gCaboitjwSE+kgx1NbYzquyx+7fQ1FlK1urh6JZP9OIhWYYLnm5W4bcfaLrwJezUdICBqkyOdyZ
	vhe7XXd+tYQgQwMnZRtuVdm6JRzxzf7NiLLz9NBTEK4Xmip4qE+nHr1sKLM7Zo1SQzExksfwa35
	HFMJ/I8Bqw7wzwYVJK6ZufcSMiINmaGBTQVuF2n1RwBYjwUqArmBXsP529k9IyaUn4wKUbJDKdg
	zK6DaLQ6fphLZFRbvWPTmYOMtivIg+MpbThOmOUGfE98fGEpr+nTtulESVLu7mogrLTZ5/vfUjY
	ZlivQOA+vhMGNjN24bROE979M2vhZuva5V9MwUmzBlzclHChCA2lbrk8KvBI1bprSBcL98ln3me
	zgeZR/ehzOy6w4Dhqa5znYRRARSUnqLjRPzlMoW8yaIfRQOw==
X-Received: by 2002:a17:90b:510c:b0:35d:9482:2233 with SMTP id 98e67ed59e1d1-35e359a4b9fmr338307a91.24.1775672394124;
        Wed, 08 Apr 2026 11:19:54 -0700 (PDT)
Received: from raizudeen ([45.251.33.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34fc9db1sm372638a91.5.2026.04.08.11.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:19:53 -0700 (PDT)
Date: Wed, 8 Apr 2026 23:49:48 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: serio - fix O(n^2) complexity in
 serio_unregister_driver()
Message-ID: <adacRNjPg2ChJjAn@raizudeen>
References: <20260408162849.4639-1-raizudeen.kerneldev@gmail.com>
 <adaJ1MJ-Rg9qeeyr@google.com>
 <CABkOv5cU8D8oo8scTOojvJ8hUeq4nxm6GGuA3GaBvebzdMBYpg@mail.gmail.com>
 <adaWU9rlMKcxLO1G@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaWU9rlMKcxLO1G@google.com>

On Wed, Apr 08, 2026 at 10:56:26AM -0700, Dmitry Torokhov wrote:
> On Wed, Apr 08, 2026 at 11:21:30PM +0530, Mohamad Raizudeen wrote:
> > Hi Dmitry,
> 
> Please do not top-post.
> 
> > 
> > *We do not have such setups at the moment, but what about parent's parent's
> > parent?*
> > You are right. Even though we don't have such setups today, let me explain
> > why the patch works for arbitrary depth.
> > 
> > If we have three ports linked like A->B->C (A is top, B is child of A, C is
> > child of B) and all use the same driver.
> 
> What happens if B uses different driver from A?
> 
> > 
> > C sees its parent B is using the same driver, skip C
> > B sees its parent A is using the same driver, skip B
> > A has no parent using the same driver, collect A
> > 
> > When we disconnect A, it automatically destroys B and C. So all ports are
> > cleaned up. The logic works for any number of levels.
> > 
> > * Could you explain more about the use-after-free scenario?*
> > If we collected both A and B, disconnecting A would free B. Then when we
> > try to process B from the list, we would use memory that is already freed
> > that leads to crash. My patch avoids this by never collecting a port whose
> > parent is also using the same driver.
> 
> But currently we restart scanning the list, so there won't be any stale
> entries. How would we end up with touching freed memory?
> 
> Thanks.
> 
> -- 
> Dmitry
Thank you for your careful review and for pointing out the mixed driver nestingscenario (A bound to driver X, B bound to driver Y, C bound to driver X). I completely missed that case.
You are right my 
My patch would collect both A and C, then disconnecting A would detroy B and C, leading to a use-after-free when C is later processed from the temporary list. The original goto approach handles this correctly by restarting the scan. 

I am sorry for sending a flawed patch. I will withdraw it.

I will try to deisign a better solution that works for all cases, includes mixed driver nesting, before submitting again.

Thank you again for your guidance.

Regards,
Mohamad Raizudeen.
