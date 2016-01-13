From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: Re: [PATCH RESEND 2/2] Input: Documentation and MAINTAINERS parts.
Date: Wed, 13 Jan 2016 10:06:36 +0200
Message-ID: <5696058C.8070608@nextfour.com>
References: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
 <1452664315-28078-5-git-send-email-mika.penttila@nextfour.com>
 <CAKdAkRQyU0jtUP3AAwKTu+-ncPfwBj6uRYmyudTCzcGf8dTFbg@mail.gmail.com>
 <5695F6FE.5050407@nextfour.com> <20160113071325.GC8906@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-am1on0069.outbound.protection.outlook.com ([157.56.112.69]:64192
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753898AbcAMIVB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 03:21:01 -0500
In-Reply-To: <20160113071325.GC8906@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?UTF-8?B?5pu+5am36JGzICh0YW1teV90c2VuZyk=?= <tammy_tseng@sis.com>, =?UTF-8?B?5ri45pOx6LGqICh5dWdlcl95dSk=?= <yuger_yu@sis.com>

On 01/13/2016 09:13 AM, Dmitry Torokhov wrote:
> On Wed, Jan 13, 2016 at 09:04:30AM +0200, Mika Penttil=E4 wrote:
>> Hi,
>>
>> On 01/13/2016 08:47 AM, Dmitry Torokhov wrote:
>>> Hi Mika,
>>>
>>> On Tue, Jan 12, 2016 at 9:51 PM,  <mika.penttila@nextfour.com> wrot=
e:
>>>> From: Mika Penttil=E4 <mika.penttila@nextfour.com>
>>>>
>>>> ---
>>>>  .../bindings/input/touchscreen/sis_i2c.txt         | 22 +++++++++=
+++++++++++++
>>>>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>>>  MAINTAINERS                                        |  7 +++++++
>>>>  3 files changed, 30 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/input/touchs=
creen/sis_i2c.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/s=
is_i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/sis_i2=
c.txt
>>>> new file mode 100644
>>>> index 0000000..b0e9980
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/sis_i2c.=
txt
>>>> @@ -0,0 +1,22 @@
>>>> +* SiS I2C Multiple Touch Controller
>>>> +
>>>> +Required properties:
>>>> +- compatible: must be "sis,9200_ts"
>>>> +- reg: i2c slave address
>>>> +- interrupt-parent: the phandle for the interrupt controller
>>>> +- interrupts: touch controller interrupt
>>>> +- irq-gpios: the gpio pin used as irq pin
>>>> +- reset-gpios: the gpio pin used to reset the controller
>>>> +
>>>> +Example:
>>>> +
>>>> +       sis9255@5c  {
>>>> +                compatible =3D "sis,9200_ts";
>>>> +                reg =3D <0x5c>;
>>>> +                pinctrl-names =3D "default";
>>>> +                pinctrl-0 =3D <&pinctrl_sis>;
>>>> +                interrupt-parent =3D <&gpio3>;
>>>> +                interrupts =3D <19 2>;
>>>> +                irq-gpios =3D <&gpio3 19 0>;
>>>> +                reset-gpios =3D <&gpio2 30 0>;
>>>> +       };
>>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt=
 b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> index 55df1d4..a6ed5f9 100644
>>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>>> @@ -207,6 +207,7 @@ simtek
>>>>  sii    Seiko Instruments, Inc.
>>>>  silergy        Silergy Corp.
>>>>  sirf   SiRF Technology, Inc.
>>>> +sis    Silicon Integrated Systems Corp.
>>>>  sitronix       Sitronix Technology Corporation
>>>>  skyworks       Skyworks Solutions, Inc.
>>>>  smsc   Standard Microsystems Corporation
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 233f834..fbf9470 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -9809,6 +9809,13 @@ L:       netdev@vger.kernel.org
>>>>  S:     Maintained
>>>>  F:     drivers/net/ethernet/sis/sis900.*
>>>>
>>>> +SIS 9200 I2C TOUCHSCREEN DRIVER
>>>> +M:     Mika Penttil=E4 <mika.penttila@nextfour.com>
>>>> +L:     linux-input@vger.kernel.org
>>>> +S:     Maintained
>>>> +F:     Documentation/devicetree/bindings/input/touchscreen/sis_i2=
c.txt
>>>> +F:     drivers/input/touchscreen/sis_i2c.c
>>>
>>> I have seen (and reviewed) the driver for the same part posted by S=
IS
>>> folks, are you working with them?
>>>
>>> Thanks.
>>>
>>
>> We are an independent company from SiS and using sis controller in o=
ur
>> product and have communicated privately with SiS wrt driver. I didn'=
t
>> see their very first posting while developing this, but later ones y=
es
>> and I think this version is right wrt multitouch protocol B handling=
,
>> doesn't keep special private state etc.
>>
>> We would like to see this mainlined soon so whichever route is best =
is
>> ok for me. I have the time now and can actively work on this towards
>> inclusion with the support of SiS folks. If ok would be nice to get
>> signed-of-bys's from SiS also.
>=20
> As long as you are not butting heads with them over the same codebase=
 I
> am fine with either option. I'll take a look at your version in a day=
 or
> so, and I will expect you work with SiS folks on the next version.
>=20
> Ultimately it would be the best if SiS maintains the code once it is
> in mainline so they can keep adding support for newer hardware.
>=20
> Thanks.
>=20

Yes, sounds ok to me,

Thanks,
Mika

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
