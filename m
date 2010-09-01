From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Input: wm97xx-core - Remove save state from
 wm97xx_read_aux_adc()
Date: Wed, 1 Sep 2010 18:19:25 +0100
Message-ID: <20100901171925.GA22444@rakim.wolfsonmicro.main>
References: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51945 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753071Ab0IART0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 13:19:26 -0400
Content-Disposition: inline
In-Reply-To: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-input@vger.kernel.org

On Wed, Sep 01, 2010 at 10:52:10AM -0400, Eric Millbrandt wrote:

> Saving the state of the digitizers seems unnecessary since the next
> sample will rewrite those registers.  It also causes an unnecessary
> sample to occur if the previous state was a sample.  This will cause
> the wrong sample to be returned on the next call to wm97xx_read_aux_adc().

You need to explain how this interacts with both polling and continuous
touchscreen modes - saying that it seems unneeded feels a little fuzzy.
Note that this will also clear the current digitiser configuration
before it starts the AUXADC so it's not a simple save of the values.
