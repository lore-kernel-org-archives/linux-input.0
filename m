Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DF35C183
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759233; cv=pass; b=J7rRHNSqFFmBewQ2v8pdlJlQncge2isEKdt2G+fACChVJaDs2kKRcRXtEEoy/gHG1ee79NjeWgLMQrIqZAv0IWa1LD715mybIiqcpm6ObAmr0N5nH/vBcJwEBu9H1ZFD0XocBfIX0QIZDO/atdtuD4NGAAAz5+FPq1UuJLZZFEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759233; c=relaxed/simple;
	bh=l4nZDKpyYtGn7RADpBwCfZqfWe7RRY863TVDRoW05UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYzE0LRIKeXRCZ4MnuFdT8rcMUiZLDDiybAzi1T0R4kRUlDmhVARXjtmAa9TLzIOjJLx7YwCzD5ec1SwamPyqN9zYp6TDbGCE42g+2zWK2t8XepGHUij87kFHwD98bBMnXcnC5b+rZ2cbs//eOsrKy1cEaySCKDx1EiEV8sd7jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciD6w6+2; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciD6w6+2"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84847482584so2086786b3a.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 05:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759231; cv=none;
        d=google.com; s=arc-20260327;
        b=hC5CvWkcBe7gbYleEiW+FMUQND+EHR3ljCFdsfBUqgA9O/v7Z1y6By9v9tHNuSKp5o
         4XOzSHAfF4XRY6B5VwnBMEMsl+YPeU0AUPHSBRoBrQbKJAdzrYuZM3GSSswU13hWSM2k
         ACKi/xCIpoflfYAk3VsdHfEpng4Yq/yTICzJiyVQGvR41dPi2KiBHL2Bg72C0ANWfYhD
         sE/gPfhHhwCgcFmKWG0OG++SAYoIAVmpQnzzQA4Gp7ETVuBLBiDpMgKB/4yRYe97n2ch
         1593vwv0TaoY2F6FByK81H/YgcxPBBX8287RpO9MLX0yZoMnHBah+c4eMQpAuD4aGM4M
         E0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u2srZ31RsJS5dafhIEx9nnBCgcE4tew69AS8GwZZ4gA=;
        fh=r1SmuaAEfRbXJdTeCTI/CUUOFHZBkD/GVUjXRyL6yLg=;
        b=hW8wLfuM5c5nAXSdbipWEFN7va6IuVvR6Zj0ruhacxCrgoVXTqJy18XfK3y0fNGI1j
         bCpUwuTPp9fWhDyX6JKtZYHgqLGKDF96GEqrun3KA6AK/bKwxYAvBxC76BOLUReYd/G2
         XUoSp55YL6jiE0Vd80Hmf9olqAtu2sukodpOU/o3uX9qlhfji+LKW90hU0M4LGAo+rj/
         Z7swP7Sk+ZoAQg8rYH5HJ3+Tn5CfBzp0vvNVGzwyoFBi6hVxnoInRhk/+y/51P7/y0Q8
         gHsmVosdI2YTuZSU071I7AH+0aURATV08uZ2h4U6DK55xvXZo65PAUVXQyEyte6J8VZY
         Z07Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759231; x=1786364031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u2srZ31RsJS5dafhIEx9nnBCgcE4tew69AS8GwZZ4gA=;
        b=ciD6w6+2Yv+QyeflkQC71pK82nwqymBFu5jUi72/x7gMhMhlKDFtgnE3P9GYuVMBnb
         WW2yGkpE84f1fKyXo4CIahS9zrzYc0cDDW2FVuFrRLl9zRcramsJEmHOq0Fo4kumdsJw
         9tSYu8dLgAZQ73l8G7hhO1NtVihN9APzcyHDmpxwL9phRKNmogBYDSeg6Hf5QjM8zU5B
         DcrW1rwIrGsfK/6o4ut6KxgKdwn3J3bjCsKTveL3m+1TcbPl5v9iShCEHj8ewdhj3Gjv
         06S3Dheibo5hZvlMppLwp5wMDCjML363/NyL5hIBtTDmdJW2BsSJEfkPaa5PQWwCy/LB
         cNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759231; x=1786364031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2srZ31RsJS5dafhIEx9nnBCgcE4tew69AS8GwZZ4gA=;
        b=nHGaa/4gK3uKIdbAvYdviBEDMBm00kQfYHLyhSYRe+76KjxDa16Qe+vnRWMKSu+KYT
         uu+OjyNSqXo8QlMuwomeqTCg7G6m1Y6PHPbZhQKuzihO0uuIDLZsDtMsHIie5IP44hVf
         q6lcz3yCs87Qzg2bl8A8rLPblAqpOoed2AIMGOJ9FTer4YZOD0aWesL3p1b97YDfKNlv
         Rso+Ib9D3uDMs2eObd/mOuP9abe4tocq+jRJf6eG0J/UnXaFDXNSwRgk5RGZtTdDfxBI
         DoCZ+avSWLd9cteE70VII5IprTA9E77o9sG03wXTvFie7z+QsIlJnzNN1uMPNT2xHjwd
         zw6A==
