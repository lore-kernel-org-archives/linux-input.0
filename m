Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD9383C81
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489945; cv=none; b=bbBL8YRkVf0QkZDFr9XKgJ3oqNwaAk7kU2qga5VmB0tXQocD236BJ0KPY06eyWybBwtfjDz3RZ38VTs7ifmbK9JrlSrWmRNmHUo22je0Kze+NfDSXmW1W2YBIxJHmPUdGX1aCaQ7KKAEAXrb1P/MG+pCJlA59HH8kGGHzhhwuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489945; c=relaxed/simple;
	bh=Al3+uVGP0cwL0jSgTqhyYKTpF9qCePy3QWCdBNNN2mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrGpc1jR598VI6lPxeCLWoGRPiiuIzZXU4g+9eLcGjbKYF4GPXGbeRV5OepubGkavGR92bPM8QtdJi4WyjEFRezvTA31YcPqkMuHoP86hn2yJyxVulSF55vbrM7GnuIkKGhhmLwhr108WCNmZdsU1JYueb4GcKQLcgL/A4s7BxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH8+hTF1; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH8+hTF1"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso310265eec.1
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777489944; x=1778094744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HqN8rTwQqxRLQ6CfNS8UL2258OmapYg9VvqzF8o3sU=;
        b=MH8+hTF1QkIqhX2MbZXA7+G95b22HsDhKnmj9csLI8S+AQ0L7PfN7T5Jyp9MjeVqGa
         BjPzdYcV7qh8WMiKkGkShbioe/unzCrJLfOMiOHlWkQsaprrPFkvx0JG/fRWwIJ1YvDB
         r1rVLv3Xzv5592ZOwk9UAOlJr2jizacLSqWniVY9V+sjN6QJiYGTCQT1H/Mc+M3oBfvN
         mU+Gikzm/ZtL3TBeH7yXFjyvSbxLkVRBt+D1Xt95mk4IjzZBlnm7gLr1P5GwcZ2IX8py
         j32yyD9QNubsM7O/UfyEPbqP6FQZR7OTNhKIxc6A3bi0EA0mlhmNwpKMP13ksllWd1I0
         pKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489944; x=1778094744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HqN8rTwQqxRLQ6CfNS8UL2258OmapYg9VvqzF8o3sU=;
        b=I/Y2h7vsUgQIhwkn/U52Ua4HYX4746A0ux5Jo/3RMYgj9c99bQPfk5SN6KlPo5nuSz
         vCc3ndZmgTrQVErCo3nZnzWiCnF42ZxkuK4XGNZSbxDBBlRcnatoJGkhqX312RBQqj2V
         iXlMttQ1ZGDQOHvfbk4zaJLes8JZw+QlmS9iHDi9EZyYh1Uwot4+O79RixGoYzv4j1dX
         25JMbSbdd/iVVvyZXHSl/VwVBaKIgMub6rm5g3noIk7Uel7x7KztOGrfMuFq710YTsqe
         TzYBwDs+Odn85wBXz7AyfF3Lp2ZsqKPB3yTPbHxjibehdSud79z5g5ta6rwcBqQnrHlu
         i7Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+QDe47MDEvx3MdWcSFGHaCuQFO4yOD3nqJuq4Ku4IRfJvtsWjGkR/O2umUFLWC0fuq2btMbxcSRIxIiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztGXd0kowzLh+eCve0gMnP4QrN6aSUqwQ/ccmNRxJmzQ1vJh6V
	ZrKjViRNTIYTmxmm+UeHrJbUklw2mV0BMwyxzGMST6vjGSrcpBznbcOu
X-Gm-Gg: AeBDietTpx2Kuz9U58fQBmOMyYtXo3aJrXfiFowWyxOqFrVji4OULkm3xP5OnOgPmoo
	+7CMtTOQeDC3ZMsoRIUD58lD+0tidQP2YqpA+FdtZBhy3YSlyFFsKzlC4IuXlD9z+/w/a7hT6rm
	/Jc7ptLd3UXcAY7vjMVu8uqZhJfQ6+90I29Sg1c4yQp1XDTCdi/apMoPJGfuY4/2vCeRiBf65qj
	+DsgkZA0oHXETYH9wN5SbWlYhDsTRg44pG1qOJUycd4JRtIzMYbAxe/BbB9hLFSsBQ4kQu9A7y+
	EwSgoZV7BhKScPVIrJI9BiG/vr6bsGCjZEaaEF74CScDL6TqqWWbiMS3YYdlzPR93qPNmgOQDAO
	faNx6t83ZP5DMw7ZYSrdSQU6y/aZX4W6r3NFbJx0AptVt7KuyncXNYWdFEf7Fo9p5GB3aUkIh7z
	Zo3prV6EO0fcLwEWAXbSK0Z6n1mWBhunOAOhhnHqVrNfyE3V8c0ez9r3CbUk4NfL0FNR5x+lwGu
	A==
