From: Paul Cercueil <pcercuei@gmail.com>
Subject: Re: kernel panic on gpio-keys
Date: Mon, 30 Dec 2013 16:13:12 +0100
Message-ID: <52C18D88.9070707@gmail.com>
References: <52A8BA49.7080507@gmail.com> <20131214093900.GA10799@core.coreip.homeip.net> <52B06B0E.20501@gmail.com> <20131227015658.GA20756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:40265 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951Ab3L3PNS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 10:13:18 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm19so11668170wib.7
        for <linux-input@vger.kernel.org>; Mon, 30 Dec 2013 07:13:17 -0800 (PST)
In-Reply-To: <20131227015658.GA20756@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On 27/12/2013 02:56, Dmitry Torokhov wrote:
> On Tue, Dec 17, 2013 at 04:17:34PM +0100, Paul Cercueil wrote:
>> On 14/12/2013 10:39, Dmitry Torokhov wrote:
>>> On Wed, Dec 11, 2013 at 08:17:29PM +0100, Paul Cercueil wrote:
>>>> Hi there,
>>>>
>>>> I am trying to use the gpio-keys driver to inject joystick events.
>>>> There seems to be some basic support of it, looking at <linux/gpio_keys.h>.
>>>>
>>>> However, registering the following will trigger a kernel panic in
>>>> the kernel:
>>>>
>>>> static struct gpio_keys_button my_buttons[] {
>>>> 	{
>>>> 		.gpio = GPIO_FOO,
>>>> 		.type = EV_ABS,
>>>> 		.code = ABS_HAT0X,
>>>> 		.value = 1,
>>>> 	},
>>>> };
>>>>
>>>> (tested on kernel 3.12).
>>>>
>>>> I don't know well the input subsystem, so I have no idea of what is
>>>> going wrong. Could anybody try to at least reproduce the issue?
>>>
>>> It woudl be helpful if you poster the stack trace from panic so we'd
>>> have an idea where the fault happens.
>>>
>>> Thanks.
>>>
>>
>> Here is the crash log I get: http://pastebin.com/FzTTGxsR
>> (I did put it on pastebin because it's huge, 200+ lines).
>>
>> The first OOPS happen as soon as the GPIO button is pressed; the
>> other ones seem to happen recursively. I included only a part of the
>> log I get, as the OOPSes continue to flow until the watchdog kicks
>> in.
>
> Hmm, I have an idea: this driver is one of few that does not use
> input_set_abs_info() and this does not allocate memory for absinfo data
> that input core uses to handle absolute events.
>
> Does the patch below work for you?
>
> Thanks.
>

Hi,

The patch works just fine, thank you!
