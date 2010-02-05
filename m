From: <samu.p.onkalo@nokia.com>
Subject: RE: [RFC] Generic implementation for Input enable disable methods
Date: Fri, 5 Feb 2010 09:46:05 +0100
Message-ID: <62697B07E9803846BC582181BD6FB6B8257283DB70@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1263968920.18053.24.camel@4fid08082>
 <20100201085901.GC24188@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B8257283DAC4@NOK-EUMSG-02.mgdnok.nokia.com>
 <201002050010.55524.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36265 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab0BEIqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 03:46:24 -0500
In-Reply-To: <201002050010.55524.dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, ext-mika.1.westerberg@nokia.com, ext-jani.1.nikula@nokia.com

>From: linux-input-owner@vger.kernel.org [mailto:linux-input-
>owner@vger.kernel.org] On Behalf Of ext Dmitry Torokhov
>Sent: 05 February, 2010 10:11
>To: Onkalo Samu.P (Nokia-D/Tampere)
>Cc: linux-input@vger.kernel.org; Westerberg Mika.1 (EXT-Nixu/Helsinki);
>Nikula Jani.1 (EXT-Nixu/Helsinki)
>Subject: Re: [RFC] Generic implementation for Input enable disable
>methods
>
>On Thursday 04 February 2010 11:38:41 pm samu.p.onkalo@nokia.com wrote:
>> >-----Original Message-----
>> >From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> >
>> >Hi Samu,
>> >
>> >I still believe that the only thing we need (apart of special
>plumbing
>> >in
>> >gpio-keys) is a way for userspace clients to subsribe on unsubscribe
>> >from certain events rather than device-wide configuration. This way
>we
>> >can avoid waking up processes that are not interested in some of the
>> >events.
>>
>> Hi Dmitry,
>>
>> I just noticed that control interface for gpio was applied to input-
>tree.
>> We still have a need to disable hw in certain cases. It is probably
>better
>> to forget generic implementation to input core and make control
>interface
>> as specific to each driver like proposed some months ago for example
>> for tel4030-keypad driver. Or what do you think?
>>
>> Sw filtering which avoids to wakeup some processes is not proper
>solution
>> to embedded devices. We need to avoid waking up the processor itself.
>
>I see. I think that such facility should not be limited to input devices
>(with the exception of gpio-keys which is a special case since it works
>with multiple interrupts). We need a way to allow userspace initiate
>putting an arbitrary device to "sleep" and this should be generic
>infrastructure.

I a way yes, generic interface would make sense. However, input devices
may have needs to partially shut down the HW based on the certain events
(similar to gpio key case).

>
>So you need to talk to PM people again and design such facility with
>them
>since IIRC there wasn't anything like that last time you tried asking
>that
>question.

Originally implementation for twl4030-keypad was about the HW activity control.
It is true that this latest discussion is only about the interface.
I'm sorry about the confusion.

br
Samu




