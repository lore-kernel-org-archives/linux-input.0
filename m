From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: soc_button_array - Set input device name
Date: Sun, 22 Jan 2017 02:00:05 -0800
Message-ID: <CAKdAkRQisdL=PXeYFgorq0_mG8H2EScw1sPXbeT73+PxCY_aVQ@mail.gmail.com>
References: <20170109175707.12854-1-hdegoede@redhat.com> <20170121191328.GC36944@dtor-ws>
 <f6eeaeee-6343-a849-2dcd-0136b8882498@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35439 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdAVKAH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 05:00:07 -0500
Received: by mail-ua0-f194.google.com with SMTP id 96so10986331uaq.2
        for <linux-input@vger.kernel.org>; Sun, 22 Jan 2017 02:00:07 -0800 (PST)
In-Reply-To: <f6eeaeee-6343-a849-2dcd-0136b8882498@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Jan 22, 2017 at 12:49 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 21-01-17 20:13, Dmitry Torokhov wrote:
>>
>> On Mon, Jan 09, 2017 at 06:57:06PM +0100, Hans de Goede wrote:
>>>
>>> On some tablets using the soc_button_array driver the buttons do not
>>> follow the standard home, power, volume_up, volume_down, rotation_lock
>>> button order as published by Microsoft.
>>>
>>> We can use the existing udev hwdb mechanism to fix this up, but then
>>> the created devices must have a unique name, therefor this commit adds
>>> a unique name for the 2 created gpio-keys input devices.
>>
>>
>> Why does it have to have unique name? You should be able to match on
>> other input device properties, for example ATTR{capabilities/ev} or
>> ATTR{capabilities/keys} to identify the device you want to adjust.
>
>
> hwdb entries do not have access to full udev data, basically there
> are 2 match formats:
>
> # Supported hardware matches are:
> #  - Generic input devices match:
> #      evdev:input:bZZZZvYYYYpXXXXeWWWW-VVVV
> #    This matches on the kernel modalias of the input-device, mainly:
> #    ZZZZ is the bus-id (see /usr/include/linux/input.h BUS_*), YYYY, XXXX
> and
> #    WWW are the 4-digit hex uppercase vendor, product and version ID and
> VVVV
> #    is an arbitrary length input-modalias describing the device
> capabilities.
> #    The vendor, product and version ID for a device node "eventX" is listed
> #    in /sys/class/input/eventX/device/id.
> #
> #  - Input driver device name and DMI data match:
> #      evdev:name:<input device name>:dmi:bvn*:bvr*:bd*:svn<vendor>:pn*
> #    <input device name> is the name device specified by the
> #    driver, <vendor> is the firmware-provided string exported
> #    by the kernel DMI modalias, see /sys/class/dmi/id/modalias
>
>
> Since we want to match on DMI info we need to use the second, and
> the info you are referring to is not available here.

Well, you can either teach hwdb new tricks or mangle the name in udev
rule. As far as I can see the original invocation is:

# device matching the input device name and the machine's DMI data
KERNELS=="input*", IMPORT{builtin}="hwdb
'evdev:name:$attr{name}:$attr{[dmi/id]modalias}'", \
 RUN{builtin}+="keyboard", GOTO="evdev_end"

You can add a similar rule that also looks at ATTR{whatever}, but
instead of using "name:$attr{name}" you can use whatever string you
want.

There is no need to change kernel, it already exports all necessary data.

Thanks.

-- 
Dmitry
