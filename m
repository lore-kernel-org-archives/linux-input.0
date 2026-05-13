Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE393D34A6
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655142; cv=pass; b=WUzV9VTLX44f03yFP7S40lPwHKD1UFKt5j7cf/PDwcYn9sWyYPEBz19cuckdxrw28qTtVdcYVm/LTzP5QL7ywD41Pyqt5g+13BpVZr/AAU1ASDMOAh068+8LI07X+bzRmArsPkV3WX3mOgviiPxOUYUgGCaBzbVpHl4ex/xdVLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655142; c=relaxed/simple;
	bh=lAXhm8pLEII8v+ZINmHWk1Y/ZMypKtV4TCwQgI+VZRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcfMQmj1YrS6znfeG+KdBqVNy0mDpgQCbs1DU3KIX66n+D8ctId8fv+rAebAs9bIVD6oQXZk1xBC0jIqe056knoPM+FlRtsYpGNLof45cZfAvCJ2n64HA1HR4chEXjbr+Vhe6OsUYiwRj3ySWfBPwqLqKPZMrGx/ps0Ykxv711I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBxfNZg9; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBxfNZg9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcc1459daddso615138366b.1
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 23:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778655139; cv=none;
        d=google.com; s=arc-20240605;
        b=GWlPbIvawu1rNvhG13fTT1j69sORSt+S4xmUPldpP1ZUa3CFGMaTIYuB6hxkb1c+8h
         rXa4owjfgbZIkI0M7RKJiOkulhuz533+6Ujs2al/5oUzoZmRB3q323Bo8sPg+vGrrEPF
         vmPCQ02eNrSKuAgNZwrU2VqoeJvT0wXTVnabzKBuBSZcHyGKdFr22OYjALZsjpMcHaE1
         AKnAqggVzxtgcUc9mbBhm5lrCgltG3M8ZdzMsV82N5G3ePaMHFqVLBbqcNm/arZ11jxc
         dCXX62UmtIxgVqRnSqLv/9BtY7qwLKz6YoeQhu2LbcjX9MtGwyMNPS/cUYeZIvC5kUE/
         /kHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uLXdefzcXVe7MnIsVYDrJx66lKMvUZbM4WU0L3fSWiM=;
        fh=G6nra929vlaMzliV/X7/97Fng8G4i+tVci/hb32Hd+I=;
        b=YvCslrHCbIU+eEdtigcQTJjvFqBXBnabLMRfptSsPqCkJNqsVvI7BSuW1ojhffBfSI
         z3Wem1qa/EnsrHMX0WOYiBqS6FsFr7aWQS4mhDQCGIEH2NK49ffQsuR+Egzx+FepLMj5
         YOpocAEljovZ+WdgZWCifEtuXLb5tGLQoautmVOJ4l59774dCUbYIuueYc24hreWk3uG
         AJQLSlNq+I3yaGYKKpTTQJNhpBvf4eNyhSX/Ze2ofNzJWVZg+qyg3LIvDs+v8dbQbXU7
         KkQ393eeTtNhGhzgPr5LfiD07a7+FgIx89Lkan4y3D201lk45L9+2DPBC3BN/Us9Jxo7
         /xsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778655139; x=1779259939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLXdefzcXVe7MnIsVYDrJx66lKMvUZbM4WU0L3fSWiM=;
        b=GBxfNZg9AH4caWBUaAuXQrgHB34AlnkKHG5zE558W2eW53wSuzKLge0MwR3FOqgh2v
         BPKjFEkPhRKYTmaB1sEY8lWYSHR9Tp5xWWmkFB2crzYODrtMDZy3Dr08AbYCul8tSak3
         qORTD7XU88OMWJ4CqHLtjyFVAK27Q+K9IFOD+pz4MBbdoVZ5Ec+p8I4psw9FUgMQDXHQ
         hiqyJKWjtPSzt4Ej7YHcKkCvUd/XBX/NhvTR9xxjJdWQ7icTZRBnaE1LhdJb9yrh51hu
         saomdBLEdwPl9XgkyrpwxAXaoIVO/ULlCna3kuWRCm1jbbUzfDV/AzIjFBAbirSpJaHN
         /aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655139; x=1779259939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLXdefzcXVe7MnIsVYDrJx66lKMvUZbM4WU0L3fSWiM=;
        b=aZw7b6ZZzFoJ0uRbdcVo3MhjRWootoDK1WwZ1Xk2SUSpY26F5LwI2LUMbMA/23xha+
         EqEUa5RZOskELeK8+F/Fo9VQduhK8yjBRybNR5o0S43wa4iyBcQXDvvP9ePvXtgaAxbO
         o+r4guy0qzEqVLEgM6CP7z6ZiHnEEQzrdNLG21ahGcLv2kNpaNvSXeGIqYSZwm52Otf1
         KoDwr5JeiE0+CRxyk9JAnl/BDL28HtLz/NCGqooiKSA3D7/69lswNxGMbvEELW4lbGuS
         3/KsIDfamdShQ2KloSx+b47i+FQxT6BtYNiSDu2wR8hWMha3OAu0z2wEbmra/a7ds4Ec
         b7dA==
