Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859610;
	b=STIdFo30MqXo/af6cSwPXv3u0w7YAVAW3Bkih6KsntCul1UaDwruUXxqA/GBBdSYDS4U
	 vZNymSwRPMxvJSdeXkSRJ3rOysKBAG7qhVRjGIzDZdtJShOqNcDmCm/71iNaHMktpVwdP
	 9xGZ+Vrx7URMyH+UQOLOkl8BXwct6BtkUxpbcAePBL0JOGGajB1/G3m/vV1s0XZVXc4Oh
	 /wZVmiWXrkxj+RBZYZmNUnn4wRDQGctylCRy/5R5xC1G/eQDoKbMwsZ+73TGYLHw3x4c7
	 +9pgt+JezVaWTiG9FeECdNaUKwFB1mva5EhKGzksdW3bp30UklqYhLsVC5xa/OORaTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859610;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HWddJWKKqGmq8vl+zXTvh3cDqPUlu3TThSvnka3qiUE=;
	b=RBJVddzGq8DhkUF56DOvuyeIy4fHWRqzrba8iS/q0KRFFOPSA78qi1HWNwmC6MzT/Jlx
	 Dq+fBvsd0QPYHMbxAbxDtCPOHdqaZCvq0nfgkob0lvWIlMeR/tFnaYxGtJo3wfHvbsSDw
	 s9tOx/iR8hjMz50Xz4l/mNlo1g7kvELB6VcSshoqtvQWm8Di2g9xKseAlnJaTmeXzYMiE
	 R1u4AYIf1zOBkbkWlOx3YhOnERbCeORQigFIm53HlRePMa3o1T21VqNlFNk0EfXHsGRAg
	 /3JycqCV2/iPzefrIBX1GRuPAdZO0y605UFcEejPEX66ONFad8TXM/ok47Sh0d09mhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=qmm4bmuW;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E913606A31B;
	Thu,  5 Nov 2026 06:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E913606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=qmm4bmuW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=HWddJWKKqGmq8vl+zXTvh3cDqPUlu3TThSvnka3qiUE=; t=1793859609; x=1795069209; 
	b=qmm4bmuWnbkKIKqAj4vCRlNQj405DqYUHrN0DqKvL/rrGfUXDSrDPnafmyGFRo8S7utrDJeF/8E
	y6sOuaO6xUTWa+Uix49f5BRphVWfgBm188lbRzHZ7urazoWtpbxIWVNYYPQbdVIS6EnCRlNqkpQHX
	0kFji2L9fdAc1O6nbIC+GCALYhZZnOdINI8ToNM6iKuaIbHS9RHOULJt8TDHOLjuVGU5UBu8HfPkh
	QTt+ULoQORXc8e3xoeVYg3kb5MmYpbgbJslsk9Vv1oLuuoiOkTUwImUrSnkbgqUtwg77UPw1JD0C0
	GpTtAUBS1I8BjfRFrV6XZctXiSNg9OrwDvMw==;
Date: Thu, 5 Nov 2026 07:19:52 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: bartosz.golaszewski@oss.qualcomm.com, marco.crivellari@suse.com,
 arnd@arndb.de, tony@atomide.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, brgl@kernel.org
Subject: Re: [PATCH] Input: gpio-keys - do not BUG() on requested wakeirqs
Message-ID: <20261105071952.33c39dd8@kemnade.info>
In-Reply-To: <f5c1435fbfa7568a107c864781897d6e@gmail.com>
References: <20261104160305.2501369-1-andreas@kemnade.info>
	<f5c1435fbfa7568a107c864781897d6e@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Nov 2026 14:28:15 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Andreas,
> 
> On Wed, Nov 04, 2026 at 05:03:05PM +0100, Andreas Kemnade wrote:
> > Having the IRQ handler called when enabled IRQs arrive should be considered
> > as a feature not as a bug. So do not BUG() there when this happens.
> >
> > Fixes: 3717194f24922 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index fbc31c5db3db..f1c31c5366f0 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -412,7 +412,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
> >  {
> >  	struct gpio_button_data *bdata = dev_id;
> >  
> > -	BUG_ON(irq != bdata->irq);
> > +	BUG_ON((irq != bdata->irq) && (irq != bdata->wakeirq));
> >  
> >  	if (bdata->button->wakeup) {
> >  		const struct gpio_keys_button *button = bdata->button;  
> 
> Doesn't gpio_keys_irq_isr() have the same issue when a wakeirq is
> configured for an interrupt-only button?
> 
yes, it has.

> Also, neither gpio_keys_gpio_isr() nor gpio_keys_irq_isr() uses the irq
> argument for anything else, so instead of expanding the condition, could
> we simply drop the BUG_ON() from both handlers?
>
Sure, was just unsure about the intention of escalating things so much here.
I think we should trust the interrupt system a bit.

Regards,
Andreas
