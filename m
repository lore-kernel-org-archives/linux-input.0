From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Fix error handling in I2C
 transport driver
Date: Sat, 1 Oct 2016 13:46:37 -0700
Message-ID: <7f3a157a-4dc0-5f81-c1ba-36bc1c0d6da2@roeck-us.net>
References: <1475109426-23644-1-git-send-email-linux@roeck-us.net>
 <20160929175540.GF7509@tuxbot> <20160930225403.GG30208@dtor-ws>
 <20160930230203.GH30208@dtor-ws>
 <74a818fc-6ebf-0514-461e-b664390c32cb@roeck-us.net>
 <1475342862.162608.742891553.456AA401@webmail.messagingengine.com>
 <20161001190429.GB12313@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45262 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbcJAUqp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Oct 2016 16:46:45 -0400
In-Reply-To: <20161001190429.GB12313@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <andrew@duggan.us>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

On 10/01/2016 12:04 PM, Dmitry Torokhov wrote:
> On Sat, Oct 01, 2016 at 10:27:42AM -0700, Andrew Duggan wrote:
>>
>>
>> On Fri, Sep 30, 2016, at 08:44 PM, Guenter Roeck wrote:
>>> On 09/30/2016 04:02 PM, Dmitry Torokhov wrote:
>>>> On Fri, Sep 30, 2016 at 03:54:03PM -0700, Dmitry Torokhov wrote:
>>>>> On Thu, Sep 29, 2016 at 10:55:40AM -0700, Bjorn Andersson wrote:
>>>>>> On Wed 28 Sep 17:37 PDT 2016, Guenter Roeck wrote:
>>>>>>
>>>>>>> Instantiating the rmi4 I2C transport driver without interrupts assigned
>>>>>>> (for example using manual i2c instantiation from the command line)
>>>>>>> caused the driver to fail to load, but it does not clean up its
>>>>>>> regulator or transport device registrations. Result is a crash at a later
>>>>>>> time, for example when rebooting the system.
>>>>>>>
>>>>>>> Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")
>>>>>>
>>>>>> Sorry for that.
>>>>>>
>>>>>>> Fixes: fdf51604f104 ("Input: synaptics-rmi4 - add I2C transport driver")
>>>>>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>>
>>>>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>
>>>>> Applied, thank you.
>>>>
>>>> I take it back. rmi_i2c_init_irq() uses devm* so this whole thing mixes
>>>> up devm* and manual unregistering and unwind order is completely
>>>> broken.
>>>>
>>> Oops ...
>>>
>>>> 1. Why do we register interrupt from transport drivers and not make it
>>>> part of rmi_register_transport_device()?
>>
>> Not all RMI devices will have access to interrupts (ie HID and SMBus).
>> The same goes for regulators. Here is a reference to a previous
>> discussion regarding both:
>> https://lkml.org/lkml/2016/5/9/1055
>
> Yeah, I am wondering if we should not revisit this and have SMBus (and
> possibly HID) actually provide us with an interrupt.
>
> In the meantime we can just ignore interrupt value if it is set to 0.
>

I have another follow-up patch doing that (I have a test setup which
doesn't support interrupts); I just wasn't sure if there was interest,
so I did not yet send it out. I'll be happy to do that, though I would
prefer to keep it separate (it isn't a bug fix, after all).

Thanks,
Guenter

