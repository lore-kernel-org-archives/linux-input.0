From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx data
Date: Thu, 16 Jul 2009 00:56:33 -0700
Message-ID: <200907160056.33302.david-b@pacbell.net>
References: <200907151106.47917.david-b@pacbell.net> <20090716071529.GA28840@n2100.arm.linux.org.uk> <20090716072226.GA8113@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp101.sbc.mail.gq1.yahoo.com ([67.195.15.60]:46483 "HELO
	smtp101.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751867AbZGPH4e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 03:56:34 -0400
In-Reply-To: <20090716072226.GA8113@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Alessandro Rubini <rubini-list@gnudd.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thursday 16 July 2009, Russell King - ARM Linux wrote:
> ... and until that happens, I suggest you remove the ADS7846 chip from
> your hardware; as that DMA stuff in the driver currently stands, it
> can NEVER work on ARM or any other DMA cache incoherent CPU which uses
> DMA for SPI transfers.

Wrong again.  There's a localized issue, easily enough fixed.
As noted by Alessandro, earlier:  the touchscreen logic does
not have this issue.  Only the ADC logic.

- Dave

p.s. Note by the way that L-A-K is only getting Russell's
     flamage, not the responses disproving his claims.
