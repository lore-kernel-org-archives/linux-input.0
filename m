From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: The way for disabling input device?
Date: Wed, 16 Mar 2011 09:48:06 +0000
Message-ID: <20110316094805.GA2688@opensource.wolfsonmicro.com>
References: <4D7F2C12.5020509@samsung.com>
 <20110315151728.GD17277@sirena.org.uk>
 <20110316045346.GA2582@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52514 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752508Ab1CPJru (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 05:47:50 -0400
Content-Disposition: inline
In-Reply-To: <20110316045346.GA2582@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Tue, Mar 15, 2011 at 09:53:46PM -0700, Dmitry Torokhov wrote:

> Closing the device might be a bit unwieldy, I was thinking more along
> the lines of having a way of "accelerating" runtime PM timeout and using
> that framework to put the device to sleep.

I guess if I get the time to get the rate control stuff I've mentioned
before done that'd also be another way of doing this.
