Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E44477986
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634481; cv=pass; b=YCdkw7zyWFNZV8R3H32sur/ml4Kjpb5aCVtpVJOYU/Xk8LkQcfBaz43AQqEP9ng+/UmXqAYIUfNVAHItrLfE1yMeWkrZrHeccSl0ad8VklVMPQRyEWM/mN8x/beuDuW1kt3NTR0CeLvAtIRHhhzNlgmgsPnLuZJDYuuroyHXhxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634481; c=relaxed/simple;
	bh=9KYQVeJqDC6g30EpuQzxpSpMc6t69Vhk0PPkMRQVSyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auqKOWBNSAIibKgvATC9mceATW2saN+hIY1Htoo3308q2/hH1hjMWW0/pe2CTF7L8fByXL0FiQQk8vO5eLfRBG7Y+42jauqNmq5sFcDJ8A95fk4wX0Hwu6UCW22SETJhb3CthZqJH7VO94pYyAf7qBz01NjMAIoWqwFh91oOGeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTwlxC78; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTwlxC78"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so43642656d6.3
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781634479; cv=none;
        d=google.com; s=arc-20240605;
        b=ihR7Vr+O4SeFwufb+5uevBCLWLt1I+/BOQLnvYHms4h2ona8Slp5vDtEU7LZEV0qvw
         L1frhbYlOrrEslL/HMG1yyPd1bIR42MT/eqFFKaV9jpz/ffA6r3ykOh8G+wriBiRK+7F
         TsCBd5ZSGu2dyjlASJFLiE4k9CZwZa+gfRrrTgBOdaDLWo/yrV1tFhGAuWIpCcx2hlxX
         vYM0TBv4dkWn2pTp/d4V+R/ex7I+4i8zlWlEo3YVS2428QYJHHEfktJHt0WxmZ5KQW3i
         GQCMXhJzL3fMGPLQQBorHIl/68kkiKDeuzT7C9wqsHUi4GXojbGOe9E2Fa4NwsRCVS72
         7vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vT2fTPXtlvAkXE4MH/BbVJEoLSXIJf8BKKcZALaH+9Q=;
        fh=BVxRsheYRTuKSGwTwijMNBDRbAHzVfBjcaaOwFi0VeM=;
        b=J8jS40fKH0o4Zxeb5cVtFffGKXpGBPLXXdpKtQ9G0sDSW8/zJwZkOFoqskfDPBoq8Y
         KNO6ITKjMpRtjw4IBk/1g0ejQbJ8YvdKO+Pt3N5vEKpAb+dMfIPV5HBGuRuGgMdFWfxH
         eC4BW/xnpD6yq6SeyXuQlX7NYfn3nBMJIcuhuV5bhgdqKRMqY7WwC5axhDLdHhlCrMmu
         F8D1unsIzIwC30xOhgzxVNRCnjTBRXrbYVabDCz3h48BEOFRkWs7xpI3M/310u+YAbTE
         5mPxVLSqYfzKWa++bFSB4UUVZV0IJCDGxcpEu1ZbIbjQj595Yxxvr8zqptoS4QhDn3rB
         aB6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634479; x=1782239279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT2fTPXtlvAkXE4MH/BbVJEoLSXIJf8BKKcZALaH+9Q=;
        b=YTwlxC78wEi/cVcOdEvE4BsTdOWoPF5MvjJ0TbnQ/k2uGcaTy0hS+yoQdYbg7hFIC3
         bRxwA44QVz2yTwvor3CT96YMojDjrZyROZWXtrZIj+rIQhZ5om/+CzHzm52moXiJlpou
         iOhD4rGPeYv1qACz7X2/kCm3I5agWqUxWDTAFMpXx4UA9UxPqc/CpGeSi7GjScKrQ07l
         II3Vhg5dAMlNxZhkNfcSucbd2RFruVuBzbn689VmWsU7EAMac3eBmQlg65mjLqVUiRRS
         jXRjAJ8vfcqUMMcZFr1isNtf8xsJjC+JDfrFvrjddceygjqSsghjj6l86oCDZNOJylnz
         QjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634479; x=1782239279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vT2fTPXtlvAkXE4MH/BbVJEoLSXIJf8BKKcZALaH+9Q=;
        b=TJZSQ2ibwzDB84G3vz1hLcyhIdBr2DI1aphO6ZdrO5B50AUXI/cLRYpsyE0mOtBR3p
         D4KfjoZR+C8i9yje1/QYLebT3Rco1KnJEq4kngoOEeR9YY+iI3ReABrBtDV+/nDr9B96
         GwzD3o02JAnYEtSHPq0J5gbFct0loyBAflheINkWHiPBiDA8kGyxkg8KIqQvTwVrib2C
         u3PMO+MewIUJ3PvkxdcCjiBPGR19DMl+DnEoZ8rlg7sclRqQGGNWtWg//oVwtj3dVDOD
         W5XapL4B4IAIKV9x0734A2O9RBauXPrnScsdj0BPduBDSpgtvOoohDZeBQuPzPBqTsJG
         BduQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AsSXPLjcINuKAtTLAiokm6gzNk+sJxDF1YtZLhi9iw35bIbT86R9VFTduFc/9UwdnTe503yEq7LyR5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39m+ehJOwM6ZEd3fosZjKsaK63H1W5eAClenhxYcplD6Rdy5H
	uonMPyufj5gWRrkrVpXf0gIRGfHRLWZ6bKNud1EZUNovfpruUSoFLcJ3njQKFrorXJE1cIx/r35
	n5bj1L9WbTo7eNW3/xgDvYMSpbmjflUM=
