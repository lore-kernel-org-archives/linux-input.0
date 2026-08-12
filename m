Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85ED1F5842
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509596; cv=pass; b=NoaIZQx0cjEz9aYtVdqKobu4rwAiy3MGuoFQjFWsSqxlC9192Bf9cnueQsEv7xeMRauR5ewrjXfs1RgZ68SF+C3z+cydtPaHnOOxt2JkEGyW4HZO5m/Pov7auk7w0i8k58kRf2DB7qayxu6S0n3Yj6eg46+EYJhRCSuxIQDMbi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509596; c=relaxed/simple;
	bh=Bn5EA8mnuFm3bH5umIuq0sbge5qbiERu/rawKyKCdjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7fza0gCu9VIfSu2J2k83qkeLdwDoDFA4jAq+07rsGvEvWSuUX3w/JU9F0t5PE70AC7tbJMiBelt2I4OFwulJkpegh4r2lseb6HYnM9ZRCHzbyJ2Vs9nQqGyd1vAHAeadROHiYYiuKd7piVr8ig+aq/VI6V6Lufm3jpDmbWLNYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SCEhEFlg; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCEhEFlg"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-45691990234so310102fac.3
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 21:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786509594; cv=none;
        d=google.com; s=arc-20260327;
        b=gPlLCPpkFcd/m/J7DJVBP8JHCq2yTEcHK54EoVGr/e0gR/c7HCLCuOv9mCnbTpEHWW
         VdvRV4LoIYdeaGo8Voi2LwUNalvN2hTz7s4Nx+cGQ6AeaUeAUvluaMw4XCdptaGrxDKU
         ygxAvLLKWHMIYgqSRMSwnY6MHGe/m7oFnl+snovzMjxQ5dTR7979fqW2y4QOratcuTaH
         hudQ2iKFr4vKLEPigXPZ1RCHc6INejC9pRJX47lYNIDWwRdbCFjFfHq/pJ4bHYCm7Bhi
         2JYCwmBgzaouBckO3OsEobng558z4PdFgsq/mOAg4kq8ytTTFHkM01D4fG7XOZRt8NL7
         HxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y8EqzbJg8fD3KowEEfKkshsn5eXfhPp6NSIWl0mIxuU=;
        fh=pOZKs4xCD1epnD/oPlSufpmMSXRn5abofj9xM4uYQa8=;
        b=jHcB/z/a4F8C7T47GsEXyMWgSI1d5nhqQn77EdKL7W+aL0dFvsoKOGAfFmypCMtSWz
         V4noh5/UsLinYqaf+asuIoiFvubmmt+aCOQjG1xBfC/ED3Oj58pj7pfIqkU3hqowOk9/
         gOkQJidgaK7GoVJKt9rxDCoLQiYfI5VPTFw5yEv8jfOyanv9+xj9cCr3YiYbvWGMRSzz
         kvR408O0zfAaIHNcfzLrNYQroYTFUFN/WWC+B7Ayx3G3HCq+SDmZuN6VxCmkWbm6NfoY
         dmTT7l4kkZQfk/x1OySUrnlsUbCoZ5zdTkWxKBvKN8P2p8I1cs3O1aNjJC8asd+AHT/h
         YCAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786509594; x=1787114394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y8EqzbJg8fD3KowEEfKkshsn5eXfhPp6NSIWl0mIxuU=;
        b=SCEhEFlgd74xOyfBIj27VZ9v0UZnM9YfgSkzGDtY8wgdxjQPcWSY1DsH/o0QfXTwHN
         2Le5BFDtThj66x48BVeVT2jfg6y+MLmBwxerE2AuLgXtaK7q5oI7e10w2/I8YMRcviXi
         bcPIb3/pImk6nK08Y20lAkDKR2wdUKqOOd+zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786509594; x=1787114394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8EqzbJg8fD3KowEEfKkshsn5eXfhPp6NSIWl0mIxuU=;
        b=jaXz8nb/fSKJxtD5Np5PXydI95y9Ptdk464ShSNweL9L7BbI/cccmksZZVW7/ImQii
         CgZiN7Y54HlpnXlWRbvGOrdgjCgOj5nvSQ3NyY58NIxcfjPjqhoYHYkZorKetWq1rHKQ
         mHA2hM3YTvxitBtiKDra+/bU78n2JKJx/gYnrwr+gpDNKQ80Dgba+rwbpT1zB++wiVas
         zflKlR+Lc1C5FRaCkgA4AbeZn/L8a0R5wsgXioHg9mz1MSYOxoeC/qu91EE2BoUbaR4x
         DvuJr6zrj2yFxrOPV5FGlkoFKZgEVlgswdfm6JKzKSCDZKa/qwxiF5i4BM1jWLWIivy4
         zemw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/1d1FzP0ryJ5NY6ezpeEBMM3Jqv7PiGRlFjuvkFLTZgu5IINeCH7v2zvAj2qo/eF4dPEEZaJHTCia4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3KXj8vV362luP64eTYWqggSikjv/peE60/woNzOg3NRkWNHr
	G+jg/pyO9yk/N83wUQXshWMmms8zFl/25I4qkEyUVrEVSyFdI44bfOcNr9/s8i7z7LBtbFGl+5Z
	sLAN2yG9RyEVi2adsjO0ANLIUXa8cjRcEQfwlVyJI
