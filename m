From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: Re: [PATCH v2 0/4] Read battery voltage from G403 and G900 mice
Date: Wed, 5 Jun 2019 19:41:56 -0400
Message-ID: <EEC01F32-27A7-4C05-B82C-27ADD6591F3E@pedrovanzella.com>
References: <20190605194533.18717-1-pedro@pedrovanzella.com> <0d998fe0ff4473be2a9341c1f5ddf55957d18ad8.camel@archlinux.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0d998fe0ff4473be2a9341c1f5ddf55957d18ad8.camel@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


> On Jun 5, 2019, at 6:24 PM, Filipe La=C3=ADns <lains@archlinux.org> wrote:=

>=20
>> On Wed, 2019-06-05 at 15:45 -0400, Pedro Vanzella wrote:
>> The gaming line of Logitech devices doesn't use the old hidpp20
>> feature
>> for battery level reporting. Instead, they report the current voltage
>> of the battery, in millivolts.
>>=20
>> This patch set handles this case by adding a quirk to the devices we
>> know
>> to have this new feature, in both wired and wireless mode.
>>=20
>> This version of the patch set is better split, as well as adding the
>> quirk to make sure we don't needlessly probe every device connected.
>>=20
>> Pedro Vanzella (4):
>>  HID: hid-logitech-hidpp: add quirk to handle battery voltage
>>  HID: hid-logitech-hidpp: add function to query battery voltage
>>  HID: hid-logitech-hidpp: report battery voltage to the power supply
>>  HID: hid-logitech-hidpp: subscribe to battery voltage events
>>=20
>> drivers/hid/hid-logitech-hidpp.c | 150
>> ++++++++++++++++++++++++++++++-
>> 1 file changed, 147 insertions(+), 3 deletions(-)
>>=20
>=20
> Hello,
>=20
> Why using quirks? 0x1001 is a feature, it should be discoverable in
> IFeatureSet (0x0001). I don't understand the need to hardcode the
> supported devices, HID++ exists specifically to prevent that.
>=20
> Wasn't this what you started in your previous patch? Why move away from
> it?

I was asked to change to conform to the way the other features were handled.=
 I=E2=80=99ll let the maintainers decide, but I agree with you that the othe=
r way was better.

In fact, since the kernel only needs to support about half a dozen features,=
 we could refactor the probe function to, well, probe the device for those f=
eatures and set the capability flags. It looks to me like that would be clea=
ner and easier to extend (and would make it easier to support future devices=
).

> Thank you,
> Filipe La=C3=ADns
> 3DCE 51D6 0930 EBA4 7858 BA41 46F6 33CB B0EB 4BF2
