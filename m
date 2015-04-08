From: Hans de Bruin <jmdebruin@xmsnet.nl>
Subject: Re: 4.0.0-rc mouse/keyboard events get stuck
Date: Wed, 08 Apr 2015 12:59:23 +0200
Message-ID: <55250A0B.6060608@xmsnet.nl>
References: <5522D2EF.9070505@xmsnet.nl> <CAKdAkRRao8aXYABV0M-KrqPuzrJG_7M2Qq+6hJQoqe7Q32USKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRRao8aXYABV0M-KrqPuzrJG_7M2Qq+6hJQoqe7Q32USKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
List-Id: linux-input@vger.kernel.org

On 04/06/2015 11:23 PM, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Mon, Apr 6, 2015 at 11:39 AM, Hans de Bruin <jmdebruin@xmsnet.nl> wrote:
>> Since 4.0.0-rc something mu laptop has some mouse /keyboard problems.
>> When I play KDE kpatience, a card game, card stick to my mousepointer: left
>> mouse button down on a card, move mouse pointer and card to another place.
>> left mouse button up to drop the card. This should drop the card, but often
>> the mouse button up events gets stuck somewhere until I move he mouse
>> pointer a little bit.
>> In web based mail clients something similar happens when I drag mail to
>> another folder.
>> Sometime after I start a xterm and start typing, the letters don't appear
>> until move the mouse pointer.
>>
>> Bisecting is out of the question. This kernel realease was so dramatic I was
>> glad to have functioning kde screen when rc4 arrived.
>>
>> My laptop is a Dell Latitude D430, it has a touchpad and a pointer an two
>> sets of buttons.
>>
>> dmesg
>> [    0.636492] input: AT Translated Set 2 keyboard as
>> /devices/platform/i8042/serio0/input/input4
>> [    0.633108] mousedev: PS/2 mouse device common for all mice
>> [   80.543044] input: PS/2 ALPS Mouse as
>> /devices/platform/i8042/serio1/input/input8
>
> Linus just merged 2 fixes to ALPS driver that might help you. Could
> you please try compiling tip of the tree and telling me if it fixes
> your issue?
>

I am at rc.7 and the problem is still there. But maybe you can get away 
with "user error". Here is a picture of the layout of my laptop:

http://img.clubic.com/000000DC00604500-photo-dell-latitude-d430-4.jpg

Lets call the blue thing ts. The buttons directly beneath the keys ts-l 
and ts-r. For the touchpad tp, tp-l and tp-r. And because one can never 
have to many input devices um, um-l and um-r for a usb mouse.

When I play kpatience and stick to one device ts or ts-l or mp and mp-l 
no problems arise. I can also mix devices for example um and tp-l. There 
are several combinations. Only one of these ts and tp-l show the 
problematic behavior. This is the way i use my laptop (user error?)

Now something to distract you from the issue, something almost 
completely different. Something which is also present in 3.18 and 
probably before. Firefox and other programs have scrollbars on the right 
side. One can click on it, move the slider and release the button. 
Except with the combination tp and ts-l, It does not work. Al other 
combinations do.

-- 
Hans
