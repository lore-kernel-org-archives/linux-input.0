From: "Shen, Voice" <Voice.Shen@atmel.com>
Subject: RE: [RFC] QT1070: change the trigger mode of QT1070
Date: Tue, 8 May 2012 07:45:15 +0000
Message-ID: <ABFEDD1A8D2AAF42A54E3C074D49DC720F62AE93@penmbx02>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
 <20120507070424.GC22074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:22223 "EHLO
	nasmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926Ab2EHHwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 May 2012 03:52:08 -0400
In-Reply-To: <20120507070424.GC22074@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "javier.martin@vista-silicon.com" <javier.martin@vista-silicon.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "Wu, Josh" <Josh.wu@atmel.com>, "Lin, JM" <JM.Lin@atmel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,
> On Mon, May 07, 2012 at 10:27:33AM +0800, Bo Shen wrote:
> > The default trigger mode of QT1070 is IRQF_TRIGGER_LOW,
> > Using TRQF_TRIGGER_FALLING to replace IRQF_TRIGGER_LOW | IRQF_ONESHOT.
> 
> Why don't you set up IRQ the way you want in board code instead of
> implementing workarounds in the driver?
Do you mean to use the platform data to pass the irq flag? If yes, when use DT, may be need other modification. If not, any suggestions for how to deal with it in board code?

Best Regards
