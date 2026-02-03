Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E203B8D5F
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137417; cv=pass; b=QUwwd0vxixtfpXwevMcEeeY83kivFlByT6eD8fgWrMfjQ9OfWWRTit6mBv0V8SfdWOkplPbc0ozvnUQzW/im3KKOBVAbOCdRZckIc2ixEnTPYTCDF5jFdG2xOnv1sG5tub4uCDE2pmsCAHZEJmVszi83+AYnh0OSD0AzjfIvcz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137417; c=relaxed/simple;
	bh=LrQnpvin4jtRqTsha3/cBUOZ8TmO+h7BvZEhl43PHAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO9TtO1NtqFpqrPrzWbK9h7gBj3SBNJPHcn9gKCMFvMfuyDhHUY1rXhlAXYorIb5F0Xg5A+6HHv1/6IdgGlmutYynhBkJUtQ20xg4FRV7HSHZch4c10AcgJ/B2lQtmUVz9ay3irjSEaYlIy/yQ9JWG9sKK9bx1OAGO63hXIzUY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2dQmV9r; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2dQmV9r"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so78591435e9.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 08:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770137413; cv=none;
        d=google.com; s=arc-20240605;
        b=fi/ubf713Ixik22ToZX12Yi8Uy4sFsOTdW0BtWE1/1ZvJjvJQzbupyQOXiE6v+wbWW
         4HLfFR1Un+DvH7vh59KYOQk4jACHLBgHEjlQM5sTOADJUz4cVDs+jpIy02Q6ZiUd51N1
         c2i5mgfRSrgQYRpuN8b1R3fVN6a1cnFoesTZEp+cOMTmQqAk0QzTlbGbC/DWc3N08iL4
         jso3tumfbc5gnJ9KZwfVYQplR0DCEG5NAMCTGs90keyXLpvUmk6vaYIleG+Bhg4g2ay6
         oXq8GVeKtuh9e39wgP8yHvFf14Lioby4nrLgA6LKfI6GnNqrZDprvaTaEkotGuzW8uwO
         kMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=peC1LbgC8hk+M9QjMfBLz3bgPIBhDM3o4nZmhT+Urjk=;
        fh=dr2zAOtXlMRBTLAFFeBzmkFyEeXeFIwfvAasjjjlVMQ=;
        b=MbEQthAZbc2iwmS/TKLv45g8y9sShD9XU4iAm+ou6VkIQCjN2a1W9cEl7DcvkDUVbD
         uZ6f/j17Zgf3Acl51gUqgZ+jVnaFydackZR84dhTSC51JgGzwEQUZB//RoEYLjPfvwLx
         CaWm5OzXqxh8I3beJuhTl2vfj5d3y+YBw1//v62rxeu75ZlOAX2vYKoQHbRe/6FJequa
         IjehxAWGqA/m/MzARlg58uIAPQzZiy/RnalvrYIyf8a2mBZJ1g4n5yaTxZ8Ta3bnnyZH
         Xgw76tfXGCtxlirC5rK1nEhXMnNLAr0BZmjQyEr36OuRVJywGYTDqMgkLNyivmXmEr6n
         Vkxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770137413; x=1770742213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peC1LbgC8hk+M9QjMfBLz3bgPIBhDM3o4nZmhT+Urjk=;
        b=l2dQmV9rfqTvBDqTAxv/XOKuhb1MNeWZmU0EFv+Apr8CU1PzRklu24uu3akqqWRpKf
         1D93WWfNTeSex8YQ5j6Cfkf4Ol7dvWfSqUcjXWCNTNIYTbIgfe7g2c2Rg9wUbWCSwY5B
         E97KAd/ZWA8bAS+dlvZ8XJNo3gWgOB1CQtI0Wp3hgsq2z7w2SMPA2kx/55qBprAUEA0E
         mtSNsxJUg4v2h5mVu5GZVLGmzuYthb5Owz1867Q40GqSztumvSiQ1FSNJe6uJrxVfsdR
         wTZjbGj8EuqwdDgnefbI+HLiEYPH7z7+rzMRRC2httg0Zajl7eqYp+SomWUXnEBZOBnn
         3SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770137413; x=1770742213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=peC1LbgC8hk+M9QjMfBLz3bgPIBhDM3o4nZmhT+Urjk=;
        b=ZKS+DCueVkC6OA5qmElRqArFgRID2YzoB9bLF7jPZskx8AXLQdKFXKM27xmMS2St6u
         Dtsv2KTbFXKZzdbR83NeDZlfj8+mtdCiPbV0qyQX89rQYcUJwFnMO4RdynVbXD4sZ/85
         e5QUIWyaOD+chyyu2ue/vXilYOcJa1Flmw/Et4lU9YJXLjy7Zqpytm+o13vF3MFyLZY1
         llWrUkaiiXpZaMP+T88AcX1jVUvYH7QyN9Wd82wfNseKDRO7SY7D4U2cRqQ6i0XY5jGv
         kO8poZvdMjY4LD1AWRKWrX103ZNVtCrEnq0hMVm7aLsa/D4L+w3qgfJJKXYAabzuyI4s
         RfzA==
