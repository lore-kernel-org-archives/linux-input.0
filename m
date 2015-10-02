From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input:gpio-key: set IRQF_NO_SUSPEND for wake capable key
Date: Fri, 2 Oct 2015 03:26:27 -0700
Message-ID: <CACRpkdYJEG1n4phfC=St0nic1_Z+qdoGKzhyS5yhDM9O9ci25w@mail.gmail.com>
References: <1442506019-13687-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36228 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbJBK02 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 06:26:28 -0400
Received: by oibi136 with SMTP id i136so55613064oib.3
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2015 03:26:27 -0700 (PDT)
In-Reply-To: <1442506019-13687-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Qi Zheng <qi.zheng@intel.com>, Aubrey Li <aubrey.li@intel.com>

On Thu, Sep 17, 2015 at 9:06 AM, Qipeng Zha <qipeng.zha@intel.com> wrote:

> When wakeup attribute is set, GPIO key is supposed to wake up
> the system from system sleep state, So set IRQF_NO_SUSPEND
> flag to keep IRQ enabled during suspend.
>
> Signed-off-by: Qi Zheng <qi.zheng@intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@intel.com>
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Should this not be tagged for stable?

Yours,
Linus Walleij
