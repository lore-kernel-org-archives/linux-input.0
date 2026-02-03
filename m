Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E23D1CAA
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136108; cv=pass; b=BANUVz/htqoV8H+JshDLiP9hBN4+UcZ2eCpRsv/hMZ/wok6jYydVPQBWVCYc4F6Xn7Adlm1QYdS/uyMi82Fov681Xv8zXXj4oacvhQyPLH4k1lfjhEsNuAUgvL8qIYsdlNBO4X1b2Xf5v/TZvHU2rX9iahS5gCKcS33rYhFDl2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136108; c=relaxed/simple;
	bh=fXSdM/tph+CQ0hSdypd+WHNN70gFwJDk5S/Zwg+BMGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxTiWOTjH9OCdC2/ZcldbfytMHdkYbCStyR3fXUPW93yGduPfKERBbuKWeIA9XK3GauEjqIzmSelob85BYUy/XPqKWp+1SDtP5pRp3eEuwZZO9fmJUT0egh+LNGtsyEuLHCHk7ZvgrhikHeBsxlNkduk0BoLq/NfzBi0yUScJs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcbm8xyI; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcbm8xyI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806f9e61f9so30176865e9.1
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 08:28:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770136104; cv=none;
        d=google.com; s=arc-20240605;
        b=PuTYHw6eGCQl6fdj0xY9uHSVW5xeIW7b/2CmzwURHadQBh9epBrAVgTxOoOVx2NTxw
         1M5ponpn5tHCjZsfg1JKP3WmfD0i/BOMSZ3c64grx5TShkoJB268PFzDmvX0sN9E3KMa
         XsGU+S88336ewq1Ve7ACLh9cRoYer0Kp7jbUkNGVdDHKLK2cbo31jyaPB2UX0iLhNlON
         CZoBSMNUQofNR5b3xhDhaOrsJ4tEAcnViWXBvLpDrylvFvu4a28+ehLzGqospZ5+Dolo
         ISHNtbkoepaCEmhfED/D3iV4fjX2HvwNcbZxwfEK1Gr0AwsxJqZwROq39X/INvqo0Fae
         dAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gRDaphbKaaiBTQfNJABzc/bHdMK4aRKibRK4EZa3oTc=;
        fh=wg7x9qifaAIj/avBYpYx4ob4ycRtTXiYei2rG6py40I=;
        b=Y1DX6qUeW3pr/dBeZvfBGJxraz4Q5VAUAAdPEGw0OVgVHVTlWZuLZAJRjIvmdFhKlw
         +Jax5bpeL6+aIebHguWxrh3ABIc/8cQ40p5DrnVhhy3TN95Vy6At/rTfWRUOxJln7tHb
         KVhWg7yBFKhT2rloBh3UJ1RgCkIQqWyxnEUKz0lafJGUB8UbTJUkFHhVEolFAEfTx5xa
         c9sBdo53LxZIa6Cgmvnp01LOjgdFXqu7+xzQGVw9LCIbwx/IibAmfd5SvrZJxdBMABgS
         kgpJcSTBt5aEolntGgKZkfEVJBU6yVST88saUn4ivZEJDhC/O4KH8y1XHplcQSxt8Ksp
         tomA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770136104; x=1770740904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRDaphbKaaiBTQfNJABzc/bHdMK4aRKibRK4EZa3oTc=;
        b=Hcbm8xyItJ7T//WYCVBSa+eAv5LUDufCmbSIr9/0EatuyOo/AosxsDdhj0awaik0lU
         HTZXFjQn7DhpDgu+K0Iz0mk0vqNO67pD1S92IS6NN2QCdfDY3T41asrGQqh4K4yhA48v
         STzrDQae4Nm7c4rTYcRvxl7NbIqZgN0gCqQs0ejELh1klRYalpIMgakz0jJxejEQ5l58
         z7rQM0PvIs4DrVB51oSKlh+Fc74uQdN4pTbqKVfXIZOg0Su5gX9mFCFKfYRIGOh2VyQ4
         BAu7K0EVSgIquiKYGhAbquLZH4T3kTh1UyU4XneTt3hrBoJ5Hcy5TwPEc5K/ZFTpdwtR
         jJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136104; x=1770740904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRDaphbKaaiBTQfNJABzc/bHdMK4aRKibRK4EZa3oTc=;
        b=a5Ws0b3lTOXy6kQ0DB8tdym3PsBhusR5Tz6h0fV5kt8qi7QO3ogLK41VUtWOcvSVBX
         sSvplJJvwi2zsjwqwt4byXW8TvbOM1f5yvzZVaWQgzaXPsKmOg/z/fbfMSTlKiSFBcpr
         bFChwV2fsDxJPvE5zxgCLrqWwgyNGFE2761Pz5e/eW2cUCgd/8dXNQMq5CU9/TIECTRX
         js/DpLYw+942CDtTgQWlr+dffNX9bcn0dhC/0s2DFxbpDjaisC20z7cBYPWdVpgJfiLG
         3RSyqdZnr6k0dD9ZDib49h+ukaWDO+83NsIGlNMl+kzroDJqIoHo8VoT9MdYF5J1mbbA
         bwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE7fQOoJBPVF2dMzRyOBb96EolN+TD5yRa/e/jKU7ojqaKMKHeLo/MQExvQBUz4n88fJvZcYL4SWT0dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM69zM+bhl2AD/pfAt9QVtRbbR1SrTZHbD4dvaM/6G1w9JXJW/
	2RDuX1dLESuRQDHJ/f2RrpDN4NChVRGo7e8gkwarPgdMgMIQgzieFgy7UohhTsGxgiAOPkM5rgG
	sW8xwkepNYaZ6TI7jdUJnuQXuElFHJIc=
