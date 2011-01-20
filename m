From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH] input: replace request_irq by request_any_context_irq
 in keyboard GPIO driver
Date: Thu, 20 Jan 2011 14:26:30 +0530
Message-ID: <4D37F8BE.8040005@codeaurora.org>
References: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com> <1294825292-24134-2-git-send-email-philippe.langlais@stericsson.com> <20110120075348.GE30522@core.coreip.homeip.net> <4D37EB9F.4040103@codeaurora.org> <20110120081319.GC2498@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:3528 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1ATI4n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 03:56:43 -0500
In-Reply-To: <20110120081319.GC2498@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philippe Langlais <philippe.langlais@stericsson.com>, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Hi Dmitry,

On 1/20/2011 1:43 PM, Dmitry Torokhov wrote:
>>>
>>> No, this it not correct. request_any_context_irq() means that you could
>>> either get a hardirq or a treaded one. However above you are changing to
>>> gpio_get_value_cansleep() which indicates that you can sleep.
>>>
>>> You need to either revert to gpio_get_value() or explicitly request
>>> threaded IRQ.
>>
>> This could be problem. Say, we are doing request_any_context_irq(..) and gpio is over slow-bus,
>> so we naturally get into the threaded code, and in the thread handler we are calling gpio_get_value(..),
>> but in this case gpio_get_value could throw a warning that we should call gpio_get_value_cansleep(...)
>> because sleep attribute is added into the gpiolib hook implementation for these gpios.
>>
>> Now suppose gpio is memory mapped and we enter into the hardirq and calling sleep variant into the 
>> handler code will be naturally bad. 
>>
>> How about checking maysleep explicitly here while using the request_any_context_irq() call though
>> the semantics of gpiolib framework discourages that. 
>>
> 
> Any drawbacks for explicitly switching to threaded IRQ and keeping
> gpio_get_value_cansleep()? (That was the 2nd option I mentioned BTW).
> 

Only drawback is that you get "dedicated thread" in case the irqs are not chained handler. In worst-case
it would introduce the latencies otherwise fine.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
