Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249038734A
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036043; cv=none; b=Ef9jxwqGUCTQ+xEgq1dkZKBLFM36eUYaPHUkuAFQZxiVRy0yIgPaG77lSO71EfX7nbm2U3f9/hobq5imReYH6gIxr0a7gqAhK9aYPtoEQNS0ZryM9Kxjd47TUgegqvbsMGmP9GNEBf0aYzkhfVgMZb6+YfqLUWRn+oHn6JBnmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036043; c=relaxed/simple;
	bh=tW6BQQWLK6LD5clxNFXzE8v4o9oRX1JWcPOvo/Jp5Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3s5Ex7mp34LAJYr02lS5iYSt6mjXzEras91uiG+w5p+IcuDsvlY6V7SDGbSJa6YqOsw7oDuj8qBSfUeSI28+ThwkCueoHctkrw47VuTTvdq57NNSWkikmxeVlDvFofsl7GacMKRRvbCRpWk3z0NayAANdW6hs58BFwDlVad/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXzI3I3r; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXzI3I3r"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6f85470b6so677105eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 14:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769036033; x=1769640833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cp39T9yhEDWCKMoI7qosF72z7yBKmmlkDNy5bRjSKFM=;
        b=IXzI3I3rSDvxoa9XS2qqBcrgBmKQINLb+OhGgJA7GE158nev7WZW8U91vcZmM6HR5n
         hCsHfEjk4D6RjcLifvzTiNezebMWV1TTQA1Hzz54CLp8lU+DKSFeNWp56ITsWneghP/M
         F+mhleyb3042tUyqR70liXnFWIeHW56ilbm40Ddn5c6DPNUauGOsFTFvF3DySqlxKBXM
         sYhbdHhKyDsxjzoWVtmHo10AR4npaXT1DCeFsJQ6BU7XgAYp1cp6Wj8gJx0tbOxF6htJ
         M1bjfod8ZO4OjtjciaXO4R5KldicaGIHqUoz14HFIcaML6yFvMCGVGfWciFsVuYYTfNr
         1hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769036033; x=1769640833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp39T9yhEDWCKMoI7qosF72z7yBKmmlkDNy5bRjSKFM=;
        b=mH15ecU5cfskE95GBFOUJukuI1P1L0iQQgzMpJ72RUF+IxMYc89DQmfPyxm+ScqfSL
         n4rZWkuBhuE9P17XuXy23h1Lqm3qgCXhq3uVm9fmWMYTBNL7ksw3IxSnCWu3P4wTQ7Sh
         sykqmEC6eqiFacC1IUJq6MTQ+mog20QK8MpgztnqRd8nvbeWiq7LXes9hHtpvwuBrczx
         ++3AvePES1bM6/pmtsISycPpaR1AylT6gxx5uaJlJvjbJhnldBJ4a3u3vgkJRns6i42n
         qv/A+zIgpCTMSarKtpIoEf5YzZABWl05cXgVXYYs7TfGmDjGgRyHuKEGs4pHHUlU/d8P
         ybdQ==
X-Gm-Message-State: AOJu0YweIIPbhYJVxurmO+KGA/CW3n5t+WzTflHAvbOV0aG6+zPovwdF
	j7GAr27xFDQZDYTgNwPe40V//d/kFnIumNOwAl4zNBmXxoz6j9ofia5F
X-Gm-Gg: AZuq6aKIG4xtYALDbLFcT48ULzxsJJ+S5ZQ+avIdy3AlMPT4ibMlZkhGuLFEClmg591
	oP+ni+khvEOhctdVctBZovcD7Sdo9o4j3mSemBYcNyZ9ToIABIFrpQomb526uGflYAUTf4xAr8p
	BnbWhGhYhtuPn1qVmIz7cQMSejPiu4OdwiiwIAPDSJiKoxbfDtY4iDFkPyfdpHpAwwKv/YmrIvp
	AmjzhnwAcYp5MUowSDQD5getFRKZX5DMn7ely2misq7FaL/VX0MW/iZRCnNuTkMMpl3nM0CVI27
	bv6UsqWmxF9cWU0LpT4+BqwrO9Ias8UzvMWgAgIo4p7AdD4tQxUadXu7eeiiGpVzaJjowT5s8FW
	/6nlja7UhEahFQTyMTJmEjOaKaQo4+hTrlPPYuB2VH+qtbM9klzXkGE+k4lm59U6pHjSfjahvn0
	CC7IgWza5ix4xYIW8UosiQi4D6s++jhSrXIAOzWu/m8EV/5PojKop/GVTB2fIgzIk=
