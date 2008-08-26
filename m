From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: Re: [regression] LID switch and /dev/input/event*
Date: Tue, 26 Aug 2008 07:29:33 +0200
Message-ID: <48B394BD.6080407@freemail.hu>
References: <48B0849B.7070800@freemail.hu> <1219626707.4116.6.camel@yakui_zhao.sh.intel.com> <48B25568.8060901@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail00a.mail.t-online.hu ([84.2.40.5]:57028 "EHLO
	mail00a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYHZF3o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2008 01:29:44 -0400
In-Reply-To: <48B25568.8060901@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-input@vger.kernel.org

N=C3=A9meth M=C3=A1rton wrote:
> Zhao Yakui wrote:
>> On Sat, 2008-08-23 at 23:43 +0200, N=C3=A9meth M=C3=A1rton wrote:
>>> Hi,
>>>
>>> I am using Linux 2.6.27-rc4 on Clevo D410J laptop and the I can
>>> query the LID switch state like this:
>>>
>>> # cat /proc/acpi/button/lid/LID/state
>>> state:      open
>>> # cat /proc/acpi/button/lid/LID/state
>>> state:      closed
>>>
>>> If I check the event4, I get no events when the LID switch is pushe=
d:
>>>
>>> # evtest /dev/input/event4
>>> Input driver version is 1.0.0
>>> Input device ID: bus 0x19 vendor 0x0 product 0x5 version 0x0
>>> Input device name: "Lid Switch"
>>> Supported events:
>>>   Event type 0 (Sync)
>>>   Event type 5 (?)
>>>     Event code 0 (?)
>>> Testing ... (interrupt to exit)
>> It seems that the status of LID device is correct, but there is no L=
ID
>> input event. Right?
>> Will you please enable the CONFIG_ACPI_DEBUG in kernel configuration=
 and
>> boot the system with the option of "acpi.debug_layer=3D0x00090004
>> acpi.debug_level=3D0x01f"?=20
>> After pressing the LID switch several times, please attach the outpu=
t of
>> dmesg.
>>
>> It will be great if you can attach the output of acpidump.
>>
>> Of course you can open a new bug in bugzilla and attach the output o=
f
>> dmesg, acpidump.
>>
>> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
>>
>> Thanks.
>=20
> What I could find out since then is that the Linux kernel 2.6.25 is
> working correctly, but 2.6.26-rc3 is bad. I am about to "git bisect"
> the problem and I'll create a bugreport and provide the asked informa=
tion.
> This will take some time, however, as I am currently busy with differ=
ent
> topics.

Bug report was created: http://bugzilla.kernel.org/show_bug.cgi?id=3D11=
428


>>> The events are only reported if I suspend to RAM with "s2ram -f -p =
-s". I did
>>> the following steps:
>>>
>>> 1. Execute "s2ram -f -p -s". Now the system suspends to RAM.
>>> 2. Push the LID switch and hold it down.
>>> 3. Wake the system with the POWER button.
>>> 4. After the system is up, release the LID switch to see the screen=
=2E
>>> 5. "evtest" reports the following line:
>>>
>>> Event: time 1219526119.163805, type 5 (?), code 0 (?), value 1
>>>
>>> 6. Execute "s2ram -f -p -s" again.
>>> 7. Wake the system with the POWER button.
>>> 8. "evtest" reports the following line:
>>>
>>> Event: time 1219526913.208803, type 5 (?), code 0 (?), value 0
>>>
>>> 	M=C3=A1rton N=C3=A9meth
>>>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
