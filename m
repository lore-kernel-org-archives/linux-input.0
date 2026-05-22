Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C86198E91
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415321; cv=pass; b=LBM7/+0q+eFnrGe0dZJ9J+VAtsJ44jn+zAM75xkncAMUB5GB9hByVSKz0S7k1begjFmogszLPjhXlc2NypmAXRVnkaIM8rJUfiktXQmfA8o6YRCkydhLVPug9kJsEvYnuWRl5etWfY7YtePQtphDyuiyZ3JOmdanPg/hMAX1vBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415321; c=relaxed/simple;
	bh=K67WFn8ii9DJNcLgfm2GtQYZ2ZM4/T0NSchlV6ORpEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaAsCq0CNr8uMbE1e+dogLbFJuUJR6nd6zJ72W8v2LOxeE4J2GNbUmpS5h6JbwiEhjVjN4fnQROguAEpXeGN/eLqK9fLymUZCH3nyVygIxkz5P9bERFBsd8Pt7n8tgxpvDvqgoekEnpPsSNXnQp/2buixO8jSalNbWBQFR7c5cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBmxs5pW; arc=pass smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBmxs5pW"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bd5c773ef3so63349007b3.1
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 19:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779415320; cv=none;
        d=google.com; s=arc-20240605;
        b=O7Mkw3QlVKmmq2cnsvlH7fSgFs70+ngoSMkiLvnpi4DYYXnOJBF07D9Zgwkpe1Re2x
         qi14yqTMfBhCRGFbQrCHtwR7Jx6uUqMxlEZSVy4qIRmvTHD/RNCamSeNhzpEpZ66wj1G
         u3DVoeU0x/eFBc7u4+a1VVXXMfbHIEQjbsXiYLK7W/7UnLkZCIV9JJJNUqbqW+5fRsxi
         3bcGjzlusK7KTMdcFZGWK/WB2OzBp4AEbpfvDAH8RsRVXcyvjHGXcZjNFoLKbWaqzKtM
         Zst1e+Vxka3bGLh9/22L2sh4bY5KRcWBbdniRSWvflMh7pBRaqZbGxP51HQEYS+FjKGc
         Bz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=faTc+Swa56Dlj5XDWap+/ztpbd3S5wZXBvlPOHFWIxU=;
        fh=qhRtUGwbPXMOJmZGeqKpX5fXoCLyrruoYXyXUMwL1ic=;
        b=H01gek4hQVI6HYeyyEUAokAtEDCXIj+c9xCLvRfWMAjuUUIpJkQNxrcTVNK1SFjOHW
         ramkk7p1yhGJyag7M7xfXqFMTH3mrAjir9sHykPQSBiKNlm0zKHmX0Hvm7HGc6zqTSBr
         9tBrzu+U7YRD8nZfiP41/orVEIwKwOeVMMykK+0vwDqKuwU4Vx3BBu6LLFTu15GLl5FW
         H+y55wZXxbhAn+4/wKLN9GYYSq/bAjT8QXDq1TS47IYkt1DFcWvuNT9uqcj4DcQJG6eY
         mUJtDypTwDjULV50qOgTCnVXMDuK42OSYvMt4Rw9RFFr4ISH927FtOTL9XofLIYMPoym
         wzLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779415320; x=1780020120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=faTc+Swa56Dlj5XDWap+/ztpbd3S5wZXBvlPOHFWIxU=;
        b=tBmxs5pWqV8MD1GZ0NB41sO872G5/RPLWEcQ5lOFLmWZ5hB1tVtt5acaXW+Agf3i4W
         rOtHV5aPdn1dGowsiACpMHH3oDTxS785T7IE1rPL0SdQex0iLMWlR54lPuqcqTcM1q94
         eZjAZ2G9Pkf2+ZVPei4wBhNhWbRF8YSEm2mMVamRJdVkmZnEV2xa+tsBqsEC/kWzwQjn
         v42zBAj0fgy8Xyf3ZoBxV5+rOAwe9b1QQax43/si1YJpC2b0SJpQIc+V83bcuLNZJfyp
         nkX9une509w+kpkxV227sDerIkEw7w2Gd01T9Hs/VjC9GAOekaNYD7+AaMe1zOtypvSj
         J5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779415320; x=1780020120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faTc+Swa56Dlj5XDWap+/ztpbd3S5wZXBvlPOHFWIxU=;
        b=ARO/L8Isxdu7h178L1G2M4SdUF0XZvlNwJECBt0btN5sJ21hPhMGa419YnBNBoD1h8
         0Y3AENz833EFZFsCc5QL6G6OU0bZADjyUHRQvJFmLMyClV01husn8VdqqZUFypizkWfI
         1XboAb6x00mjQLkBnk5UMzyUNF6QPsesJZ4B73CN9m/iko8Mvrc+OGWmvs8ykYXAsCm0
         NYls3DU3gOGKjGLSgyEA4HGnGYbBJxLcgwTdQHH3lezqEgJ4D8V5MUIx3tL64DdsaogF
         voxXuAouIvlnaxqKNSKWkpHtZ3Qpj2/E1enHHy2s0d4UhrCbcoE8KnDewjILUjVNMeIG
         C4lg==
