Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AF32B137
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111043; cv=none; b=TEbUGF9/IPJgtzRTDtNaWekXumgkIW3pG0xLOHavRP6M2a9zg6ULT4yi2FF0bo8/V0JOiVm87mi/K9qN4wwxBg66XFwrRftO6aS5nEY+0ZznIlbxqiTac8v/X6b54v2aknQg0ggCoY1p7XTvJeexPkcFusqexXqlXbGsXRAdrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111043; c=relaxed/simple;
	bh=TVW9575YcKLG0bHn7A6LJowba0uRlJHWjHvsONl4INQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsbNTKZg0lJrqv7TPyqYBinzDln3tnxQaCA3v1fYaxzi2YeWm8Z+PSYPfGMZ4bAgXuBYiuTukyooQaNWnsi8ce4UNeOnGe9xiv+Phy2BCw3b0xJLBLhp/lZn0L+hhrMF+/SsgvVCJDrByeaEWrs3102q0LfV3Rw8h8vwvE5PDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzsHds8k; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzsHds8k"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-307263ad0cbso9778635eec.0
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111041; x=1781715841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J93QDWWtLOTX1wvAB+lhHDAb2H6FMZC29/IawhQbAQA=;
        b=ZzsHds8kr9lM7kT8mMeCi1V86B8GCn+NH0KGiztCdGWEdWMhof1tAv5jSODGHbSnLu
         xcfSHGUBXuXPBo8twjdS0MSToCqbbesVYPqr19pu1yNznMULfnhvtjvSgLm30brIzqpQ
         EDETPOBRRkqZzClK6lSh7b2BUbYVdlo8y/ff/WVWdOGgoqLbEX13emNEQjdq8BJ+7i+k
         Dny8ff/CLiohJ20Whz15cxzX3G2uIiUdbR/0hlQkH8RCm2oxZKqd6y9X9HMkJw5PWTd0
         QGTy1Y8JL9Ig7eoVqsXkJSe6yOYNs91rDgKClnx0gcN+bnOpIi6RpOJNPUmoV+cucel8
         xgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111041; x=1781715841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J93QDWWtLOTX1wvAB+lhHDAb2H6FMZC29/IawhQbAQA=;
        b=FgaM9oxALfvXlA3sHLwEBam69KE6tH1XO8mcmgYoe+uSYNuCDdJsWjWbafELWK/pfh
         wGLTr7h+HjtRhsA1bjAVmgAhnDNH9Kk+LoxiPWYheZ1NIGvfnQOFQay2YOuD64DPbJrj
         RVkw4XeBXZgwg9t/mSSj66YXX+OgIMjGjPB/S2eZHxFgZtCgd67KsHtjlEmXPP/GEGPt
         03J3sEPb8Fea8ziM5MUTZtBlwt+C1kQ2JqhYGGSrR8esXt/07IGuRu44go8dWVt1Pc8V
         2nBofUkl6W90Eq5lp7aOTbisKRgplwQzfjNUKeg5BGjWTrjIr7wd7O0vBojUhWZpGnET
         M8iQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Bfv12h2S39yuo0VnqAyxSgjqIj6t6Iy1+lCK8oLoDAI2K0UFGl950REHOCHqRaPqD/UNePKjiQt1nww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkz/wovrs2UMTY3gxe93j3vUvtia/mDk9TgxLIkz7zeEffB8dL
	bJcQ0TqM5cM2fbOtDHpy/5xl/e8Fc9p8ZRKRrrKmmY1+kUVufnipF6OoPYyU5w==
X-Gm-Gg: Acq92OFjnE8dDYy6CvxC09w19YjKK5hC6R9YOwAp3fMRpaV8w6Q/FjJgFvZDbVJdbAd
	RE4WCt7/6//lL11eSB03ia/NnfMk8mfuMEnvMvl72cSA2gUeDkBEqj0BOzyfspJOHfStG8yA7sD
	4bzwe1PeNtMTH1hKkftvqQ/woa6a6FVPYZFIWhpoGlKyuTz3J2eWKsQelPQ2f+7VPmoHQv4hCpc
	Ibxxtxepwf63lAdoUaul3juxfxqxF+ZdegCqlMxEoKluBb8E2sz1thFvbobkTUEmYBUIV1QMcQ3
	odo4SdqNBYKqDgN04QP/y4Hqs8KPShEwKUq02yCy6/uhnH93XnUrFLStvbW26LAhzG84luQJYBk
	C4K73+T+WYTvbhvjOXpTfNw9nAgJck1CHOjBX64LmWT4vkax1++3+dk5mPC51JFhjNWzhZA7Rx8
	j+f9N/nfWyeHCUkd7frjMsgND1HQZK6h5mzNfgsdd2LOp2lZp/FqK5qON3me5MtT2JxCeUSGR1m
	uE=
X-Received: by 2002:a05:7300:7313:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3077ae89f68mr16554448eec.5.1781111040802;
        Wed, 10 Jun 2026 10:04:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f9da69sm18610159eec.31.2026.06.10.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:04:00 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:03:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
Message-ID: <aimYkTdIAoye5sEG@google.com>
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
 <aibz3auoiq4CFa9l@google.com>
 <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
 <CADkSEUhh1NdOMTHVsErhqzyCpDGFA-FkNFaWp94e9LnB3njxqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUhh1NdOMTHVsErhqzyCpDGFA-FkNFaWp94e9LnB3njxqw@mail.gmail.com>

On Mon, Jun 08, 2026 at 10:13:50AM -0700, Ethan Nelson-Moore wrote:
> Hi, Arnd,
> 
> On Mon, Jun 8, 2026 at 10:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > I think this is correct, as footbridge is the only one that selects
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and defines I8042_KBD_IRQ on arm.
> 
> I came to the same conclusion.

I see. In this case:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
