From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: spi: Driver for SPI data stream driven vibrator
Date: Mon, 8 Nov 2010 11:38:53 +0000
Message-ID: <20101108113853.772b960e@lxorguk.ukuu.org.uk>
References: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
	<20101107235157.728ea5b6@lxorguk.ukuu.org.uk>
	<F80267346F10C541946CBE8909F1C39E36817A8845@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46092 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754492Ab0KHLkd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 06:40:33 -0500
In-Reply-To: <F80267346F10C541946CBE8909F1C39E36817A8845@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ilkka.koskinen@nokia.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Mon, 8 Nov 2010 12:08:07 +0100
<ilkka.koskinen@nokia.com> wrote:

> Hi,
> 
> >From: ext Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> >Sent: 08 November, 2010 01:52
> >
> >> +	datalen = p->custom_len * sizeof(p->custom_data[0]);
> >
> >signed
> >
> >> +	if (datalen > MAX_EFFECT_SIZE) {
> >
> >unsigned
> 
> It should be unsigned. I'll fix it.
> 
> >> +	memcpy(einfo->buf, p->custom_data, datalen);
> >
> >ungood
> 
> Yep, that's clearly wrong too. Should be copy_from_user() I suppose.

That I hadn't considered - and I'm not sure whether the caller is passed
a kernel copy or not. The problem I was looking at was just the signed
case

	datalen < 0
	if (datalen > MAX ..)
		Nope

	memcpy(kernel, mysource, vastly more than intended (unsigned))

