From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH v5 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 15 Sep 2010 10:49:03 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B18043784FA97@EXDCVYMBSTM006.EQ1STM.local>
References: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
 <20100915075513.GB28348@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:57324 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699Ab0IOItM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 04:49:12 -0400
In-Reply-To: <20100915075513.GB28348@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kwangwoo LEE <kwangwoo.lee@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hi Dmitry,

>-----Original Message-----
>From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]

>> +
>> +	/* disable auto scan interrupt; mask the interrupt generated */
>> +	ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
>> +	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
>> +
>> +	mod_timer(&keypad->timer, jiffies + 2);
>> +
>
>I expected you would do "return IRQ_HANDLED;" here so that hardware
>polling is done exclusively in timer handler.
>
What I thought is: enable the timer by default; so that in case we find out the
ASRs aren't stable, the reporting automatically will get deferred to the timer. In
a normal case, when the ASRs are stable, the reporting gets done by the IRQ handler;
in case they aren't, the reporting will get done by the timers. Is this not correct?

Regards,
Sundar
