Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7C3D6684
	for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039662; cv=none; b=Msm6KKwIh3iiGpoKoAgheuMRX97ozky93ZJ2WY4qsktDxLzsDOaxFFR3C5Ie0mryEMJBkM9qzKgv/rNKb5Cl4ChIO//Zkc3tEc9ljqlwXgDxarNjw1/PMAEl9iB1+yAzotTTDu3g7tIDBb5xN1HUoPJ3c1CoU7umtS1V1tIvuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039662; c=relaxed/simple;
	bh=6+SccbS+g4a6oOmUo4VbEGkpk8iwX9aoh4LICkhKYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrmShTHPWYhsvu8znetaUtANjQSR7Q41sudNm6tvq8v3ZAMLCr7o5V1xMhFZPnqD2VOcB8GyWrIsRlXb2fUjJ0PzwXxMiEO81HKL7l/Aa2wXs63Hcv6BOaQ7mL/TAhCno4+0PeWpxul3lum7q7Szv+YnbeiQ5S4xBN3vqCvwuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4Xzuk3R; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Xzuk3R"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdc47747e2so757005eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 09:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772039661; x=1772644461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6Fai54Ul21d21qsppL/OgbjNjE4u/Ww2JyK/Frhu5U=;
        b=L4Xzuk3R0W8s+Pr8g70rI3llz5/7izSqkAZQc4uldD1EraLNWcwrdwISNpmkpmvw4h
         WtaGX51Lap5U1vaVxY+XLLWbtABv8ptP3vjSsSCcce8hwIb3bBnoYfoJeI0cGjfFg2g+
         PYo5aynYEvIbMA639kcjMU6+adgc3xWMfjIBCSpc/CX28ItY8wiUmrnjVmlh7p9MQMrZ
         JreQ4dYn6a5eSvvY68bCQnb4XOliGSiV/D1wPUjE369FbJqz/6WnOlRQz3fYqpbBlBzT
         0SPHehj7uaCIiTV12lJMz1k7r5ATq/rqpLkF7N5GIWim24Mi0t9D58C5Wsnth8ClCcCi
         CzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039661; x=1772644461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6Fai54Ul21d21qsppL/OgbjNjE4u/Ww2JyK/Frhu5U=;
        b=wURFILeIBje6+9oNO4bep6+8houyrzE/hBvLZ0apbkyjfJb5W/2ibZRfvAHRDJmi35
         8CC6WKuxZ9vxmUXIDtBrMlfHzkH/8HjKhoOXTwQsnp+XvRG7uDFU1wMnjlkybckO976r
         j6n+8JfnlsIiu+lZ9a3RhJE7rTt1zUsCIT6wdle3cCXryyFyx//qoXqzUnS/YoIzz+fT
         8TrIi6vmbvznYcxUiicAF9CEgy0XrQ+f5Sbd4ZEGcYdVuxkRHMBufHu/PZjZFKeIOj4n
         Uzb8w+HhGl96ByRc2xaprNnIYdAzc6RTglw5eIOb9/50R/rurQKOpAJOdCh1PnrRgXuL
         LDGA==
X-Forwarded-Encrypted: i=1; AJvYcCXFC4Y6VhlQAb1HN2gd0pdqmf8Yn5A17q/7Ol6JFKKQdH/z9Mp3plTE3ytzI3f1f/HsUEHhXrUccgxqbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjltg96CF56z3XzuNvCXFXPp3BLyfAL4Ve1/+1ZeTxGH3z61u
	pjcA90xbJ2zk33/vilkeJcnwfYU8jPvthKxD+KKmyQ+1eRI8cGyWEJbi
