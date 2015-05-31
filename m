From: Hans de Goede <hdegoede@redhat.com>
Subject: Re:
Date: Sun, 31 May 2015 17:53:22 +0200
Message-ID: <556B2E72.5020508@redhat.com>
References: <E1Yz4NQ-0000Cw-B5@feisty.vs19.net> <20150531183740.17593bd3@v1ron-s7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52578 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494AbbEaPx2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2015 11:53:28 -0400
In-Reply-To: <20150531183740.17593bd3@v1ron-s7>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roman Volkov <rvolkov@v1ros.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Prisk <linux@prisktech.co.nz>

Hi Roman,

On 31-05-15 17:37, Roman Volkov wrote:
> =D0=92 Sat, 14 Mar 2015 20:20:38 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>>
>> Hi Roman,
>>
>> On Mon, Feb 16, 2015 at 12:11:43AM +0300, Roman Volkov wrote:
>>> Documentation for 'intel,8042' DT compatible node.
>>>
>>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>>> Signed-off-by: Roman Volkov <v1ron@v1ros.org>
>>> ---
>>>   .../devicetree/bindings/input/intel-8042.txt       | 26
>>> ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/input/intel-8042.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt
>>> b/Documentation/devicetree/bindings/input/intel-8042.txt new file
>>> mode 100644 index 0000000..ab8a3e0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
>>> @@ -0,0 +1,26 @@
>>> +Intel 8042 Keyboard Controller
>>> +
>>> +Required properties:
>>> +- compatible: should be "intel,8042"
>>> +- regs: memory for keyboard controller
>>> +- interrupts: usually, two interrupts should be specified
>>> (keyboard and aux).
>>> +	However, only one interrupt is also allowed in case of
>>> absence of the
>>> +	physical port in the controller. The i8042 driver must be
>>> loaded with
>>> +	nokbd/noaux option in this case.
>>> +- interrupt-names: interrupt names corresponding to numbers in the
>>> list.
>>> +	"kbd" is the keyboard interrupt and "aux" is the auxiliary
>>> (mouse)
>>> +	interrupt.
>>> +- command-reg: offset in memory for command register
>>> +- status-reg: offset in memory for status register
>>> +- data-reg: offset in memory for data register
>>> +
>>> +Example:
>>> +	i8042@d8008800 {
>>> +		compatible =3D "intel,8042";
>>> +		regs =3D <0xd8008800 0x100>;
>>> +		interrupts =3D <23>, <4>;
>>> +		interrupt-names =3D "kbd", "aux";
>>> +		command-reg =3D <0x04>;
>>> +		status-reg =3D <0x04>;
>>> +		data-reg =3D <0x00>;
>>> +	};
>>
>> No, we already have existing OF bindings for i8042 on sparc and
>> powerpc, I do not think we need to invent a brand new one.
>>
>> Thanks.
>>
>
> Hi Dmitry,
>
> I see some OF code in i8042-sparcio.h file. There are node definition=
s
> like "kb_ps2", "keyboard", "kdmouse", "mouse". Are these documented
> somewhere?
>
> Great if vt8500 is not unique with OF bindings for i8042. The code fr=
om
> sparc even looks compatible, only register offsets are hardcoded for
> specific machine. Is it possible to read offsets from Device Tree usi=
ng
> these existing bindings without dealing with the kernel configuration=
?

Have you looked at the existing bindings for ps/2 controllers
under Documentation/devicetree/bindings/serio ?

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
