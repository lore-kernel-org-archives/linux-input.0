From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix error handling in I2C
 transport driver
Date: Sat, 1 Oct 2016 10:45:16 -0700
Message-ID: <d94362b3-8659-e995-aeb3-eab04ab4548c@roeck-us.net>
References: <1475109426-23644-1-git-send-email-linux@roeck-us.net>
 <20160929175540.GF7509@tuxbot> <20160930225403.GG30208@dtor-ws>
 <20160930230203.GH30208@dtor-ws>
 <74a818fc-6ebf-0514-461e-b664390c32cb@roeck-us.net>
 <1475342862.162608.742891553.456AA401@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36400 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbcJARpT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Oct 2016 13:45:19 -0400
In-Reply-To: <1475342862.162608.742891553.456AA401@webmail.messagingengine.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <andrew@duggan.us>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On 10/01/2016 10:27 AM, Andrew Duggan wrote:
>
>
> On Fri, Sep 30, 2016, at 08:44 PM, Guenter Roeck wrote:
>> On 09/30/2016 04:02 PM, Dmitry Torokhov wrote:
>>> On Fri, Sep 30, 2016 at 03:54:03PM -0700, Dmitry Torokhov wrote:
>>>> On Thu, Sep 29, 2016 at 10:55:40AM -0700, Bjorn Andersson wrote:
>>>>> On Wed 28 Sep 17:37 PDT 2016, Guenter Roeck wrote:
>>>>>
>>>>>> Instantiating the rmi4 I2C transport driver without interrupts assigned
>>>>>> (for example using manual i2c instantiation from the command line)
>>>>>> caused the driver to fail to load, but it does not clean up its
>>>>>> regulator or transport device registrations. Result is a crash at a later
>>>>>> time, for example when rebooting the system.
>>>>>>
>>>>>> Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
>>>>>
>>>>> Sorry for that.
>>>>>
>>>>>> Fixes: fdf51604f104 ("Input: synaptics-rmi4 - add I2C transport driver")
>>>>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>
>>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>
>>>> Applied, thank you.
>>>
>>> I take it back. rmi_i2c_init_irq() uses devm* so this whole thing mixes
>>> up devm* and manual unregistering and unwind order is completely
>>> broken.
>>>
>> Oops ...
>>
>>> 1. Why do we register interrupt from transport drivers and not make it
>>> part of rmi_register_transport_device()?
>
> Not all RMI devices will have access to interrupts (ie HID and SMBus).
> The same goes for regulators. Here is a reference to a previous
> discussion regarding both:
> https://lkml.org/lkml/2016/5/9/1055
>
>>
>> rmi_register_transport_device() doesn't take dev as parameter.
>>
>>> 2. If we need to use some non-devm-ised resources we should use
>>> devm_add_action[_or_reset] to work these operations into devm stream.
>>
>
> Since the regulator functions have their own devm_ versions I would
> suggest switching to those functions to avoid dealing with
> unregistering.
>
Maybe I am missing something, but I don't see a devm_regulator_bulk_enable().
devm_regulator_bulk_get() is already used.

Guenter

> Registering and unregistering the transport device is a bit more
> complicated since these functions add and put the rmi_dev device. But,
> it sounds like we can handle the unregister using
> devm_add_action_or_reset().
>
