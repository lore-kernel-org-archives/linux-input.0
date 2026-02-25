Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEF3E9F73;
	Wed, 25 Feb 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040489; cv=none; b=T9X2giFYkHJCWUl/4E8Mn6Of4K6HU70Ubsh+OILptuBn4Omjo7nk/QlcUPrb+IVpPUkgItIFpU7S9bwSNGggEyPI4+y3yugEW/ebeb6kFPibRRPmBexCGdxiTVGe29Vt1fad7FgQf2sXkO6y8sq5CopoXciL5J3Ny65YotP4w3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040489; c=relaxed/simple;
	bh=lt9isqYMDMlCfIlYYr1+xKwWWsbS5N+vrC/CVr/MmxE=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=Eluya4sJfnnwn7cFJFp8/SGhptpw9ZwNf2D61IIS/gPzMcTTqxAh8r2/YWxvB2eH7697lb5TM4O1wvR/ifrcT0TOGAbH3YfV/ha2jDeiQ+s0ugXUclxZkkTgg5Holed6Ih2RY3QyNoisePugWsh9YMxM9bB1lk6gI+2+W3Dae+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=t0tK90/l; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="t0tK90/l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=IQKoXwA9RhHZUpi+4eo53Id8BXP1PRpZdb8KsvS3Tqk=; b=t0tK90/l3fitjNJ1x0woq9Rvkj
	sX88TmvXF2JbnRyiV6YnZtl7rT3hMzeZFM0tntGuczAvgPBLS/qv3aYcgTGwygENuLG+i988zvCUm
	rdQg7vf8q7kThSuYPpzC/8QFFGnaZKxQqoRb9o3z7gRjci3by/nYaONjMsMYiqZ3heQo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvIfz-0005Dc-Rj; Wed, 25 Feb 2026 12:27:56 -0500
Date: Wed, 25 Feb 2026 12:27:55 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, robin@protonic.nl,
 andy@kernel.org, geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hvilleneuve@dimonoff.com, mkorpershoek@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 lee@kernel.org, alexander.sverdlin@gmail.com, marek.vasut@gmail.com,
 akurz@blala.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Message-Id: <20260225122755.3b2043c7cdd42bbaa7671fe7@hugovil.com>
In-Reply-To: <aZ8sjwaKk5MCSDlg@google.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
	<20260225155409.612478-5-hugo@hugovil.com>
	<aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
	<20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
	<aZ8sjwaKk5MCSDlg@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -1.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

Hi Dmitry,

On Wed, 25 Feb 2026 09:12:57 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Hugo,
> 
> On Wed, Feb 25, 2026 at 11:41:55AM -0500, Hugo Villeneuve wrote:
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
> > 
> > 
> > > 
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/property.h>
> > > > +#include <linux/types.h>
> > > 
> > > ...
> > > 
> > > > +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> > > > +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> > > > +		int iline;
> > > 
> > > > +		int rc;
> > > 
> > > I think Dmitry prefers 'error' name for this kind of variables.
> > 
> > I hate using "error", can be so misleading :)
> > 
> > I would prefer to use "rc" everywhere, but if Dmitry chimes in and
> > specifies "error" or "err", then so it will be.
> 
> Yes, I prefer err or error for variables that carry error code or 0.
> This allows to write
> 
> 	error = action(...);
> 	if (error) {
> 		// handle it
> 	}
> 
> which is very clear IMO.

Ok, will fix it globally to "err" everywhere in V4.


> 
> 
> > > > +
> > > > +	err = input_register_device(keypad->input_dev);
> > > > +	if (err)
> > > > +		return err;
> > > 
> > > > +	platform_set_drvdata(pdev, keypad);
> > > 
> > > Is this needed?
> > 
> > No, will remove it, and replace last lines with:
> > 
> >    return input_register_device(keypad->input_dev);
> 
> Please use
> 
> 	err = input_register_device(...);
> 	if (err)
> 		return err;
> 
> 	return 0;
> 
> It clearly differentiates error an normal paths, shows that function
> returns 0 and not anything else on success, and allows to reorder
> or add additional actions easily.

Ok.

Thank you,
Hugo

