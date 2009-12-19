From: Marjan Fojkar <marjan@pajkc.eu>
Subject: Re: [PATCH] AT32AP700X PS/2 controller (PSIF): remove msleep call
 from atomic context
Date: Sat, 19 Dec 2009 12:57:48 +0100
Message-ID: <4B2CBFBC.2000500@pajkc.eu>
References: <4B24EB45.2020708@pajkc.eu>	<20091214044937.GD16760@core.coreip.homeip.net> <20091214083016.35d00091@hcegtvedt.norway.atmel.com>
Reply-To: marjan@pajkc.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from md2.t-2.net ([84.255.209.81]:29857 "EHLO md2.t-2.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbZLSL56 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2009 06:57:58 -0500
In-Reply-To: <20091214083016.35d00091@hcegtvedt.norway.atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kernel@avr32linux.org

Hans-Christian Egtvedt wrote:
> On Sun, 13 Dec 2009 20:49:37 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
>> Hi Martin,
>>
>> On Sun, Dec 13, 2009 at 02:25:25PM +0100, Marjan Fojkar wrote:
>>> From: Marjan Fojkar <marjan@pajkc.eu>
>>>
>>> The patch removes msleep call from atomic context. To achieve that, the driver
>>> PSIF leaves atomic context before the call in order to enable interrupts to be
>>> performed safely. When the call is done, the driver jumps back to atomic context.
>>>
>> Yes, msleep is not allowed in atomic context, however serio's write()
>> method is supposed to be callable from atomic context so msleep is not
>> available there period. I scanned the datasheet quickly and did not see
>> any restriction on the frequency of reading status register so I think
>> we should do what i8042 driver does - udelay(50).
>>
> 
> Sure udelay(50) will work fine, you can poll the registers as fast as
> you would like. Only disadvantage with udelay is that it will block all
> other threads. But I would guess that most of the times a character
> should be sent to the peripheral, the hardware will be ready since the
> speed is quite low bandwidth.
> 

So, the final conclusion is udelay(50), I presume? :)

