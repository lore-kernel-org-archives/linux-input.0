Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE93A8FEC
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973018; cv=none; b=cNd5SdBpSEOQ6GXNe+4ry+gXOiDRup17AdB63jLC5hNi42Ae2VrrhUirj+u4cigbL+GRNm/S+XNjY6d2DDOX+VepvfF4I6Xc4OkHobxUtWjHJhhzKk+n0njo5aSJ7kyE8iYE+msAwYSBxntgKB+0cOPPakwNuCjLoEQsALndKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973018; c=relaxed/simple;
	bh=Dw9HsdmJOjzl+Kv7hLQdOCfLXTyunVYFcP72pCiv2D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sljPrJr3N2RQk/4KozcZJ9WhIOQQxCHdRATT9NL4Zp/LZovYM9naT2lNhZXZAOMYoYP7aANsOtILJ+a1guiBY7aEuUvJNEF+UnK5blScz+j7VUf/6VQCOi91ki9wHoAIJivwiQrBPZocTk5QqMLSkSkaIUNanUL1Iu9Y+AdtsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEPjFqFR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEPjFqFR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so11722901eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 21:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768973016; x=1769577816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xHJElSAdSqvbGqx9RRBRVuePrz2/MCvNfCaMRCbPdA=;
        b=PEPjFqFRghO1tmToodI9M6hMlNh3UmQVP4M4XujxRrWcReM1xzsFqk+fhRNQeOXwyG
         qZeb6l4g44wSdY828zaMOqqV2sCt0iNAXw0xS9lK2eOFEpISnzxYRExmPPkefliqKifY
         HJoBbGELDC3fYpH26mAgSgXPjBh2mZh1KGXnjr5zmkWNHVdzQtKxUhT6BiualpPxCwWZ
         OLb6tjCFDC/JCWE6hEhzKfCU5hU5Ld9cOncB07LDxR1UYvVLFpdng8OeQ+mlhDXTcmuo
         xGB8/oq+Uz4q3uqVoKRQf0QiuPFlsM7h2Whc57r2UnuWIrPI0bOGuhB8FPtM57tUbo2A
         0F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973016; x=1769577816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xHJElSAdSqvbGqx9RRBRVuePrz2/MCvNfCaMRCbPdA=;
        b=T4sDkLrEKUX9ROaCAhBOwxhD1s4syXcADdDh6dz7WZnnKBi7QQ+DMYWmtRsTK9juZA
         msABImZh17VoCE7K1YhwFwH32Iz/4z/RFnELG6+dYncW2MEiMCsbSRL2ls8QlV5pGGNp
         fx3OuxldtTFMADiGFhWNF1APPKhg3HhLojLRkn7dk8i15noubtSn9Q+qAXkYX1oKeBdL
         GskVD4j41lKSRh/WuUxF+PB87yl2ns7mQRBqeavuy6HFoY87xntPmG5pD1XrlR4M2+0k
         PO59qWTgiYHTNUxFqvC/MqTPF/2fre9C1lMe4pxdme9HUG+ekuKxFGvy2t3QEzEtY6N1
         AfJA==
X-Gm-Message-State: AOJu0YykfzNb4JmSPXOKT2C9PpgZvBImtFiHE6WZR85WVeadYFXP0cDa
	9xyhZbx8PRsC3R1Tc5k9+uCHLYNnLwnFG8XV5S/tAV2uJz1te7xEs7YE
X-Gm-Gg: AZuq6aJWArPOIHuc5qOINppwku+yA0J2rJvnvaCxTWC105t87ijuTedKBONJ7NI+t8N
	WBmqXNEQ0SyLQUYLe8dFoXckuIUn30FnosLnDH1WKVap90TTfrn30XAChyf34nRTT6dI72GnAHM
	oxxrHp55jatCvo5p3hAdKXySpHT0KdgiiXdmzcn8CZcEQYHeneQ7iqgOJyWBMWQsHfui2piQrpk
	2JG8AN8m/rDTl7AZP/0m/EOxgrS+zUHLSH4cQzbITTXFCSErfYpJkKo+lQpPEfQfjpnTQsHrxzf
	korbLr7yNBrEVB6zI7VwzdRrJEB4A1vBpNxlp6MwzSCj0RrGFsDb8w3+YCpahBCL5KvG+VUzHsG
	efSR9D6lnAeWQM+k8JpAkvuzIsMsq1RQvd4OHK2W14MQ+XIPy97cS9hdhGh9phSSMw38bsleCSJ
	ANyikq1fv+qlcKoMCbH0vQgilu8yh0djAHUv7aXVysg5cGNgQS91rrdMvtlcMlvL4=
