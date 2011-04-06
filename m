From: Manoj <manoj.iyer@canonical.com>
Subject: Re: Lenovo X220 Touchpad + Trackpoint BIOS issue workaround ?
Date: Wed, 06 Apr 2011 12:03:33 -0500
Message-ID: <4D9C9CE5.9070109@canonical.com>
References: <4D9B2CD0.20404@canonical.com> <4D9B522B.7080201@canonical.com> <20110405173940.GA13086@core.coreip.homeip.net> <4D9B5807.9090406@canonical.com> <20110405183001.GC13086@core.coreip.homeip.net> <4D9B9169.5090909@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:60580 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab1DFRDg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 13:03:36 -0400
In-Reply-To: <4D9B9169.5090909@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry,

Did you get a chance to look at this message? Can you pls nudge me in 
the right direction?

Manoj Iyer
Ubuntu/Canonical
Hardware Enablement

On 04/05/2011 05:02 PM, Manoj wrote:
> Dmitry,
>
> I turned on i8042.debug and it produced a lot of noise, and I couldint
> make out what it was trying to tell me. So I put some debug prints in
> synaptic.c and psmouse-base.c. In the case where both touchpad and
> trackpoint are enabled in the BIOS I get the following failure in
> psmouse_probe(). I have attached the psmouse-base.c and synaptic.c for
> you reference as to where the prints are coming from. Dont know why
> psmouse_probe() PSMOUSE_CMD_GETID would fail on the pass-through device.
>
> [ 726.431405] DEBUG: psmouse_probe:931 probing for isa0060/serio1
> [ 726.436949] DEBUG: psmouse_probe:937 got PSMOUSE_CMD_GETID 00
> [ 727.349407] Synaptics Touchpad, model: 1, fw: 8.0, id: 0x1e2b1, caps:
> 0xd001a3/0x940300/0x120c00
> [ 727.349415] Synaptics: Clickpad mode enabled
> [ 727.349423] serio: Synaptics pass-through port at isa0060/serio1/input0
> [ 727.349438] DEBUG: Synaptics: synaptics_init:828: psmouse->rate = 0x64
> [ 727.349444] DEBUG: psmouse_switch_protocol:1266 selected_proto->type = 7
> [ 727.407740] input: SynPS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input9
> [ 727.419607] DEBUG: psmouse_connect:1318 pass-though device detected
> [ 727.425287] DEBUG: psmouse_deactivate:1028 deacivating isa0060/serio1
> [ 727.425307] DEBUG: psmouse_probe:931 probing for synaptics-pt/serio0
> [ 727.672729] DEBUG: psmouse_probe:934 failed to get PSMOUSE_CMD_GETID a5
> [ 727.672738] DEBUG: psmouse_connect:1342 failed in psmouse_probe()
> [ 727.672747] DEBUG: psmouse_connect:1376 psmouse_activate() called on
> parent
>
>
> Manoj Iyer
> Ubuntu/Canonical
> Hardware Enablement
>
> On 04/05/2011 01:30 PM, Dmitry Torokhov wrote:
>> On Tue, Apr 05, 2011 at 12:57:27PM -0500, Manoj wrote:
>>>
>>>> When both are enabled in BIOS what protocol does the kernel use to talk
>>>> to the touchpad? Does it use synaptics protocol?
>>>
>>> Yes it uses Synaptics TouchPad.
>>>
>>> if (max_proto> PSMOUSE_PS2&& synaptics_detect(p .. etc...
>>>
>>> I should say here that the trackpoint is not detected. And sometimes
>>> (very random) the trackpad is detected as PS/2 Mouse when touchpad
>>> and trackpoint are enabled in the BIOS... here is what it looks like
>>> in dmesg when it shows up as PS/2 Mouse instead of TPPS/2 IBM
>>> TrackPoint.
>>>
>>> [ 9.797624] input: ThinkPad Extra Buttons as
>>> /devices/platform/thinkpad_acpi/input/input8
>>> [ 10.480034] serio: Synaptics pass-through port at isa0060/serio1/input0
>>> [ 10.536122] input: SynPS/2 Synaptics TouchPad as
>>> /devices/platform/i8042/serio1/input/input9
>>> [ 34.507201] input: PS/2 Generic Mouse as
>>> /devices/platform/i8042/serio1/serio2/input/input10
>>>
>>
>> Ah, so we do know that the touchpad has a pass-through port.
>>
>> I guess you can try booting with i8042.debug with touchpad enabled and
>> disabled and see where exactly we fail to enable trackpoint the the
>> former case.
>>
