From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from	Arnaud
  Patard.
Date: Thu, 19 Nov 2009 17:48:24 +0000
Message-ID: <4B0584E8.3040800@simtec.co.uk>
References: <20091118232939.201290297@fluff.org.uk>	<20091118232948.063635416@fluff.org.uk>	<20091119025930.GA20172@core.coreip.homeip.net>	<4B052D50.2070002@simtec.co.uk>	<20091119135236.GB5535@digital-scurf.org> <20091119170321.GB15647@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20091119170321.GB15647@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Silverstone <dsilvers@simtec.co.uk>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Simtec Linux Team <linux@simtec.co.uk>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Thu, Nov 19, 2009 at 01:52:36PM +0000, Daniel Silverstone wrote:
>> On Thu, Nov 19, 2009 at 11:34:40AM +0000, Ben Dooks wrote:
>>>>> +		input_report_key(ts.input, BTN_TOUCH, 1);
>>>>> +		input_report_abs(ts.input, ABS_PRESSURE, 1);
>>>> No fake pressure events please, BTN_TOUCH should be enough.
>>> I'd have to check, IIRC tslib needs these to function properly.
>> Indeed it does -- otherwise it won't work.  Yes you could try going around and
>> patching TSLIB but so many people use it that it is principle-of-least-surprise
>> to produce pressure events.
>>
>>>>> +	ts.input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>>>>> +	input_set_abs_params(ts.input, ABS_X, 0, 0x3FF, 0, 0);
>>>>> +	input_set_abs_params(ts.input, ABS_Y, 0, 0x3FF, 0, 0);
>>>>> +	input_set_abs_params(ts.input, ABS_PRESSURE, 0, 1, 0, 0);
>>>> Drop ABS_PRESSURE.
>>> ok, see above.
>> The same applies here -- claim ABS_PRESSURE or tslib won't operate with the
>> touchscreen.
>>
>> While it is tempting to be 100% exactly correct to what the hardware reports
>> (which is only TOUCH not PRESSURE) it is preferable to work with the software
>> which the majority of people use -- namely tslib.
>>
>> I would strongly argue against removing the ABS_PRESSURE stuff personally,
>> despite it being essentially a lie.

ok, i'll remove it and anyone who can't be bothered to update their
tslib can hack in their own solution if they really care about it.

> And I would strongly argue that you just need to update your tslib,
> especially given the fact that this issue was dealt with there about a
> year ago.  And if you really need that fix to be in released (read
> 'tagged') version of tslib - please speak to its maintainer.

> Why everyone thinks that it is a good idea to pile workarounds for
> software issues in the kernel but updating the other parts of software
> stack is a big no-no?

it can be much more difficult to update a userland than to hack the
kernel...
