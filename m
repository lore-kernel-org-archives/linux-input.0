Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652944;
	b=d+F767NKBqIvEoWoSDdnbuJQmUibXbFEyfAGFM2zjDrRQF/NVbZWsk9OwQyfw4siLwSg
	 GqWi0EZRsR6QiIWVYnG26UiNC7fvnV/VGuZ9GLqcJkhoPOa1Kx77qtxV1jerOMkioeoG0
	 3XV5POxlHx4dujNDxXDX/pGZiU58PYjzugE4Xol9RoyeAIEunq7mtgR4Q3Qxu91LlOGfm
	 aTDHTHdq6SlzAcveOS3ljRcL5+XkAKof7Whb8i+PKoPJA7Ghaj0/hbgAwkBWmDO1FYQz+
	 l7c4fMzpD2K2GvY6Bf/4JFhuCyJn5RMnBUkKHWPGPK7sRXa5D7Yhfna1USiyaxlJ2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XssGaeVl2OdevVN/fICXdcbv8t7nXjI9BLYiHfZ6gHw=;
	b=zuCn0IVwtvAGEb9weyaxHKgY6RPIsKNL0fuGfedo7GsgHGaB+Ay1SyuoJTdM/dKpz502
	 YLDbihGq0BHd5wNbZYxM/9/XlSN0kFEr3HmxOZg60jm0p/H0b+YbCxKm6PwG4YVAqgHci
	 LAYyF/BUE/QNFhoqa98OcG96uqWzmoocrP1ky7FtMBbjtzgQdb12pafanRGTgobSl2QDY
	 yPSrD+z6RN+DzlAnXBsBgpChlIvlrLI0proRs/OooFUwfGxRCpVTAryY+dQ//2E+jAL9k
	 OfPX29Yv7q1sFWc4r44N+SuVCWbzDOxM8dSy6qW4o3mdHBnPpQI27Xstov9muWmaemQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft7k+83o;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEE606A31D
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25CEE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft7k+83o
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so398257a91.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652943; x=1793257743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XssGaeVl2OdevVN/fICXdcbv8t7nXjI9BLYiHfZ6gHw=;
        b=Ft7k+83oYx8wwz21l0KLd/G/7TbRV/NMT2VZ2SfEwZA3WPyM+tGFEfDhqfRJFYX0zv
         M92D4zjGi/jH9I/GtwqRaQoEcF/P6xbeSxppXF/PDNvo3N0zC7BKMsrwr9Ram+frL+S0
         us4LfN9ML4N+GJRqsKljAVaajmbB30EfOvxkESt2vrGTgM1TuOBKg5TCWBsj3ZjegHh8
         wW76N2u2U2YpkqnWtexonzeiqF3gsTN7PyYZEfEqbGoUbPi78iii3EhWmpARwNxjaQS8
         DP7moImk6x6BQMgU376o4Rn6QYUhxohfuZnf3t2jXEQEX4O5MYm5UjpOPcPXT8vFPgXG
         7UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652943; x=1793257743;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XssGaeVl2OdevVN/fICXdcbv8t7nXjI9BLYiHfZ6gHw=;
        b=OCcW9BRLsCxrMgUJaXu115R6c9CQx6ExBmWp/FVvHiRWcod/bO8JuXSHJEWS1KewTH
         fZtOOls2PkvpdWq5EIIVCCqy0U6/TyxkBFLuiIvc8ayzRxLcU3LMg/oTGEYH6kZ2gVuu
         ks5sTqY8G3+V03Elam1w4oKAO4TidhX2B/zkpzAR5yM9u0Hs2Fm5z55bO4S5hKzFwgGm
         r5IeL+KVxlyfhQ8qn3nuhMHEs5mmAWjH26WHrUZHoIc1JF9boBAcNeLylW7fgbr/HPO9
         yvLvL2JXL660RFQZGnVZyhlRnf59WUI7bfVfImbIn/iQUyNkKlHdQupEkMcHL0CU4QIl
         ImOQ==
X-Gm-Message-State: AFq9FYKjYhJHoiT6Myjj8x+eCjMyZj+gQa+zcc2Otk+ZbtY4RXJMiwfg
	uTXg2JWF22KZHUt2BRRbafezrBF+Yw+ZUJevQstw2LnG1eLAp4HUDzIa
