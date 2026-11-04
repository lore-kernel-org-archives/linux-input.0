Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793799825;
	b=tOWdsYWZnSGjDEBwlTxSpphmMzNwGh8iyDqIjP1DRdWsFqMWBG7OGEIeBiDpIvin4KqM
	 XYkof9+RGa9JfVAntI+dCgJBE43hIPYZC7jCyBS3eCVZ381tYs3L8+ivTmXfQWKEkYiU+
	 tpGcXw/d8u4pVCOTwi4l1civHulBN8otrbjT0iIFaGXHj+2NhVfQgOfdyfII/2iEKujW5
	 qfKO3VpJLgycKoDw6HVEzAA9TFJ/DgXlTkVSxsAsBXAF+Lw6sFD6I1rE+q6zWKuB6dRDe
	 mAUfUwEAzvZ7+hXO2nra8oU6TdqIl/UDsEHYcjFFbvKf27t6O8xTehHmFJRho+ZMR+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1mtCLTM0QOYEwlUCRAW41FbetRzUaeoC1C38a9gQ/K4=;
	b=sKQvuEN8yVhwG5Amu9yXzQ/hhbYY2fduaxvYjOVrk2wQgn2ylR8W6XoqHo/j/Pone9Vf
	 u1uDi0pZH7c5PnlM+vYl3XAxNUwIBEeyCirzmnQDUjKtUWAyD/gbDuqlti60oXISj5wBV
	 nx2cIctZ5oiGf0rKT/RBB1gfvP0qIM06PGRUSVrtr4i7ufnKrjIzzKiPpqQSSSfnAcNQA
	 +k1zgZxoQQFfwRolRRulbd245eGv0I8iASduMpJctV7ev7S4TIDb1eODAAnRe/l4ebb+A
	 EcutAPSgsgmcO4vCYH36Gl13Lonr+/WZfbQ79uCnMzFyNuHiqZNRjWXmeR+heeHOD8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zCdCOcQl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A6606A331
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 13:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B96A6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zCdCOcQl
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso770659a12.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 05:43:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793799823; cv=none;
        d=google.com; s=arc-20260327;
        b=sJrQnnTenGRriLgVaTTuZGBka4bt2+UZp3Hcq69XPGzXtxdd2EBr+xJLsUp+Rm/1eM
         dm9NMB6amwdOG0/ABDIpySP3jDSG4mFRUb998b/NY2oSrYbzKKDhfTBWFWmb/clkFh4Q
         LR86XayHAeH6YcKkrCeVy0/nI5EjI6tydt0RZ/dlAy5za6Giu49+ltRwSoph7TNKEPBD
         zfBM7NoelyLuIj1M8l4rxwvf+IvNEFd8JQg209FDQNoM4o3746WGkqDkDV2i7C20mTam
         X2itgWDpfuQIsuume0L40HdAhzORPnN6WcOYAA4o/fVq5UqJf6PGcqKw2q3dUs8iwS0T
         4nCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=1mtCLTM0QOYEwlUCRAW41FbetRzUaeoC1C38a9gQ/K4=;
        fh=sjpnztv0oAmAPr2dNvbpcMIzHX/5g2dd4hnXtM6xwN8=;
        b=cKJ073XTkqVJkVO0+rVyVmDSWsCh74fNUIDMnnkXsgnsADS9TuQyScABvhJPAlvy09
         YiNGYvcKXVMR9HdJxr+i9pV83Z1EkiZ8BCf8XGha1jJk/sC73UHq5zhR9yO3oaOQiJuR
         Zgt8MFUKLA1sT/GhlQponc52STPXxXYyb8b5dFc+goEE0zSTeTTIN0UE6JUAEf9f8dHr
         XfKi0JZgG/dzg9F0+yO+GNzL59Xobk7CUT6ZVuheYsKl9cpV6hDk6ENMFE/IKcfL8COk
         +aktsCSc4rEfvuYrz7DLZTiL1VBJ2PhKnbUtjl0aQzvJuFVV3v9+phTCivTG21JqpJhq
         EiXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793799823; x=1794404623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mtCLTM0QOYEwlUCRAW41FbetRzUaeoC1C38a9gQ/K4=;
        b=zCdCOcQlTNc8Gfi6OgADU1joemBkAd0zQzq3UaPaTmtOCCOenG9L+QAhxmv9TzLJ7J
         nQaZaQxwtjHq8LYsst2b/7ZsZNxPRvBcbz7RFO9E81YNDyxqyNrWmVNM+uPVzM2aCklc
         wxZLcFWEdu5f/RNnPDNGE7P/FyoWAo6OgAYjIUih/5+GoihNjE3WA28oH9TltpzVW6wh
         R6Ri0EMhrwsyQBTC0nvl6KKVTjrmxddKFl1Z26nfyNIR8jtF6mVMAH0326pMs+L/hyZn
         4QuXtkZ7KuZNJUiWQp4ncx1hYvwsfNQ59LHKFz4TuLv+eKNrykh0Ozm6KuGlAPoVZY6d
         dfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799823; x=1794404623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mtCLTM0QOYEwlUCRAW41FbetRzUaeoC1C38a9gQ/K4=;
        b=c6j3Zgml9req9a12Fx5GU4+HHKlYs3F554G5Ut1grH280ooJCZHf3MC65YALxqvsjq
         3vyeDX/M/ogk1ql9485vfD+dJQqyBvjtv6v3K6cqUKtBmArstxTEL52d3yJDKXDxNII9
         umkbCtcewBy3LKGtyLOz8OSloJN3SnDhzmJ0P3m7f8oeSgNz/hJoK2juorB0f1Gv16Ug
         tFSG+JaE6GSZ01BaNe4GOR7+jyfArhfh0wwKpu5fDTGDBAGGEbM3FVWPXIT0wS+y24+C
         +S3/Xde7fh2uc+69VRkWLAAGVYua7GTT0weToxLtsxPaVQuMPCpA/1PuA34zYUD/6sN3
         IKSg==
