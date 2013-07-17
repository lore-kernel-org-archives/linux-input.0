From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH -next] Input: olpc_apsp - remove redundant dev_err call in olpc_apsp_probe()
Date: Wed, 17 Jul 2013 07:00:10 -0600
Message-ID: <CAMLZHHTWBRvTuFzUHBT=H_ex_aOExiuCf0fzuFnF-fdYoAharQ@mail.gmail.com>
References: <CAPgLHd-tOWoxE-qYOkX_HcQRaUsifn0MQH=i+2KDARLKAxz2KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:60743 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab3GQNAL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jul 2013 09:00:11 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so2953381qae.13
        for <linux-input@vger.kernel.org>; Wed, 17 Jul 2013 06:00:11 -0700 (PDT)
In-Reply-To: <CAPgLHd-tOWoxE-qYOkX_HcQRaUsifn0MQH=i+2KDARLKAxz2KA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Tue, Jul 16, 2013 at 11:31 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Daniel Drake <dsd@laptop.org>
