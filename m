From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] drivers: Adding driver support for "One by Wacom
 CTL472/672" (parameters transferred from CTL471/671 since only difference is
 the force resolution)
Date: Wed, 11 Oct 2017 08:11:20 -0700
Message-ID: <CANRwn3SDQar=gT-M1_hPenv0pzsGTy6Wj1HjW+0z+OigXFtvTQ@mail.gmail.com>
References: <SG2PR03MB1519A67D9FD33585E560743DD9770@SG2PR03MB1519.apcprd03.prod.outlook.com>
 <nycvar.YFH.7.76.1710111524210.14384@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1710111524210.14384@jbgna.fhfr.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, ? ?? <jingmingxuan@outlook.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 11, 2017 at 6:24 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Sun, 8 Oct 2017, ? ?? wrote:
>
>> Signed-off-by: Mx Jing <jingmingxuan@outlook.com>
>
> Changelog is missing, please provide one.
>
> Adding Jason and Ping to CC.
>

A few inline nits:

>> ---
>>  drivers/hid/wacom_wac.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index aa692e28b2cd..920f3d6bbc71 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -4376,6 +4376,12 @@ static const struct wacom_features wacom_features=
_0x360 =3D
>>  static const struct wacom_features wacom_features_0x361 =3D
>>       { "Wacom Intuos Pro L", 62200, 43200, 8191, 63,
>>         INTUOSP2_BT, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max=
 =3D 10 };
>> +static const struct wacom_features wacom_features_0x37A =3D
>> +     { "One by Wacom CTL472", 14720, 9225, 2047, 63,

Replace "CTL472" in name with "S". Resolution should be 15200 x 9500,
not 14720 x 9225.

>> +       BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>> +static const struct wacom_features wacom_features_0x37B =3D
>> +     { "One by Wacom CTL672", 21648, 13530, 2047, 63,

Replace "CTL672" in name with "M". Resolution should be 21600 x 13500,
not 21648 x 13530.

>> +       BAMBOO_PEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>>

Nits aside, this seems reasonable:

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>>  static const struct wacom_features wacom_features_HID_ANY_ID =3D
>>       { "Wacom HID", .type =3D HID_GENERIC, .oVid =3D HID_ANY_ID, .oPid =
=3D HID_ANY_ID };
>> @@ -4544,6 +4550,8 @@ const struct hid_device_id wacom_ids[] =3D {
>>       { USB_DEVICE_WACOM(0x343) },
>>       { BT_DEVICE_WACOM(0x360) },
>>       { BT_DEVICE_WACOM(0x361) },
>> +     { USB_DEVICE_WACOM(0x37A) },
>> +     { USB_DEVICE_WACOM(0x37B) },
>>       { USB_DEVICE_WACOM(0x4001) },
>>       { USB_DEVICE_WACOM(0x4004) },
>>       { USB_DEVICE_WACOM(0x5000) },
>> --
>> 2.11.0
>>
>
> --
> Jiri Kosina
> SUSE Labs
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
