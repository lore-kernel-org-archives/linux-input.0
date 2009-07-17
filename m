From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: Input : regression - touchpad not detected
Date: Fri, 17 Jul 2009 21:31:21 +0800
Message-ID: <a8e1da0907170631i435da8d1p4351654c5e116fcc@mail.gmail.com>
References: <a8e1da0907162213w13a5113dj556bb314e73fb19b@mail.gmail.com>
	 <alpine.LRH.2.00.0907171200350.27150@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:59935 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583AbZGQNbX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2009 09:31:23 -0400
In-Reply-To: <alpine.LRH.2.00.0907171200350.27150@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, Jul 17, 2009 at 6:01 PM, Jiri Kosina<jkosina@suse.cz> wrote:
> On Fri, 17 Jul 2009, Dave Young wrote:
>
>> Hi,
>>
>> since 2.6.31-rc3, sometimes the touchpad of my laptop will not be
>> detected, usually after reboot it will be there.
>>
>> I have no such problem with 2.6.31-rc2
>>
>> `dmesg|grep input` with touchpad detected:
>>
>> [ =C2=A0 =C2=A02.447119] input: Lid Switch as
>> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
>> [ =C2=A0 =C2=A02.458089] input: Power Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
>> [ =C2=A0 =C2=A02.459155] input: Sleep Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
>> [ =C2=A0 =C2=A03.093556] input: Video Bus as
>> /devices/LNXSYSTM:00/device:00/PNP0A03:00/device:33/input/input3
>> [ =C2=A0 =C2=A03.120647] input: Video Bus as
>> /devices/LNXSYSTM:00/device:00/PNP0A03:00/device:3b/input/input4
>> [ =C2=A0 =C2=A05.300364] input: AT Translated Set 2 keyboard as
>> /devices/platform/i8042/serio0/input/input5
>> [ =C2=A0 =C2=A05.669278] input: PS/2 Mouse as /devices/platform/i804=
2/serio1/input/input6
>> [ =C2=A0 =C2=A05.698278] input: AlpsPS/2 ALPS GlidePoint as
>> /devices/platform/i8042/serio1/input/input7
>>
>> `dmesg|grep input` without touchpad detected:
>>
>> [ =C2=A0 =C2=A02.454246] input: Lid Switch as
>> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
>> [ =C2=A0 =C2=A02.478038] input: Power Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
>> [ =C2=A0 =C2=A02.487538] input: Sleep Button as
>> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
>> [ =C2=A0 =C2=A03.118063] input: Video Bus as
>> /devices/LNXSYSTM:00/device:00/PNP0A03:00/device:33/input/input3
>> [ =C2=A0 =C2=A03.164064] input: Video Bus as
>> /devices/LNXSYSTM:00/device:00/PNP0A03:00/device:3b/input/input4
>> [ =C2=A0 =C2=A05.353006] input: AT Translated Set 2 keyboard as
>> /devices/platform/i8042/serio0/input/input5
>
> Providing the dmesg output with 'i8042.debug' kernel parameter in pla=
ce
> from the situation the TouchPad doesn't get detected might be helpful=
=2E

I did some test with i8042.debug param but did not get it. I will keep
an eye on this issue, if I encounter the bug again I will provide the
dmesg.

When I keep rebooting with ctrl+alt+del I have another problem,
sometimes there will be many kernel warnings about unknown key pressed
like following, after which the keyboard will be unusable, I means the
pressed-key changed promiscuously.

Apr 26 14:49:06 darkstar kernel: [    4.776903] atkbd.c: Unknown key
pressed (raw set 2, code 0xd3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    4.780095] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    4.946906] atkbd.c: Unknown key
pressed (raw set 2, code 0x1d3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    4.950187] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    5.000172] Clocksource tsc
unstable (delta =3D -214953565 ns)
Apr 26 14:49:06 darkstar kernel: [    5.216977] atkbd.c: Unknown key
pressed (raw set 2, code 0xd3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    5.220251] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    5.298545] VFS: Mounted root
(ext3 filesystem) readonly on device 8:2.
Apr 26 14:49:06 darkstar kernel: [    5.331958] atkbd.c: Unknown key
pressed (raw set 2, code 0x1d3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    5.335253] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    5.456971] atkbd.c: Unknown key
pressed (raw set 2, code 0xd3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    5.460252] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    5.546911] atkbd.c: Unknown key
pressed (raw set 2, code 0x1d3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    5.550189] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    5.756976] atkbd.c: Unknown key
pressed (raw set 2, code 0xd3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    5.760253] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    5.866754] atkbd.c: Unknown key
pressed (raw set 2, code 0x1d3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    5.870042] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    6.006971] atkbd.c: Unknown key
pressed (raw set 2, code 0xd3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    6.010250] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    6.106748] atkbd.c: Unknown key
pressed (raw set 2, code 0x1d3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    6.110031] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    6.216754] atkbd.c: Unknown key
pressed (raw set 2, code 0xd3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    6.220032] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.
Apr 26 14:49:06 darkstar kernel: [    6.296912] atkbd.c: Unknown key
pressed (raw set 2, code 0x1d3 on isa0060/serio0).
Apr 26 14:49:06 darkstar kernel: [    6.300189] atkbd.c: Use
'setkeycodes e053 <keycode>' to make it known.


>
> --
> Jiri Kosina
> SUSE Labs
>
>



--=20
Regards
dave
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
