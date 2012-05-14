From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [RFC] QT1070: change the trigger mode of QT1070
Date: Mon, 14 May 2012 10:54:30 +0800
Message-ID: <4FB073E6.8070303@atmel.com>
References: <1336357653-18663-1-git-send-email-voice.shen@atmel.com> <20120507070424.GC22074@core.coreip.homeip.net> <4FACCDA6.7040506@atmel.com> <20120511160846.GC6542@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:24484 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab2ENCzV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 22:55:21 -0400
In-Reply-To: <20120511160846.GC6542@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Josh Wu <josh.wu@atmel.com>, javier.martin@vista-silicon.com, khali@linux-fr.org, w.sang@pengutronix.de, jm.lin@atmel.com, linux-input@vger.kernel.org

On 5/12/2012 0:08, Dmitry Torokhov wrote:
> On Fri, May 11, 2012 at 04:28:22PM +0800, Josh Wu wrote:
>> Hello, Dmitry
>>
>> On 5/7/2012 3:04 PM, Dmitry Torokhov wrote:
>>> Hi Bo,
>>>
>>> On Mon, May 07, 2012 at 10:27:33AM +0800, Bo Shen wrote:
>>>> The default trigger mode of QT1070 is IRQF_TRIGGER_LOW,
>>>> Using TRQF_TRIGGER_FALLING to replace IRQF_TRIGGER_LOW | IRQF_ONESHOT.
>>> Why don't you set up IRQ the way you want in board code instead of
>>> implementing workarounds in the driver?
>> The QT1070 will generate a falling edge interrupt if any valid data
>> coming. The workaround is only for the boarding that can handle edge
>> interrupt but cannot distinguish rising and falling.
>> So I think put this trigger set up code to board code will make
>> thing more complex.
> In the board code it is only a matter of doing irq_set_irq_type(). AT
> this time you know exactly how chip is wired and whether it needs level
> or edge interupts.

Hi Dmitry,
   Thanks, this API works fine. So, there is no need to change the 
driver code of QT1070.

> Thanks.
>