X-Gm-Gg: AZuq6aKweVezLXkiqAH6zRp6koRDYM2A4BNpwfCP03TQS+5Wnmuv9OdYSh+ezdlFYOu
	4k8ZnNUwMYDGpWhX/3MCMcoXtzI1/dsgKR2rHzXcR/fzjdPXnKdV4PZX4D/jGwP5TgRvKLLqQiV
	wU3N/ZaAfugNwBigunbvEfgcy5H1C422iSKwv4YiXc7/1t17mX5AAwC1RoEpAKHi9j/T5msXroC
	zcHbAyKYCIf8aA76WTmLEjPr69Va6554UZeBLEk+8/bMQyfmx2tIYD3DIQG/LhZKyk6HJYD
X-Received: by 2002:a05:600c:8505:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-4830e983855mr2996525e9.29.1770136104240; Tue, 03 Feb 2026
 08:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh> <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh>
In-Reply-To: <2026020346-ashamed-campfire-b483@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 18:28:11 +0200
X-Gm-Features: AZwV_QhcrxqiNzZ8cC3BM6w2wrqMyFc9v-0naWUEm2SUwORm6CXF_qwNkbtlMVY
Message-ID: <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:00 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:41 G=
reg Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/misc/asus-dockram.c
> > > > @@ -0,0 +1,327 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * ASUS EC: DockRAM
> > > > + */
> > > > +
> > > > +#include <linux/device.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/mfd/asus-ec.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/sysfs.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/unaligned.h>
> > > > +
> > > > +struct dockram_ec_data {
> > > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > +};
> > > > +
> > > > +int asus_dockram_read(struct i2c_client *client, int reg, char *bu=
f)
> > > > +{
> > > > +     int rc;
> > > > +
> > > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > > +     rc =3D i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENT=
RY_BUFSIZE, buf);
> > > > +     if (rc < 0)
> > > > +             return rc;
> > > > +
> > > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc=
: %d\n",
> > > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > +             return -EPROTO;
> > > > +     }
> > > > +
> > > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> > >
> > > No documentation for these new public symbols?
> > >
> >
> > These functions are mainly used in communication between the dockram
> > device, asus-ec and its subdevices. Export is used here because all
> > mentioned devices can be built as modules. I can add descriptions of
> > functions into header if needed, but they should never be used outside
> > of dockram-EC complex. Same applies to 2 export functions in the EC
> > MFD.
>
> Then you should properly document this :)
>
> > > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > > > +static DEVICE_ATTR_RW(control_reg);
> > >
> > > You did not document your new sysfs files in Documentation/ABI/ which=
 is
> > > required.
> > >
> > > Also, why do you need a brand new user/kernel api at all?  Who is goi=
ng
> > > to use this and for what?
> > >
> >
> > These api were used mainly for debugging/logging purposes and descend
> > from original downstream EC driver. I can both add documentation into
> > ABI or remove them if that is absolutely necessary.
>
> Debugging should not be in sysfs, please put this type of stuff into
> debugfs instead if you really need it.
>

There is no similar way to handle BIN_ATTR_RW in the debugfs (), may I
preserve  dockram_read/write with __maybe_unused instead of removing
them? I will add comment with explanation

> thanks,
>
> greg k-h
