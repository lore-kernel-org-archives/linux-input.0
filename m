From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2 3/3] keyboard: imx_keypad: Check error returned by
 clk_prepare_enable()
Date: Fri, 6 Jul 2012 15:46:33 -0300
Message-ID: <4FF73289.8020209@freescale.com>
References: <1341596514-15972-1-git-send-email-fabio.estevam@freescale.com> <1341596514-15972-3-git-send-email-fabio.estevam@freescale.com> <20120706183436.GA31613@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:42395
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754946Ab2GFSjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Jul 2012 14:39:44 -0400
In-Reply-To: <20120706183436.GA31613@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, festevam@gmail.com

Dmitry Torokhov wrote:
 
> That would leave "keypad->enabled = true" if clk_prepare_enable() fails.
> You need something like below.

You are right. Thanks for fixing it.

