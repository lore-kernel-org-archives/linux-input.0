From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable()
 conditions
Date: Wed, 13 Oct 2010 11:12:55 +0800
Message-ID: <4CB523B7.8010209@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com> <1284634286-8871-4-git-send-email-jason77.wang@gmail.com> <1284634286-8871-5-git-send-email-jason77.wang@gmail.com> <201009162339.06395.dmitry.torokhov@gmail.com> <4C9332CE.6040905@gmail.com> <20100917160709.GC14186@core.coreip.homeip.net> <4C9718E9.5040104@gmail.com> <4CB4314C.7050308@gmail.com> <20101012160055.GA6355@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47292 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab0JMDIq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 23:08:46 -0400
In-Reply-To: <20101012160055.GA6355@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Wang <jason77.wang@gmail.com>, notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

Hi Dmitry,

I have validated the new patch based off the 2.6.36-rc7 on
the ti_omap3530evm, it works fine.

Thanks,
Jason.

Dmitry Torokhov wrote:
> Hi Jason.
>
> On Tue, Oct 12, 2010 at 05:58:36PM +0800, Jason Wang wrote:
>   
>> Hi Dmitry,
>>
>> Still remember the thread irq modificition for the ads7846.c? I sent
>> 4 patches,
>> you pointed out that the last patch(the 4th one) seems not right, i think it
>> over and find i was wrong because i mingled two independent flags(
>> disabled/suspended). Then i gave my understanding and two plans to
>> be chosen 3 weeks ago, but by now don't get feedback.
>>     
>
> Sorry about that.
>
>   
>> @@ -253,9 +253,10 @@ static void ads7846_enable(struct ads7846 *ts)
>> {
>> mutex_lock(&ts->lock);
>>
>> - if (ts->disabled && !ts->suspended)
>> + if (ts->disabled && !ts->suspended) {
>> + ts->disabled = false;
>> __ads7846_enable(ts);
>>     
>
> If the device was both disabled and suspended then enable will never
> succeed.
>
> I actually was looking over the patches yesterday and I believe I
> corrected the problem you mentioned. I rolled all patches together (no
> reason to keep them separate - they have not been yet applied to
> non-rebasing branch and they are simple fix-ups to the issues introduced
> by the fisrt patch). Could you please try the patch below and if it
> still works I'll queue for .37.
>
> Thanks!
>
>   

