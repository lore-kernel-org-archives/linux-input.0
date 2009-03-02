From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/2] Input: add wm97xx accelerated driver for AVR32 AT32AP700X
 microprocessors
Date: Mon, 02 Mar 2009 23:33:22 +0100
Message-ID: <49AC5EB2.3050805@gmail.com>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1236000228-13025-2-git-send-email-broonie@opensource.wolfsonmicro.com> <49ABEE83.904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:35767 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZCBWd2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 17:33:28 -0500
In-Reply-To: <49ABEE83.904@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

On 2.3.2009 15:34, Jiri Slaby wrote:
>> +static int at32_wm97xx_suspend(struct platform_device *pdev,
>> pm_message_t msg)
>> +{
>> + struct at32_wm97xx *at32_wm97xx = platform_get_drvdata(pdev);
>> +
>> + ac97c_writel(at32_wm97xx, IDR, AC97C_INT_CBEVT);
>> + disable_irq(at32_wm97xx->gpio_irq);
>
> Here, you should call disable_irq_sync() (that's what I meant by _sync
> in the last post).

Ah, it's in the opposite way. This one is fine, the patch 1/2 should use 
disable_irq_nosync(), if I understand the code correctly.