X-Gm-Gg: AR+sD10VnjAn6yl29OakPU6OuxyQpyXlzcNGlMVdQjyDFI82UjmQlIuOly4YA2Sg2Ti
	bh/XgpaQlXT6bGGZdZLwcnXEZBU4hm3VVoYK+P8ed2WC8Sj4GRWXgnWpBA2j7fQj+VIw6d9A4QP
	6jsXkOLZkfNK+zV4A6YhYbKerChD3FPkmu9lx5tM1+SD8/mGCbGHYwBuFWnaNJTLakieiDC4W4P
	1B7r+y4yPyRfE3oQnxdBfGsdpNBrlWiMgJFRW2RLXWmkLLs5ydc0gE7e4W4cohA78fCgSxtevtU
	TJbfyy178oLLJcBh+sIhl5Cpbb+rV9TNbHS20ZzXBwMp/51hnFNuX0vSAfrk3Ant2iV+7b9SD6l
	/NiOUZAs=
X-Received: by 2002:a05:6808:2f13:b0:495:d7ec:b6be with SMTP id
 5614622812f47-4b210ca8dc6mr1833103b6e.18.1786509593853; Tue, 11 Aug 2026
 21:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811122011.3539250-1-wenst@chromium.org> <20260811122011.3539250-2-wenst@chromium.org>
 <99ad23ba-f8f2-404b-960e-1c22a20c9ac4@sirena.org.uk>
In-Reply-To: <99ad23ba-f8f2-404b-960e-1c22a20c9ac4@sirena.org.uk>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 12 Aug 2026 12:39:42 +0800
X-Gm-Features: AUfX_myPgwTrMoDWlXxd7K4JTdOxXQP71DAA9qzbfq1hbTylwiYJcqKiFEh4if4
Message-ID: <CAGXv+5EeEQM6O8Vb8e8fGjRzMe1icmz=cPm3GoKLxvEO=weVcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] regulator: core: Add "enable and wait" functions
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:43=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Aug 11, 2026 at 08:20:01PM +0800, Chen-Yu Tsai wrote:
> > In device power sequencing and initialization use cases, it is common
> > for the driver to enable the regulator and then wait for a certain
> > period of time to pass before continuing.
>
> Please don't bury core changes for subsystems in the middle of random
> other serieses, this is the first time I've seen this.  :(

Sorry, that is entirely my fault. I was using an old v1 recipient list
on the previous two versions and that list didn't include you.

> > One case in particular is not optimized yet: a regulator left on either
> > by hardware reset default or by the bootloader, but does not have the
> > "regulator-boot-on" property set. As the enable timestamp only gets
> > updated when enabled by a consumer or by the core, the first enablement
> > always needs to wait.
>
> Just take a timestamp during registration if the regulator is enabled,
> we check if it's enabled anyway so we may as well take that as the last
> time the enable happened.

Yeah, I just haven't figured out where exactly in regulator_register() to
put it. I think it should be after the supplies are resolved, so maybe
I could do this in the "final setup" part in regulator_resolve_supply()?


Thanks
ChenYu
