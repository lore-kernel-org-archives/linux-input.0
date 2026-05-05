Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFB24A05D
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940965; cv=none; b=Buk66t/yo5Ue5PwHwCg/xT+8MpCigVdEq1id2+1u7shd05TYJ8/d/yRCoBwbxphD5nDLA3/DkIuVCFFlqOtkFwOHn+CjCt5k0ErwMX1Po/OpWRZgAMsupDUf8lZUaFnCyTbBdxczuew9bIKevkSRlNbmJYZ+ONzOe3x4AhRcgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940965; c=relaxed/simple;
	bh=n+yS1CvY0CmW7OVftNAM9NlRKuTVESjFOEPTAVICytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmESW7hlmQkzdq+Tcs9eE0sAkx2Rkya4dcpH/+uCdIcY0yGZB28079hDiXQVHZdUlImr5fF/tQ67a7MTllqareH+YoR3f9i0Pozon+GEo18w5us0Xc4SQaYlFcomEKPZ3JDpespgAYq9fOXN1vduNqqw25J5CdQorseYQRA6hpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/yhkIZF; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/yhkIZF"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7113823eec.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940963; x=1778545763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ98BYYgVSags0l/ypxUAgmbyziNWlO6SoP8eFJlVT4=;
        b=K/yhkIZFNs+JhDEQHYwbnPV5At0xTwJ9bTMW973RyAVrT67+kCM4wt3ej1FeTbDkQH
         qD9AcmrJHKk5bFb2ILummDt3uI+OMz4d8NcQ9UFKEEMOnZ2Z6AeqSpbHE0AehdF3RFUv
         yiKZiRZsQQlHNHazQkteuEQ+DPsrF3LKb5kj7huf8BRhqDBfqooNLIYxkSHtHM1qEpRf
         7ZocMHhZheNc40sKxoXSNmWRYTiipZ2JgRuUW4ENpEJYv65LSH61aVDgV3/LBx5AB/03
         SvNRL7AybcQasj0XPH5BTgrf5G9cHT1CKoPHW9NyYHcb/hu67p6ScdK1Y4CGZ5PbjGw+
         On9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940963; x=1778545763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ98BYYgVSags0l/ypxUAgmbyziNWlO6SoP8eFJlVT4=;
        b=HxAecf6hPI6T2/82JcD2ko1oLhTMD4wGGhmllqCeV9yqU94Of0QUjpqjXbgXOUUvqN
         xk7lXRhQTRATBYA/RnGCNkI4hnaghkU429UtPHSBLTWXeX4VEQktTG8qPbG3tjbSX0qF
         tDUrT7hz3CFmHXCUAoJhSKMBV9zOollZuXZrO9U/FJB5fntlmL1mYYAWgBSDN4PMPoVT
         1FNqgEouREKM8NBLSShu6bNLXeWhiOYMM9WZ5WVk26zkoF2uEEPO/m6D52qdMAge+SSk
         yCqV1WS0xUR0awLzkU0o2mJwU1Bn23JWwkV4JRwCFxYpV52nOoCuByl6b2Te1VKrm2DK
         lVGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0DQZY4Rn9d4m8j3nIQ9bUbqbNWwhl7De8fhxxc3lRjxF3oOqNaulbXkb7Diq5dF9It4g/Y4kHC/47sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YziOR5EpIv/G+WagXXnObbAs57KYnnhve+aCCzRaUhdKP0Y0HQC
	QG4imTH4TWc1YiM5fx63zljdvC+JOmS8nKIz1iW0kM06pPCOH1ecBpjm
