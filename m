From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
Date: Fri, 16 Jun 2017 11:06:28 +0200
Message-ID: <33C872C7-EFB2-4CA0-8CAD-8B6E8916180C@hadess.net>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com> <20170607074848.GE27006@gardel-login> <20170613100617.GD29589@mail.corp.redhat.com> <1AE640813FDE7649BE1B193DEA596E886CED0386@SHSMSX101.ccr.corp.intel.com> <20170615064715.GA6195@jelly> <1AE640813FDE7649BE1B193DEA596E886CED047B@SHSMSX101.ccr.corp.intel.com> <20170615075755.GA10001@jelly> <1AE640813FDE7649BE1B193DEA596E886CED0A03@SHSMSX101.ccr.corp.intel.com> <20170616072322.GL5085@mail.corp.redhat.com> <1AE640813FDE7649BE1B193DEA596E886CED0AC1@SHSMSX101.ccr.corp.intel.com> <20170616080950.GM5085@mail.corp.redhat.com> <1AE640813FDE7649BE1B193DEA596E886CED0C5E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED0C5E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Lennart Poettering <mzxreary@0pointer.de>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> On 16 Jun 2017, at 10:53, Zheng, Lv <lv.zheng@intel.com> wrote:
> 
> Hi,
> 
>> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
>> Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
>> 
>>> On Jun 16 2017 or thereabouts, Zheng, Lv wrote:
>>> Hi, Benjamin
>>> 
>>> Let me just say something one more time.
>>> 
>>>> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
>> 
>> [snip]
>>>>>>> 
>>>>>>> We can see:
>>>>>>> "logind" has already implemented a timeout, and will not respond lid state
>>>>>>> unless it can be stable within this timeout period.
>>>>>>> I'm not an expert of logind, maybe this is because of "HoldOffTimeoutSec"?
>>>>>>> 
>>>>>>> I feel "removing the input node for a period where its state is not trustful"
>>>>>>> is technically identical to this mechanism.
>>>>>> 
>>>>>> but you'd be making kernel policy based on one userspace implementation.
>>>>>> e.g. libinput doesn't have a timeout period, it assumes the state is
>>>>>> correct when an input node is present.
>>>>> 
>>>>> Do you see practical issues?
>>>> 
>>>> Yes, libinput can't rely on the LID switch information to disable
>>>> touchpads/touchscreens that are potentially sending false positive.
>>> 
>>> "potential" doesn't mean "practical", right?
>> 
>> I was using potential to say that some actual devices are sending
>> rightful states, while others are not (we already named them a lot in
>> those countless threads). So potential here is from a user space
>> perspective where you are not sure if the state is reliable or not
>> (given we currently don't have this information about reliability).
>> 
>>> After applying my last version.
>>> There are no false-positives IMO.
>>> There are only delays for the reliable key events.
>>>               ^^^^^^
>>> While the "delay" is very common in computing world.
>> 
>> No, if there is a delay, there is a false positive, because the initial
>> state is wrong with respect to the device physical state.
>> 
>>> 
>>>>> After resume, SW_LID state could remain unreliable "close" for a while.
>>>> 
>>>> This is not an option. It is not part of the protocol, having an
>>>> unreliable state.
>>>> 
>>>>> But that's just a kind of delay happens in all computing programs.
>>>>> I suppose all power managing programs have already handled that.
>>>>> I confirmed no breakage for systemd 233.
>>>>> For systemd 229, it cannot handle it well due to bugs.
>>>>> But my latest patch series has worked the bug around.
>>>>> So I don't see any breakage related to post-resume incorrect state period.
>>>>> Do you see problems that my tests haven't covered?
>>>> 
>>>> The problems are that you are not following the protocol. And if systemd
>>>> 233 works around it, that's good, but systemd is not the only listener
>>>> of the LID switch input node, and you are still breaking those by
>>>> refusing to follow the specification of the evdev protocol.
>>> 
>>> As you are talking about protocol, let me just ask once.
>>> 
>>> In computing world,
>>> 1. delay is very common
>>>   There are bus turnaround, network turnaround, ...
>>>   Even measurement itself has delay described by Shannon sampling.
>>>   Should the delay be a part of the protocol?
>> 
>> Please, you are either trolling or just kidding. If there are delays in
>> the "computing world", these has to be handled by the kernel, and not
>> exported to the user space if the kernel protocol says that the state is
>> reliable.
>> 
>>> 2. programs are acting according to rules (we call state machines)
>>>   States are only determined after measurement (like "quantum states")
>>>   I have Schroedinger's cat in my mind.
>>>   Events are determined as they always occur after measurement to trigger "quantum jumps".
>>>   So for EV_SW protocol,
>>>   Should programs rely on the reliable "quantum jumps",
>>>   Or should programs rely on the unreliable "quantum states"?
>> 
>> No comments, this won't get us anywhere.
>> 
>>> 
>>> I think most UI programs care no about state stored in the input node,
>>> they only receive events raised from the input node.
>> 
>> Bullshit. When you launch such a program, you need to query the state
>> because you won't receive the event that happened way before the launch.
>> 
>>> Why should the kernel export a fade-in/fade-out input node to the UI programs and ask them to change?
>>> 
>>> The only program that cares about the state stored in the input node is libinput.
>>> So why should every user program be changed to make libinput easier?
>> 
>> No, all program that listen to LID switches input nodes care about the
>> state. We already told you that, you just don't listen:
>> 
>> - systemd cares about the state as it does polling on the input node in
>>  case it misses an event
>> - libinput cares about the state as previously mentioned
>> - gnome-setting-daemons cares about the state given it decides whether
>>  or not lighting up the monitors depending on the state. And if you
>>  relaunch the daemon, it'll query the state to decide what is the best
>>  arrangement for the screens
> 
> Let's consider this case with delay:
> After resume, gnome-setting-daemon queries SW_LID and got "close".
> Then it lights up the wrong monitors.
> Then I believe "open" will be delivered to it several seconds later.
> Should gnome-setting-daemon light-up correct monitors this time?
> So it just looks like user programs behave with a delay accordingly because of the "platform turnaround" delay.

If you implement it in such a way that GNOME settings daemon behaves weirdly, you'll get my revert request in the mail. Do. Not. Ever. Lie.

> 
>> - KDE should do the same (as it is not a daemon that can catch any
>>  events)
> 
> Cheers,
> Lv
> ¢éì¹»®&Þ~º&¶¬–+-±éÝ¶¥Šw®žË›±Êâmébžìbž›­Š{ayºÊ‡Ú™ë,j­¢f£¢·hš‹àz¹®w¥¢¸¢·¦j:+v‰¨ŠwèjØm¶Ÿÿ¾«‘êçzZ+ƒùšŽŠÝ¢j"ú!¶i

