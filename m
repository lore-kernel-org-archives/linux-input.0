From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v6] input: IMX: add imx-keypad driver to support the
 Keypad Port present in the imx application processors family.
Date: Sun, 31 Jan 2010 14:42:31 +0100
Message-ID: <1264945351.2433.10.camel@realization>
References: <1264852407.2587.4.camel@realization>
	 <20100131090802.GD12320@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44358 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab0AaNmf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jan 2010 08:42:35 -0500
Received: by ewy19 with SMTP id 19so1203577ewy.1
        for <linux-input@vger.kernel.org>; Sun, 31 Jan 2010 05:42:34 -0800 (PST)
In-Reply-To: <20100131090802.GD12320@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On dom, 2010-01-31 at 01:08 -0800, Dmitry Torokhov wrote:
> Hi Alberto,
> 
> On Sat, Jan 30, 2010 at 12:53:27PM +0100, Alberto Panizzo wrote:
> > 
> > Changes in v6:
> > -MXC to IMX pattern change (apart of Kconfig dependencies)
> > -Comment style fixes
> > -Greater check delay in debouncing process (10). 
> > -Improve the usage of keypad->exit_flag: now it is false only
> between open and 
> >  close functions. And if we handle an interrupt out there, leave all
> interrupts
> >  masked, and wait for another open to re enable they.
> > -Remove unnecessary "free events" mechanism (tested with evtest).
> > 
> 
> I took the liberty of making some changes to the driver, could you
> please give the patch below a try and if I did not mess it up I will
> fold it into your v6 version and apply to next.
> 
> Thank you.
> 
> -- 
> Dmitry 

For me it is ok. Your patch looks good and I tested your changes and all
goes well. I have to work on my English and other changes make the 
source code more readable.
Dmitry, put also your Signed-off line in v6 patch after merge if you
feel to wont this. (I've already thought to ask you this before this
patch fix) You help me a lot on building this version and an Acked-by
maybe is not fair about your work.

Thank You Dmirty :)


-- 
Alberto!

