From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] mfd/ucb1400: don't depend on gpiolib
Date: Thu, 08 Jan 2009 13:39:40 +0100
Message-ID: <4965F40C.3060500@linutronix.de>
References: <20090108110612.GA24243@www.tglx.de> <200901081325.53589.marek.vasut@gmail.com> <4965F37B.6040304@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:48117 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbZAHMjt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jan 2009 07:39:49 -0500
In-Reply-To: <4965F37B.6040304@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

Sebastian Andrzej Siewior wrote:
> Marek Vasut wrote:
>> On Thursday 08 of January 2009 12:06:12 Sebastian Andrzej Siewior wrote:
>>> it didn't in the past and I can't see how it does.
>>>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>> I use ucb1400 with its ts capabilities without *gpiolib* on a ppc 
>>> system.
>>>
>>>  drivers/mfd/Kconfig |    1 -
>>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index 2572773..8bcd600 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -53,7 +53,6 @@ config HTC_PASIC3
>>>  config UCB1400_CORE
>>>      tristate "Philips UCB1400 Core driver"
>>>      depends on AC97_BUS
>>> -    depends on GPIOLIB
>>>      help
>>>        This enables support for the Philips UCB1400 core functions.
>>>        The UCB1400 is an AC97 audio codec.
>>
>> That dependency was added there later, I got email from Andrew Morton 
>> from 22.9.2008 23:44 adding that there, go ask him about it. CCed.
> 
> The header file exports functions which have gpio in its name. However I 
> did not find any users in tree.
> Andrew, do you remember the reason why GPIOLIB got added as a dependency?

I've found [1]. Will look later into it.

[1] http://marc.info/?l=linux-mm-commits&m=121919139002830&w=2

Sebastian
