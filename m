Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE1337B8F
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120107; cv=pass; b=aZDI3oV8uXyoUwBnqkEtnTJX/PKyMWgLngRF0pHJ7mQjX1XhZ5xGB52KY9s7q0oKhnEX7GPF4peobPyISU4ASvTYyujgThIJvHU+6AMcioPBwxfpsuDOlpYPd1lRKuGWdoik3PChl5eSaJtBdddWgtoLpt4oL6kMfSmPL91qSAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120107; c=relaxed/simple;
	bh=KgIolBAt6/FrgaPpJwLax8SGQvAvtZV5AB2VrW6pIuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANeLvfgLip7OEY1Wg4aTaKd1ADTUPDCzeb5lwCYuYXkmU94jFmhN894NglU9IcGNU3STFSh4gk8CwH0XHsg4Z6yTDJ6w/9UKGwsCGGMvbrfNH//3ld4zHIotI14AZvQhscTrGm7H75lAhkkmdQlXx/MRTNNNpEDqxAUAEms0LHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdzPS04D; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdzPS04D"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305552so5135596f8f.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 04:01:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770120104; cv=none;
        d=google.com; s=arc-20240605;
        b=T4AD9IH7fZoT55PI/jE5ICLuV/ZQMa4CWBnLddEBV2OdcFhx8XDfHqdVcfGZvhsxO4
         gxxo9lOLrx67t2uwuY2KPcMPUFNAJzNFHJ4seJJB+0PLGvO/T0oEXeljQOiobbuVyLXq
         QVGJIIQrCnbuKkp/cqzjRgfFjkgCh4Sd8TslVD9eX90fjaYG2S+XiFKkFUSiTwpMsQI0
         WR7vKCQf7MZ4YHfkPX9EhpBHw8U177BmsnV3xd7GoI2c4uMgZPuyFS43k9oeoNu8Lb+Q
         6R2b0zdB3D3cYQgQMLCtuX8x6jTTyxysH2BMePzqgLevFqXzP6/n7OnxX23VqkVjzoBK
         u0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2VFmkjkyUco8JpC8ERq9+9wVbEgE55aH092lxEE7AA=;
        fh=xfl7iW4eVAyOKg74PbmhwYlE4XVrQFW3Sr9lGW/b4PI=;
        b=aWWiyiz9Mvh57nhTRSf2EJ4v+ZU0265Ru1SfMhrLk+JhYqPnbdcmvm1dXciN8Ota6B
         BpEYejfzicAMkKtPCPxXm/2E/9ndnWp9qh/1V1M5uO0We9amaQNafWHsbo+VjdR9ejAO
         9itdAF75KHECnTDj7WyobOMBk+ZsHAiOu6hQAb9FEn0dLER9aTdEW9N7O6pUEsFp2CBJ
         cTfkqApReW24tpYC+tscRCkfy6I6I2hkrSIN21qtuRACW1U2OQQHHms61FrPD4sLyX7R
         rBfkj2C88sVVeR+Pr9raumECkBWXDgg+R+HTiOyPJ0QNLOti03VxJNdNO/5MDJfQs8n/
         3K+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770120104; x=1770724904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2VFmkjkyUco8JpC8ERq9+9wVbEgE55aH092lxEE7AA=;
        b=GdzPS04DgJWbVhGdA2GLpyD8YFmtcjDo0w9k/VpyWJJdd4iucnSGHa5kANfD5xlCq3
         dRpMLqpGB6czdTfsSaBp9QXOFEodZu8Q/Zr7gCdCXkRTDBR/a2nX6lJeMccHDkWeGmnh
         St/H7SbdgVyC68OlR8eFBdd4ar9PSRRx9R5iPjJBPzm4bO3SRw0I2P7IH7CC42csFy5N
         1u9LzhMnOlg3WwT0oEwd0MGlLlaeNuGGWJtYCdZesXVBPdt4a3jKWdfH/DL5yEuTdbXV
         M9yt0/8MQHqyC7+RNyO4YMajTtUFqpgLhLv8WnJ2HRgt+EHfgfDR9qLCYs1akpxRVX4l
         MeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120104; x=1770724904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2VFmkjkyUco8JpC8ERq9+9wVbEgE55aH092lxEE7AA=;
        b=JNqjYc+GGVoShH8uhkpgtXnP3YXBsCgc8TupUfkoHRNYle69SN8GLRQN3Md+qZkD/T
         pXXi4QyyaY2oYa+VQNkAA/JFUxj7JqmmfTqwkPIYXm7r9IqeYP8DwJIIOqjK8LE7HFSf
         DNOirF1qVc4mT7ms4DQKdZR9dAWlQcSWXlXb/DZtGxxCbC8gDLeXdwp0svjPxECTtiWz
         vMa9aIyvPgRnrofJ9ExdwhRt8XgoUxeZ2/qgAUx1zJn0Y5kuo8b4RSZJQZTcHy0n/aHm
         9dSfm7DUS41t+BjFBOzL4NPw9kXRrdIEopvAAbGBvGAGFO7gU8wNsYvPjjS90Wrm7v1G
         85pA==
X-Forwarded-Encrypted: i=1; AJvYcCXnkb4Hwa+nVygKssAYI0mhCoQ+WjEjOHoZJKx0A0SqCOBLZZwjjaoX/pH169wmdYHDgjo+RUUWq4zXHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7BWbQ6Uym/aNLzGrRQeFtkbl6zWCC6V3cKm2zwbSLM5a4Iva
	oIB1ZCRAJM+1vGSWI9kHA+f/LDJ8u7OhRPSB7TOTXza6iXDe19MTHCA40XtNLwMsJcm0YCLaKgX
	EtzzD/+MI961lEzV9ytKys/zkayfxexE=
X-Gm-Gg: AZuq6aIlPjJTpMD7ja/ZOjhuAIzxJnN1LxU0mKjwK4i4rmtx6Jn5ORD0H5I4YCiieEa
	UfskOLwf3t/aikzfZIIMVQY/gnAG8NUPiAnnzmV9RCTsDriToIhJ76EFCqsUUABu4FTANy39uOZ
	ijvgBgSSR42EJZVw1SneZBKwCwOPgEkvPWPy9U0acOj0tIHjz7CVJv0dvBTsIGkQTYq3mdp7yZL
	vpdbnEo8kfnLds30OZ+yhHG6bHC61+pW/0P0ulAGKWAM1luoO4JPxuFT96XOyoluHHX1/kp
X-Received: by 2002:a5d:64c9:0:b0:431:a43:ee88 with SMTP id
 ffacd0b85a97d-435f3aaf7cemr23688957f8f.42.1770120103900; Tue, 03 Feb 2026
 04:01:43 -0800 (PST)
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
Date: Tue, 3 Feb 2026 14:01:31 +0200
X-Gm-Features: AZwV_Qgr0pBQ1wVH0-u5VwU9YYr35W4aVL8W6PTRUnVQKr-nmLWu36hzeAruxuU
Message-ID: <CAPVz0n2i1r03R=yO4XnQpKFggixfcn_Ni4vGZrfDyEOTJHDi+w@mail.gmail.com>
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

Noted

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

Noted. Thank you.

> thanks,
>
> greg k-h