X-Gm-Gg: AYBFou0Jwifni2zR+i4iq3N47LSSOJAgk7IE8nHFKuK7D70zmqPFHdZVb1c8O46oTBi
	0moA8VLj33JKJmsaijXJKua+0UZhPNqMAgh8TMg8c7iVjrUGj/2zq9oBbkS2r4ZCDB3vJgXelZl
	psh8xJdetammIRzCbBnjY5+S0wokO6hDAfB/gAlDFfVCr/GXzVZEkc5gwj8MuTelbU6jbAdni2A
	TfZqWgJKrkJUp5XIONnQEYjy1Q4TRauZ4kmXpOjwvIQs7CUgNZcVqiSf52xvO5n5DVuUHJxxc7G
	tE3+vUvBTSrPcpBlBlOJpPrqYOZZ1tga+YcB1ZkLCz4prn7Rnwst2keM6FSAtFVRWvEQ9rlZO6g
	cWyDBq5sfJolGtXDG53zns5gRPwPgb/HbVHUcko+SatbU85NqVf9KU6DrRiV0DYD3KsSt3VNofy
	5+ko06Zb1vdSwoG3FOG9pbKVq/Yx5Kzw+ytarcxXPi0gmhbA2W0+iTP/Q3YCom1xCXweVFK18po
	RLv5oJnil+YbLCRIzDRMPIWASqbj1XFgmOu4wZilwal2Sk12TSIjWMoGfEtmDHp9uIiwb7lmNwQ
	6TEKMuo=
X-Received: by 2002:a17:90b:37cf:b0:3ab:c674:d83c with SMTP id 98e67ed59e1d1-3ad86ed34a8mr3884621a91.27.1792652942680;
        Thu, 22 Oct 2026 00:09:02 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm2913545a91.2.2026.10.22.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:02 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:08:58 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <tlemhufl7x3zatbf7ygcfnshinyz4bunroyhegmyxutgooqbcc@wtpqkldesosb>
Mail-Followup-To: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
 <ati7RlrVvmzMjzNr@debian>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ati7RlrVvmzMjzNr@debian>

On Wed, Oct 21, 2026 at 03:17:56PM +0200, Alejandro Colomar wrote:
> Hi Shihuang,
> 
> > Date: 2026-10-21 20:31:41+0800
> > From: Shihuang Liu <shlomojune6@gmail.com>
> >
> > USB drivers often build device paths by calling usb_make_path() :and
> > then appending a subpath. Several callers use the deprecated strlcat()
> > API for this.
> > 
> > In preparation for removing the deprecated strlcat() API[1], add
> > usb_make_subpath() to format the USB device path.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index 1da4ad1610bca..c90ccea0cdbf6 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>        /* for -ENODEV */
> >  #include <linux/delay.h>	/* for mdelay() */
> >  #include <linux/interrupt.h>	/* for in_interrupt() */
> > +#include <linux/stdarg.h>	/* for va_list */
> >  #include <linux/list.h>		/* for struct list_head */
> >  #include <linux/kref.h>		/* for struct kref */
> >  #include <linux/device.h>	/* for struct device */
> > @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
> >  	return (actual >= (int)size) ? -1 : actual;
> >  }
> >  
> > +/**
> > + * usb_make_subpath - returns a stable device path and formatted subpath
> > + * @dev: the device whose path is being constructed
> > + * @buf: where to put the string
> > + * @size: how big is "buf"?
> > + * @fmt: format string for the subpath, without the leading slash
> > + * @...: arguments for @fmt
> > + *
> > + * Return: Length of the string (> 0) or negative if size was too small.
> > + */
> > +static inline __printf(4, 5)
> > +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > +		     const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +	int actual;
> > +
> > +	va_start(args, fmt);
> > +	vaf.fmt = fmt;
> > +	vaf.va = &args;
> > +	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> > +			  dev->devpath, &vaf);
> > +	va_end(args);
> > +
> > +	return (actual >= (int)size) ? -1 : actual;
> 
> Why are you open-coding usb_make_path() here instead of calling it?
> 
> 
> Have a lovely day!
> Alex
> 
Hi, Alex

With open-coding, a single snprintf() is enough, so we don't need to
call usb_make_path() and then another function to append the suffix.

Thanks,
Shihuang
> > +}
> > +
> >  /*-------------------------------------------------------------------------*/
> >  
> >  #define USB_DEVICE_ID_MATCH_DEVICE \
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> <https://www.alejandro-colomar.es>
