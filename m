From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Have wacom_tpc_irq guard against possible
 NULL dereference
Date: Tue, 2 May 2017 14:04:12 -0700
Message-ID: <CANRwn3RdKs-NeuWD9=KBKKi_uJ_YQ9Mhd2OrvCegupZDhUvtcQ@mail.gmail.com>
References: <20170412203123.GA3915@mwanda> <20170425182956.15406-1-killertofu@gmail.com>
 <CAF8JNh+31UjTFzAEDGHACw7DhFMrTBGxgm=_ZoxP-8UAiq18vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34425 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEBVEN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 May 2017 17:04:13 -0400
Received: by mail-ua0-f194.google.com with SMTP id u40so2171801uaf.1
        for <linux-input@vger.kernel.org>; Tue, 02 May 2017 14:04:13 -0700 (PDT)
In-Reply-To: <CAF8JNh+31UjTFzAEDGHACw7DhFMrTBGxgm=_ZoxP-8UAiq18vg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Just making sure this doesn't get lost in the cracks.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Tue, Apr 25, 2017 at 1:56 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Tuesday, April 25, 2017, Jason Gerecke <killertofu@gmail.com> wrote:
>>
>> The following Smatch complaint was generated in response to commit
>> 2a6cdbd ("HID: wacom: Introduce new 'touch_input' device"):
>>
>>     drivers/hid/wacom_wac.c:1586 wacom_tpc_irq()
>>              error: we previously assumed 'wacom->touch_input' could be =
null (see line 1577)
>>
>> The 'touch_input' and 'pen_input' variables point to the 'struct input_d=
ev'
>> used for relaying touch and pen events to userspace, respectively. If a
>> device does not have a touch interface or pen interface, the associated
>> input variable is NULL. The 'wacom_tpc_irq()' function is responsible fo=
r
>> forwarding input reports to a more-specific IRQ handler function. An
>> unknown report could theoretically be mistaken as e.g. a touch report
>> on a device which does not have a touch interface. This can be prevented
>> by only calling the pen/touch functions are called when the pen/touch
>> pointers are valid.
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
>
> Looks good to me.
>
> Cheers,
> Ping
>
>>
>> ---
>>  drivers/hid/wacom_wac.c | 45 +++++++++++++++++++++++-------------------=
---
>>  1 file changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index 6b8f6b816195..b963499e3351 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -1571,37 +1571,38 @@ static int wacom_tpc_irq(struct wacom_wac *wacom=
, size_t len)
>>  {
>>         unsigned char *data =3D wacom->data;
>>
>> -       if (wacom->pen_input)
>> +       if (wacom->pen_input) {
>>                 dev_dbg(wacom->pen_input->dev.parent,
>>                         "%s: received report #%d\n", __func__, data[0]);
>> -       else if (wacom->touch_input)
>> +
>> +               if (len =3D=3D WACOM_PKGLEN_PENABLED ||
>> +                   data[0] =3D=3D WACOM_REPORT_PENABLED)
>> +                       return wacom_tpc_pen(wacom);
>> +       }
>> +       else if (wacom->touch_input) {
>>                 dev_dbg(wacom->touch_input->dev.parent,
>>                         "%s: received report #%d\n", __func__, data[0]);
>>
>> -       switch (len) {
>> -       case WACOM_PKGLEN_TPC1FG:
>> -               return wacom_tpc_single_touch(wacom, len);
>> +               switch (len) {
>> +               case WACOM_PKGLEN_TPC1FG:
>> +                       return wacom_tpc_single_touch(wacom, len);
>>
>> -       case WACOM_PKGLEN_TPC2FG:
>> -               return wacom_tpc_mt_touch(wacom);
>> +               case WACOM_PKGLEN_TPC2FG:
>> +                       return wacom_tpc_mt_touch(wacom);
>>
>> -       case WACOM_PKGLEN_PENABLED:
>> -               return wacom_tpc_pen(wacom);
>> +               default:
>> +                       switch (data[0]) {
>> +                       case WACOM_REPORT_TPC1FG:
>> +                       case WACOM_REPORT_TPCHID:
>> +                       case WACOM_REPORT_TPCST:
>> +                       case WACOM_REPORT_TPC1FGE:
>> +                               return wacom_tpc_single_touch(wacom, len=
);
>>
>> -       default:
>> -               switch (data[0]) {
>> -               case WACOM_REPORT_TPC1FG:
>> -               case WACOM_REPORT_TPCHID:
>> -               case WACOM_REPORT_TPCST:
>> -               case WACOM_REPORT_TPC1FGE:
>> -                       return wacom_tpc_single_touch(wacom, len);
>> -
>> -               case WACOM_REPORT_TPCMT:
>> -               case WACOM_REPORT_TPCMT2:
>> -                       return wacom_mt_touch(wacom);
>> +                       case WACOM_REPORT_TPCMT:
>> +                       case WACOM_REPORT_TPCMT2:
>> +                               return wacom_mt_touch(wacom);
>>
>> -               case WACOM_REPORT_PENABLED:
>> -                       return wacom_tpc_pen(wacom);
>> +                       }
>>                 }
>>         }
>>
>> --
>> 2.12.2
>>
