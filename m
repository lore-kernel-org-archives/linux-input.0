From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] staging: ste_rmi4: use module_i2c_driver to simplify the code
Date: Tue, 9 Oct 2012 14:07:59 +0200
Message-ID: <CACRpkdYnqVgzFkNO7C-SD8E=SR-=59F6Mf3VhK+sVbe_5Q-2dQ@mail.gmail.com>
References: <CAPgLHd_XxaAb-y=qnb0Wf97Uno-U-MUOW1S6J7__S-UzLSgD0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58725 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab2JIMIB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Oct 2012 08:08:01 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so5003452wib.1
        for <linux-input@vger.kernel.org>; Tue, 09 Oct 2012 05:08:00 -0700 (PDT)
In-Reply-To: <CAPgLHd_XxaAb-y=qnb0Wf97Uno-U-MUOW1S6J7__S-UzLSgD0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: gregkh@linuxfoundation.org, rydberg@euromail.se, yongjun_wei@trendmicro.com.cn, devel@driverdev.osuosl.org, linux-input@vger.kernel.org

On Mon, Oct 8, 2012 at 4:15 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Use the module_i2c_driver() macro to make the code smaller
> and a bit simpler.
>
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Why not?
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
