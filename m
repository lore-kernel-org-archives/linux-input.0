From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Input: wm97xx-core - Remove save state from
 wm97xx_read_aux_adc()
Date: Wed, 1 Sep 2010 19:46:50 +0100
Message-ID: <20100901184650.GH22444@rakim.wolfsonmicro.main>
References: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
 <20100901171925.GA22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E7F@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57645 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753998Ab0IASqw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 14:46:52 -0400
Content-Disposition: inline
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3254AA09E7F@dekaexchange07.deka.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Sep 01, 2010 at 02:46:59PM -0400, Eric Millbrandt wrote:
> On Wed, 1 Sep 2010 at 13:19:25 Mark Brown wrote:

[Reflowed your mail into 80 columns for legibility - you might want to
look at your MUA configuration]

> > You need to explain how this interacts with both polling and continuous
> > touchscreen modes - saying that it seems unneeded feels a little fuzzy.
> > Note that this will also clear the current digitiser configuration before
> > it starts the AUXADC so it's not a simple save of the values.

> You are right; the current digitizer settings do need to be cleared.
> I was testing in the polling touchscreen mode and overlooked that fact.
> But do we want to restore the POLL bit if it happened to be set?
> Continuous mode does not need it and it looks like wm9712_poll_*() will
> set the POLL bit again when it needs a touchscreen measurement.

I've got a feeling that at least some machine-specific semi accelerated
drivers make use of this but can't quite remember.  If it just causes an
extra sample sometimes I'm inclined to feel it's safer to leave things
as-is.
