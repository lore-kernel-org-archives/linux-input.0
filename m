From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH -next] Input: pmic8xxx-pwrkey - fix to pass correct
 device identity to free_irq()
Date: Mon, 16 Dec 2013 17:23:58 -0800
Message-ID: <20131217012358.GA31766@codeaurora.org>
References: <CAPgLHd87FxZ6ur_WLC9Q9bjOfNbOTu6yzNWNcN-ar0=o1y48Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:59040 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab3LQBYA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 20:24:00 -0500
Content-Disposition: inline
In-Reply-To: <CAPgLHd87FxZ6ur_WLC9Q9bjOfNbOTu6yzNWNcN-ar0=o1y48Kg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: dmitry.torokhov@gmail.com, lars@metafoo.de, sachin.kamat@linaro.org, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On 12/17, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> free_irq() in the error handling case is missing when change
> pass input device directly to interrupt.
> 
> Fixes: b27f8fee4965('Input: pmic8xxx-pwrkey - pass input device directly to interrupt')
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

This driver was supposed to be converted to devm before
that patch. I forgot to send it and then Dmitry seems to have
fixed up the patch to make it apply. We should just use the devm
conversion patch to avoid needing to apply this one.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
