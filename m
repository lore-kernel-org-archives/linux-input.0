Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA503D7D8D
	for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039583; cv=none; b=MrRVM69dBSyQ0/QaEZEKibyASzX++pHVIKnjkxVbKt2XG1GZK+cr1vzQn2nOTTVcLMqY21AglHvQs01CwxiLethkHDOHu/nALoB7lv3X9fxaPM2RISQpG5XpkiHV/cymWZypy5YAcmprY9tXBDEhP70XQSHpWBVtnNiOI43u6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039583; c=relaxed/simple;
	bh=ELCyhyC2gTSZpNqVhJedUxH106OdRf+PWAfdGW01zCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKgkWZBuQV1uYqyyAYWtTIoy2G736+eesjlu0WXcPEC3uIz9NCsICPBVDg0AHYKxmzJVpocLA+ZWFtYnA6XNeeAgLDxcKDvDQKb9bUXOiHfqWjYtJkK9PYFZKdvBqY9lGAzYiF4ou+OcyQvZmF6l1wWiRu5Ru6EYPH5KjzJTyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvqhjSy4; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvqhjSy4"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12732e6a123so1158417c88.1
        for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772039581; x=1772644381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpUJEtvyUfbAfsM/AsYdfsmRudWk2usCr4zOgiJsVxI=;
        b=VvqhjSy4JzXl00stjTKaYYYCFpluU/D7KgaPPOeJ1rRzti3yFViYo48/XUfNFCXrpf
         x2/7pjUxV/uHOSOgGM2tWmIOKfwX3qm86YUraF3RoBv6k42ZR7b1UbjqfGuDKSOM1MdQ
         VCxiiacABSgUhur84hrcWjjvMkalviZe/01E8QWHFZjqluN3beki2mhVCaHd0JjxE/lc
         8VVTOJ4hfq27IdRUSaUCfcmMo1XLTQWG9VY7evhKWcdcYe+/d99Sv5v5wmWSJiveQ2vp
         h4GxH5NaPWuVAytYhoNRKuGdatxoV2EcgX2na0sumVU/ureuAt7cFxFsbD3i/7BqhFEM
         fLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039581; x=1772644381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpUJEtvyUfbAfsM/AsYdfsmRudWk2usCr4zOgiJsVxI=;
        b=pSjaEUNotROeZD36ObXiFBhZnG0+xaWo8q+CJidzdYrVG6nQqQefB4C8ffw0XEL9cW
         6PQ91Jm4grLB4mlOOrKMZ7QFfFRgfxZMRDH7huQKULaIbuR4KfiDcFfE1JbXTCiZucLo
         t5WgkLy5SGwwGhpKGOoXp1c5yhTs7FIZIqVlqgmDiz0b4nhNEXjHOpN8x39K6lCA9nt2
         wfZ5nKCqMyfAswymNSLToWMhDO/9De7wrXxc2YFdZfLEZEr7tSzty6ayoOuO+mpcxKKY
         BYBhg7oa174BmfqT/ICf0YinF4GoWB+pGvKXVMWGYjU9x+BxCYJHqb9MjYwy6YBGhB1a
         Qpuw==
X-Forwarded-Encrypted: i=1; AJvYcCWSCnKeNumgfavK565hscy9ZrA7CYq9u/PRwu9DngWrOSPrZjRQEUlgD7MdjnswdbSkk/RrE0s/Y0eK6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YygccMhoCQro5wdu3USleVbYz4g4Pgbu7SdX+omR0n9/KbWnjkP
	uDMEqF/YRUFt7v7qkd2f4Ecijwl9lIpt0ZrH+81eAK4hsubGCc4XOsZf
