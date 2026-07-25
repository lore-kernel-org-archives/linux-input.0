Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D1175A7C
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784981441; cv=pass; b=nCGoUHyqra/WRin5NjjWxpTNgvkb1B5FBYSgETqj5g5XljeqMgd/m11a1gjWh7Bws2Nk6PLvTiazv3MmW868s5OnQaYDrkeM/qdEFaTA96WBzV+psP6HO7Y6yd//fO7+0lDgI+8VAUxbFxHB3BFHFakHuOKnarm6QDXNK60dBrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784981441; c=relaxed/simple;
	bh=ceWHJRMvj/iH3Uen6J609HInGfD8eBkHTTISpeXxA98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw1T6nHdoPcpSy5vUND1pwVTPZeq39nxIQWkeYQ0UEySu1RH2tufA9WuFyec3U3mPlchI0J5UhIMQXBqCN8qJo2VlTdKo+2LuoEjQBh7fc3MgW7bfzPQ5LDaY/ylhFQ6ydfYj3rheVK/F5NC6hmtkpOXJXpy/3PkvE1jXM3n9c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vss2EW6Q; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vss2EW6Q"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81ef8255cccso12453897b3.0
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 05:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784981439; cv=none;
        d=google.com; s=arc-20260327;
        b=JGrJo4Jv9EtGwqUaCakGnVePoB9aeikNULrqygJK28Dc5Cu07HA5X1DVk6p1ZwnRD7
         xGTdiEpTTQSZX+8vIo4lGZRDu3LHGb6sFLsp6thAwVwGSLsmmhNV+LFk4ChzGTWgrGtJ
         Yte/hJy5+r0mil5HVnzrA31aLTteLtg6eIWGMivKNqNgJ1xI7lzVmMZ+GZ7EUOtDgp4x
         XZRA5U6YoZLZOJNMets/ZVFLa18ywZBDFJ/LCkvoj7dY4q9VISwwHlISvx7VtaZu6Z9y
         9nK1vSvbWGB7druJQmUtg2iQNYzNgoJ0Bvvw/7t/yK23wkvgu+3zXMDIwOGnaB271HNt
         xlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UQjzIwc9gBDFc7HsB7Hlk+0zGjSPBDo4bGGeN0vUKb0=;
        fh=S9721dI85KVxi9XS0Oe92vkA4WU9UFrYFsrWqSmCuno=;
        b=hTvfWl78VDX6eKIswDk2fHOU9OmMYyjomRubzwPm5MOsE7AEXD0pvr6jZNm5F/snF+
         ODfq2iI2VZhpcpZVACca/6UrB1tIkMtcjPoXzsubv9t3qMe8f2rcDPrtKeuABZ16fOGM
         16koiSvvKua1D/cGjyLEeGkAy5IZ1IyJCCoKEvGc84nME0fTyAbf8M7VY2NHoti7Kj1z
         UAAZR35O5htrfolPM3hCfrKbTxhwXME1RPmdmU6OrjZIzHXWZZgAQMKKa0tPYUtavaQA
         MZPzOinr6dt9+2ekART8uW0pRar+xoiISrZLpv/KRMmNRazQYXF2a8qzXmqWSkTbm2ks
         BCWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784981439; x=1785586239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UQjzIwc9gBDFc7HsB7Hlk+0zGjSPBDo4bGGeN0vUKb0=;
        b=Vss2EW6QL0IlYVUPoHrehb3pRC8j6nDme/WVntXOU6z6mAdc7MrSU/o5iYdjm4S1rB
         QaqLlwTtbzweOAkTZ0dvULHxn4ZhWTxhTLbjBMexSEthXWezR2RRi1Vz+ib5syaf32Xn
         47PUAnz5mdRKAvvyLvsRbahClKNuBWjoF2kH2Wdnc5XDUEcgtWn1zDZuncdHNmsZwl5w
         hP4kLb/JRhRIEtoMJ8xXfNJpsxJ4upvTjiUbUtzmw2hZA3vJ2a2YrGvvvqpttgeJKxbv
         tY9xwKFG3ubhJryyexFjW5Vxbwtw6JRMG6SCMPJj5VGdc2Xvw9VBd0jf0FugsLkeN8pC
         ELag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784981439; x=1785586239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQjzIwc9gBDFc7HsB7Hlk+0zGjSPBDo4bGGeN0vUKb0=;
        b=J4Ht6Pqasm5MNbP2BF4VdAxErTybx2ajtmzp5AcwdDTLJ+zxeQj5LiZw+nT9eFvlUL
         TbzgM8GW+h/g0sQpxYLOFaVSAsdTsvvwS5DHxGjYGXPExx80IL6NIClu5bneKl+IC0oE
         d2T1CR7ET3MyBwvBHdn5aXygXAnp2llfq5lewyFlEGeE8GgalIqWhGdPztt9Q6dfHsSQ
         FdscD+gYUT7oLn5Bqr1vn7PM6Eu67KSXswOwjD7ZTjeyK50+pyXup89aPdgMQgaylWwZ
         cPNeSeI1mUxqjV8rBk2kjQgxEUsKz0K2O5CvtROfFp9j2juwYG3/Va+NdH1o/rsMhqXw
         aUhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVc18ou6qCeeGSphzEQloFZQfkq+a/gD/7MyQih6aU5/lVQZXF+TFM+MSP+UWptp9kqG2OB3qg1vr7xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3D1uGkgcwaI/6pyc3Zi4sqGxqqmwJ4yS8HcTB/FX2U1aIxBDf
	+c45Xbilh56+21X/Uy+ISeLW5hN2+xwe/dE3Kv4TR3ABXjYKTr1qKEGoMCXQtlY+TAWbPZ2WphM
	GHyCN3aEq9YVIl2GRHOA11XVrnhVhoKMLYlV1bkc=
