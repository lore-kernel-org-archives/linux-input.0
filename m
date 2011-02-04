From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] Add chip I2C addresses to header file
Date: Fri, 4 Feb 2011 14:25:36 +0000
Message-ID: <20110204142536.GC5393@opensource.wolfsonmicro.com>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB7F5.3070704@atmel.com>
 <20110203144946.GA21568@sirena.org.uk>
 <4D4BBAD7.8060300@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49095 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752267Ab1BDOZS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Feb 2011 09:25:18 -0500
Content-Disposition: inline
In-Reply-To: <4D4BBAD7.8060300@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

On Fri, Feb 04, 2011 at 10:37:43AM +0200, Iiro Valkonen wrote:

Please fix your mail client to word wrap within paragraphs, I've
reflowed your text for legibility.

> To help lazy developers, they don't have to dig up the datasheet to
> see what address their chip is at? Well, I guess they might have to do
> that anyway to see what address out of these is selected with the
> address select pin. I thought it would be neat to have all the
> possible addresses listed here, and the developer could pick the
> correct one for his/her board file. Or in the case where he is not
> sure about the state of the address select pin, maybe even try them
> all. 

If you're going to do this a comment in the driver describing what
addresses correspond to which device configurations - having it as a
bunch of #defines in the code is less discoverable and still requires
users to look up in the datasheet to see which address the device
actually has.