X-Forwarded-Encrypted: i=1; AKwUvBwbnt8QgOOLvEy0xePVXWULYo8IwB0eWTOzWnOESa89PdISw3XtXwrDm8+o0MDLQGOjq70SR4uh2Yspvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+SuJGG30Yis3ZAmoPYcIPK9ULxvx/Yn5qVXma18o9z4GY8zn7u
	c/El5pAfDMi/wlDtXGzuD+YETQnHjENlM8N0wR7yVPgHgp/dX4p8SgPO1Ns7C5zPdWlClBcWz7s
	rkNM57J2rRwoVcsEb16OgzUhiJ3woemI=
X-Gm-Gg: AYBFou1IExML0vvbQJHzM6SMvGJLM0FcXrmxOOMOnR1LyfmWWe5M+B3IqLEnHbB/fSk
	CYsq1bh2W455JT8EirbgjA4pWSzJgzUZTjjs/lkhR5XMl3Kpshq7feb3zaYyH++IxiDqLgNWVsF
	z3VtpzJ7oYrHQV+2fWM1Fqf86ehLlPEwxILSRyqQD0quXKn/B3FOkpgTu2gVMHed7gBzGn6EOoW
	bPnV3D+dTjWNd7OFt9xQhA6ZHOJCsLkKNrka886787clPNJD9QVNUVaOf2LTAieO+ip7Q24JkQn
	tn8bC89EW4JSX2aDPxKLbpxXzofDzbCfl7b3+PEuQpS4tXn/7Un0SYWDtJdv6dMm/zoHOduBvJk
	GuAUT6M39+Q2LStUEYYECHn+rkM2BYDVpJAVBkALgHP6SffVT+S5olwmnJdSHMfdZK1hiNHo=
X-Received: by 2002:a05:6402:360a:b0:6b5:6428:6037 with SMTP id
 4fb4d7f45d1cf-6b564286349mr1404704a12.7.1793799822972; Wed, 04 Nov 2026
 05:43:42 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 07:43:41 -0600
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 07:43:41 -0600
In-Reply-To: <CANC3H+Lc3GCuWpqr2ydCkYmRxTu4em+vM9R4gd-vEn_kzu-gyQ@mail.gmail.com>
References: <20260927114425.442803-1-pooyan.azadparvar@gmail.com>
 <cover.1790612085.git.pooyan.azadparvar@gmail.com> <CANC3H+Lc3GCuWpqr2ydCkYmRxTu4em+vM9R4gd-vEn_kzu-gyQ@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Wed, 4 Nov 2026 07:43:41 -0600
X-Gm-Features: AclHuK9GLC8UvqHpZxnkrDxlPR294Gvt84XjrIhABOYbFIYhRv4AlZQScmURKt4
Message-ID: <CANC3H+Jwb1=_mhBRb50yeZAg2N3iFnaq5C=xbvFqf7SuDirjBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Input: raydium_i2c_ts report handling fixes
To: dmitry.torokhov@gmail.com
Cc: u.kleine-koenig@baylibre.com, meatuni001@gmail.com, w1zardsec@proton.me, 
	robh@kernel.org, jeffrey.lin@rad-ic.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Just following up on the Raydium v2 series from September 28.

I split the changes as you suggested, separating the validation fix
from the buffer management improvements.

Is there anything else you'd like me to address?

If it would make things easier, would you prefer taking the validation
fix (1/3) separately from the other two patches?

Thanks for your time and review.

Best,
Pooyan

On Wed, 7 Oct 2026 11:04:46 +0200, Pooyan Azadparvar
<pooyan.azadparvar@gmail.com> wrote:
> Hi Dmitry,
>
> A gentle ping on this v2 series. Please let me know if there is
> anything else I should address.
> Thanks,
> Pooyan
>
> On Mon, Sep 28, 2026 at 6:26=E2=80=AFPM Pooyan Azad <pooyan.azadparvar@gm=
ail.com> wrote:
> >
> > Hi Dmitry,
> >
> > This is v2 of the Raydium report parameter patch, split as requested.
> >
> > Patch 1 validates the packet and contact sizes supplied by the controll=
er.
> > It also propagates main firmware query errors because otherwise a valid=
ation
> > failure would be ignored by initialization. This is the only patch mark=
ed
> > for stable.
> >
> > Patch 2 resizes an existing report buffer when a firmware update change=
s the
> > packet size. Patch 3 moves the initial allocation to the main firmware =
query
> > so devices can remain usable for recovery when they probe in bootloader=
 mode.
> >
> > Changes in v2:
> > - Split validation, buffer resizing, and bootloader-mode allocation han=
dling
> > into separate patches.
> > - Mark only the validation fix for stable.
> > - Rebase onto v7.3-rc5.
> >
> > The series was compile-tested with:
> >
> > make O=3D/tmp/raydium-build W=3D1 -j$(nproc) \
> > drivers/input/touchscreen/raydium_i2c_ts.o
> >
> > No runtime testing with a Raydium controller was performed.
> >
> > Thanks,
> > Pooyan
> >
> > Pooyan Azad (3):
> > Input: raydium_i2c_ts - validate report parameters
> > Input: raydium_i2c_ts - resize report buffer after firmware update
> > Input: raydium_i2c_ts - defer report buffer allocation
> >
> > drivers/input/touchscreen/raydium_i2c_ts.c | 64 +++++++++++++---------
> > 1 file changed, 39 insertions(+), 25 deletions(-)
> >
> > --
> > 2.43.0