X-Gm-Gg: AeBDiesSMEAXWdtJNyXyfYGapIhSwClaZ+J+jkZTV88kIvxm/wLSJeo67G4gKMPe5qD
	B0OigyTYbj1N5v5xWNDedXdJz5kgq40JSew0XNjfIwgytdRDuhpMPJpGFfMJaaZYlMhQnxB6+fj
	pMCDSOykljK0N34iw9avm7xTL4qUdpyAZjiUrrxiZVivlhilk8yrpiu8S2RNiUyuQk8fph88+G1
	ehgtAXpL1yf2LY+ote4Bxw67p/83K7+amM2TKcDvJEu8zkbJNOHSwVRj6peMgja4IE2SKQZgAPn
	ElcLCvLPc5j7sbXLEUL7eCEDsp9/oM1WxG5YkcDxkzA+2ZaeWOzCKaP5bpTuck3pQWnHL+DOe0g
	z7Fb9GqwLv0rh4L318fF3llsB260ktKAgm7gMaOBiC9H3VzjMlxXuFomiv9K0m5oq1DunnxcjQL
	0pyoLuvTn035uVS+tNJJMmQGzL57LXGz4mmZWu4lann7zuuhopE/RtN5PcVLHZ6PYbegzkRrq6L
	uIjrbI8steR+g==
X-Received: by 2002:a05:7300:7490:b0:2dd:db16:478e with SMTP id 5a478bee46e88-2efb82b2113mr4552969eec.10.1777940963176;
        Mon, 04 May 2026 17:29:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71bccsm17395122eec.11.2026.05.04.17.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:29:21 -0700 (PDT)
Date: Mon, 4 May 2026 17:29:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Yuki Horii <yuuki198708@gmail.com>, clamor95@gmail.com, 
	johannes.kirchmair@skidata.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: touchscreen: tsc2007: Reduce I2C transactions for
 Z2 read
Message-ID: <afk5tzJFRUqyFxUK@google.com>
References: <20260410074100.1660-1-horiiyuk@ishida.co.jp>
 <aeVwUKCQmTmn3OnY@google.com>
 <20260502125313.3e1c296a@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502125313.3e1c296a@kemnade.info>

On Sat, May 02, 2026 at 12:53:13PM +0200, Andreas Kemnade wrote:
> Hi,
> 
> On Sun, 19 Apr 2026 17:18:23 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Yuki,
> > 
> > On Fri, Apr 10, 2026 at 04:41:00PM +0900, Yuki Horii wrote:
> > > From: Yuki Horii <yuuki198708@gmail.com>
> > > 
> > > The current implementation sends a separate power-down command
> > > after reading the Z2 value, resulting in an extra I2C
> > > transaction per measurement cycle.
> > > 
> > > The TSC2007 command byte contains a 2-bit power-down mode
> > > selection field. By selecting the power-down state in the Z2
> > > measurement command, the device powers down after the Z2 A/D
> > > conversion completes, eliminating the subsequent power-down
> > > transaction.
> > > 
> > > This reduces the number of I2C transactions by one per touch
> > > measurement cycle, decreasing I2C bus overhead and improving
> > > touch sampling performance.
> > > 
> > > Signed-off-by: Yuki Horii <yuuki198708@gmail.com>
> > > ---
> > >  drivers/input/touchscreen/tsc2007_core.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> > > index 948935de894b..ff60245baa96 100644
> > > --- a/drivers/input/touchscreen/tsc2007_core.c
> > > +++ b/drivers/input/touchscreen/tsc2007_core.c
> > > @@ -61,10 +61,8 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
> > >  
> > >  	/* turn y+ off, x- on; we'll use formula #1 */
> > >  	tc->z1 = tsc2007_xfer(tsc, READ_Z1);
> > > -	tc->z2 = tsc2007_xfer(tsc, READ_Z2);
> > > -
> > > -	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
> > > -	tsc2007_xfer(tsc, PWRDOWN);
> > > +	/* Read Z2 and power down ADC after A/D conversion, enable PENIRQ */
> > > +	tc->z2 = tsc2007_xfer(tsc, (TSC2007_POWER_OFF_IRQ_EN | TSC2007_MEASURE_Z2));
> > >  }
> > >  
> > >  u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)  
> > 
> > Thank you for the patch.
> > 
> > I'd like people using this part to chime in (CCed).
> > 
> This looks like that there might be some reason behind it. But I cannot find any.
> Either by reading the datasheet nor by testing.
> 
> I have checked the interrupt counter. Output seems still be same.
> Interrupts appear when finger is moving.
> 
> So 
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04

Thank you for giving it a spin Andreas.

Applied, thank you Yuki.

-- 
Dmitry