X-Gm-Gg: AR+sD12q1S8f8nZIyGIISfJskVXk4XAli5N8CBZ8AQNV3JDLjnn7EpPhn0Fd7Jl53PV
	ttjJHouUm0hCQG5QlemxOwf8SZALbgfols2Bu6eSjtkrPFGGpM/Z7DErztAwJRgLvcgvBUzLsVW
	5YNPosNdLaPa/de8Bxon0T6MChM5UxJbtn67HnJa0I1HhX5Pfnc6k1L8VighZ8q9snJD+65b/Fr
	C5IE0iPjq6I/FlrNwc6HCG9yrUEr7mPzl9ebVP4UwJbudVsq8cWElEXtkzSRQV4DxqyHQ==
X-Received: by 2002:a05:690c:305:b0:7bd:8cd8:de2e with SMTP id
 00721157ae682-81f69e2bb70mr6170037b3.46.1784981438688; Sat, 25 Jul 2026
 05:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-17-ekffu200098@gmail.com> <amO8lj_0sqBFOqub@google.com>
In-Reply-To: <amO8lj_0sqBFOqub@google.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 21:10:27 +0900
X-Gm-Features: AUfX_mzp1C69m7KmXLhoQ5EcoqcgNae9idEmqSeAXBncFwjmvwP1WlrmgDUo-P4
Message-ID: <CABFDxMGfrah3AKumyWAkxose5VnF9frZ6Jp3dxpPTStetr4ryQ@mail.gmail.com>
Subject: Re: [PATCH 16/36] Input: remove conditional return with no effect
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Julia.Lawall@inria.fr, cocci@inria.fr, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jul 25, 2026 at 4:30=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Jul 24, 2026 at 03:45:18AM +0900, Sang-Heon Jeon wrote:
> > Both branches of the check return the same value, so the check has
> > no effect. Remove it and return the value directly.
> >
> > This is the result of running the Coccinelle script from
> > scripts/coccinelle/misc/cond_return_no_effect.cocci.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/input/keyboard/pmic8xxx-keypad.c | 8 +-------
> >  drivers/input/mouse/synaptics_i2c.c      | 6 +-----
> >  drivers/input/rmi4/rmi_smbus.c           | 7 +------
> >  3 files changed, 3 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/k=
eyboard/pmic8xxx-keypad.c
> > index 35d1aa2a22a5..c916e80e2f58 100644
> > --- a/drivers/input/keyboard/pmic8xxx-keypad.c
> > +++ b/drivers/input/keyboard/pmic8xxx-keypad.c
> > @@ -462,15 +462,9 @@ static int pmic8xxx_kp_enable(struct pmic8xxx_kp *=
kp)
> >
> >  static int pmic8xxx_kp_disable(struct pmic8xxx_kp *kp)
> >  {
> > -     int rc;
> > -
> >       kp->ctrl_reg &=3D ~KEYP_CTRL_KEYP_EN;
> >
> > -     rc =3D regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
> > -     if (rc < 0)
> > -             return rc;
> > -
> > -     return rc;
> > +     return regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
>
> This is fine.
>
> >  }
> >
> >  static int pmic8xxx_kp_open(struct input_dev *dev)
> > diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/=
synaptics_i2c.c
> > index d4cf982f1263..85e37e2ce45b 100644
> > --- a/drivers/input/mouse/synaptics_i2c.c
> > +++ b/drivers/input/mouse/synaptics_i2c.c
> > @@ -257,11 +257,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client=
 *client, u16 reg, u8 val)
> >       if (error)
> >               return error;
> >
> > -     error =3D i2c_smbus_write_byte_data(client, reg & 0xff, val);
> > -     if (error)
> > -             return error;
> > -
> > -     return error;
> > +     return i2c_smbus_write_byte_data(client, reg & 0xff, val);
>
> When there ate multiple failure points the preference is to explicitly
> return 0 on success.

i2c_smbus_write_byte_data() only returns negative or zero, so still no
functional change. I will change it to follow the preference in v2.

> >  }
> >
> >  static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
> > diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_sm=
bus.c
> > index 6de68c602558..3160714a514a 100644
> > --- a/drivers/input/rmi4/rmi_smbus.c
> > +++ b/drivers/input/rmi4/rmi_smbus.c
> > @@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev=
 *xport,
> >       struct rmi_smb_xport *rmi_smb =3D
> >               container_of(xport, struct rmi_smb_xport, xport);
> >       struct i2c_client *client =3D rmi_smb->client;
> > -     int retval;
> >
> > -     retval =3D i2c_smbus_read_block_data(client, commandcode, buf);
> > -     if (retval < 0)
> > -             return retval;
> > -
> > -     return retval;
> > +     return i2c_smbus_read_block_data(client, commandcode, buf);
>
> This is fine too...
>
> >  }
> >
> >  static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmi=
addr,
>
> Thanks.
>
> --
> Dmitry

Thanks for reviewing!

Best Regards,
Sang-Heon Jeon
