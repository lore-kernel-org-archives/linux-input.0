From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: Input: add Atmel Atmegaxx captouch driver
Date: Fri, 6 May 2016 11:19:45 +0200
Message-ID: <572C61B1.2040508@atmel.com>
References: <1462295611-49684-1-git-send-email-grundler@chromium.org>
 <20160504135123.GA4567@rob-hp-laptop>
 <CANEJEGt1Ri7Q-g25U8_KTAb9Z8MfVWH0N5QLaLcdnDuF_wwrtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:12997 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbcEFJUE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2016 05:20:04 -0400
In-Reply-To: <CANEJEGt1Ri7Q-g25U8_KTAb9Z8MfVWH0N5QLaLcdnDuF_wwrtw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>, Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Hung-yu Wu <hywu@google.com>

Le 05/05/2016 18:04, Grant Grundler a =C3=A9crit :
> On Wed, May 4, 2016 at 6:51 AM, Rob Herring <robh@kernel.org> wrote:
> ...
>>> +Required properties:
>>> +
>>> +     compatible:     Must be "atmel,atmegaxx_captouch".
>>
>> No wildcards in the compatible strings. Use the specific devices.
>>
>> Also, use hyphen rather than underscore. However, if the device is o=
nly
>> a touch controller, then '_captouch' is not needed. The part number =
is
>> sufficient to identify the device.
>=20
> The primary part used on the board is AtMega88PA. Details of that SoC
> are public:
>     http://www.atmel.com/devices/ATMEGA88PA.aspx
>=20
> I don't see why the exact chip is relevant to the driver. The driver
> is just talking to an I2C device that reports button events.  The
> protocol across the I2C determines what this driver has to do and tha=
t
> protocol is implemented by the on-board firmware (supplied by Atmel).
> Any AVR CPU could implement this same protocol.
>=20
> Can we call this "atmel,qtouch-buttons-v2" or something like that?

Is it different from the Atmel QT1070 or QT2160 which have drivers
already available in Linux:
drivers/input/keyboard/qt1070.c

Bye,

> I personally don't have anything invested in any particular name. Fee=
l
> free to suggest a different one. I'm perfectly happy with any color
> paint on the shed.
>=20
> ...
>>> +Example:
>>> +
>>> +     atmegaxx_captouch@51 {
>>
>> atmegaxx@51 (with actual part number)
>=20
> Is "qtouch-buttons@51" ok?
>=20
>>
>>> +             compatible =3D "atmel,atmegaxx_captouch";
>>> +             reg =3D <0x51>;
>>> +             interrupt-parent =3D <&tlmm>;
>>> +             interrupts =3D <67 IRQ_TYPE_EDGE_FALLING>;
>>> +             linux,keycodes =3D <BTN_0>, <BTN_1>,
>>> +                     <BTN_2>, <BTN_3>,
>>> +                     <BTN_4>, <BTN_5>,
>>> +                     <BTN_6>, <BTN_7>;
>>> +             autorepeat;
>>> +     };
>=20
> cheers,
> grant
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
