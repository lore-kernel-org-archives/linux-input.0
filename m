Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8233A9CD
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119713; cv=pass; b=g2YR0Tn/2EnJ9zrwJa06uzpEoVhY0fp7/TO3SsxtGFS90to92Pj99BInBdPCXuyYoLWFRGQJUlEUw7KLUHmHQCH7FIxHmmVCyZUjyUdVS5Z8ki8PvMyEkxwmORtw+dGej/wrbxcGHL74t3/+3fPx842bNNGvoqmFXISFgIIl/ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119713; c=relaxed/simple;
	bh=9O0t3nOqWgtzHoOehLwVH3QJcXMOzB1ELLyYtURrIuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0mraj/csg5haJ8FsCaqgUAWzsxUbjzCUiUhyQFX4Wvq2730IE/k9AP/ZF5RjATuA7PCMtwQFR1ZGNBV2O4A/GYD00blmsi1HuWORbI7Oo08MzlHu0hg6k8bvkPMBAuvwoqIvBK8/y8k51ccXrmJF0T5K1dxeU0JX3/Mhzo7JrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCyAVNgX; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCyAVNgX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc32725so42561945e9.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 03:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770119710; cv=none;
        d=google.com; s=arc-20240605;
        b=GlVcpe1PyNtfQR4fvGLbVpljuWj9pPH1teQEMo46Pc3WnVsI17kcv45GTO19KX4dlK
         oM9Vs7ksdeAj0aEQn2d/5SARCbNlUtvedod/E0Lf2DZgOm1ARCxfUwJ31yKxcwumzxqn
         2qBRTRYJMaA5G5+/5yHI0B1qeBbWQgtrVO4Ykr8HGo5xlRv04pAmiiXjB3dZ4gfa2V+R
         TaYy+q6qqhpcdnkGIpRli9VV6qtipTQByvTiJSZvxBMeC2/SOnq4leMAlL7MSfEp54C6
         BbiMeV1tiyrvP4JYSgX15nph1tnicOK6w1fybce2OgJhunCpjn839Q11pRLYuL4nNSX9
         WvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJ2rGVAn9aB3hsANmqfw/I2Kf6J6nYb+RtHOxOIJw0I=;
        fh=1/tCURDPKhJQ6CYTlUfZnUPiHQfJOj0Bt7RyUUJ7+mE=;
        b=bVI+Q0RHRDRW9ZeXkme8wix0xUZ+NT3PSpAuQJDVhNdbayZnFgPd81sqg8QZgMbb3T
         9bghTGaRx6RAAc/0ELbkccVQ12gTZWTlauxonbXywHTveg/xBZZy2AQDG+Qbj5l72VB/
         AV8+MwH12NH3C9lpDcM34f03oO+6S/TRGmV1pbCLdCGJDlu7iPTVPWb72az0lqxMd4/9
         3z3iSkkvvpH7JvKDH7JAkYvfinwTLd5LhDTw0uFPT/nunqwXtTPh4BP/6wDZcCqfLDde
         V+dAB1W6z9jr84QNjYB2BpTGalGeUVijcFkcSVz4xwy0I6JwwoqYJfaGDdIKW7QWL6qI
         kPbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770119710; x=1770724510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ2rGVAn9aB3hsANmqfw/I2Kf6J6nYb+RtHOxOIJw0I=;
        b=MCyAVNgXL7nwa1l+j+PMLHiJK29uguooa6k9wvZGwna76kxD/t0qVYQbK9Mll7WidJ
         ZPcRlwB6qJ8qw0nIQHtlSxKh2FzzMfTNsX+LvGUaOWIGBAxVBWTEeKuB3lAvoBtxcEC7
         qwkIdURKccIDoWNbXifcEuR9L77pRHmnA4agCs4bmBUlEqkcnMmpjlEaYmGKPOhUNdBZ
         T+nv5tjL29a3zsW8ET2PEe27hA4ZXUxNigCfpxlSEhqe/01xzLNogfLhPNAfr5bikbdx
         KMHwbD1++UT/r1DXuMag6MNtH1Qcy0jflsuN/SCFhAdfz6v4WD5GFsNI9GlXYTdDX3rh
         oFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119710; x=1770724510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJ2rGVAn9aB3hsANmqfw/I2Kf6J6nYb+RtHOxOIJw0I=;
        b=TvumzUvp3qZI1JS7tif+I+7K9l8LVVjylWN3CfOXY/5UMM8NSW1wFm9pIDZLMnIobS
         Vr8jCBSAg7HyfC5RGEmvGVWzZbbd1DVK2M38f4sNE8vAWowICbigxzEHkPQpfdnHiqd9
         jXvQMAUF1BctDPyhuPbfG56pDZ3IFeEwHX95xYlgzZ3dz7kifoA8aRea66jONiPTV8t3
         1stkzcAUHdLry3XqbRNB+UzuZpzKs30ZhqcQ85mVsOF6Avm5xm4L4CdouFvW7+MoexVn
         Xuq5ohlpSeNjJ7mbtd586j3oN25RLlT8FxjU/MaQBvOsW6yAhRwQjcTtPd5Hf8d3MVAg
         FIXw==
