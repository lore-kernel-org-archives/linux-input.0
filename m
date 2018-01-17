From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Wed, 17 Jan 2018 12:12:47 -0800
Message-ID: <6086f672-d633-6084-5688-99c35170f56f@infradead.org>
References: <20180117190716.22380-1-marcus.folkesson@gmail.com>
 <9607d51a-4382-396c-a4bd-46bbb24ba46e@infradead.org>
 <20180117194516.GC10949@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59857 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeAQUMt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Jan 2018 15:12:49 -0500
In-Reply-To: <20180117194516.GC10949@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/17/2018 11:45 AM, Marcus Folkesson wrote:
> Hi Randy!
> 
> On Wed, Jan 17, 2018 at 11:13:43AM -0800, Randy Dunlap wrote:
>> On 01/17/2018 11:07 AM, Marcus Folkesson wrote:
>>> This driver let you plug in your RC controller to the adapter and
>>> use it as input device in various RC simulators.
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> ---
>>
>>> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
>>> index f3c2f6ea8b44..18ab6dafff41 100644
>>> --- a/drivers/input/joystick/Kconfig
>>> +++ b/drivers/input/joystick/Kconfig
>>> @@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
>>>  
>>>  	  To drive rumble motor a dedicated power supply is required.
>>>  
>>> +config JOYSTICK_PXRC
>>> +	tristate "PhoenixRC Flight Controller Adapter"
>>> +	depends on USB_ARCH_HAS_HCD
>>> +	select USB
>>
>> Drop the (first) depends and change "select USB" to "depends on USB".
>>
>> Argh, there are lots of input/ drivers that do that.  That's bad/wrong.
>> A driver should not select (enable) an entire subsystem.  If the user had
>> the subsystem disabled, it should stay that way.
>>
>> Dmitry, you can expect some patches...
>>
> 
> Hah, of course it should be "depends on" :-)
> Other drivers fooled me...
> 
> Should I fix the other drivers too when I'm on it, or do you?

Either way.  If you are up for it, please go ahead.

thanks,
-- 
~Randy
