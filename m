From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 05/15] keyboard: imx_keypad: Use clk_prepare_enable/clk_disable_unprepare
Date: Wed, 6 Jun 2012 00:41:56 -0300
Message-ID: <CAOMZO5CeqAHr8gi4HUxXBbYYuP7rLv+fBRLWiNPiZVdOrOd5=g@mail.gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
	<1337987696-31728-5-git-send-email-festevam@gmail.com>
	<20120529091825.GH30400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33423 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab2FFDl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jun 2012 23:41:57 -0400
Received: by bkcji2 with SMTP id ji2so5232460bkc.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jun 2012 20:41:56 -0700 (PDT)
In-Reply-To: <20120529091825.GH30400@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: kernel@pengutronix.de, shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Dmitry,

On Tue, May 29, 2012 at 6:18 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, May 25, 2012 at 08:14:46PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Prepare the clock before enabling it.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: <linux-input@vger.kernel.org>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Can this be applied?