X-Gm-Gg: Acq92OG6d2ueMLQa36nnCehzkvlDWIKG1Wfixx3RxY3AUwwImqUUN34jU/BGGHmQBqr
	bOjOV1DDJqTx8Pz01b9gObkzLSKDjKottzGaG+RetpYBLO4n9fqfL1sY3HZnfr1j3z4n3vPAdNe
	p7UPMX+cM8VCYozAkvnLlub6ZDH/epgiOe2f1vCLio/uAtYP+Flyt7+ob+sJgwv8aKGU/oAVJTv
	Dx8PCRbetAk8X3/mkImz7EfzNl558x9TSFwQ7PasLxijBIUdSm7QV08GxVdhcwbXh5P4nRlnHpN
	hoYHcu9E
X-Received: by 2002:ad4:4390:0:b0:8d1:97c5:857a with SMTP id
 6a1803df08f44-8db60cf71d9mr9463786d6.42.1781634478692; Tue, 16 Jun 2026
 11:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606040344.4-1-ruoyuw560@gmail.com>
In-Reply-To: <20260606040344.4-1-ruoyuw560@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 16 Jun 2026 11:27:47 -0700
X-Gm-Features: AVVi8Cckv190Y7JouFrEJYeYs6MveiCvkIX_CfpSKAfHznXnQJgB5HvboQR-6Fs
Message-ID: <CANRwn3Rbieap2tYacOrwABg6f0xxEKPgG1AVVt6Y5VYpsyW+=g@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: handle kmemdup failure in Bluetooth IRQ path
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:04=E2=80=AFPM Ruoyu Wang <ruoyuw560@gmail.com> wro=
te:
>
> wacom_intuos_bt_irq() duplicates the input report with kmemdup() and then
> uses data[0] to dispatch the report type. If the allocation fails, the
> switch statement dereferences a NULL pointer.
>
> Handle allocation failure by dropping the report. This keeps the
> interrupt path from dereferencing a NULL buffer while preserving the
> existing return convention for ignored or malformed reports.
>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625d..c42af15e7dba0 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1206,6 +1206,9 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wa=
com, size_t len)
>         int i =3D 1;
>         unsigned power_raw, battery_capacity, bat_charging, ps_connected;
>
> +       if (!data)
> +               return 0;
> +

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Though, I think we should also (or instead?) entertain a change that
does away with the kmemdup entirely... Replacing this kmemdup and the
memcpy in wacom_intuos_bt_process_data with some simple pointer
manipulation should have the same effect with less work.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>         switch (data[0]) {
>         case 0x04:
>                 if (len < 32) {
> --
> 2.34.1
>
>
