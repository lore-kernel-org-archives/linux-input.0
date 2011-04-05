From: Manoj <manoj.iyer@canonical.com>
Subject: Re: Lenovo X220 Touchpad + Trackpoint BIOS issue workaround ?
Date: Tue, 05 Apr 2011 12:57:27 -0500
Message-ID: <4D9B5807.9090406@canonical.com>
References: <4D9B2CD0.20404@canonical.com> <4D9B522B.7080201@canonical.com> <20110405173940.GA13086@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37004 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1DER5a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Apr 2011 13:57:30 -0400
In-Reply-To: <20110405173940.GA13086@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


> When both are enabled in BIOS what protocol does the kernel use to talk
> to the touchpad? Does it use synaptics protocol?

Yes it uses Synaptics TouchPad.

if (max_proto > PSMOUSE_PS2 && synaptics_detect(p .. etc...

I should say here that the trackpoint is not detected. And sometimes 
(very random) the trackpad is detected as PS/2 Mouse when touchpad and 
trackpoint are enabled in the BIOS... here is what it looks like in 
dmesg when it shows up as PS/2 Mouse instead of TPPS/2 IBM TrackPoint.

[    9.797624] input: ThinkPad Extra Buttons as 
/devices/platform/thinkpad_acpi/input/input8
[   10.480034] serio: Synaptics pass-through port at isa0060/serio1/input0
[   10.536122] input: SynPS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input9
[   34.507201] input: PS/2 Generic Mouse as 
/devices/platform/i8042/serio1/serio2/input/input10

>
> Thanks.
>
>> Manoj Iyer
>> Ubuntu/Canonical
>> Hardware Enablement
>>
>> On 04/05/2011 09:53 AM, Manoj wrote:
>>> The Lenovo X220 has a touch pad and a track point. I would like to get
>>> some clues as to if there is any work around in the kernel for the issue
>>> I am seeing below:
>>>
>>> Case 1: Touchpad and Trackpoint enabled in BIOS.
>>> ================================================
>>> In this case the touchpad works correctly, but the trackpoint is not
>>> detected at all. Some times after random number of reboots, the
>>> trackpoint will start to respond approximately 15mts after X starts. But
>>> the mouse will be detected as PS2 Generic Mouse.
>>>
>>> Case 2: Touchpad Disabled Trackpoint Enabled in BIOS
>>> ======================================================
>>> In this case the trackpoint works as expected, and it is detected as
>>> TPPS/2 IBM TrackPoint.
>>> [ 9.675396] input: TPPS/2 IBM TrackPoint as
>>> /devices/platform/i8042/serio1/input/input9
>>>
>>> I suspect this is a BIOS bug? Is it possible to work around this in the
>>> kernel?
>>>
>>>
>
