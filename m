Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2E4C77A3
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050900; cv=pass; b=nQ4URa6Ml5RFCHlz3ec/cm+z7i1T7j030+FGuDHuHKhZ0NN39WLl02gFRUNMLsKecsrGnpCPD0PmcmEknsx5zqJ/SLFjFc3pcvWiOF8q427nEk2BE20RNm1PLh5SnsinF2xsBnv498qNBYxZkmBL45i2ajaO6bJor6LL/NWEbeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050900; c=relaxed/simple;
	bh=QUhjA9hwUmTXGUjT356rZPUadcbJKMeW3gD2q9pu7ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB/GrXwAyuAczjs/fDbEtGCQ3tDwnMbfuqn4nd95hItvxh9ADZ9G2C8VFcAADFyN4pHAeGawpdfUCFf/JvBDbjtYN+ITDlykBl2WaU0Bp0EScW+d/+WLtuJ0QN6dCRVwcX5FvUOY56yz8IPgFNB90Zvyc6oQVFcnuFjTXdXSavQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO/ApVEH; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO/ApVEH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so2332311a12.2
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 00:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792050895; cv=none;
        d=google.com; s=arc-20260327;
        b=f3NQstVNA0/uNqbuVsCjl2DZFv3lu4m/uJsXTNYSUZPiHmGhkoihPoDPDpNXIKjVTA
         DaKiFtyE8v/Kg2QP4xhtHV7S4zPcSt1SpK7ofA40rxMmQS/XLRfmaNX9OVUP87ZvoikN
         4r54HJT96TDwBcmueDQCWovXM/XFdDztR37hrj7QCI/KXbc83RryYS6w4fQoDWB18YJK
         IlGQVJJiD2EAES50PkuxCFrE6GvPRF/b5kJcoYdaPn3oubrFla8mfOExPxI4jvOgh5hj
         JgQen23mMLys6WeipO5IBqzSlf8SwlGiMOBJF3z3TsHRy2HYWTqUZRCpLfnXOq3+TqIs
         tZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/sGN7s60I9kDns7tf8RWcyBjmY1L2WRY6Qxl0o1md1A=;
        fh=Itk89Emli8cQdlkVtDZNFYGKbARt4Gkf8FEKA6RBAzo=;
        b=b5Remrqf1r7zYj+UhitVO5NNhTdI95G45hXefWLSEQu3zo6gun3RdbwZmHcEA1QZct
         meXmdL6Y7VCGdKMSybpBAnXr1+FM+C2Y/LwLbyA62iUTIi/52r22TVo2cBc/HWlgTV+0
         a2HWJu45XzwLcpGnADPjqwpPRYNvVrsfSY96vH2aW9yLXzcvd1jVomD4mu1muijpFqx1
         ViBsTe7d2jBKceRWfHb3u5/1ig0Vl7xyczJ9eH3YB7whvSCncStGxgsDMWR6+BLRGfOl
         y3Bqe3Frh81aqpm1y4Lsz/IX3oeZ5PgHu9TY9sGiyP7n40BUieX6x20u8jl/iDs1Y4J7
         S+Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050895; x=1792655695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/sGN7s60I9kDns7tf8RWcyBjmY1L2WRY6Qxl0o1md1A=;
        b=OO/ApVEHdlMA+521QfgUyewuRF+kf2hjs0PRCNJq9e9UyMF+NZg4yE8noEbW0VQqiw
         heeCecfx2SAxsXGljKL8xJcsWHmovEBJ9XE1lJKaKjN6cHPseUAOFx+4YupAR+a+u91y
         9zcqeE4bNofPGI3CJ1aDfILvdWZINkT+V6a60FcuHlaY9ccgNRIV0HnG+0UNFD3bBCWq
         Ngp0MVzqCwUy01JBK5LJgypWF2pyVVInExRXgBvz/sc97GSwGS9xkfQkEyISSIJlfFRi
         XLLz5o4tuiTZmUD5qzvJAUh1OhV/VHAFuGaSZQ8croGvTQtjxplABAs3Roy/E1sdKDgn
         BUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050895; x=1792655695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sGN7s60I9kDns7tf8RWcyBjmY1L2WRY6Qxl0o1md1A=;
        b=JWz4tHgs8872bSozAtY+CmN7/xLF1WkA/4NRbgQzOiTLpWFGduBRKC64mKUG7brV4A
         DZ2yA22apfErYWJamkLYjjCUUBiudET/Fgerswr2y0EmJfaG2FhEXJmqNLmUf9wXKaNj
         C2Yuo7f2TU6rhZ2DLu5o5aPxa257Ef3uY3Zvqij8Bfi5PDIYanEghqYYpsiEDxza+hMZ
         QSpU02c1HUhtDk+nsD45m/xU7GMmN8vmqTH3BwskL4QJpwNdqgscFsal3R3ddZlLJ+uy
         gBl7/YCoLeDj2HdkpQB3UYmu7DLHDuKy7Ki/Pd/L7ZlmFdfufDRuI3+3Yj2m8VSnLotB
         a1pA==
