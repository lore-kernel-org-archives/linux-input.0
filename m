From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [rtc-linux] [PATCH v5 1/6] rtc: arm: imx: snvs: change use
 syscon to access register
Date: Mon, 29 Jun 2015 16:38:14 +0800
Message-ID: <20150629083814.GH10332@tiger>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
 <20150601202507.GP4710@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33271 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbbF2Iia (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 04:38:30 -0400
Content-Disposition: inline
In-Reply-To: <20150601202507.GP4710@piout.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Frank.Li@freescale.com, shawn.guo@linaro.org, devicetree@vger.kernel.org, rtc-linux@googlegroups.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, linux-input@vger.kernel.org, lznuaa@gmail.com, linux-arm-kernel@lists.infradead.org

On Mon, Jun 01, 2015 at 10:25:07PM +0200, Alexandre Belloni wrote:
> On 27/05/2015 at 00:25:57 +0800, Frank.Li@freescale.com wrote :
> > From: Frank Li <Frank.Li@freescale.com>
> > 
> > snvs included rtc, on/off key, power-off module
> > change to syscon to access register
> > 
> > Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Shawn, when applying could you please change the subject to:
> rtc: snvs: use syscon to access registers

Okay, will do.

Shawn
