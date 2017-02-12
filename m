From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] Input: soc_button_array - Set input device name
Date: Sun, 12 Feb 2017 13:36:16 +0100
Message-ID: <79120253-b26b-01fa-daf1-100259baf222@redhat.com>
References: <20170109175707.12854-1-hdegoede@redhat.com>
 <20170121191328.GC36944@dtor-ws>
 <f6eeaeee-6343-a849-2dcd-0136b8882498@redhat.com>
 <CAKdAkRQisdL=PXeYFgorq0_mG8H2EScw1sPXbeT73+PxCY_aVQ@mail.gmail.com>
 <9dd3f04e-83e0-edb9-2296-ef6ea80c5adc@redhat.com>
 <20170123221044.GA34769@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbdBLMgT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 07:36:19 -0500
In-Reply-To: <20170123221044.GA34769@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On 23-01-17 23:10, Dmitry Torokhov wrote:
> On Sun, Jan 22, 2017 at 11:10:31AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 22-01-17 11:00, Dmitry Torokhov wrote:
>>> On Sun, Jan 22, 2017 at 12:49 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 21-01-17 20:13, Dmitry Torokhov wrote:
>>>>>
>>>>> On Mon, Jan 09, 2017 at 06:57:06PM +0100, Hans de Goede wrote:
>>>>>>
>>>>>> On some tablets using the soc_button_array driver the buttons do not
>>>>>> follow the standard home, power, volume_up, volume_down, rotation_lock
>>>>>> button order as published by Microsoft.
>>>>>>
>>>>>> We can use the existing udev hwdb mechanism to fix this up, but then
>>>>>> the created devices must have a unique name, therefor this commit adds
>>>>>> a unique name for the 2 created gpio-keys input devices.
>>>>>
>>>>>
>>>>> Why does it have to have unique name? You should be able to match on
>>>>> other input device properties, for example ATTR{capabilities/ev} or
>>>>> ATTR{capabilities/keys} to identify the device you want to adjust.
>>>>
>>>>
>>>> hwdb entries do not have access to full udev data, basically there
>>>> are 2 match formats:
>>>>
>>>> # Supported hardware matches are:
>>>> #  - Generic input devices match:
>>>> #      evdev:input:bZZZZvYYYYpXXXXeWWWW-VVVV
>>>> #    This matches on the kernel modalias of the input-device, mainly:
>>>> #    ZZZZ is the bus-id (see /usr/include/linux/input.h BUS_*), YYYY, XXXX
>>>> and
>>>> #    WWW are the 4-digit hex uppercase vendor, product and version ID and
>>>> VVVV
>>>> #    is an arbitrary length input-modalias describing the device
>>>> capabilities.
>>>> #    The vendor, product and version ID for a device node "eventX" is listed
>>>> #    in /sys/class/input/eventX/device/id.
>>>> #
>>>> #  - Input driver device name and DMI data match:
>>>> #      evdev:name:<input device name>:dmi:bvn*:bvr*:bd*:svn<vendor>:pn*
>>>> #    <input device name> is the name device specified by the
>>>> #    driver, <vendor> is the firmware-provided string exported
>>>> #    by the kernel DMI modalias, see /sys/class/dmi/id/modalias
>>>>
>>>>
>>>> Since we want to match on DMI info we need to use the second, and
>>>> the info you are referring to is not available here.
>>>
>>> Well, you can either teach hwdb new tricks or mangle the name in udev
>>> rule. As far as I can see the original invocation is:
>>>
>>> # device matching the input device name and the machine's DMI data
>>> KERNELS=="input*", IMPORT{builtin}="hwdb
>>> 'evdev:name:$attr{name}:$attr{[dmi/id]modalias}'", \
>>> RUN{builtin}+="keyboard", GOTO="evdev_end"
>>>
>>> You can add a similar rule that also looks at ATTR{whatever}, but
>>> instead of using "name:$attr{name}" you can use whatever string you
>>> want.
>>>
>>> There is no need to change kernel, it already exports all necessary data.
>>
>> Ah, come one, requiring a custom udev rule for this is a pain, where as
>
> OK, do not require custom property. Provide an extended one:
>
> # device matching the input device properties and the machine's DMI data
> KERNELS=="input*", IMPORT{builtin}="hwdb
> 'evdev:name:$attr{name}:phys:$attr{phys}:ev:$attr{capabilities/ev}:$attr{[dmi/id]modalias}'", \
>   RUN{builtin}+="keyboard"
>
> and either migrate old keymaps to the extended one, or keep both. In the
> end, there is nothing special in 'evdev:name:...' prefix, it matches
> across all lines of hwdb with whatever is provided in the rule.

Ok, I've send a pull-req to the systemd maintainers with a new rule for
extended input matches + a hwdb entry for the tablet with the issue
using the new extended rule.

Regards,

Hans