X-Forwarded-Encrypted: i=1; AKwUvBwydML8rscoIeZThFTwf3Rdgz9BupY4onAj9uKUXrU2crohOJdkFmSzN/XPNgH64nEG2ERIqKowS9VRkg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJM2Gu9R7PJ+5bwKNQjEDIJ/GrypktBoyjquJdowdWUhBHJW1JI
	Hw0N6AHVOfkErNOASLEmrbi0lZGnk7/hCBWlrwSReaHwf33+VlGd99A8HiyEZITWMarAg783aIb
	f7hvYWyU+CxvbXO9mxLS7DtYatlaPU94=
X-Gm-Gg: AYBFou2tDksnlBj5tbLRRxgFq6RfSvvzMZmDuw5qEeezjd2yK9xGcWH7zB+JmyG3O6/
	VhTo027/iZOMpTjLKso8zWaUBXq7AT/XiZWZwgQoxSVKeuwbGW04zW5iA4AJaIoWI+n2toSYF2Z
	u2iJ2RAv2jXyqZxEuZhlhGIzUeHzq7ZkQ+vXSUN46cl7vNYfZP6z1bLWpwLCF5AYhF8/ckpvjyP
	6khu96wtIE2zgMUw/shQtufKQMuy6n9OFzLDeIjDMreaP+VsjxNB1pZgQOG8f7xIi4XE+L4XRk9
	c2VYzuPIzmzbOevQn1+PoV5ZDu/Ot4u84szeexTNJHSFU/sZ7h0eQjdideJnOKCK58kdqAh758l
	6SW39dHh697bAOLgYwGQ7EQA=
X-Received: by 2002:a17:907:c60e:10b0:c32:110d:682f with SMTP id
 a640c23a62f3a-c32110d6952mr1085661366b.18.1792050895249; Thu, 15 Oct 2026
 00:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013173504.451391-1-clamor95@gmail.com> <20261013173504.451391-3-clamor95@gmail.com>
 <d5f54636c25e0e60731adc200a63ceb5@gmail.com>
In-Reply-To: <d5f54636c25e0e60731adc200a63ceb5@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Oct 2026 10:54:40 +0300
X-Gm-Features: AclHuK8G-cs7nBf_jb7Nz-sYHdY2hV4DGcnygUqGWeotEdcljE4mZaNjbadyaBQ
Message-ID: <CAPVz0n2yR9C4Jan9=0=ck-RyKk1m19s3q4wfLCz9Bvw1TYNS0A@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] mfd: Add driver for ASUS Transformer embedded controller
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

=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 04:3=
6 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Tue, Oct 13, 2026 at 08:34:58PM +0300, Svyatoslav Ryhel wrote:
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/debugfs.h>
>
> Unused include (left over after debugfs support was dropped).
>

