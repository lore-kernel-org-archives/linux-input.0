Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB44378D95
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985707; cv=pass; b=rHJn/Jw4BUZEukipguJ2p45P9vM30MJPWQbsdaqKp9qTtSS3yhJhO4N676qEZQ22OfIZ39l4eGaEbAm8eIn7S4WZvCkx+6Q93+QX/LnnkdbspDvuyERbWpUVYuzK/AEKqHFBBNGvVRNX5bs001II3ihkawSZOvswb/hNnwZbVLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985707; c=relaxed/simple;
	bh=4l5/0S+WizAF2E0sNh0rDxUBI6+PqDQJbozPOpgfYUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSg++5ALILBwizgCxc9EUmkmfTPa1Zbl/wTjreCxqhepackK28qFcB33F5+0PK+mks/en1+Z1oEm/QEY4Bg4IU3kcxBRwOOJYfVChz6KvvZJMjd+JBdRazKy/yxSsgDEoHwN8buWXvFeP7QX5aqzX6VWijbSyQlxohmUCpyT0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQbNPR7R; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQbNPR7R"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-894724bc5cbso4541826d6.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 00:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768985701; cv=none;
        d=google.com; s=arc-20240605;
        b=WBQvT7Py8Jq2P3yboiY89XjGfwdSb3DpudK+V1ea+U0bf0JNDiCJ2wYufIJjTkdqLt
         HB8SCXruPY10uQ1UPNsftBen9qMTTFIrJqt5AcPxNNB81u62exE6+pWOo3q2g1h+2+Dd
         ABGdBgE2rHwjf0GwhcZNCnjj7lrtlUmiQLTZyxDz/AXGWiTvEg5PjFNglSGm17drrffH
         0vxlh09APnleEURV4vchsw5h7SjjuA0IVsvv1AbBCvSAne9EIczRLyL1k/TAREaW5t0f
         FliT3qAcDgEWBFT2fW6+d+p+RCYmR87tzbRGBaRXEQMaAe1J5JLmSkQv1EJTQAXPyJSn
         ZzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NytW7INNZcRV36x1NW42Y3kPsrFHe3X6M+99O2e689M=;
        fh=cSJ4vuZfMyZ1z6BUl50HpZcZet59Y4wl/3u35DChNKY=;
        b=VWDseeGI0v5PjVnGcs7VOdasOBDjIIOtrzRygZ60lt054JLiGv9RSvdhPlpa+2an+Z
         xq0rDw/fH0eOB/TNMOi1yJbgVl63OOopTC0o/Tu7WyL7ljh9BHcewi/GFgecf3tsOiU+
         caKVBDMsKs3bwLNacG8geAkZViwS7241nG0rcrqxykdWV5NMbPflU9BSzx43fzO+6DhQ
         dNQ1YKZfx5fh5nqDcpmKokqmk+KDXKilnc8dBAahJl9PExutdIJ8lghuRguWD2bOocIv
         Xhey1rlo0tfUJPeM/LVwhwI5tBIgEru3DWqN5n4L/28liUTMNuISY3bZZcAtIEcQNSer
         vMYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768985701; x=1769590501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NytW7INNZcRV36x1NW42Y3kPsrFHe3X6M+99O2e689M=;
        b=LQbNPR7RNOtee87H/GHGfi6poJXDmuIlix/2wd+C9LO0ak1ur/jqQumKgYxGuSXiZK
         wQFhc6+/pR4jMSo1DU61TzmiTO7iCQfswAJugKK2B6pHHyYLAD7MoZCWYAs32WM1TkaH
         h2IhyfJBKClstniH8ATbPdJ523qhZwoYcy1KNtEyms1PVtbwUmXVp5AO23GJWVHHT+G3
         K5nYomGUq3gv25YzhZCN5KuEL0P96esY9nRyLlvM7ox6ED0avI/v7gAXxk0aUZQBw1Iv
         p8G0F686SF9wkVjwQsVTDKYa0GMs29IBYj9GlQAP2Oatx2NNuNxiGrobqe2Qy6xWWCRy
         beJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768985701; x=1769590501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NytW7INNZcRV36x1NW42Y3kPsrFHe3X6M+99O2e689M=;
        b=nsT+QzRkK8k55eCe9mgC6cy6rFqZbpaNRl9UEsiD6TglyzS6AKCVZjnLd/ZDq/NoX+
         nDwBNdV2UargMIDgjd72qaBmskeST0fzTu9RsbJ6/pYq4dkE9aq3EFesG+dwU6hKwBeL
         gYIkedVg1wwoqBhNUW6cvjvRrYMVp0bo47ORTx22rAwPw1gUzSSo9A5tXqkiLsJnedda
         8fWzsiUiHKjaY08SEaIzP8Jp+dEovJWEYszXNm4IC01da4YrF76jzdMJKs07fjLtEyW+
         SzorBOM2uFnm9NkcTp4OfiBJRB6+DpTldOcKIM07nElja+99BTE9lO8PUCzWKjwl8yXf
         U84A==
