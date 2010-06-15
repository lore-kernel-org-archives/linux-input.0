From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 2/3] input: wm97xx: set GPIOs with AC97 GPIO busops
 if implemented
Date: Tue, 15 Jun 2010 17:27:55 +0100
Message-ID: <20100615162755.GM14510@rakim.wolfsonmicro.main>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
 <1276617347-3522-3-git-send-email-manuel.lauss@googlemail.com>
 <20100615160802.GL14510@rakim.wolfsonmicro.main>
 <AANLkTil-WxjFdE5oGEJklu_cA2o-23TCLjqD8sz-iMLm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40739 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751015Ab0FOQ15 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 12:27:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTil-WxjFdE5oGEJklu_cA2o-23TCLjqD8sz-iMLm@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@vger.kernel.org, linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, Jun 15, 2010 at 06:17:18PM +0200, Manuel Lauss wrote:
> On Tue, Jun 15, 2010 at 6:08 PM, Mark Brown

> > It seems like it'd be easier to just do this as a generic AC'97 thing
> > rather than adding it to the WM97xx driver - that way any CODEC that has
> > GPIO support can use it, we don't have to add custom per-CODEC GPIO APIs.
> > If you're using the WM97xx-specific code you're already doing something
> > custom so it's not much loss to use a generic thing.

> Oh, now I get it.  Hmm, what about setting pin direction?  That
> certainly is per-codec, no?

IIRC, yes - I'd need to check.  I'd guess a lot of devices will be fixed
function and only support one direction.