X-Forwarded-Encrypted: i=1; AHgh+Rq3m/xaZln2GZVGZny2UXlpOeX/eNKKW66VB0fnRaLl4yVp8WLCrBmWtxrZyAFmn1zep3J4zydieH+Pmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuKSVCaBR0UPqijfv+wBCk8zuJwJH9d8qdW02NQx4erEvkHSO
	GBqjLULIeAjFPFULufatAZeGVcE01Q1/D8CW75q9ukfBYgV7QszgHe6V/38n1vEreGZGY6lO5jJ
	NqUW10oQjX01K9WnFPFWttv0iq7p3h1wxTcyY47fyoEw1
X-Gm-Gg: AR+sD120m2OK0kM7aSwWFUW5dYj+e0MrImItadkiUwvJ3laN5udJtWJaKn/9BP90htx
	jCwEV+I6hjYAN2HBjp7gEh509MwmcSsadzR4u3cLkVTgaSfn33p9ZFmOXBlHvOEc8Hhjzu/RpvG
	W1Abcq55pidT4Xv/pxAdYABMLVImcfyBCofF24Vx0zqQRD6Jn0UAgVnBdUGOP+GFjQTWM6tz+Gg
	28eI4a2khaE6L6irKs7L0wX5BOCytOIa8PNuRH1w+X+fkxhP5YNZstA+sTIUUqhfe8JYXEH0s/t
	pHV5En3Jr8M0p+oVx2wlJdFQ8EYATdnu4U06GaqLkIM=
X-Received: by 2002:a05:6a00:338c:b0:848:7bcf:9a9a with SMTP id
 d2e1a72fcca58-84ee4811e12mr8527892b3a.1.1785759231024; Mon, 03 Aug 2026
 05:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801075623.2769601-1-mapengyu@gmail.com> <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
In-Reply-To: <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Mon, 3 Aug 2026 20:13:39 +0800
X-Gm-Features: AUfX_mwm0HHyQAaXWiuFnvTJ6pnwHzjgMJlA3K3GxSGtco__CpTqjpvvTynPGok
Message-ID: <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Sanjay Govind <sanjay.govind9@gmail.com>, Kees Cook <kees@kernel.org>, 
	Zoltan Illes <zoliviragh@gmail.com>, Qbeliw Tanaka <q.tanaka@gmx.com>, 
	Elliot Tester <elliotctester@gmail.com>, Dmitriy Zharov <contact@zharov.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 5:40=E2=80=AFPM Shengyu Qu <wiagn233@outlook.com> wr=
ote:
>
>
>
> =E5=9C=A8 2026/8/1 15:56, Aaron Ma =E5=86=99=E9=81=93:
>
> > @@ -334,6 +335,7 @@ static const struct xpad_device {
> >       { 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
> >       { 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX3=
60 },
> >       { 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX3=
60 },
> > +     { 0x20bc, 0x5159, "Beitong BTP-KP20D Controller", 0, XTYPE_XBOX36=
0, FLAG_MS_OS_DESC },
>
> I think using dongle instead of controller is more clear? Since
> controller itself use a different VID.
>

This is the controller VID.
The controller is idVendor=3D20bc
The dongle ID is idVendor=3D20dd.

Aaron

> >       { 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_=
XBOXONE },
> >       { 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Seri=
es X|S", 0, XTYPE_XBOXONE },
> >       { 0x20d6, 0x2064, "PowerA Wired Controller for Xbox", MAP_SHARE_B=
UTTON, XTYPE_XBOXONE },
