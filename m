Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794277347;
	b=pAtVl5OYj40dmw0whjKWPsVi3K1fr9AbTzntQVePRKwq7mc6AtDRb4sn1BRkPOlpeLNN
	 orE4aBP+sTRil8JZYc4kJu5lEv1b+M1+Zd+I/O21aQqFlF371eVqOTZdy3bKNtI1UrkFL
	 mWQF1kHPoACFJLJbnPA0Kayq6rKpLVguOptgPFt/2vQUBG3ICoqG5WbK2PGE3tBhlRMcv
	 pkUu1fxiWi0gc6F4fOlS4mT+uEsuh/E6mhHe3MpmaXw/kn0dbc0p2mch5vaWxQDOcxZM0
	 rUv22lPFcUK0hTuYmHSkzA3enJz09En9T/qF7mL6esB7Mm5mt7HMdGoXPEnYcqqeLNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4Wpwa4XVyGqQGugMaR06HSk6F68APSi1+DRWGbuhVww=;
	b=1fptb/tz8tzUFrvQSMdrOPWU7JlFOIdf8zeHeIlVoOv6QtBjt7qIbaGdB9lyGPtPfEhU
	 RGAb2dJ79YJWQMikndMc9uy3+gZKKYPDEcfeGfgPBBeUynFoUCH8nYzRGX5Uwr1rjF7LX
	 OM2IKiW6cfJWIlLNcAHT/OpOqUWvdAcU80aHE3XXtwoGpctarulcwqVj7M/25G19+1taO
	 UMdbv4gMjAYbIGqc1VT3mhoYZIlFzaHRQ2GgsNuDnx8IMFZvAJEuRIYwpSFHKLSxYl4CO
	 Xr3sG4kKXVQlheBBOu2RuO7a/ATUTwqQ4ol0MmNew99R2Fm5iWrLqYpc6ZfBh1qqxDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXxmrQJ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB07606A321
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB07606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXxmrQJ1
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso2265217a12.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794277345; cv=none;
        d=google.com; s=arc-20260327;
        b=dUyjHB92cNK61tj6IVoGShey3ECuKdFNcvznIdLhDs9eKO/5eN/o6kAc2pFgNQueyK
         O0YvW7urBHONbAwNJUJlR2j7dvKxUjkPCSZkmjLgnftJzdSBTY+Ul1cvIi4bwUEILxxI
         QqKVHt93kRhLxsTql2YKg34qAsWAAVKv81lwl5CBDuXpbkqFi4csEG3hl+BPbeyjPjHC
         JyFKeGiJh1gAGIyZHoluaS6NNxwFLdsqpaf/0CSxwgyx4R7EyuMzrkvArAtIbffFTIz6
         ZvwrV9U01MEujMILe7UKlvLBWZgW3Kog9UhaPWp5MdwzqRUeifcwHn+/Cy7+2+TgdnD3
         fHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Wpwa4XVyGqQGugMaR06HSk6F68APSi1+DRWGbuhVww=;
        fh=wdPd41xtOzwamEmE86f/+Hpoiy9Qk6qpB8YZYXXMKRc=;
        b=DxVJqCr/J/VQnFxFaF+ID9xN/L425Eo8MeoEVvAC0OLsD1em3EapRIjeOsLIU+bl46
         LtknPneHpqMpPjD/eMwksi926yPSm4kxKQ45uWg51HK3uRzRPe659/ZwM9fANJ58nsz3
         x79PSYzHAnDeygyzvIHO+nbwRbVV3OwREsUBmVsB8WjUjs6SRNpsrOeTG+Pt1UsUxOJm
         tDJAFikkP9nwP3Qj0Ule5tL2CAA8R+JYh+JQuxY7YiLqf/YZGavUVXlpqtaDKDiO7YmM
         BMMljku3yTSredfeBp4O+fPS0C8ypCEXYU4LrZntqHSe0YAgjspaPQ1UMC80fNMaCILH
         ESJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277345; x=1794882145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Wpwa4XVyGqQGugMaR06HSk6F68APSi1+DRWGbuhVww=;
        b=DXxmrQJ1EsrbNPhnqwrQVNpTjUWu3R+XkOju7bOqwzLAFQ4aJEYNYEuRKtTFVzrafc
         TRsT3xfuGj8ve+klCotLBnHjKaA17A6q4XDSC9dMCz40tRqF47pZYp5Ag53oJTP7T9f/
         hj+N/lw7OOEabRXog1qAKnaDpekqnGZSpfnXOpHw0xp+edy6LYuEXxzNXULArO5QivLv
         aRY2W4L9PPiEGTTCDMYq1EuH3NXDwzseOaYNs0JP/U6aBMD0XU6Ziz8U6EOCpInaH3nG
         uiTa9XHHo6xbD4JkoX92UtFPAr9it0WAdF/ywG4HjwaCLkd7SYzVIKYlYwb5AdqPlA/L
         UhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277345; x=1794882145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Wpwa4XVyGqQGugMaR06HSk6F68APSi1+DRWGbuhVww=;
        b=SczecEXVIj87giFdHX/YOiW0fXyGsoINP+VevmBUHhodxaa4pXl+0JY2+9Rx+tS0ry
         cajs8o4XCtBgB7CN9zan7qB11KOuG3KepVNdHINdVf3BugtI9ieVhspk4T+CPlHfGnFe
         zHxmuqPw9uNr2C0/KW+HOG9VhSNwbG6HG7eX8ixpfhk5aPtFN4lXoSlLY3EGbU7qwkhg
         eDu99c9tPRMOcD8OnAemsauUnxN/Z1lV+FVdq6k/akj9Bd4FQdw1OikzxFikaKtK6v//
         X7OXCUPr7rs7X1xT7l5CDzVICPC/f4FYhvjDoItNx431c6xSjihKEap0PHIIync+hnNQ
         gZsg==
