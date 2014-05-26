From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH] input: gpio_keys: Add IRQF_NO_SUSPEND flag to wake-up
 from freeze state
Date: Mon, 26 May 2014 10:32:14 +0530
Message-ID: <CAK9yfHyOYXOVMKUpKisT4tZePh=s_Lv6h=SLOnw=1iS8NaHv7A@mail.gmail.com>
References: <1401080234-31174-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51333 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaEZFCO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 01:02:14 -0400
Received: by mail-oa0-f46.google.com with SMTP id i4so7914522oah.33
        for <linux-input@vger.kernel.org>; Sun, 25 May 2014 22:02:14 -0700 (PDT)
In-Reply-To: <1401080234-31174-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Chanwoo,


On 26 May 2014 10:27, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch add IRQF_NO_SUSPEND flag before requesting interrupt handler
> if button->wakeup is true. If ther interrupt of gpio-keys hasn't included
> IRQF_NO_SUSPEND, wouldn't wake-up from freeze state when pressing button.

Please refer to the below thread. Looks like it was similar to what
you are proposing.
http://www.spinics.net/lists/linux-input/msg28780.html

-- 
With warm regards,
Sachin