X-Forwarded-Encrypted: i=1; AJvYcCXDdCmD+08/dP9JyaWmmojbga5uz6QDZBf55o+IE1tCYmnFqNgRmVlIfLqMDn68lJeTg1Cb/tBUcsTe2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWja+D7XBBwuc6SqB7XDNB80m+cv7pnGCn0pdPDy54fg2h7ZG
	5+W3HeWbe/WhBIqTauLUFf0oDy8QpkeTpr7AzXhwlkPeslkCujaReW7vipWgZAQdmihXp6TPL00
	emdYu4Qdj7UWLf0edDQ05TPzh4IfLag==
X-Gm-Gg: AZuq6aI3OVXg2vWRb0MqPiORZgCqhxzs8fckBf58sehFFF4kzAEXKcS/CO8o6U9q/hd
	AFG0Qc2slI3GUTkM0RhSaBk866Dg/L3E/8WuZna/wepGL4THWGPGuqiCTtkkeMbYUSyl2130eiJ
	4CydlrGSbXc0rmOp7z48USZuWqhRTJFVwWzjXy8FusBB0b5BiB69ZReVjvv72LPCNLMXE2SPUkh
	sZNrm/6hwd+hgw/Ivp5ok3uTdJAJzIiaf4etjdyJ2lTEZRNGf6I5v2lGSRFz3NAgpObRg==
X-Received: by 2002:ac8:5e49:0:b0:4ed:bc0a:88c3 with SMTP id
 d75a77b69052e-502a163c0demr247645331cf.33.1768985700982; Wed, 21 Jan 2026
 00:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALEuBan7Knm3G3eXPd8BZ37jVQFtRs7fAssts+picVKHBjGBqQ@mail.gmail.com>
 <4mtpditwnavptpvstqphwa2auhb6wcd63gi76w2dekw7ryn2bp@au7dyelbvzmi>
In-Reply-To: <4mtpditwnavptpvstqphwa2auhb6wcd63gi76w2dekw7ryn2bp@au7dyelbvzmi>
From: =?UTF-8?B?6b2Q5p+v5a6H?= <qikeyu2017@gmail.com>
Date: Wed, 21 Jan 2026 16:54:50 +0800
X-Gm-Features: AZwV_Qh5M_iJjgG-1pzyCq7DHl93ajPH2A8vYQ5DVKkfWOm1s3iCnkMg2MTVLqE
Message-ID: <CALEuBakeMdTor9gbshrJmyJ4uuw5W9QC=XBCF26+UAe3FUdENg@mail.gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix NULL pointer dereference in mxt_object_show
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, rydberg@euromail.se, jy0922.shim@samsung.com, 
	bleung@chromium.org, ezequiel@vanguardiasur.com.ar, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thank you for the review.

You're absolutely right. The NULL check only narrows the race window but
does not eliminate the race condition - the pointers can still be
invalidated between the check and the actual dereference.

I will rework the patch with proper synchronization to fully address this
issue.

regards,

Kery

Dmitry Torokhov <dmitry.torokhov@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=89 02:22=E5=86=99=E9=81=93=EF=BC=9A

>
> Hi,
>
> On Thu, Jan 15, 2026 at 03:43:37AM +0800, =E9=BD=90=E6=9F=AF=E5=AE=87 wro=
te:
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> > b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index dd0544cc1bc1..401fcae2264d 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -2859,6 +2859,10 @@ static ssize_t mxt_object_show(struct device *de=
v,
> >   int error;
> >   u8 *obuf;
> >
> > + /* Check for NULL to prevent race condition during firmware update */
> > + if (!data->info || !data->object_table)
> > +   return -ENODEV;
> > +
>
> What stops the pointers from being invalidated right here?
>
> >   /* Pre-allocate buffer large enough to hold max sized object. */
> >   obuf =3D kmalloc(256, GFP_KERNEL);
> >   if (!obuf)
>
> Thanks.
>
> --
> Dmitry