X-Forwarded-Encrypted: i=1; AL+hErE2lFVoIi/UTJovdNOiXVNB/1z2PAghu8adA3pYdDti1ASltmGG5CPfzQY4DuIULY+9DTSug//lJhSVow==@vger.kernel.org
X-Gm-Message-State: APuU4Z9dHGr91d1byNz6ZTza0RDMb5SFA/LDwTcid7SKQdCbZALHwKKQ
	00ybpYgJ419wsYfUwgaTjKW7hLWvyFriEvQmzJyjBFRLPVSOpD9l/bCZePyeZlyUXI/g38IiGbj
	B+hnVJCQU8wS5s+grEm08flAcSZ7Dig==
X-Gm-Gg: AYBFou3TnSZoFIiXCxE6SR5jkJwgQjEWjpNLilFfRoq/GqNpL6T5jfavcv9NEhpz4eW
	6dvF8bAMpjIXhoQwEohyFPZcIfvLwlrKPpHbN+iSsdW/w8z49N0Dxaa312JwoWBo1jRd4vgC8Ei
	qDmRy8/XP5Y7lgoWDl1KLS65VsRu3aNEsKomrUW0gdjy4ehYLRmR68DY/J4AZYMtJwIn7NlneXx
	fIXf1PcKAr8YUHRKjfXnNQoL6ovF3E+wCts2GFzqpw/4HSFFA6zgqKL0xMM+rUR+n+NsyydAipA
	wSssnhmztA29BlWdC4nv1tQzAhh5Mw+/Qismy9fRVpIw1FnCCjBjNcxCLqzh/PkIMCSzUVvjW5X
	l+OMk0PHcjI0scTzRI6F+HVbuEiozzrmgSiXS9ZbiYuURhlKVdUc0K66KG+HzNrBMq33xUcHbXK
	8E/YzIyz++rEgX1lsEiBmSckhZ9ChHD9/Hv5y0hB83zl0Iq4I=
X-Received: by 2002:a17:906:ef0c:b0:c40:91fb:b76 with SMTP id
 a640c23a62f3a-c50495f09f8mr89856066b.33.1794277345504; Mon, 09 Nov 2026
 18:22:25 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016024300.3660850-1-mhun512@gmail.com> <atJycIEnUZKVdTjW@google.com>
In-Reply-To: <atJycIEnUZKVdTjW@google.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 9 Nov 2026 21:22:13 -0500
X-Gm-Features: AclHuK8xZhpHzpn9-AplnHcwkAVpxz6Qptfxkr2G4Zkv10w3cEkBO82uL0JlSd8
Message-ID: <CAGEsz8GKNh2K=22+_C-HWPFv6QUpSXbFWT6WmFX5gTSO-e9NtQ@mail.gmail.com>
Subject: Re: [PATCH] Input: wm831x-on - free the mapped IRQ on removal
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: patches@opensource.cirrus.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for the review. I've updated the patch to use managed IRQ/work
cleanup and MFD-provided mapped IRQs.

Polling is retained for release detection, since the chip only
interrupts on assertion.

Thanks,
Myeonghun

2026=EB=85=84 10=EC=9B=94 16=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 2:57, =
Dmitry Torokhov <dmitry.torokhov@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:

>
> Hi Myeonghun,
>
> On Thu, Oct 15, 2026 at 10:43:00PM -0400, Myeonghun Pak wrote:
> > Probe requests the Linux IRQ returned by wm831x_irq(), but remove
> > passes the untransformed MFD IRQ resource to free_irq(). The two number=
s
> > are not guaranteed to match. If they differ, the ON handler remains
> > registered and can queue polling work after the input device and driver
> > data have been released.
> >
> > Store the requested IRQ and free it before cancelling polling work on
> > removal. Also cancel already queued work after free_irq() when input
> > registration fails; free_irq() waits for the handler but does not cance=
l
> > its work.
>
> Why don't we switch to devm_delayed_work_autocancel() and
> devm_request_irq() (or maybe use devm_request_threaded_itq() and get rid
> of the delayed work)?
>
> Also we need to get rid of wm831_irq() and make MFD give us already
> mapped interrupt.
>
> Thanks.
>
> --
> Dmitry
