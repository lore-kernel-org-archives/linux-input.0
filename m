Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DF3D88F4
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670992; cv=none; b=Ax43BpiDin1g5QoYb8sfBOdoLq1vSUTxINl1Bnq+X62fZKVBAYSgsvsHOOwNTohkBzwFUHf5vtEvmal4QUhFO7Xsi/0WquNRi/8xJTX74ubHauMTFOgFJQey9Dd5eL3OFXRMTKMyn6kNPFQkEaisfjEsem1Q1WSNtNE59VahBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670992; c=relaxed/simple;
	bh=7BYRe7ZHkNeoh9cn6zRYpespCM9IuTIIZJVVoLdSPoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUPGlHDzMx/G1Rt+mhe9qQp9BcVpjgQXG6xQDW5BLzBEB9KnIMAPFFUh3DUQwyfU/RZ4u84lvwpxgF1izfTHnn5yjAjnmneeHYquNP2l6I+OZKw0db3T2ReXhnMJz9nul/twuWukTqj+VFUGYsMlk5JmPsv6f62a6q+ujSfeWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJhZJGmk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJhZJGmk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70c112cb61so9333a12.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775670990; x=1776275790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7QZewUT0BWk5yZHEqmvJYle58rVlSnReBc0oklkAx0=;
        b=BJhZJGmkin45pVziXe1uMRoz2gnUSAsTwrI/1yqbqdURix8idSZEt/6TY9eOsWFm5D
         ZI6Zwjvf05hfSf4y8hPTcPj+IbJB3cYHgFMrQyCH+vYyD1ofzVb8UKLZzzrTPu5OcDLA
         Xq3t4hmiKn0FjN9PUGvoYtLH8gM9Nl7NxuXo0EXvAbhoGJTgYIJ5z2gKPjP+PBq4cf+9
         RKqTxnoz4A+QGYGqDYdf54e+t1l97iF2jr0sezWDASGVNLIwZBd/nf39pX0lVWqcJfEt
         /fuCyX9/om2bl8vrlRp4Qsv/kLLf7pfGFbN3dtEsc58sTacb5HaHV8XPjubsve1Gp4eV
         4thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670990; x=1776275790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7QZewUT0BWk5yZHEqmvJYle58rVlSnReBc0oklkAx0=;
        b=OvR5oEVmlxQNNYCHAihfJbrp0dKMY4VlzgJxCo/ln9rWO4z80wXz7ggCc48EiUvoAB
         7kHBb/N3VQydsGVYK8DkfKyA4d7OQYBWw7r1jk8J+V58UsObqRcmcdkH8GfiKQ2ijuVz
         Q4cbDM5EWaOZf+s/l9LkEMTy76od4Gnvy2C0XQYV7P2FZkCY8DN2b/UX2AP0nvf8TuMz
         dDucNSD+p6Fk2IBAwCrpZyKHF7W53Dzv7kxZ0BsTG8HKxPGNxBxl3R5NCgbSef5vu6oA
         1HtXOSWCUDeAH59PS9PZPKT32tHitbztU2rnZQRahda4IRoUox020660+Go3iG24DQZd
         5L2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNXLbGDVWr0hR6Wf/xbPk+3L6a2p9lI4HLZXFrbwmB2ZRb7EhyRBEk9JcyzFnFwh20+ETuy3cfMnUEGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkv08IihW4FT8MIpMolgs1lTBlfjK9RGE5n+6Sfhh6sY2HdDY
	qTG5D77sYY+Rtu5xHrr6k6vgh45DH/3HjhgEJ9bOYbxpwfUIAUGIw1BU
X-Gm-Gg: AeBDietDFC8xpI8U+Qhu9abir67bmUwS/w4Vdip5DNehfmMjLnwJL9/fQL6LFXIYyNs
	WIf1KiAlFF4QpQwSrvgMOouoijvCdQcdJ93Dv1Rs0km+YvEdZTJDk08XLLWfww2iAb/4JidLn+w
	ojv18rzzgHM/qNK9R695QyoFodQvsZQmyv69n5fbz7H+vjUWo5G9IdBbuNh1hlENWOzwfa0xXiX
	KzoZG/5WRyTXqaX2UuzeL8xYJDE4gLPxnWVuzF9ChzskA3PjnvTkb5khN4FsiVzNHaYCzgpxzVf
	u21EMo26kIaUym1I4eiL9kkcC4jfyxo80ZS7kjQJUaTdbIr5RN9KzRdrzU0fe7WZGMOzo9AJ4DQ
	hXIeJrv/CYJD5GB3eno5c4VIvAYon5jZRe0ZA+gz1vDYBiXM6N0FhAkvAT7J5ogFYUqWurem4wv
	NaioujQldBCxvo/99mIAAIay1mG3CA9wuIDXcbCuaCSH95d+EtbwWvI3oxXCjz0YFG
X-Received: by 2002:a05:7022:3d0b:b0:12a:6fbb:3353 with SMTP id a92af1059eb24-12bfb6e8cd5mr12723523c88.3.1775670990283;
        Wed, 08 Apr 2026 10:56:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm20383342c88.2.2026.04.08.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:56:29 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:56:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: kees@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: serio - fix O(n^2) complexity in
 serio_unregister_driver()
Message-ID: <adaWU9rlMKcxLO1G@google.com>
References: <20260408162849.4639-1-raizudeen.kerneldev@gmail.com>
 <adaJ1MJ-Rg9qeeyr@google.com>
 <CABkOv5cU8D8oo8scTOojvJ8hUeq4nxm6GGuA3GaBvebzdMBYpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkOv5cU8D8oo8scTOojvJ8hUeq4nxm6GGuA3GaBvebzdMBYpg@mail.gmail.com>

On Wed, Apr 08, 2026 at 11:21:30PM +0530, Mohamad Raizudeen wrote:
> Hi Dmitry,

Please do not top-post.

> 
> *We do not have such setups at the moment, but what about parent's parent's
> parent?*
> You are right. Even though we don't have such setups today, let me explain
> why the patch works for arbitrary depth.
> 
> If we have three ports linked like A->B->C (A is top, B is child of A, C is
> child of B) and all use the same driver.

What happens if B uses different driver from A?

> 
> C sees its parent B is using the same driver, skip C
> B sees its parent A is using the same driver, skip B
> A has no parent using the same driver, collect A
> 
> When we disconnect A, it automatically destroys B and C. So all ports are
> cleaned up. The logic works for any number of levels.
> 
> * Could you explain more about the use-after-free scenario?*
> If we collected both A and B, disconnecting A would free B. Then when we
> try to process B from the list, we would use memory that is already freed
> that leads to crash. My patch avoids this by never collecting a port whose
> parent is also using the same driver.

But currently we restart scanning the list, so there won't be any stale
entries. How would we end up with touching freed memory?

Thanks.

-- 
Dmitry
