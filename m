From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] Input: gpio_keys - Also send release events for ABS
 codes
Date: Sat, 5 Nov 2016 12:58:00 +0100
Message-ID: <56a0750b-c0f6-1fad-c730-11213dd64a97@crapouillou.net>
References: <20161101102504.3783-1-paul@crapouillou.net>
 <20161101102504.3783-2-paul@crapouillou.net> <20161103162159.GB15366@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:35846 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbcKEL6H (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 5 Nov 2016 07:58:07 -0400
In-Reply-To: <20161103162159.GB15366@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>

On 03/11/2016 17:21, Dmitry Torokhov wrote:
> On Tue, Nov 01, 2016 at 11:25:03AM +0100, Paul Cercueil wrote:
>> Right now, the gpio-keys driver is mostly used with EV_KEY event types.
>> However, this driver (and its devicetree bindings) support specifying
>> a different input type, like EV_ABS, even though this doesn't work in
>> practice: "key pressed" events are correctly received and treated, but
>> "key released" are silently ignored.
>>
>> With this commit, keys configured as EV_ABS will inject an event with
>> the value 0 when released.
> No, this will break setups like this:
>
> gpio0 - ABS_X - 0
> gpio1 - ABS_X - 1
> gpio2 - ABS_X - 2
> ...
> gpio7 - ABS_X - 7
>
> - something like a slider built on top of gpios.

So what would you suggest for the implementation of a hat / d-pad on top 
of GPIOs?

Thanks,
- Paul
