Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792565202;
	b=VvKL6BAe9YsM2nwkn21LnTrPxmAtFjI1BvVPiItMOy0Fb1LFfYTwkaVjRSd98Ly7gO6Q
	 Tl3UJN5iP+gmzohTtp7JRRg6J/u+VIEvlhyGx/bo1GIh6dh4sSY6e3aXIU2KvHGQTexAq
	 VhVW39Vcar2MYQkWwFIA6+MOJIqeTwb82c2Og38XiBESv2S5cyhvuj92buZsSp+LhK8Sl
	 2nwVvyVGZErahgp1N8rnPTF7XEBnYuL/GLfpGvCzFZZkHUC5TatqGk8jBoK0mvzKb/Dph
	 1r7pBY5JuFjfMgyxQ4NHOPS30ggRQ1yYDt4Yy74nTOCFkcovnF2a00fJ7Jeq/zkkCMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
	b=zCiUPlpnB1/5rw6qZjc72sbhLMjd1r7r2OaisDxc169krWFAx8kiqNIM8dgbkRUIKx/U
	 7ykx3BUmZjNAiwnf3I+VYK5OQmio4wRisVgETYKELnD4zJ1mp4KeXWmmamzcE53q6h9dn
	 20eBD4GM+GMsX+EmcGcq7OiH4Av2MGkM7ZNJ+UXQ6BOg1zLMUv4sGVb/522Xknfz1EEAK
	 O0+sP/fGfMTYzYi2OE7Zn0AA+QOm206ooVJq100Axup3E8iEEQOSCXTjNN50ky/JRB5DI
	 Hc0pOwaKC643+WK/uTURQ4+dEv/0/3SMqoPDbfAZkvYFGZjCgRBFtiORPahRi7LAkAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhmxhi0T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E64606A31C
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 06:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E64606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhmxhi0T
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so777328eec.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 23:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792565201; cv=none;
        d=google.com; s=arc-20260327;
        b=Lr7BRjnH1Se8IJ8pyCldl8xQowH4GfDy1Vlguei2Yg3H6z/UNSLpY0H1poO1KvrpZT
         BXcm072KFNhYcD3rybThFpyuJn0nHOZhuuF5RK3mtnIU/GPOGL8nWkqbe/RgnqJ5ZVi6
         rHPCgwEb0TXJFRJg2ehrubidKNt5FINl0ZS5U+hYhXfDCjIxaU/4rG2UlbVljATWkpvw
         EVatp1BLB0RkUXCJ4hsaOCk2rJaTulQxmeRPU/YvPGHQJ/FU+gI2hXroaS1JisVZY20x
         zUsPeIQJPa6C35RHkYgLrf7Y2qhZj2Pggfxwosl9oIIbDGyL+bWmX9HVT7Exy0RNRhUX
         2zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
        fh=S3UrzzbZ3dM3bwKGR0V1vVRvbBWkn4mkiD1GG4Y3AMA=;
        b=KWXhhkOchHKw0/Nvl82A+5S+tOqxoZ5td1dd6RfcN9JIXdqejH/lPciRoOkoEUcw9f
         DgPGbLjfVBb1A0V6abfkAPqNqeLtkJekjEfG3FXpSddBEeC8NNOqXsv0wKNspz/M/H5W
         KejADglDIcSb8+bN3m4CUdRRAFFj34ZLQMJSC/LxmhwtEM496FdVIqkq4FHrx38W4QYw
         UB9fA7xvqauEbK8MpR3tju+U1Yii8DtgMJx/vCLcBbvYFwhDhAJI/LVhYeNNP/S0sLFG
         7exSM/thTn+3ZJUwOxIluDkFi71tm91326k2WKSw1Sc4ib+8JtLFIyZKceagJhXTJbNi
         bhSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565201; x=1793170001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
        b=qhmxhi0TbMwtXBvTVlFY4f2LPpHPl8poznD9dAUHw8+/Z9wZhQBqqYwfND7kTtB/dj
         BDT7fy1OHPOT3SsXcIJoCO2P5QWvHhSGsWpWrDlHwCxU3wdGdBZJo+CJDKK8hjNN6KtJ
         ZTBEpRPZ/CzppBKznbLND/WVtTUpHxpIjv8l4Dszl6GShVbqspGQMSfdEn1YLZCusCt9
         8XZUeUrLgiEXnrc9s2V2o2rhr6TPF2UsE6frYfs2vuDhFHmb1RIg6wUfaQGU2siObxeN
         QZxhnIASpBqZUpMRUn6UfJAhdRPi9Cf8ml1LkjDPLUFZ1OJH0H7A3t4eraOGGpReFZps
         J94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565201; x=1793170001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFx6RfKZoDg30I8aWbaaH8/QBhrTkiLCB5URy2j6R9Y=;
        b=1CRmQLCJ4YOoOn9+b3uL/eI9CGwX6HrTG2x/yX6vD1Z+cRWgo40d/TvODEBqW9z93G
         mfwpUOFioHkyJNrtabfS+hi4lNbczaQIGhKfI+4ZEBMEIEdHSDqum09m8J0pxIgoLvgA
         qoqr8zLUgWgRgyW+r9UyB5UvMhWOUtfeTS2p60th1ZvQWaaaeCwbOtMR4BkTGRiFu0iR
         /OgwEcXUiXjvz1XzEsAjjEo8jW9G5gASsux43kcQdpEKoYhZfQn88g17ju3+rePdMHl3
         BayJStZDmAhtpNIAOUfUM2FiHZwk+sw2uQNuBSTYTM6ccVgpjCs2R396rWEFO0eWAiTL
         8PVg==
