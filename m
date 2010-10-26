From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] input: spi: Driver for SPI data stream driven vibrator
Date: Tue, 26 Oct 2010 12:17:49 +0100
Message-ID: <20101026121749.298dc60a@lxorguk.ukuu.org.uk>
References: <1288013463-21722-1-git-send-email-ilkka.koskinen@nokia.com>
	<20101026111344.GB24714@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46275 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932396Ab0JZLSy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Oct 2010 07:18:54 -0400
In-Reply-To: <20101026111344.GB24714@angua.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Ilkka Koskinen <ilkka.koskinen@nokia.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org

> > +	if (!einfo->buf) {
> > +		einfo->buf = kzalloc(datalen, GFP_KERNEL | GFP_DMA);
> > +		if (!einfo->buf) {
> > +			ret = -ENOMEM;
> > +			goto exit;
> > +		}
> > +	}
> > +
> > +	memcpy(einfo->buf, p->custom_data, datalen);
> 
> It looks like raw data from userspace is being passed on to the
> device.  Is this sane?  Is there already a data format used by other
> vibration/feedback devices that should be used here instead and
> translated into the form expected by the hardware?

It also seems to be using GFP_DMA not dma_alloc functions which looks a
bit odd and certainly isn't portable.