X-Received: by 2002:a05:693c:2b01:b0:2dd:8ac2:9f7a with SMTP id 5a478bee46e88-2ed197c14b2mr2561784eec.11.1777489943637;
        Wed, 29 Apr 2026 12:12:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54e3:5ca2:4f82:c61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0991d0sm3377505eec.20.2026.04.29.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:12:23 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:12:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Fabrice GASNIER <fabrice.gasnier@foss.st.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] input: gpio-keys: make legacy gpiolib optional
Message-ID: <afJXG4_rtaj3l2Dk@google.com>
References: <20260427143406.3020992-1-arnd@kernel.org>
 <afAz-UQY0aCaThV3@google.com>
 <7f64a929-c879-4839-a7ee-1da2e423b156@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f64a929-c879-4839-a7ee-1da2e423b156@app.fastmail.com>

On Tue, Apr 28, 2026 at 08:12:36AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 28, 2026, at 06:14, Dmitry Torokhov wrote:
> > On Mon, Apr 27, 2026 at 04:33:49PM +0200, Arnd Bergmann wrote:
> >> 
> >> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> >> passing an IRQ number instead. In order to keep this working both with
> >> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> >> the gpio number if an IRQ is passed.
> >> 
> >> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >> v2: skip the fake GPIO number passing from mfd
> >> ---
> >>  drivers/input/keyboard/gpio_keys.c        | 7 ++++---
> >>  drivers/input/keyboard/gpio_keys_polled.c | 2 ++
> >>  drivers/mfd/rohm-bd71828.c                | 1 -
> >>  drivers/mfd/rohm-bd718x7.c                | 1 -
> >
> > Let's see if my patches to rohm drivers will get accepted and then maybe
> > we can remove legacy gpio API from gpio-keys altogether.
> 
> I think it would be good to still merge the drivers/input
> parts of my patch. Since CONFIG_GPIOLIB_LEGACY is still set
> unconditionally at the moment, that should work fine as long
> as your patches for the rohm drivers get merged before
> we turn off CONFIG_GPIOLIB_LEGACY for modern platforms.
> 
> In linux-next, I see these users of the legacy gpio-keys platform
> data remaining:
> 
> arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> arch/arm/mach-orion5x/dns323-setup.c
> arch/arm/mach-orion5x/mv2120-setup.c
> arch/arm/mach-orion5x/net2big-setup.c
> arch/arm/mach-orion5x/ts209-setup.c
> arch/arm/mach-orion5x/ts409-setup.c
> arch/arm/mach-s3c/mach-crag6410.c
> arch/arm/mach-sa1100/assabet.c
> arch/arm/mach-sa1100/collie.c
> arch/arm/mach-sa1100/h3xxx.c
> arch/mips/alchemy/devboards/db1300.c
> arch/mips/bcm47xx/buttons.c
> arch/sh/boards/mach-rsk/devices-rsk7203.c
> arch/sh/boards/mach-x3proto/setup.c
> drivers/input/misc/soc_button_array.c
> drivers/mfd/ucb1x00-assabet.c
> 

Ah, yes :) I forgot about these...

> Do you already have patches for more of these? I would like to
> kill off mv78xx0, orion5x and sa1100 board files (including
> the ucb1x00-assabet mfd driver) soon, but that still leaves s3c,
> alchemy, bcm47xx, rsk and x3proto. These platforms are in
> varying states of disrepair, maybe a few more of those
> can be removed instead of converted. I know that Mark
> Brown is still using the s3c board, and Waldemar Brodkorb
> was recently working on restoring bcm47xx into a usable
> state.

I have a bunch of patches for alchemyi (posted), rsk and x3proto. If we
could kill sa1100 and assabet that would be really nice.

Thanks.

-- 
Dmitry
