From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/3] Input: ads7846 - introduce .gpio_pendown to get pendown state
Date: Thu, 4 Sep 2008 18:38:15 +0800
Message-ID: <f17812d70809040338u3f6345a2ja76ccb76b96cc9dc@mail.gmail.com>
References: <f17812d70809040221u606f5bfaxe4ae41fae644391f@mail.gmail.com>
	 <20080904100051.GC10426@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:58444 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbYIDKiQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Sep 2008 06:38:16 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1859018yxm.1
        for <linux-input@vger.kernel.org>; Thu, 04 Sep 2008 03:38:15 -0700 (PDT)
In-Reply-To: <20080904100051.GC10426@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org

On Thu, Sep 4, 2008 at 6:00 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 04, 2008 at 05:21:05PM +0800, Eric Miao wrote:
>> The GPIO connected to ADS7846 nPENIRQ signal is usually used to get
>> the pendown state as well. Introduce a .gpio_pendown, and use this
>> to decide the pendown state if .get_pendown_state is NULL.
>
>> +static int get_pendown_state(struct ads7846 *ts)
>> +{
>> +     if (ts->get_pendown_state)
>> +             return ts->get_pendown_state();
>> +
>> +     if (ts->gpio_pendown != -1)
>> +             return !gpio_get_value(ts->gpio_pendown);
>> +
>> +     return 0;
>> +}
>> +
>
>
>> +     int     gpio_pendown;           /* the GPIO usually connected to PENIRQ
>> +                                      * and used to decide pendown state
>> +                                      * (-1) to use (*get_pendown_state) */
>> +
>
> The comment doesn't match the code.  get_pendown_state() is used if it's
> non-NULL, otherwise, the GPIO if it's not -1.
>
> I'm getting a little worried about these tests for valid gpio numbers in
> drivers - some check for non-zero, this one checks for not -1.  I get the
> feeling that this is storing up problems for later.
>
> Maybe using gpio_is_valid() would be a good idea?
>

Indeed, I'll fix the other SPI GPIO CS patch as well.

> But... a related question: do we need to do the check here?  Surely either
> a pendown function is going to be supplied, or if not we're going to use
> a GPIO, in which case the GPIO better be valid.  Maybe something to check
> at driver initialisation time only?
>

There is a warning If none is provided, and probe() will fail.
So actually get_pendown_state() will never reach the last
"return 0" statement.

-- 
Cheers
- eric
