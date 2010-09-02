From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Input: wm97xx-core - Remove save state from
 wm97xx_read_aux_adc()
Date: Thu, 2 Sep 2010 17:16:01 +0100
Message-ID: <20100902161600.GF5809@rakim.wolfsonmicro.main>
References: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
 <20100901171925.GA22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E7F@dekaexchange07.deka.local>
 <20100901184650.GH22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E80@dekaexchange07.deka.local>
 <20100902144035.GB5809@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E84@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50162 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752971Ab0IBQQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 12:16:04 -0400
Content-Disposition: inline
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3254AA09E84@dekaexchange07.deka.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Sep 02, 2010 at 11:32:29AM -0400, Eric Millbrandt wrote:

> It does.  So I will modify wm97xx_read_aux_adc() to do the following:

> -Call poll_sample()
> -If the return value is not RC_VALID call poll_sample() again
> -If after 5 tries (I'm not sure how many samples can be queued) we have
> not succeeded, stop the digitizer and return -1.
> -Otherwise return auxadc.

> If this sounds reasonable I will create a patch for review.

Yup.  I'd return -EBUSY or something rather than a made up error code.
5 seems like a reasonable number of times to try.
