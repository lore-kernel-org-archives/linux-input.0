From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/7] HID: wacom: Move handling of Intuos status packets
 to seperate function
Date: Tue, 10 Mar 2015 09:22:46 -0700
Message-ID: <54FF1A56.5000809@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com> <CAF8JNh+GiqBTWZsPsPi9QgQiVJs5EO0f0ADCL_qEn3O4SwutbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46885 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbbCJQWu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 12:22:50 -0400
Received: by pabli10 with SMTP id li10so3399988pab.13
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2015 09:22:50 -0700 (PDT)
In-Reply-To: <CAF8JNh+GiqBTWZsPsPi9QgQiVJs5EO0f0ADCL_qEn3O4SwutbQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 3/9/2015 6:31 PM, Ping Cheng wrote:
> On Fri, Mar 6, 2015 at 11:47 AM, Jason Gerecke <killertofu@gmail.com>=
 wrote:
>> In addition to the touchswitch state for "Intuos", these packets are
>> also sent by the Intuos Pro, Intuos5, and last-generation Bamboo
>> tablets when using a wired connection. They contain, among other
>> things, information about the optional wireless module and battery
>> charge state (to be supported in subsuquent patches).
>>
>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>> ---
>>   drivers/hid/wacom_wac.c | 36 +++++++++++++++++++++++-------------
>>   drivers/hid/wacom_wac.h |  1 +
>>   2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index bbf72f9..cb308c5 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -1740,20 +1740,9 @@ static int wacom_bpt_pen(struct wacom_wac *wa=
com)
>>          unsigned char *data =3D wacom->data;
>>          int prox =3D 0, x =3D 0, y =3D 0, p =3D 0, d =3D 0, pen =3D=
 0, btn1 =3D 0, btn2 =3D 0;
>>
>> -       if (data[0] !=3D WACOM_REPORT_PENABLED && data[0] !=3D WACOM=
_REPORT_USB)
>> +       if (data[0] !=3D WACOM_REPORT_PENABLED)
>>              return 0;
>>
>> -       if (data[0] =3D=3D WACOM_REPORT_USB) {
>> -               if (features->type =3D=3D INTUOSHT &&
>> -                   wacom->shared->touch_input &&
>> -                   features->touch_max) {
>> -                       input_report_switch(wacom->shared->touch_inp=
ut,
>> -                                           SW_MUTE_DEVICE, data[8] =
& 0x40);
>> -                       input_sync(wacom->shared->touch_input);
>> -               }
>> -               return 0;
>> -       }
>> -
>>          prox =3D (data[1] & 0x20) =3D=3D 0x20;
>>
>>          /*
>> @@ -1960,6 +1949,24 @@ static int wacom_wireless_irq(struct wacom_wa=
c *wacom, size_t len)
>>          return 0;
>>   }
>>
>> +static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len=
)
>> +{
>> +       struct wacom_features *features =3D &wacom_wac->features;
>> +       unsigned char *data =3D wacom_wac->data;
>> +
>> +       if (data[0] !=3D WACOM_REPORT_USB)
>> +               return 0;
>> +
>> +       if (features->type =3D=3D INTUOSHT &&
>> +           wacom_wac->shared->touch_input &&
>> +           features->touch_max) {
>> +               input_report_switch(wacom_wac->shared->touch_input,
>> +                                   SW_MUTE_DEVICE, data[8] & 0x40);
>> +               input_sync(wacom_wac->shared->touch_input);
>> +       }
>> +       return 0;
>> +}
>> +
>>   void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>>   {
>>          bool sync;
>> @@ -2044,7 +2051,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wa=
c, size_t len)
>>
>>          case BAMBOO_PT:
>>          case INTUOSHT:
>> -               sync =3D wacom_bpt_irq(wacom_wac, len);
>> +               if (wacom_wac->data[0] =3D=3D WACOM_REPORT_USB)
>> +                       sync =3D wacom_status_irq(wacom_wac, len);
>> +               else
>> +                       sync =3D wacom_bpt_irq(wacom_wac, len);
>>                  break;
>>
>>          case BAMBOO_PAD:
>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> index a3d0828..ee6a545 100644
>> --- a/drivers/hid/wacom_wac.h
>> +++ b/drivers/hid/wacom_wac.h
>> @@ -71,6 +71,7 @@
>>   #define WACOM_REPORT_USB               192
>>   #define WACOM_REPORT_BPAD_PEN          3
>>   #define WACOM_REPORT_BPAD_TOUCH                16
>> +#define WACOM_PKGLEN_STATUS            10
>
> I don't see anywhere else WACOM_PKGLEN_STATUS is used. Do I miss some=
thing?
>
Good catch. That's leftover cruft from an earlier revision which is not=
=20
necessary anymore. I'll resubmit this patch with the hunk removed.

> Except that, the patchset looks good.
>
> Acked-by: Ping Cheng <pinbgc@wacom.com>
>
> Ping
>
Speaking of small mistakes... s/pinbgc/pingc/ :)

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>>   /* device quirks */
>>   #define WACOM_QUIRK_MULTI_INPUT                0x0001
>> --
>> 2.3.0
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
