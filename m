From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Support for Alps SS5 touchpad
Date: Sat, 28 May 2016 15:21:16 +0200
Message-ID: <d011b11f-adc9-e7c6-bf4b-540aa4582fa2@redhat.com>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
 <bf7c7b92-0b17-3867-aa8e-a4cda193dc4a@redhat.com>
 <87fut2nx0f.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbcE1NVW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 09:21:22 -0400
In-Reply-To: <87fut2nx0f.fsf@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

Hi,

On 28-05-16 15:16, Ben Gamari wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>
>> Hi,
>>
>> On 28-05-16 14:00, Ben Gamari wrote:
>>> Here is a patchset adding support for the Alps SS5 touchpad hardware shipped
>>> with the Dell Latitude E7470. The protocol is similar to that used by the SS4
>>> v2 devices, but with additional support for a touchstick.
>>>
>>> The touchpad exhibits slightly inconsistent behavior when single-finger
>>> contacts are released while a button is being held. This leads to extremely
>>> unpleasant jumps in pointer position, especially during drag-and-drop
>>> operations. This is resolved by patch 2/4.
>>>
>>> One minor outstanding issue is the high speed of the touchstick. Previous
>>> touchstick drivers have taken the extremely unfortunate approach of scaling the
>>> input device space to work-around this (often sacrificing device resolution in
>>> the process). I've started another thread on linux-input (see "Should
>>> touchsticks really be relative input devices?") to discuss options for
>>> resolving this.
>>
>> The problem with touchstick's is that they have a wildly varying sensitivity,
>> unfortunately this seems to be laptop model specific, e.g. one generation
>> of alps tracksticks can be slow on some models and fast on others.
>>
> Right.
>
>> We've entries in udev's hwdb for known troublesome models, see:
>> /lib/udev/hwdb.d/70-pointingstick.hwdb
>>
> Thanks, I'll submit a patch when I find a reasonable value.
>
>> On a modern Linux distro. If you add an entry for your laptop there, with a
>> slow-down factor and are using xf86-input-libinput as driver for the
>> touchstick, then things should work.
>>
> Apologies for going slightly out of kernel-land but...
>
> What exactly does this end up adjusting in libinput?

It applies a constant factor to the delta-s before processing them
further, it does so using floating point, so as to not loose
precision as the kernel downscale solution does.

Note to slow down you will want to use a value of 0.x, e.g.
0.5 or even 0.25 .

> I've been entirely
> unable to get any control over the speed of the touchstick with xinput.
> Currently the properties look like,
>
>     $ xinput list-props 14
>     Device 'AlpsPS/2 ALPS DualPoint Stick':
>       Device Enabled (137):	1
>       Coordinate Transformation Matrix (139):	0.010000, 0.000000, 0.000000, 0.000000, 0.010000, 0.000000, 0.000000, 0.000000, 0.010000
>       libinput Accel Speed (631):	0.000010
>       libinput Accel Speed Default (632):	0.000000
>       libinput Accel Profiles Available (633):	1, 1
>       libinput Accel Profile Enabled (634):	1, 0
>       libinput Accel Profile Enabled Default (635):	1, 0
>       libinput Natural Scrolling Enabled (636):	0
>       libinput Natural Scrolling Enabled Default (637):	0
>       libinput Send Events Modes Available (257):	1, 0
>       libinput Send Events Mode Enabled (258):	0, 0
>       libinput Send Events Mode Enabled Default (259):	0, 0
>       libinput Left Handed Enabled (638):	0
>       libinput Left Handed Enabled Default (639):	0
>       libinput Scroll Methods Available (640):	0, 0, 1
>       libinput Scroll Method Enabled (641):	0, 0, 1
>       libinput Scroll Method Enabled Default (642):	0, 0, 1
>       libinput Button Scrolling Button (643):	2
>       libinput Button Scrolling Button Default (644):	274
>       libinput Middle Emulation Enabled (645):	0
>       libinput Middle Emulation Enabled Default (646):	0
>       Device Node (260):	"/dev/input/event9"
>       Device Product ID (261):	2, 8
>       libinput Drag Lock Buttons (647):	<no items>
>       libinput Horizonal Scroll Enabled (262):	1
>
> Yet none of my fiddling seems to have had any effect on the sensitivity
> of the device.

The range of "libinput Accel Speed" is from -1.0 to 1.0 to de-accel
the touchstick set it to a negative value.

But you really want to use the hwdb solution, so that 0.0 more
or less works nicely, so that we do not end up with all users
needing to tweak things manually.

Regards,

Hans