X-Received: by 2002:a05:7022:4399:b0:123:3bc6:1ff7 with SMTP id a92af1059eb24-1244b3700a5mr10142956c88.27.1768973015688;
        Tue, 20 Jan 2026 21:23:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm22877361c88.3.2026.01.20.21.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:23:35 -0800 (PST)
Date: Tue, 20 Jan 2026 21:23:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-input@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Job Noorman <job@noorman.info>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Input: ili210x - add support for polling mode
Message-ID: <nk5qn7ye44lbtppp2opa273ut7lxkcz7jsw6giagwngiwhg7rr@puexvdzd2ymq>
References: <20260117001215.59272-1-marek.vasut+renesas@mailbox.org>
 <20260117001215.59272-3-marek.vasut+renesas@mailbox.org>
 <wv3vil4b4lgfrqt4qnzxiffnniw422xjfdiz4svkklnfrslz3g@yzqc265pj5t5>
 <bbb7fb54-5b04-4c38-840b-8cab58eeec7b@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb7fb54-5b04-4c38-840b-8cab58eeec7b@mailbox.org>

On Tue, Jan 20, 2026 at 11:50:53PM +0100, Marek Vasut wrote:
> On 1/20/26 7:31 PM, Dmitry Torokhov wrote:
> > Hi Marek,
> > 
> > On Sat, Jan 17, 2026 at 01:12:04AM +0100, Marek Vasut wrote:
> > > @@ -860,16 +893,12 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
> > >   	 * the touch controller to disable the IRQs during update, so we have
> > >   	 * to do it this way here.
> > >   	 */
> > > -	scoped_guard(disable_irq, &client->irq) {
> > > -		dev_dbg(dev, "Firmware update started, firmware=%s\n", fwname);
> > > -
> > > -		ili210x_hardware_reset(priv->reset_gpio);
> > > -
> > > -		error = ili210x_do_firmware_update(priv, fwbuf, ac_end, df_end);
> > > -
> > > -		ili210x_hardware_reset(priv->reset_gpio);
> > > -
> > > -		dev_dbg(dev, "Firmware update ended, error=%i\n", error);
> > > +	if (client->irq > 0) {
> > > +		scoped_guard(disable_irq, &client->irq) {
> > > +			error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> > > +		}
> > 
> > You already have a scope here, no need to establish a new one:
> > 
> > 		guard(disable_irq)(&client->irq);
> > 		error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> 
> This part ^ I do not understand. If there is no IRQ defined in DT, I need to
> call ili210x_firmware_update_noirq() without the guard because I cannot
> disable_irq() with client->irq < 0, else I need to call
> ili210x_firmware_update_noirq() within the scoped_guard() to disable IRQs to
> avoid spurious IRQs that would interfere with the firmware update ?

You do not need to use scoped_guard() because you already define a scope
in your if statement:

if (client->irq > 0) {
	guard(disable_irq)(&client->irq);
	error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
} else {
	error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
}

This is sill a bit awkward. Maybe we could add to interrupt.h

void __disable_valid_irq(unsigned int irq)
{
	if (irq > 0)
		disable_irq(irq);
}

void __enable_valid_irq(unsigned int irq)
{
	if (irq > 0)
		enable_irq(irq);
}

DEFINE_LOCK_GUARD_1(disable_valid_irq, int,
		    disable_valid_irq(*_T->lock), enable_valid_irq(*_T->lock))

and then we'd be able to keep the driver as is (just adjust the type of
the original scoped_guard).

> 
> > BTW, not a fan of the "_noirq" suffix... Maybe drop it and add
> > lockdep_is_held() there?
> 
> This part I understand even less, how does lockdep play into this ? The
> scoped_guard() disables and enables IRQs if they are available.

Ah, sorry, brainfart on my part. I got confused by _noirq suffix.

Thanks.

-- 
Dmitry
