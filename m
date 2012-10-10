From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] staging: ste_rmi4: use module_i2c_driver to simplify the
 code
Date: Wed, 10 Oct 2012 19:08:12 +0200
Message-ID: <20121010170812.GA319@polaris.bitmath.org>
References: <CAPgLHd_XxaAb-y=qnb0Wf97Uno-U-MUOW1S6J7__S-UzLSgD0w@mail.gmail.com>
 <CACRpkdYnqVgzFkNO7C-SD8E=SR-=59F6Mf3VhK+sVbe_5Q-2dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:47621 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab2JJRFq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 13:05:46 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 8E338EB8F0
	for <linux-input@vger.kernel.org>; Wed, 10 Oct 2012 19:05:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACRpkdYnqVgzFkNO7C-SD8E=SR-=59F6Mf3VhK+sVbe_5Q-2dQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, gregkh@linuxfoundation.org, yongjun_wei@trendmicro.com.cn, devel@driverdev.osuosl.org, linux-input@vger.kernel.org

On Tue, Oct 09, 2012 at 02:07:59PM +0200, Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 4:15 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> 
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >
> > Use the module_i2c_driver() macro to make the code smaller
> > and a bit simpler.
> >
> > dpatch engine is used to auto generate this patch.
> > (https://github.com/weiyj/dpatch)
> >
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Why not?
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yep, why not :-)

Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
