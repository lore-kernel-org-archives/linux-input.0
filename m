From: Paul Cercueil <pcercuei@gmail.com>
Subject: Re: kernel panic on gpio-keys
Date: Tue, 17 Dec 2013 16:17:34 +0100
Message-ID: <52B06B0E.20501@gmail.com>
References: <52A8BA49.7080507@gmail.com> <20131214093900.GA10799@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:45932 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab3LQPRh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 10:17:37 -0500
Received: by mail-we0-f175.google.com with SMTP id t60so6133487wes.6
        for <linux-input@vger.kernel.org>; Tue, 17 Dec 2013 07:17:36 -0800 (PST)
In-Reply-To: <20131214093900.GA10799@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 14/12/2013 10:39, Dmitry Torokhov wrote:
> On Wed, Dec 11, 2013 at 08:17:29PM +0100, Paul Cercueil wrote:
>> Hi there,
>>
>> I am trying to use the gpio-keys driver to inject joystick events.
>> There seems to be some basic support of it, looking at <linux/gpio_keys.h>.
>>
>> However, registering the following will trigger a kernel panic in
>> the kernel:
>>
>> static struct gpio_keys_button my_buttons[] {
>> 	{
>> 		.gpio = GPIO_FOO,
>> 		.type = EV_ABS,
>> 		.code = ABS_HAT0X,
>> 		.value = 1,
>> 	},
>> };
>>
>> (tested on kernel 3.12).
>>
>> I don't know well the input subsystem, so I have no idea of what is
>> going wrong. Could anybody try to at least reproduce the issue?
>
> It woudl be helpful if you poster the stack trace from panic so we'd
> have an idea where the fault happens.
>
> Thanks.
>

Here is the crash log I get: http://pastebin.com/FzTTGxsR
(I did put it on pastebin because it's huge, 200+ lines).

The first OOPS happen as soon as the GPIO button is pressed; the other 
ones seem to happen recursively. I included only a part of the log I 
get, as the OOPSes continue to flow until the watchdog kicks in.