X-Received: by 2002:a05:7300:a498:b0:2ae:5b01:bfa5 with SMTP id 5a478bee46e88-2b6fdc9c839mr4812625eec.32.1769036032553;
        Wed, 21 Jan 2026 14:53:52 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm23464605eec.25.2026.01.21.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:53:52 -0800 (PST)
Date: Wed, 21 Jan 2026 14:53:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-input@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Job Noorman <job@noorman.info>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Input: ili210x - add support for polling mode
Message-ID: <tuvidadi4sezm5b3ydvuie6pcxpf7pw2jrysafwdhpmtz6vjxl@o4zqdnjxkaed>
References: <20260117001215.59272-1-marek.vasut+renesas@mailbox.org>
 <20260117001215.59272-3-marek.vasut+renesas@mailbox.org>
 <wv3vil4b4lgfrqt4qnzxiffnniw422xjfdiz4svkklnfrslz3g@yzqc265pj5t5>
 <bbb7fb54-5b04-4c38-840b-8cab58eeec7b@mailbox.org>
 <nk5qn7ye44lbtppp2opa273ut7lxkcz7jsw6giagwngiwhg7rr@puexvdzd2ymq>
 <cd8f71db-c2d1-4c85-8148-83822762a916@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8f71db-c2d1-4c85-8148-83822762a916@mailbox.org>

On Wed, Jan 21, 2026 at 11:42:55PM +0100, Marek Vasut wrote:
> On 1/21/26 6:23 AM, Dmitry Torokhov wrote:
> > On Tue, Jan 20, 2026 at 11:50:53PM +0100, Marek Vasut wrote:
> > > On 1/20/26 7:31 PM, Dmitry Torokhov wrote:
> > > > Hi Marek,
> > > > 
> > > > On Sat, Jan 17, 2026 at 01:12:04AM +0100, Marek Vasut wrote:
> > > > > @@ -860,16 +893,12 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
> > > > >    	 * the touch controller to disable the IRQs during update, so we have
> > > > >    	 * to do it this way here.
> > > > >    	 */
> > > > > -	scoped_guard(disable_irq, &client->irq) {
> > > > > -		dev_dbg(dev, "Firmware update started, firmware=%s\n", fwname);
> > > > > -
> > > > > -		ili210x_hardware_reset(priv->reset_gpio);
> > > > > -
> > > > > -		error = ili210x_do_firmware_update(priv, fwbuf, ac_end, df_end);
> > > > > -
> > > > > -		ili210x_hardware_reset(priv->reset_gpio);
> > > > > -
> > > > > -		dev_dbg(dev, "Firmware update ended, error=%i\n", error);
> > > > > +	if (client->irq > 0) {
> > > > > +		scoped_guard(disable_irq, &client->irq) {
> > > > > +			error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> > > > > +		}
> > > > 
> > > > You already have a scope here, no need to establish a new one:
> > > > 
> > > > 		guard(disable_irq)(&client->irq);
> > > > 		error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> > > 
> > > This part ^ I do not understand. If there is no IRQ defined in DT, I need to
> > > call ili210x_firmware_update_noirq() without the guard because I cannot
> > > disable_irq() with client->irq < 0, else I need to call
> > > ili210x_firmware_update_noirq() within the scoped_guard() to disable IRQs to
> > > avoid spurious IRQs that would interfere with the firmware update ?
> > 
> > You do not need to use scoped_guard() because you already define a scope
> > in your if statement:
> > 
> > if (client->irq > 0) {
> > 	guard(disable_irq)(&client->irq);
> > 	error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> > } else {
> > 	error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> > }
> > 
> > This is sill a bit awkward. Maybe we could add to interrupt.h
> 
> Let me do the part above in V5 , and then the part below as a separate
> follow up patch/series. I already added the later in tree so it won't be
> lost. Does that work for you ?

It does, thanks.

-- 
Dmitry