X-Gm-Gg: ATEYQzw14hrVLkKxsG1gyuOCblJrF/TA5FTTqV3p3u6UICZV0krsQjzP/InrfilK71X
	25tBI+UAGW42ZYIsMLaXEWJUPpg8/sts5BEQw/Y5LzCDZUruejRQZj/KhmZOqHfywjKbDKyyQZy
	mp9QGdWFICdvXd4Y6LoFYdedZfTouCtV2lZ87+DsZCCLK0OeNHvImZyVjUYXspod8bDWeAffNQ2
	h2H61B8YlR2bO3ZvHQ3zBoTdCnGfMog90Mi7WvIrnrBRCgTBeYt8KYOcCSN2jfXMFfpUSegctqp
	D0aBQU/2WHqqtsNSRwNNsToKkWL0jPaLTNVHlc1tbxoaYDEyYqj2ZwplQJO48mkmnFyAY7YMgfA
	XNjDsl/nnBJRrx5oOlKR83Ym9+GMIFSd0da2x/u78+TP+Jc3poiRJeol1DSEDxAIXkFxVwfcvAa
	1yr+nJeRaJ2+Crvy0QkyWXeeZm64mp0Qu8U82EacTeTWACHFDbZtQehisBhnXHHV0o
X-Received: by 2002:a05:701a:ca03:b0:127:3440:e5d5 with SMTP id a92af1059eb24-1276ad627ecmr6367928c88.21.1772039581204;
        Wed, 25 Feb 2026 09:13:01 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64dd:9670:711a:678e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af10481sm14411000c88.3.2026.02.25.09.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:13:00 -0800 (PST)
Date: Wed, 25 Feb 2026 09:12:57 -0800
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
Message-ID: <aZ8sjwaKk5MCSDlg@google.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
 <20260225155409.612478-5-hugo@hugovil.com>
 <aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
 <20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>

Hi Hugo,

On Wed, Feb 25, 2026 at 11:41:55AM -0500, Hugo Villeneuve wrote:
> Hi Andy,
> thank you for the review.
> 
> On Wed, 25 Feb 2026 18:12:13 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Feb 25, 2026 at 10:54:01AM -0500, Hugo Villeneuve wrote:
> > 
> > > Add support for GPIO-based charlieplex keypad, allowing to control
> > > N^2-N keys using N GPIO lines.
> > > 
> > > Reuse matrix keypad keymap to simplify, even if there is no concept
> > > of rows and columns in this type of keyboard.
> > 
> > ...
> > 
> > > +/*
> > > + *  GPIO driven charlieplex keypad driver
> > > + *
> > > + *  Copyright (c) 2025 Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > + *
> > > + *  Based on matrix_keyboard.c
> > 
> > A single space after asterisk is enough.
> 
> Ok, leftover from copy/paste from matrix_keyboard.c :)
> 
> > 
> > > + */
> > 
> > ...
> > 
> > + bitops.h
> > 
> > > +#include <linux/delay.h>
> > 
> > + dev_printk.h
> > + device/devres.h
> > + err.h
> > 
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/input.h>
> > > +#include <linux/input/matrix_keypad.h>
> > 
> > + math.h
> 
> Ok.
> 
> 
> > 
> > > +#include <linux/module.h>
> > 
> > > +#include <linux/of.h>
> > 
> > Is this in use? Or you wanted mod_devicetable.h for OF ID table?
> 
> I need only OF ID table, so will replace with mod_devicetable.h.
> 
> 
> > 
> > > +#include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/types.h>
> > 
> > ...
> > 
> > > +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> > > +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> > > +		int iline;
> > 
> > > +		int rc;
> > 
> > I think Dmitry prefers 'error' name for this kind of variables.
> 
> I hate using "error", can be so misleading :)
> 
> I would prefer to use "rc" everywhere, but if Dmitry chimes in and
> specifies "error" or "err", then so it will be.

Yes, I prefer err or error for variables that carry error code or 0.
This allows to write

	error = action(...);
	if (error) {
		// handle it
	}

which is very clear IMO.


> > > +
> > > +	err = input_register_device(keypad->input_dev);
> > > +	if (err)
> > > +		return err;
> > 
> > > +	platform_set_drvdata(pdev, keypad);
> > 
> > Is this needed?
> 
> No, will remove it, and replace last lines with:
> 
>    return input_register_device(keypad->input_dev);

Please use

	err = input_register_device(...);
	if (err)
		return err;

	return 0;

It clearly differentiates error an normal paths, shows that function
returns 0 and not anything else on success, and allows to reorder
or add additional actions easily.

Thanks.

-- 
Dmitry
