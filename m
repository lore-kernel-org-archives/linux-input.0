From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Tue, 11 Dec 2012 00:22:43 +0100
Message-ID: <201212110022.44181.marex@denx.de>
References: <1354893893-26338-1-git-send-email-marex@denx.de> <50C312D8.4050405@kernel.org> <20121210222437.GA19008@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49493 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2LJXWw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2012 18:22:52 -0500
In-Reply-To: <20121210222437.GA19008@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Dmitry Torokhov,

> Hi Marek, Jonathan,
> 
> On Sat, Dec 08, 2012 at 10:13:44AM +0000, Jonathan Cameron wrote:
> > On 12/07/2012 03:24 PM, Marek Vasut wrote:
> > > This patch implements support for sampling of a touchscreen into
> > > the MXS LRADC driver. The LRADC block allows configuring some of
> > > it's channels into special mode where they either output the drive
> > > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > > resistive touchscreen.
[...]

All of these are nice catches, thanks!

Best regards,
Marek Vasut
