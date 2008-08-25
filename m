From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: Re: [regression] LID switch and /dev/input/event*
Date: Mon, 25 Aug 2008 08:47:04 +0200
Message-ID: <48B25568.8060901@freemail.hu>
References: <48B0849B.7070800@freemail.hu> <1219626707.4116.6.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail02d.mail.t-online.hu ([84.2.42.7]:59599 "EHLO
	mail02d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbYHYG4A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2008 02:56:00 -0400
In-Reply-To: <1219626707.4116.6.camel@yakui_zhao.sh.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-input@vger.kernel.org

Zhao Yakui wrote:
> On Sat, 2008-08-23 at 23:43 +0200, N=C3=A9meth M=C3=A1rton wrote:
>> Hi,
>>
>> I am using Linux 2.6.27-rc4 on Clevo D410J laptop and the I can
>> query the LID switch state like this:
>>
>> # cat /proc/acpi/button/lid/LID/state
>> state:      open
>> # cat /proc/acpi/button/lid/LID/state
>> state:      closed
>>
>> If I check the event4, I get no events when the LID switch is pushed=
:
>>
>> # evtest /dev/input/event4
>> Input driver version is 1.0.0
>> Input device ID: bus 0x19 vendor 0x0 product 0x5 version 0x0
>> Input device name: "Lid Switch"
>> Supported events:
>>   Event type 0 (Sync)
>>   Event type 5 (?)
>>     Event code 0 (?)
>> Testing ... (interrupt to exit)
> It seems that the status of LID device is correct, but there is no LI=
D
> input event. Right?
> Will you please enable the CONFIG_ACPI_DEBUG in kernel configuration =
and
> boot the system with the option of "acpi.debug_layer=3D0x00090004
> acpi.debug_level=3D0x01f"?=20
> After pressing the LID switch several times, please attach the output=
 of
> dmesg.
>=20
> It will be great if you can attach the output of acpidump.
>=20
> Of course you can open a new bug in bugzilla and attach the output of
> dmesg, acpidump.
>=20
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
>=20
> Thanks.

What I could find out since then is that the Linux kernel 2.6.25 is
working correctly, but 2.6.26-rc3 is bad. I am about to "git bisect"
the problem and I'll create a bugreport and provide the asked informati=
on.
This will take some time, however, as I am currently busy with differen=
t
topics.

>> The events are only reported if I suspend to RAM with "s2ram -f -p -=
s". I did
>> the following steps:
>>
>> 1. Execute "s2ram -f -p -s". Now the system suspends to RAM.
>> 2. Push the LID switch and hold it down.
>> 3. Wake the system with the POWER button.
>> 4. After the system is up, release the LID switch to see the screen.
>> 5. "evtest" reports the following line:
>>
>> Event: time 1219526119.163805, type 5 (?), code 0 (?), value 1
>>
>> 6. Execute "s2ram -f -p -s" again.
>> 7. Wake the system with the POWER button.
>> 8. "evtest" reports the following line:
>>
>> Event: time 1219526913.208803, type 5 (?), code 0 (?), value 0
>>
>> 	M=C3=A1rton N=C3=A9meth
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
