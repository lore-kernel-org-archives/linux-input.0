From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Fri, 8 Dec 2017 13:24:48 -0800
Message-ID: <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com> <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:39590 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbdLHVYu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 16:24:50 -0500
Received: by mail-ua0-f171.google.com with SMTP id i20so8347308uak.6
        for <linux-input@vger.kernel.org>; Fri, 08 Dec 2017 13:24:49 -0800 (PST)
In-Reply-To: <cae6e993-80af-9acd-b52f-34e493908820@scrye.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Sorry about the delay in getting back to you on this issue. It looks
like there are several different reasons that we could be getting
EREMOTEIO from the lower levels. Would you mind running the sysinfo.sh
script described at [1] and filing a bug to the project with the
output attached? This should give me an idea of what kind of hardware
is present in your 920. You might also try doing the following to see
if anything interesting gets printed to the dmesg log:

    # echo "file drivers/i2c/*.c +p" > /sys/kernel/debug/dynamic_debug/cont=
rol
    # modprobe -r wacom
    # modprobe wacom

Some of the I2C modules (which I suspect your sensor is using) log
debug messages prior to returning EREMOTEIO. The above will cause
these debug messages to be printed to dmesg and then reload the wacom
module. With luck, we might gain a little more information about
what's triggering the error.

[1]: https://github.com/linuxwacom/wacom-hid-descriptors/

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

On Thu, Nov 30, 2017 at 12:53 PM, Kevin Fenzi <kevin@scrye.com> wrote:
> On 11/29/2017 01:43 PM, Jason Gerecke wrote:
>> Hi Kevin,
>>
>> The Bluetooth and tablet issues are likely to be unrelated. The
>> Bluetooth button is completely independent from the rest of the
>> tablet, with neither the tablet sensor nor the Wacom driver being
>> aware of it.
>>
>>>From what I understand, in normal operation the Bluetooth button is
>> disconnected most of the time. When you press it, it briefly wakes up,
>> connects to the paired PC, appears as a keyboard, sends a key combo,
>> and then disconnects until you press it again. If you run something
>> like `sudo libinput-debug-events` and then press the button, you
>> should be able to see the key combo being sent (as well as the
>> connect/disconnect). I'm not sure what's up with the deadlock warning
>> that appears in dmesg, however...
>
> Ah, quite right. Sorry about that, this is my first device with a pen. I
> expected it to just connect and stay there, but I suppose doing things
> this way saves a ton of power since it's likely not writing most of the
> time.
>
>>
>> As for the tablet, the "last error =3D -121" indicates that we got an
>> EREMOTEIO error. I've not come across that particular error in this
>> function before. I'll need some time to track down why we might be
>> getting this from the lower layers.
>
> ok, thanks! If you need any more info from me just ask. Happy to test
> patches or gather more info.
>
> kevin
> --
>>
>> Jason
>> ---
>> Now instead of four in the eights place /
>> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
>> (That is to say, eight) to the two,     /
>> But you can=E2=80=99t take seven from three,    /
>> So you look at the sixty-fours....
>>
>>
>>
>> On Mon, Nov 27, 2017 at 12:23 PM, Kevin Fenzi <kevin@scrye.com> wrote:
>>> Greetings.
>>>
>>> I'm running into some problems with Lenovo active pen 2 and wacom table=
t
>>> on a new yoga 920.
>>>
>>> Filed:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1514837
>>>
>>> but I thought I would ask here if anyone had any ideas...
>>>
>>> Basically when pairing the pen it shows for a second, then drops:
>>>
>>> [Sat Nov 18 12:22:42 2017] input: Lenovo Active Pen2 as
>>> /devices/virtual/misc/uhid/0005:17EF:60A8.0006/input/input23
>>> [Sat Nov 18 12:22:42 2017] hid-generic 0005:17EF:60A8.0006:
>>> input,hidraw4: BLUETOOTH HID v0.02 Keyboard [Lenovo Active Pen2] on
>>> 64:6E:69:D1:A0:48
>>> [Sat Nov 18 12:22:47 2017] Bluetooth: hci0: last event is not cmd
>>> complete (0x0f)
>>> [Sat Nov 18 12:23:03 2017] Bluetooth: hci0: last event is not cmd
>>> complete (0x0f)
>>> [Sat Nov 18 12:23:19 2017] Bluetooth: hci0: last event is not cmd
>>> complete (0x0f)
>>>
>>> The wacom tablet is never connecting:
>>>
>>> [Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Pen as
>>> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00=
/0018:056A:5110.0003/input/input26
>>> [Fri Nov 24 21:47:01 2017] input: Wacom HID 5110 Finger as
>>> /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM5110:00=
/0018:056A:5110.0003/input/input27
>>> [Fri Nov 24 21:47:01 2017] wacom 0018:056A:5110.0003: hidraw3: I2C HID
>>> v1.00 Mouse [WCOM5110:00 056A:5110] on i2c-WCOM5110:00
>>> [Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
>>> report to device.
>>> [Fri Nov 24 21:47:02 2017] wacom 0018:056A:5110.0003: wacom_set_report:
>>> ran out of retries (last error =3D -121)
>>> [Fri Nov 24 21:47:02 2017] i2c_hid i2c-WCOM5110:00: failed to set a
>>> report to device.
>>>
>>> Happy to gather more info and/or try patches.
>>>
>>> Thanks.
>>>
>>> kevin
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
