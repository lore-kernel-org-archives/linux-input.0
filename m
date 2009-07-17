From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Fri, 17 Jul 2009 12:20:29 +0300
Message-ID: <4A60425D.9@teltonika.lt>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>	 <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>	 <200906112103.54043.dmitry.torokhov@gmail.com>	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>	 <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>	 <20090629162619.GB24533@dtor-d630.eng.vmware.com>	 <4A55BC78.6010206@gmail.com> <4A602D6D.1090707@teltonika.lt> <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 81-7-68-229.static.zebra.lt ([81.7.68.229]:54720 "EHLO
	teltonika.lt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934273AbZGQJUe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2009 05:20:34 -0400
In-Reply-To: <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Trilok Soni wrote:
> Hi Paulius,
> 
> On Fri, Jul 17, 2009 at 1:21 PM, Paulius
> Zaleckas<paulius.zaleckas@teltonika.lt> wrote:
>> Eric Miao wrote:
>>> Dmitry Torokhov wrote:
>>>> Hi Eric,
>>>>
>>>> On Fri, Jun 12, 2009 at 09:26:43PM +0800, Eric Miao wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> I've tested the driver code, and it's basically OK except for two minor
>>>>> fixes:
>>>>>
>>>>> 1) GPIO and IRQs have to be initialized before input_register_device(),
>>>>> otherwise input->open() will be invoked before that, which will schedule
>>>>> an immediate scan work and fail.
>>>>>
>>>>> 2) disable_irq_rows() called in init_matrix_gpio() so that by default it's
>>>>> initialized to disabled - and will be enabled by input->open()
>>>>>
>>>> Could you please take a look at the driver as it is commited to
>>>> 'for-linus' branch of my tree and let me know if you see anything wrong
>>>> there? Otherwise I inted to submit it in my next update to Linus.
>>>>
>>> Sorry Dmitry,
>>>
>>> Reply so late and til now I have some time to test this. The patch there
>>> still has at least one issue I guess - the keycodes[] allocation size
>>> should be MATRIX_MAX_ROWS * MATRIX_MAX_COLS if I understand correctly.
>>>
>>> I'm experiencing a problem of keypad->pdata being overwritten, and found
>>> keycodes are actually accessed by [(row << 4) + col], so that should be
>>> a full range.
>> As this driver is already in the mainline and I was trying to use it...
>> I get various kernel crashes due to this keycodes[] allocation size bug.
>> Care to send a patch for this bug?
>>
>>> And one more minor issue that may not be significant is the hardcoding of
>>> the '4' in this (row << 4).
>>>
>>> Some of the key hits on my Littleton just worked smoothly with the above
>>> correction, but not all - some key hits just gave intermittent events, I
>>> have no idea how's that - maybe related to my scan delay and debouncing
>>> settings
> 
> Did you tried assigning max_keypmap_size in platform data to
> MATRIX_MAX_COLS * MATRIX_MAX_ROWS ?
> 

Yes, this fixes crashes. But this is just workaround for bug in driver.