Noted

> > +/**
> > + * struct asus_ec_chip_info
> > + *
> > + * @name: prefix associated with the EC
> > + * @variant: id of programming model of EC
> > + * @mode: state of Factory Mode bit in EC control register
> > + * @read_size: size of block to read
> > + * @keyboard_mask: mask of keyboard packets
> > + */
> > +struct asus_ec_chip_info {
> > +     const char *name;
> > +     enum asusec_variant variant;
> > +     enum asusec_mode fmode;
> > +     u8 read_size;
> > +     u8 keyboard_mask;
> > +};
> > +
> > +/**
> > + * struct asus_ec_data
> > + *
> > + * @ec: public part shared with all cells (must be first)
> > + * @ecreq_lock: prevents simultaneous access to EC
> > + * @ecreq_gpio: EC request GPIO
> > + * @client: pointer to EC's i2c_client
> > + * @info: pointer to EC's version description
> > + * @ec_buf: buffer for EC read
> > + * @logging_disabled: flag disabling logging on reset events
> > + */
> > +struct asus_ec_data {
> > +     struct asusec_core ec;
> > +     struct mutex ecreq_lock;
> > +     struct gpio_desc *ecreq_gpio;
> > +     struct i2c_client *client;
> > +     const struct asus_ec_chip_info *info;
> > +     u8 ec_buf[ASUSEC_ENTRY_BUFSIZE];
> > +};
>
> scripts/kernel-doc warns on these two structs:
> - In struct asus_ec_chip_info, the kerneldoc says @mode while the field i=
s
>   named fmode.
> - In struct asus_ec_data, @logging_disabled no longer exists.
>

Noted

> > +int asus_dockram_access_ctl(struct i2c_client *client, u64 *out, u64 m=
ask,
> > +                         u64 xor)
> > +{
> > +     struct dockram_ec_data *ddata =3D i2c_get_clientdata(client);
> > +     u8 *buf =3D ddata->ctl_buf;
> ...
> > +static struct i2c_client *devm_asus_dockram_get(struct device *dev)
> > +{
> > +     struct i2c_client *parent =3D to_i2c_client(dev);
> > +     struct i2c_client *dockram;
> > +     struct dockram_ec_data *ddata;
> > +     int ret;
> > +
> > +     dockram =3D i2c_new_ancillary_device(parent, "dockram",
> > +                                        parent->addr + ASUSEC_DOCKRAM_=
OFFSET);
> > +     if (IS_ERR(dockram))
> > +             return dockram;
> > +
> > +     ret =3D devm_add_action_or_reset(dev, asus_ec_release_dockram_dev=
,
> > +                                    dockram);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     ddata =3D devm_kzalloc(&dockram->dev, sizeof(*ddata), GFP_KERNEL)=
;
> > +     if (!ddata)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     i2c_set_clientdata(dockram, ddata);
> > +     mutex_init(&ddata->ctl_lock);
> > +
> > +     return dockram;
> > +}
>
> Attaching ddata to &dockram->dev via devm_kzalloc() and
> i2c_set_clientdata() is fragile because dockram is bound to the I2C dummy
> driver. If the dummy driver is unbound from dockram via sysfs, the driver
> core frees &dockram->dev devres allocations and clears dockram's
> driver_data to NULL, so the next call to asus_dockram_access_ctl() will
> dereference NULL.
>
> Instead of allocating a separate struct dockram_ec_data on the ancillary
> i2c_client, could ctl_lock and ctl_buf live in struct asus_ec_data (or
> struct asusec_core) and have asus_dockram_access_ctl() take struct
> asusec_core *ec?
>
> Thanks.
>

I did this since dockram and ec can be accessed and work
independently, hence separate locks and buffers. I would like this to
remain as it is, but you have a point here. Adding check if dockram
client is not NULL should resolve possible issues with
asus_dockram_access_ctl calls.

> --
> Dmitry