X-Forwarded-Encrypted: i=1; AJvYcCVCkFHecpNmhZzm9T3+4E5cNTEsDTCWzgg0AXCnhebO8sDM4EtIx3FO/0FU+tmv1bF9236k2oqdH88XCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/AwTuc5jUa/G50nBCD9RORVRg5OEfEXN08z0R6s2JG8CCjBq
	V3KOT/URCb5yzZKPfDGD7ul7YlCyl2NMcaUulCWOg5GAcLdl2/GtZLp9kpR05jbBcMsX616gzKH
	VTOu006wBKZ5Pv5vFOVI3Zt2Vi1ydaoc=
X-Gm-Gg: AZuq6aKuv/AT+b6Yi96jRMJeArUYJbm1f8WIXPq9XpizLGZCN6cPpu0eS8a6KJrLPoC
	PHeBS/ArzNXjIBrBl9tFMEZLbEzhLqVCMejB5N2OcVNs1XaztD8xhyA1FKR0rW6S16SaLk21tMk
	EUJMAvagXTTanyGtE/scK7g06/LmVT+9Yq0VC1DRXseTQ3ZB8ny+U0uB2qvHb6bEx9WPis63rSM
	OtYiRRLYNJyXRR2eGiTgGGDUqTmG17Or+ygKGMEE0GS8u+mmeIoELG+BjfcaqZjqb5JgfyT
X-Received: by 2002:a05:600c:34ce:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-482db491e61mr217693765e9.17.1770119709814; Tue, 03 Feb 2026
 03:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh>
In-Reply-To: <2026020350-unrevised-humming-7a42@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 3 Feb 2026 13:54:58 +0200
X-Gm-Features: AZwV_Qgw0b1U_6kBWSx9OhS-IJWxhPVx8BmrGdD1Vb7TZ1z_SuHtAUlbzg5ifu4
Message-ID: <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
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

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:41 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Feb 01, 2026 at 12:43:36PM +0200, Svyatoslav Ryhel wrote:
> > --- /dev/null
> > +++ b/drivers/misc/asus-dockram.c
> > @@ -0,0 +1,327 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * ASUS EC: DockRAM
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/asus-ec.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > +
> > +struct dockram_ec_data {
> > +     struct mutex ctl_lock; /* prevent simultaneous access */
> > +     char ctl_data[DOCKRAM_ENTRY_BUFSIZE];
> > +};
> > +
> > +int asus_dockram_read(struct i2c_client *client, int reg, char *buf)
> > +{
> > +     int rc;
> > +
> > +     memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> > +     rc =3D i2c_smbus_read_i2c_block_data(client, reg, DOCKRAM_ENTRY_B=
UFSIZE, buf);
> > +     if (rc < 0)
> > +             return rc;
> > +
> > +     if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> > +             dev_err(&client->dev, "bad data len; buffer: %*ph; rc: %d=
\n",
> > +                     DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > +             return -EPROTO;
> > +     }
> > +
> > +     dev_dbg(&client->dev, "got data; buffer: %*ph; rc: %d\n",
> > +             DOCKRAM_ENTRY_BUFSIZE, buf, rc);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(asus_dockram_read);
>
> No documentation for these new public symbols?
>

These functions are mainly used in communication between the dockram
device, asus-ec and its subdevices. Export is used here because all
mentioned devices can be built as modules. I can add descriptions of
functions into header if needed, but they should never be used outside
of dockram-EC complex. Same applies to 2 export functions in the EC
MFD.

>
> > +static BIN_ATTR_RW(dockram, DOCKRAM_ENTRIES * DOCKRAM_ENTRY_SIZE);
> > +static DEVICE_ATTR_RW(control_reg);
>
> You did not document your new sysfs files in Documentation/ABI/ which is
> required.
>
> Also, why do you need a brand new user/kernel api at all?  Who is going
> to use this and for what?
>

These api were used mainly for debugging/logging purposes and descend
from original downstream EC driver. I can both add documentation into
ABI or remove them if that is absolutely necessary.

> thanks,
>
> greg k-h
