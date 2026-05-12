Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6AE356777
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627095; cv=pass; b=CfLUr5qPKBPE++ucMim6V7ZV000rwZ3UNxW84Jt7AjIY0IMd1TaJzdEtJt8rSeh9rGKGRFkVP6ZgKiKs/qocpD7If0QglcrUSNsTSzH1ZK2W5dkLUZH8AOe9UQgLjhU3LwhYSAOMN+iGzjnrdOEBfdNCcBG4UIO/+gL+VgbiY/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627095; c=relaxed/simple;
	bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXxML7HBV2Iye8Tgg8jagZHfYyl6WNNmcr5pXJgdumuIZ6GuciIEopFIikhwVPhBXcor3PHraLr5/1vwTy8E1i8NhzP/4vM65yhYYjFY7Jn0+3CgOxLHDo4LuVYaOclodsw0x5eKkh2zIBJQt/NhSnvnttmK9UWNcMaDNPemzIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=El6s+MY0; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El6s+MY0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so795e9.1
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 16:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778627093; cv=none;
        d=google.com; s=arc-20240605;
        b=j70SZg+8dbjzyxAOytAD6kWWZNA997Xyu9V9bwK0SWDngUuP/m/pXKMtlMCKMcjYey
         kY7LkQngAjQ3qqrsEOrdFXOIVIbProqOFnQifygGoD0At06vQrfqqngCPXc0K46/gJv3
         2iUmsQTjI5tDxm59h5iZRs8V/At7auwxtMCXi43JApd2DmakmrgVoZ8MWbqxAxdY9l8i
         b/pUOK09gc6d6ZfACtPmg9zc8jPmhtkweS7mArwHpGiIbw0YOVyDX165RgLZzcwWzVWO
         eJO2lkoqgdmLQOag6V59VfXoyZKTUYDrUaECsNZojE+O+tO7lpC+qv917Zb5wCkKIoQQ
         cV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
        fh=Cus7tSA+wGUABmAtQobAyZRgEQP9kVOsr4+OL9xC9As=;
        b=UZJsqI0wKoblWC6bnp8Q7aW0GSBPU1O/JXhf78rJmSGuSVH00UKi0b66mzBLfzIlhG
         DyLl1+WSmpU1N33eGkzIoAiffuAJwDxyAIGu6POkuom7ejWu0aHosME2jMs3BkVT7RpM
         +C6kZaasQSWxNqzOV0pPcC63t+RJM2GD384x/X8O+SzWl3oX/75yTQ6kryM3JC8D3BrN
         2oBPNBOk9aQR4YKEeTXmtkvydNcMc7gtJb5+NK03avYZGelCIegKlv6+zoqdR/9Os73U
         z3LWgpdrHXnhtPlVYoGTKjGAL01UUimKXTGXlkwNoqbphqAtD/rCC9P2lGfM3nX9IdMq
         KrjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778627093; x=1779231893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
        b=El6s+MY0RwRfrcvMJFu1fCTk7Gl6iq1K8hWq2suS/LAXuE/Bt9BjKyHGPYtJOevaID
         Qovmfm5WT+OfuBhPCaBHz44y+ogRsCxYXdgHftm4iz5+cqzCDaLz7KTrPoNwPHD8NqO0
         bD33SnixcpGpqmGq+d3W8VqkvnM81aE/WcaMbCaYG7bOctLWDJjHSJhLh3wXm4fAq1vs
         vWHjBWBTsn+nlVUfCHqmMk2pn4A8KHcgZi5W9BU55Kz7jkMWS0kND6gGBBSvMFi/AVup
         A8CpL6a5nA9VA/rx1NY1K7mRtMqr65/ZDglauSdfArN9KS6vKR5F0prWudFS7/MsKEf0
         QuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627093; x=1779231893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KpOoX021JXCFcKPdmiwJvqTk4B77UB3nIONU7aqJx+I=;
        b=clYwkISB7EPVoBevNCIBsta3RAYS1rXV6LFhydKb2QOFuUTKzK97xJQdgwjP62ZUIQ
         fi+B1wN/q9Xihva592I8rl01y/gClsRIitWY73Q4Krmxh14OFATU2WbhDXhkbB0zU+qS
         CYiuuxdmnGmYSz0Kyn50lh6LzyiMYH+glnDUmBElzBimggBhZMiBU2SIICcbjTIA1YRH
         ng3m+h1Je0A6ZGdJJ1hMMT3tB+Q4yZYrutY6XkbnfkWde2yIW4avYmiXdTJwjEPv00Dh
         7uH0Xvve7jUuBqiwyEfu877etwOv9WHJrSkR4Qj2kGIo8iuUVhqFiH3DcETuNd1LoAjU
         zW6g==