X-Forwarded-Encrypted: i=1; AJvYcCUmB6uA5mkJnzMb6n0MbZ7ZgBUXeh0fj7J5iyGWTO5vuLgLTLSfOQjS/1k6ZxA81cqgQisfWuaS4hMzPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHVpDJn1Y+pT9g+S1afXAeNqKoozvm153sdvvqSYzbndT+AxE
	4FpKHDCzQyp01tKqM7L/FvvujpUnMU8dtgDcJb2Arecyp7ghAoxhMwFxaNxArMjYq62VTIjSUmu
	yBo42mEUSWW8BdGq3ApC3S4FHaE0KhMM=
X-Gm-Gg: AZuq6aJk16RFPOHHZhNWSLhsWAy3P3HrFQVpQtiQhZeczZ0oV2h5E3Rrlxnbftmn48L
	cIiZLH64BFt2o7metKLbhwCstSn41OGD/h5Uwie4M73PrF/BB2NKHsSBHri0/iG5sTs4zaAiJlu
	giXvNhtFkUCBGILM0Dy1XyQOk4DQ+vSeNqJwgAtc57DKoTowjsM7mMfHEuiTwDZ0nFL+Q1WPrN0
	lgut/rHF7cNlFsdIg3Oj+qp69biu/+WP4RWyed9WGJ7zgENDe30/jnnjO5itUtUFswmpw6T
X-Received: by 2002:a05:600c:4513:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-4830e97a05bmr3659285e9.33.1770137413203; Tue, 03 Feb 2026
 08:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh> <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh> <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
 <2026020314-humbling-mobility-c24a@gregkh>
In-Reply-To: <2026020314-humbling-mobility-c24a@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 18:50:01 +0200
X-Gm-Features: AZwV_QhyAHDV7XSYIRgT7-uQ1XQONO6unrRbKGh2IXqIB7iOHyEWGvsJ3FZAmW0
Message-ID: <CAPVz0n0TMOCYnMiVUZ7xx-1SqrXuaVCOY-o4-x9L=f-xSMDj8g@mail.gmail.com>
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

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:45 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 03, 2026 at 06:28:11PM +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:00 G=
reg Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Tue, Feb 03, 2026 at 01:54:58PM +0200, Svyatoslav Ryhel wrote:
> > > > =D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:=
41 Greg Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > > >
> > > > > On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/misc/asus-dockram.c
> > > > > > @@ -0,0 +1,327 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > +/*
> > > > > > + * ASUS EC: DockRAM
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/err.h>
> > > > > > +#include <linux/i2c.h>
> > > > > > +#include <linux/mfd/asus-ec.h>
> > > > > > +#include <linux/mod_devicetable.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/mutex.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +#include <linux/string.h>
> > > > > > +#include <linux/sysfs.h>
> > > > > > +#include <linux/types.h>
> > > > > > +#include <linux/unaligned.h>
> > > > > > +
> > > > > > +struct dockram_ec_data {
> > > > > > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > > > > > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > > > > > +};
> > > > > > +
> > > > > > +int asus_dockram_read(struct i2c_client *client, int reg, char=
 *buf)
> > > > > > +{
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > > > > > +     rc =3D i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM=
_ENTRY_BUFSIZE, buf);
> > > > > > +     if (rc < 0)
> > > > > > +             return rc;
> > > > > > +
> > > > > > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > > > > > +             dev_err(&client->dev, "bad data len; buffer: %*ph=
; rc: %d\n",
> > > > > > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > > > +             return -EPROTO;
> > > > > > +     }
> > > > > > +
> > > > > > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > > > > > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(asus_dockram_read);
> > > > >
> > > > > No documentation for these new public symbols?
> > > > >
> > > >
> > > > These functions are mainly used in communication between the dockra=
m
> > > > device, asus-ec and its subdevices. Export is used here because all
> > > > mentioned devices can be built as modules. I can add descriptions o=
f
> > > > functions into header if needed, but they should never be used outs=
ide
> > > > of dockram-EC complex. Same applies to 2 export functions in the EC
> > > > MFD.
> > >
> > > Then you should properly document this :)
> > >
> > > > > > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SI=
ZE);
> > > > > > +static DEVICE_ATTR_RW(control_reg);
> > > > >
> > > > > You did not document your new sysfs files in Documentation/ABI/ w=
hich is
> > > > > required.
> > > > >
> > > > > Also, why do you need a brand new user/kernel api at all?  Who is=
 going
> > > > > to use this and for what?
> > > > >
> > > >
> > > > These api were used mainly for debugging/logging purposes and desce=
nd
> > > > from original downstream EC driver. I can both add documentation in=
to
> > > > ABI or remove them if that is absolutely necessary.
> > >
> > > Debugging should not be in sysfs, please put this type of stuff into
> > > debugfs instead if you really need it.
> > >
> >
> > There is no similar way to handle BIN_ATTR_RW in the debugfs (), may I
> > preserve  dockram_read/write with __maybe_unused instead of removing
> > them? I will add comment with explanation
>
> debugfs allows you to do much much more than simple stuff like
> BIN_ATTR_RW().  Go wild there, but don't put debugging stuff in sysfs,
> that is NOT what it is there for at all, but rather, that is exactly
> what debugfs is for.
>

I am removing said stuff from sysfs, that is not what I am asking.
Debugs does not allow to upload register values in a form of binary
block. It allows only dumping via debugfs_create_blob or
debugfs_create_regset32 but not writing. If you know examples of
reading and writing register sets as binary data, please point me to
it.

I am asking if it is possible only to preserve dockram_read/write
functions in the code, without exposing it to sysfs.

> thanks,
>
> greg k-h
