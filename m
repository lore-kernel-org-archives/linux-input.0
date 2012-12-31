From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] Input: imx_keypad - Add device tree support
Date: Mon, 31 Dec 2012 08:55:28 +0800
Message-ID: <20121231005527.GC31816@S2101-09.ap.freescale.net>
References: <1356872946-2810-1-git-send-email-Ying.Liu@freescale.com>
 <20121230232852.GB13899@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:7185
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755253Ab2LaAzH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Dec 2012 19:55:07 -0500
Content-Disposition: inline
In-Reply-To: <20121230232852.GB13899@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Liu Ying <Ying.Liu@freescale.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, s.hauer@pengutronix.de, linus.walleij@linaro.org, cjb@laptop.org, broonie@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, liu.y.victor@gmail.com

Hi Liu,

On Sun, Dec 30, 2012 at 03:28:52PM -0800, Dmitry Torokhov wrote:
> > @@ -473,6 +534,10 @@ static int imx_keypad_probe(struct platform_device *pdev)
> >  		goto failed_free_priv;
> >  	}
> >  
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl))
> > +		dev_warn(&pdev->dev, "failed to get default pinctrl\n");
> > +
> 
> No, please let core do this for you. Linus has a patch doing just that.
> 
FYI.  Dmitry is talking about the patch[1] below.  Unfortunately, you
will not be able to base your patch on that until v3.9-rc1.

Shawn

[1] http://thread.gmane.org/gmane.linux.kernel/1409263

