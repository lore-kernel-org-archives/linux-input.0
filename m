From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: ir-core and default IR maps
Date: Wed, 10 Nov 2010 11:30:25 -0200
Message-ID: <4CDA9E71.5020408@redhat.com>
References: <AANLkTikfeu4DnV8E7rKahUdu2k_d08BOFZjLzBMRA2o+@mail.gmail.com> <20101107060147.GC3823@core.coreip.homeip.net> <AANLkTinbTw26wTvbUVJU+sEGyH0DCt4WvmfO2_nvcLjR@mail.gmail.com> <4CD7F6A7.8040206@redhat.com> <AANLkTinc_SuTrP6E8aoyXxGKEQwu=QRieRPt3z4b6Xn_@mail.gmail.com> <AANLkTimPKkvdWWTPoWGCRmp-biwup1dEQpaKYEk8t9ED@mail.gmail.com> <4CD805D8.2000808@redhat.com> <20101109063242.GA10496@core.coreip.homeip.net> <4CD920AE.8090406@redhat.com> <20101110065133.GA22666@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab0KJNac (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 08:30:32 -0500
In-Reply-To: <20101110065133.GA22666@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jarod Wilson <jarod@redhat.com>

Em 10-11-2010 04:51, Dmitry Torokhov escreveu:
> On Tue, Nov 09, 2010 at 08:21:34AM -0200, Mauro Carvalho Chehab wrote:
>> Em 09-11-2010 04:32, Dmitry Torokhov escreveu:
>>> On Mon, Nov 08, 2010 at 12:14:48PM -0200, Mauro Carvalho Chehab wrote:
>>>> Em 08-11-2010 11:41, jonsmirl@gmail.com escreveu:
>>>>> On Mon, Nov 8, 2010 at 8:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>>>>> To achieve plug and play at least one of four choices has to happen:
>>>>>
>>>>> There is another option, the IR maps get integrated into user space
>>>>> keyboard mapping package. This may be possible with the new
>>>>> libxkbcommon package.
>>>>
>>>> That seems interesting.
>>>>
>>>
>>> I disagree here. libxkbcommon provides X interface while applications
>>> might want to access evdev nodes directly. 
>>
>> Let me express better: I don't think we should integrate X with the udev tool, 
>> but, eventually, we could make some X package dependent of v4l-utils. Not sure
>> if libxkbdcommon is the better way to do it, as I don't have it installed here
>> on my machines.
>>
>>> If anything, parts of
>>> ir-utils dealing with keymap selection should be moved into udev. Maybe
>>> we should split utilities that select protocol from the keymap setting
>>> and use udev keymap utilities to do the task.
>>
>> It doesn't make sense to split keymap and protocol selection. Just loading a
>> keyboard table but not changing the IR protocol is useless, as the device will
>> not be selected. Besides that, the tool that do both is really simple (and, btw,
>> it also allows changing the map for a non-RC device, by using one parameter that
>> skips the usage of the sysfs nodes at /sys/class/rc):
>>
>> # ir-keytable -d /dev/input/event4 -r
>> scancode 0x0000 = KEY_LEFTCTRL (0x1d)
>> Enabled protocols: 
> 
> OTOH loading keymap and selecting protocol are 2 distinct actions and
> udev already has a tool to load keymaps that should also work for all
> devices, including remotes.

How this tool decide what scancode should be associated with a remote controller?
There are, currently, 86 different keytables, one for each known bundled remote,
and the decision about what keymap should be load needs to take some hints provided
via RC sysfs nodes, in order to get the right table.

The two distinct actions are not independent. A keycode table should dictate what 
protocol is needed, as the same device can support more than one protocol, and the
in-hardware decoders will only produce scancodes if the protocol is properly selected.
So, the udev tool needs to do both actions at the same time.

> Basically I do not see the reason for having 2 tools doing pretty much
> the same thing.
 
We may replace the old tool, or merge both tools, but the point is that the
needs are different. For example, for Remote Controllers, before loading a keytable, 
the tool needs to clean-up the previous table, as the bundled keyboard (or a previous keytable
load) may map different scancodes than the ones that exist at the newer table. Then,
it needs to select the protocol and load the new keytable.

Also, for Remote Controllers, kernel provides some additional hints at /sys/class/rc/rc?/uevent,
specifying the name of the real driver that is loading the device and the name of
the bundled remote. Those info should be taken into account, in order to select the
proper keycode table.

On the other side, a tool to change those things at runtime is also needed. So, what I did
to avoid tools duplication is that I've added everything needed by Remote Controllers
at the very same tool, preventing duplication.

Cheers,
Mauro
