Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50361231A21
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777721158; cv=none; b=eYJ4bTqSvgYkUHgAgUtr4GqJv9TBPtWxgKRHVdK5w5/gi3EKZRK5RnxATY28es5gqJ6fN+f2CaHXS1sVy5m4GnrQKXbNgXlFE2wA0WrPjvPzIdoG48oErbNAYUf6UIe/IlPnpySCWk+hZBiwsGlTvog7qjl6MMSQ0Dk8mRsTVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777721158; c=relaxed/simple;
	bh=yy4XsArtrRKT1S4NqDorZmcv3l5hi/sC0S2OZixkReU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4M6f8tU2VvC2wWO6QPoAYLved2RPoulK4s2nwSwM2oN/y5+NmBTio45lgqP5t1ZhFHqE4MpdgVRSPihDt9CYITJUD2syYyiF7uoppH3jFxSw1YZURNDztbBuV7A/bhu1IXiVbUANSl6nw9wQrFf+HBcHWU0j0pTAyHV48bubZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=4kWdCnv1; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="4kWdCnv1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mp2uv9vTZo+OgUQ47UKR0UnUqpelJsUJ4sj0/ejeCDo=; b=4kWdCnv11IhiuaMGXm7Bptl8S7
	l8/FXW8H/uW2suvDmzSIIqW3z0cdVb6jzM3NadvQJxRpTJchcUwqfRfKt6dTmSmb/H64cVh/13HmN
	VdOi45BuKpTEOWU/BPwsCE8Nx2Hug5h+GVUGOaGAK6tjGUGP5Y7WQfQZQa3NegHsyIANXeBr/OgKR
	X/n/Nj/i+D/JXENW/WrlQ96+vCplX9CMF64BiQHix/QV/amtMOxJNOI5k61Qa/zznlqHbeINwNHZZ
	PKN5h1RiznG7Z0NQdlocsrxl5cdwajtL9IWEdakKtvkzpEskw5LOrmyhWapD89+TwS16x2v5Xkpco
	wKNO1WGQ==;
Date: Sat, 2 May 2026 12:53:13 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yuki Horii <yuuki198708@gmail.com>, clamor95@gmail.com,
 johannes.kirchmair@skidata.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: touchscreen: tsc2007: Reduce I2C transactions
 for Z2 read
Message-ID: <20260502125313.3e1c296a@kemnade.info>
In-Reply-To: <aeVwUKCQmTmn3OnY@google.com>
References: <20260410074100.1660-1-horiiyuk@ishida.co.jp>
	<aeVwUKCQmTmn3OnY@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Sun, 19 Apr 2026 17:18:23 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Yuki,
> 
> On Fri, Apr 10, 2026 at 04:41:00PM +0900, Yuki Horii wrote:
> > From: Yuki Horii <yuuki198708@gmail.com>
> > 
> > The current implementation sends a separate power-down command
> > after reading the Z2 value, resulting in an extra I2C
> > transaction per measurement cycle.
> > 
> > The TSC2007 command byte contains a 2-bit power-down mode
> > selection field. By selecting the power-down state in the Z2
> > measurement command, the device powers down after the Z2 A/D
> > conversion completes, eliminating the subsequent power-down
> > transaction.
> > 
> > This reduces the number of I2C transactions by one per touch
> > measurement cycle, decreasing I2C bus overhead and improving
> > touch sampling performance.
> > 
> > Signed-off-by: Yuki Horii <yuuki198708@gmail.com>
> > ---
> >  drivers/input/touchscreen/tsc2007_core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> > index 948935de894b..ff60245baa96 100644
> > --- a/drivers/input/touchscreen/tsc2007_core.c
> > +++ b/drivers/input/touchscreen/tsc2007_core.c
> > @@ -61,10 +61,8 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
> >  
> >  	/* turn y+ off, x- on; we'll use formula #1 */
> >  	tc->z1 = tsc2007_xfer(tsc, READ_Z1);
> > -	tc->z2 = tsc2007_xfer(tsc, READ_Z2);
> > -
> > -	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
> > -	tsc2007_xfer(tsc, PWRDOWN);
> > +	/* Read Z2 and power down ADC after A/D conversion, enable PENIRQ */
> > +	tc->z2 = tsc2007_xfer(tsc, (TSC2007_POWER_OFF_IRQ_EN | TSC2007_MEASURE_Z2));
> >  }
> >  
> >  u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)  
> 
> Thank you for the patch.
> 
> I'd like people using this part to chime in (CCed).
> 
This looks like that there might be some reason behind it. But I cannot find any.
Either by reading the datasheet nor by testing.

I have checked the interrupt counter. Output seems still be same.
Interrupts appear when finger is moving.

So 
Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04



> Thanks.
> 

