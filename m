From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Input: wm97xx-core - Remove save state from
 wm97xx_read_aux_adc()
Date: Thu, 2 Sep 2010 15:40:35 +0100
Message-ID: <20100902144035.GB5809@rakim.wolfsonmicro.main>
References: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
 <20100901171925.GA22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E7F@dekaexchange07.deka.local>
 <20100901184650.GH22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E80@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40777 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754373Ab0IBOki (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 10:40:38 -0400
Content-Disposition: inline
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3254AA09E80@dekaexchange07.deka.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Sep 01, 2010 at 03:17:27PM -0400, Eric Millbrandt wrote:

> The problem there is the return value of poll_sample currently is not
> being checked, so wm97xx_read_aux_adc() is returning invalid data.  That
> could be fixed to either keep polling until RC_VALID or a timeout is hit
> is returned or return an error to the calling function and letting it
> decide what to do.  I don't like the second option because it creates a
> pathologic failure:

I think (without having thought through it all so I may have missed
something) that the best thing for the pathalogical case is to have a
limited number of goes at restoring things and then just stop the
digitiser - that will leave things restored while still providing a
guaranteed exit case which should be recoverable (since everything will
be halted).  Does that seem sensible to you?