X-Forwarded-Encrypted: i=1; AFNElJ+7DPMDVvDxmVZUAPigvT8YVI4WzWS1wT32EXWa2WAi0Knm8/PqeGnOm5Ct9YOPqldMQNA0sIDkcEgVHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqOS2+jy/n9pjGEJ6ywjTGVu9Y/e9VKDcblyKD0GNBBZVFkZu
	Sh6su+C14W0B/LH/b6TphY6ntbq9dMR0I7C0TLvLdOmlkjSNKc0d8D8q5Ce0VGrPQrseVj0t70C
	TI+q5EhscSRfrYCH6qbOhK103kSogtZrifW/JEl9j
X-Gm-Gg: Acq92OGGbEB++wxvYdFUy72IyXKLA68Q83hoMaLj2igMxldMzIYZfWRnNFitS7nEFQR
	HkVMI/xh+wJ9PhO4i0PUSYArO+z+wpFxIuqjyz/dLa5cWNyBwVEte0F4CK1QTG3dFYhB6vhCIFA
	S1WQUiu/1UOvuIovrTeuxw+Qwaf/LFYznzVpfg4u0ax7seYuLqCma8tFHgBWw5RVxoTMR44aFsQ
	MC1Kfbrn+8in/NF4Yz4kQCj4dSuCnlVyyUbTKITswl1YywjUbEmtvitrQWH1N/jvhHYBPXQ95ov
	0tnx6FuEWYP41ThKlu0vyR47HJcbB9vfIFD2LzBM26us8AUpWFO65izA4AilnheQeyzHfdB4OXE
	gzZbOug2yBQ/04r0=
X-Received: by 2002:a7b:c455:0:b0:48a:56fa:36dd with SMTP id
 5b1f17b1804b1-48fcaebf3b3mr120885e9.11.1778627092566; Tue, 12 May 2026
 16:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417154704.1186803-1-tjmercier@google.com> <89s27nso-4053-p971-4q69-p4nqo5n7p65q@xreary.bet>
In-Reply-To: <89s27nso-4053-p971-4q69-p4nqo5n7p65q@xreary.bet>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 12 May 2026 16:04:37 -0700
X-Gm-Features: AVHnY4LH5AHtFpO25VgzAeX3k2o7aRw38Q8TFmJHj5_FfZZxyPG2XicnoUV5PV8
Message-ID: <CABdmKX2sLGEFZDziwKG3rJOYQsdyUVUxM68xbLe5WGAPoy0AYQ@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: Clamp num_touch_reports
To: Jiri Kosina <jikos@kernel.org>
Cc: roderick.colenbrander@sony.com, linux-input@vger.kernel.org, 
	Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org, 
	Xingyu Jin <xingyuj@google.com>, Roderick Colenbrander <roderick@gaikai.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:55=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Fri, 17 Apr 2026, T.J. Mercier wrote:
>
> > A device would never lie about the number of touch reports would it?
> >
> > If it does the loop in dualshock4_parse_report will read off the end of
> > the touch_reports array, up to about 2 KiB for the maximum number of 25=
6
> > loop iteraions. The data that is read is emitted via evdev if the
> > DS4_TOUCH_POINT_INACTIVE bit happens to be set. Protect against this by
> > clamping the num_touch_reports value provided by the device to the
> > maximum size of the touch_reports array.
> >
> > Fixes: 752038248808 ("HID: playstation: add DualShock4 touchpad support=
.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xingyu Jin <xingyuj@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Applied, thanks.
>
> --
> Jiri Kosina
> SUSE Labs

Hi Jiri,

Thanks for applying this. However now I see that a different fix from
Beno=C3=AEt Sevens from around the same time has landed:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D82a4fc46330910b4c1d9b189561439d468e3ff11

That fix was not yet present at
3cd8b194bf3428dfa53120fee47e827a7c495815 which I used as my base.

His patch prints and returns an error in this situation while mine
silently avoids the OOB read.

So I think it probably makes sense to keep Beno=C3=AEt's patch, and drop
mine since his code means mine will never be reached.

Thanks,
T.J.