X-Forwarded-Encrypted: i=1; AFNElJ9peV5qPlD47PGv9p1oQ/aiFzS2Y774epFyjLjFJ7A0zAKiuEUiirDVhZbmqKIePc8e8dtps3p2G28DxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5drnIubpAHW0JyE7hWBp7rFz2wanKRHFC4tWN1gZZMetaDPDG
	fnEFJ4HxfFXgQMdQ/kcFwyEnM8RTcf7r6NysLPWEuR6dsZuwN2Z1Z3sWGoPl5x7F7wMLT6cA1Be
	tD1JjRpty21ZYAmcRigGxJIVP/8OeQHSjuDIdgqdktZnL
X-Gm-Gg: Acq92OH6VpM/DBYqXSUNBKupMdOQ59QHbntdxNl0wR9Sq98WAg628LuI58cIJJ/7Yq4
	uUhk8b5FUW1W0k1+W2GmXA7RaW1IL7TCsk+MS8LwKSDk31CrwCWi8EqdyduLHLwssHsJWjQbotb
	sL9slYtlRlO2uPiciYxNknUNVoGcDnGotc4CBgantl2cpZNuTUL21RikXE+TRNQry9CXMKmo1DQ
	KGCbqwVpwyGOah0PbpdmKrEoSSuGcdBcpXOTL5FG/F+rWSuzmCIpH0WC0zdqGgI9Wxfb7z76Amb
	lQ861Hc7SJY5nTwo
X-Received: by 2002:a05:690c:6a89:b0:7d0:4824:6424 with SMTP id
 00721157ae682-7d3362b179bmr22484557b3.39.1779415319587; Thu, 21 May 2026
 19:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421134824.35027-1-l1za0.sec@gmail.com> <ag8UFDazSyHKR0d2@beelink>
In-Reply-To: <ag8UFDazSyHKR0d2@beelink>
From: Li Zao <l1za0.sec@gmail.com>
Date: Fri, 22 May 2026 10:01:44 +0800
X-Gm-Features: AVHnY4IcxcFZF3VDTp9Tj3eW4jBJApn1brU5YeWyPLB81JnYsGFhcae1CWUflaI
Message-ID: <CAAwbnpf0APFBj5GDvy9-hYfQW2GUjsYk7zdZmbMquGLbrP0jQg@mail.gmail.com>
Subject: Re: [PATCH] HID: u2fzero: fix general protection fault in u2fzero_recv
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Couple of things:
> - sorry, but a couple of days later someone else send a patch to tackle
>   the same problem at a better level IMO:
>   https://lore.kernel.org/linux-input/20260424-u2fzero-probe-urb-unwind-v1-1-mhun512@gmail.com/
>   So I'm going to take this one instead of yours. I would appreciate if
>   you can confirm this fixes your current reproducer.
>
> - Your commit description is not great. Please have a look at
>   Documentation/process/submitting-patches.rst The thing that made me
>   notice this is the non imperative form (quoting
>   submitting-patches.rst):
>   """
>   Describe your changes in imperative mood,
>   e.g. "make xyzzy do frotz" instead of "[This patch] makes xyzzy do
>   frotz" or "[I] changed xyzzy to do frotz", as if you are giving orders
>   to the codebase to change its behaviour.
>   """
>   The paragraph above is also hard to follow but valuable for
>   understanding why it needs to be fixed.
>
> Again, in the end the problem is that is dev->urb is NULL, there are
> little chances the system is healthy and the device will work correctly,
> so it's best to bail out early in probe like the other patch I
> mentioned.
>
> Cheers,
> Benjamin



Hi Benjamin,

I have verified the patch against our reproducer and can confirm that
it indeed fixes the issue. And thanks for the guidance on the commit
description. That's quite useful.

BTW, would it be possible to add a "Reported-by" tag to the patch? I'm
not sure about the exact convention for this situation, since the bug
was found by our private fuzzing tool and no public report is available
on the web.

Thanks again for your time and guidance!

Best regards,
Haocheng
