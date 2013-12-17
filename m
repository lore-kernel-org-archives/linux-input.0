From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] Input: pmic8xxx-pwrkey - fix to pass correct
 device identity to free_irq()
Date: Tue, 17 Dec 2013 08:48:28 -0800
Message-ID: <20131217164828.GA17790@core.coreip.homeip.net>
References: <CAPgLHd87FxZ6ur_WLC9Q9bjOfNbOTu6yzNWNcN-ar0=o1y48Kg@mail.gmail.com>
 <20131217012358.GA31766@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:60350 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3LQQsc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 11:48:32 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so7006804pde.7
        for <linux-input@vger.kernel.org>; Tue, 17 Dec 2013 08:48:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131217012358.GA31766@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, lars@metafoo.de, sachin.kamat@linaro.org, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Mon, Dec 16, 2013 at 05:23:58PM -0800, Stephen Boyd wrote:
> On 12/17, Wei Yongjun wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > free_irq() in the error handling case is missing when change
> > pass input device directly to interrupt.
> > 
> > Fixes: b27f8fee4965('Input: pmic8xxx-pwrkey - pass input device directly to interrupt')
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> This driver was supposed to be converted to devm before
> that patch. I forgot to send it and then Dmitry seems to have
> fixed up the patch to make it apply. We should just use the devm
> conversion patch to avoid needing to apply this one.

I am still going to apply it, but if you could take a look at my devm
conversion patch for the driver that would be great.

Thanks.

-- 
Dmitry
