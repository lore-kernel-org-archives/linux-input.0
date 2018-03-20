From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devices
Date: Tue, 20 Mar 2018 11:47:26 -0700
Message-ID: <CAKdAkRRjMrpdjuaivh-5bKCCgYpcySqDCKzbuvso1_x_+Qkp1w@mail.gmail.com>
References: <20171115063404.10066-1-aaron.ma@canonical.com>
 <20171115083529.jmlpcj4td4evj3xl@pali> <TYXPR01MB07195A0116F835764DE99882C72E0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180129225138.voujq54itw7yblbi@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180129225138.voujq54itw7yblbi@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aaron Ma <aaron.ma@canonical.com>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 29, 2018 at 2:51 PM, dmitry.torokhov@gmail.com
<dmitry.torokhov@gmail.com> wrote:
> Hi,
>
> On Thu, Nov 16, 2017 at 07:27:02AM +0000, Masaki Ota wrote:
>> Hi, Pali, Aaron,
>>
>> Current code is correct device setting, previous code is wrong.
>> If the trackstick does not work(DUALPOINT flag disable), Device Firmware=
 setting is wrong.
>>
>> But recently I received the same report from Thinkpad L570 user, and I c=
hecked this device and found this device Firmware setting is wrong. Sorry f=
or our mistake.
>> Is your laptop L570 ?
>>
>> I will add code that supports the trackstick for this device.
>
> Sorry for resurrecting this old thread, I am just trying to understand
> what went wrong here. Is the sequence of "f0 f0 e9" and "ea ea e9" is
> important in getting the correct OTP data and we originally got this
> order wrong? It is not clear from the original patch and discussion that
> this change was intentional.

Could I please get an answer to my question?

Thanks!

>
> Thanks.
>
>>
>> Best Regards,
>> Masaki Ota
>> -----Original Message-----
>> From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
>> Sent: Wednesday, November 15, 2017 5:35 PM
>> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps=
.com>
>> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; dmitry.to=
rokhov@gmail.com; Aaron Ma <aaron.ma@canonical.com>
>> Subject: Re: [PATCH] Input: ALPS - fix DualPoint flag for 74 03 28 devic=
es
>>
>> On Wednesday 15 November 2017 14:34:04 Aaron Ma wrote:
>> > There is a regression of commit 4a646580f793 ("Input: ALPS - fix
>> > two-finger scroll breakage"), ALPS device fails with log:
>> >
>> > psmouse serio1: alps: Rejected trackstick packet from non DualPoint
>> > device
>> >
>> > ALPS device with id "74 03 28" report OTP[0] data 0xCE after commit
>> > 4a646580f793, after restore the OTP reading order, it becomes to 0x10
>> > as before and reports the right flag.
>> >
>> > Fixes: 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage")
>> > Cc: <stable@vger.kernel.org>
>> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> > ---
>> >  drivers/input/mouse/alps.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> > index 579b899add26..c59b8f7ca2fc 100644
>> > --- a/drivers/input/mouse/alps.c
>> > +++ b/drivers/input/mouse/alps.c
>> > @@ -2562,8 +2562,8 @@ static int alps_set_defaults_ss4_v2(struct
>> > psmouse *psmouse,
>> >
>> >     memset(otp, 0, sizeof(otp));
>> >
>> > -   if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
>> > -       alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
>> > +   if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
>> > +       alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
>> >             return -1;
>> >
>> >     alps_update_device_area_ss4_v2(otp, priv);
>>
>> Masaki Ota, please look at this patch as it partially revert your commit
>> 4a646580f793 ("Input: ALPS - fix two-finger scroll breakage"). Something=
 smells here.
>>
>> --
>> Pali Roh=C3=A1r
>> pali.rohar@gmail.com
>
> --
> Dmitry



--=20
Dmitry
