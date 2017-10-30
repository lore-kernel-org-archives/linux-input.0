From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] Input: gpio_keys - Allow suppression of input
 events for wakeup button presses
Date: Mon, 30 Oct 2017 21:08:21 +0100
Message-ID: <b6016f99-a313-164b-9e45-8611982d03a1@redhat.com>
References: <20171030174050.30375-1-hdegoede@redhat.com>
 <20171030174050.30375-3-hdegoede@redhat.com>
 <20171030181706.huwka5foqxparsiq@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932405AbdJ3UIZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 16:08:25 -0400
In-Reply-To: <20171030181706.huwka5foqxparsiq@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi,

On 30-10-17 19:17, Dmitry Torokhov wrote:
> On Mon, Oct 30, 2017 at 06:40:49PM +0100, Hans de Goede wrote:
>> In some cases it is undesirable for a wakeup button to send input events
>> to userspace if pressed to wakeup the system (if pressed during suspend).
>>
>> A typical example of this is the power-button on laptops / tablets,
>> sending a KEY_POWER event to userspace when woken up with the power-button
>> will cause userspace to immediately suspend the system again which is
>> undesirable.
>>
>> For power-buttons attached to a PMIC, or handled by e.g. ACPI, not sending
>> an input event in this case is take care of by the PMIC / ACPI hardware /
>> code. But in the case of a GPIO button we need to explicitly suppress the
>> sending of the input event.
>>
>> This commit supports this by adding a suppress_evdev_events_on_wakeup bool
>> to struct gpio_keys_button, which platform code can set to suppress the
>> input events for presses of wakeup keys during suspend.
> 
> I think this is [your] userspace issue.

It would have been nice if you started discussing this when I posted v1
quite some time ago.

> What if I press the button
> rapidly several times?

Why would anyone do that ?  But to answer the question it depends on
the timing, if you keep pressing it long enough for the resume to complete
then the first press after that will cause it to suspend again.

> I know Android actually _wants_ to see KEY_POWER
> at resume, or its opportunistic suspend will kick in right away.

Hmm, that is weird, because I believe that android x86 does work
on regular PCs and they do not do that.

> I think
> ChromeOS is OK with getting KEY_POWER on resume as well.
> 
> I'd say you need to have a small timeout before you start suspending
> again.

The problem with that is that it is going to be inherently racy.

More in general Bay Trail / Cherry Trail devices using gpio_key
for their power-button are the only "PC" devices sending a
KEY_POWER after wake-up, Bay / Cherry Trail devices which
have their power button hooked-up differently such as the Asus
Transformer series do not do this.

So both for consistency and because a timeout is racy I believe
that having the power button not send KEY_POWER after resume is
the proper solution here.

Note that I've made this configurable and that soc_button_array
is the only driver getting this enabled, making the power-button
behavior on PC like devices consistent, without impacting any
other devices.

Regards,

Hans