X-Gm-Gg: ATEYQzwbXWu/gDRyuUFxDswMhB8RVZtSZIpH5yzvfTUNvVWsyyity/gWhgoz2AlkPe3
	HK5UIoaEHg0Corkx46EHDF1DBb2Dro0W3XeXnVsHdzT+BGbSUyoR+KCgNFgfCb9Ju2HKEa6m5t7
	TboVvGtH0ldaAJtzr0eXf3rMc8nGV9fCresLF4IXdNYlF9z2+OJcfEPx6KsOfCZY1/EU1sDNxib
	Nz5OJEn61aDwjDmGTem96gWAS1u0TZ2fOpssmONlSBkNDTgGF5a5fEgdylUolmp8HRDDGpeHtH6
	kpo0fOoUC3NA4mA/Km8+db4S6SqP3AgXro7yhd02ouiWAnevxhAzdSQjSDzUHPWu7otOJSNlXRI
	q0DDtOGqgjbHrf2fix/3p3lMTSUCKdU20G1tdiGhyW/hJiwN/kdbUb3E8Z9y4OJrCxxPP+yvE9W
	NhcljDu13WokAytAQMnFkSk3RiEyLNeJeShU2QzfszC9P6vBJhnMItkUTp2oBmR0mW
X-Received: by 2002:a05:7301:d1a:b0:2bd:b2c9:851c with SMTP id 5a478bee46e88-2bdcc070e66mr620754eec.30.1772039660613;
        Wed, 25 Feb 2026 09:14:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64dd:9670:711a:678e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da4775dsm9332416eec.2.2026.02.25.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:14:20 -0800 (PST)
Date: Wed, 25 Feb 2026 09:14:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, robin@protonic.nl, 
	andy@kernel.org, geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hvilleneuve@dimonoff.com, mkorpershoek@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, lee@kernel.org, 
	alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <aZ8tocPCKqTXqbC0@google.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
 <20260225155409.612478-5-hugo@hugovil.com>
 <aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
 <20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
 <20260225115652.8beb1979df3824f7a95d22bc@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225115652.8beb1979df3824f7a95d22bc@hugovil.com>

On Wed, Feb 25, 2026 at 11:56:52AM -0500, Hugo Villeneuve wrote:
> On Wed, 25 Feb 2026 11:41:55 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > Hi Andy,
> > thank you for the review.
> > 
> > On Wed, 25 Feb 2026 18:12:13 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > 
> > > On Wed, Feb 25, 2026 at 10:54:01AM -0500, Hugo Villeneuve wrote:
> > > 
> > > > Add support for GPIO-based charlieplex keypad, allowing to control
> > > > N^2-N keys using N GPIO lines.
> > > > 
> > > > Reuse matrix keypad keymap to simplify, even if there is no concept
> > > > of rows and columns in this type of keyboard.
> > > 
> > > ...
> > > 
> > > > +/*
> > > > + *  GPIO driven charlieplex keypad driver
> > > > + *
> > > > + *  Copyright (c) 2025 Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > + *
> > > > + *  Based on matrix_keyboard.c
> > > 
> > > A single space after asterisk is enough.
> > 
> > Ok, leftover from copy/paste from matrix_keyboard.c :)
> > 
> > > 
> > > > + */
> > > 
> > > ...
> > > 
> > > + bitops.h
> > > 
> > > > +#include <linux/delay.h>
> > > 
> > > + dev_printk.h
> > > + device/devres.h
> > > + err.h
> > > 
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/input/matrix_keypad.h>
> > > 
> > > + math.h
> > 
> > Ok.
> > 
> > 
> > > 
> > > > +#include <linux/module.h>
> > > 
> > > > +#include <linux/of.h>
> > > 
> > > Is this in use? Or you wanted mod_devicetable.h for OF ID table?
> > 
> > I need only OF ID table, so will replace with mod_devicetable.h.
> 
> Hi Andy,
> finally I need <linux/of.h> for of_match_ptr()...
> 
> But I will keep <mod_devicetable.h> ...

Do we need the dependency on OF? We may include of match pointer
unconditionally and the driver could be used on ACPI systems with
PRP0001 HID.

Thanks.

-- 
Dmitry