X-Forwarded-Encrypted: i=1; AFNElJ+eFxXW0NQZKsA++alfH6bJjyQC4U5zfEomoPt3Z58EdfkkY2imj2bykbUeIdYrzoz4BIoBw7KBuu40Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgEdcZcuEUr3VpEm0q/Z0eVJGlRwEGK6oAxLi8maiiwZaOWji7
	hvblNrUgHJVEsonzwceqvknSA76aT1wwb5Ais6jSdqBsweGsxvIsTcC9IDjcCHcuLOl6TciLWpQ
	ZJDOOKW3ktaKsDsGA1g5AfZyhgQGxvA==
X-Gm-Gg: Acq92OFZ6uBKetpMHYAIAtuYzofUKDG/MoqSrzU7TWvrp7LJTFkCvK6Z6I4M/3gmqmB
	iNCJfBQWEPohaaMor3CVgugtzD7ZbpND0WJf+JoQ0QXYZyp+9F44wDP7bGz4oUEEcisqyJjc7dy
	rzuUveLug2O1RS7KeAG6x+QLtH/tcEmOTkBVw+CBfZqXk7rQNR6fjGEN1hz/6kvk3lkmQnFsRLT
	d/tiwHXxwcm0cuaXrb753yGOS+5I6spo8a23PkyNSuRjq+hsMQvFOSGQDCfZ53ZuFDbrG3I0zMs
	RRpX6szXLREs+Q9vWO2RIaqUfIWpwblq4mx4XfAaPtufGPmjkQ==
X-Received: by 2002:a17:906:7945:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-bd3dfc6cea8mr87282366b.13.1778655139292; Tue, 12 May 2026
 23:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424125043.52639-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
 <42o9po52-64po-n8o8-or3q-q439o09s2p0p@xreary.bet>
In-Reply-To: <42o9po52-64po-n8o8-or3q-q439o09s2p0p@xreary.bet>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 13 May 2026 15:52:08 +0900
X-Gm-Features: AVHnY4JWUsfldQtQ2PfS8jTmoY2MO5wc1JELHmkxlSsiOT6Dxc19wi5NSCsQDuc
Message-ID: <CAGEsz8HjsBsrZUi+OETe0N3krxObyxQi5--xX4_4gkNeDVY8cw@mail.gmail.com>
Subject: Re: [PATCH] HID: google: hammer: stop hardware on devres action failure
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jiri,

Thanks for applying the patch.

Best regards,
Myeonghun

2026=EB=85=84 5=EC=9B=94 13=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:01, J=
iri Kosina <jikos@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, 24 Apr 2026, =EB=B0=95=EB=AA=85=ED=9B=88 wrote:
>
> > From: Myeonghun Pak <mhun512@gmail.com>
> >
> > hammer_probe() starts the HID hardware before registering the devres
> > action that stops it. If devm_add_action() fails, probe returns an
> > error with the hardware still started because the cleanup action was
> > never registered and the driver's remove callback is not called after a
> > failed probe.
> >
> > Use devm_add_action_or_reset() so the stop action runs immediately on
> > registration failure while preserving the existing devres-managed clean=
up
> > path for later probe failures and remove.
> >
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/hid/hid-google-hammer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-h=
ammer.c
> > index 1af477e584..c99c3c0d44 100644
> > --- a/drivers/hid/hid-google-hammer.c
> > +++ b/drivers/hid/hid-google-hammer.c
> > @@ -496,7 +496,7 @@ static int hammer_probe(struct hid_device *hdev,
> >       if (error)
> >               return error;
> >
> > -     error =3D devm_add_action(&hdev->dev, hammer_stop, hdev);
> > +     error =3D devm_add_action_or_reset(&hdev->dev, hammer_stop, hdev)=
;
>
> Makes sense, thanks for catching it. Applied.
>
> --
> Jiri Kosina
> SUSE Labs
>
