From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Sat, 18 Apr 2009 08:51:04 +0100
Message-ID: <20090418075104.GB27327@n2100.arm.linux.org.uk>
References: <200904171640.14294.hs4233@mail.mn-solutions.de> <18920.42140.160633.645220@ipc1.ka-ro> <200904172123.18096.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37623 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZDRHvS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2009 03:51:18 -0400
Content-Disposition: inline
In-Reply-To: <200904172123.18096.hs4233@mail.mn-solutions.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, linux-input@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, Apr 17, 2009 at 09:23:17PM +0200, Holger Schurig wrote:
> > Why do you invent your own error code instead of reporting the
> > error that clk_get() returned?
> 
> You're total right, I should have known better :-)
> 
> 
> This error happens so often, not only by me, that I think the 
> clk_get should actually simply return NULL.

We have implementations which have only a single clock, and return NULL
as a valid clock.