X-Forwarded-Encrypted: i=1; AKwUvBwiVSVcbVZ63XfMICbnlta/MaDeqKkRurzUvhTyi9dG11Yl/CxTU51/a7oSfCAXHC4o8CKW11Riy7I/rw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLyiQY5i9roBD+w2FnZTIDsX/ezLPGpDq83gT0NKSNqf+Nrwrez
	hvS3cBW4x06Ntk0S7weY6NKvqlriwEa1wmPej15r08fF0Ghg767Nb2kk5I8lVKVbQ4JnMiewtbO
	wfO/MtBU/apoWNUbggV3l5b1proPkX5w=
X-Gm-Gg: AYBFou2TvZBGHFbpfesKmJee+2u5S6Ye0mTXWLGPCNIic4VIgCTjGBAkuVwU2lsDogu
	t39Vc9oloO375aQAaug7eskvboy4enVIZv/5D/waLCRCVTTqpiUDgjcZ4PRcDvZdloRAFFAILXN
	a7XU07IqIXi7Ga0wuV1JBZI1irrZliofzHHaEgVfpJyxSZYeI0Lm1cSloYauH7fKoVyAw3KRz7u
	yOdksNsj2tKEvFTF6dGzmJOMOLKX0DaZVmcVTsmkMZFVI00JdbdIHOI/jVEy4sGgX+zlyptEg6A
	P8tw/FhRRG8itRDl7dOmCa+HROXeOCjDVVUjENwDsqFps0qbk6L4t7gZSAoGQ347+hfWPw0WYB1
	/NouUdD7Osu3QyqBDv2/2xRMPdZLUriHnrCurcFeK+FQ5n1d8lD3xDJhpssmrEOgh19YbtA==
X-Received: by 2002:a05:693c:88c7:20b0:366:703c:5f0e with SMTP id
 5a478bee46e88-3674ef1f33cmr2092100eec.35.1792565200654; Tue, 20 Oct 2026
 23:46:40 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <20261019100406.103687-4-clamor95@gmail.com>
 <ate5K6ZdrSoBUI08@google.com>
In-Reply-To: <ate5K6ZdrSoBUI08@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 21 Oct 2026 09:46:29 +0300
X-Gm-Features: AclHuK9vSBGobmYgXVnmsJbAb2zJc_kKp_DYHLaIwx6A0bp9NGDYceSKiyk9FqE
Message-ID: <CAPVz0n13NFbY1ChZRkc8_2CQd8HfjahA-gcRWzxsv7KbAxf5Ag@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 20 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 22:0=
4 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Oct 19, 2026 at 01:04:02PM +0300, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add input driver for ASUS Transformer dock keyboard and touchpad.
> >
> > Some keys in ASUS Dock report keycodes that don't make sense according =
to
> > their position, this patch modifies the incoming data that is sent to
> > serio to send proper scancodes.
> >
> > Co-developed-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> > +static int asus_ec_kbc_probe(struct platform_device *pdev)
> > +{
> > +     struct asusec_core *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +     struct asus_ec_kbc_data *priv;
> > +     int error;
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, priv);
> > +
> > +     priv->ec =3D ec;
> > +     priv->parent =3D to_i2c_client(pdev->dev.parent);
> > +
> > +     error =3D asus_ec_register_serio(pdev, 0, "Keyboard", 0);
> > +     if (error)
> > +             return error;
> > +
> > +     error =3D asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_A=
UX_SEND);
> > +     if (error)
> > +             return error;
> > +
> > +     priv->nb.notifier_call =3D asus_ec_kbc_notify;
> > +
> > +     error =3D blocking_notifier_chain_register(&ec->notify_list, &pri=
v->nb);
> > +     if (error)
> > +             return dev_err_probe(&pdev->dev, error,
> > +                                  "failed to register blocking notifie=
r chain");
>
> I think sashiko is right that we need to register the notifier first,
> and in it check if serio ports are ready/registered or not. For that we
> probably need a lock and set pointers or flags in serio's start()/stop()
> or open()/close() methods.
>
> This can be done as a followup I think.
>

FYI, Sashiko likes to hallucinate. Initially notifier was registered
after ports, then sashiko suggested to move it before. Then in v10 it
fussed again and suggested to move after. Then v11 passed without
regressions and now in v12 it fusses again that notifier should be
before.

> Thanks.
>
> --
> Dmitry
