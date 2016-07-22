From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for Cintiqs
 and similar
Date: Fri, 22 Jul 2016 11:58:46 -0700
Message-ID: <CAKdAkRQoi-dafMtgNi6frEL6n+w1mRXmHgMDWy0jzHa2XNq4Hg@mail.gmail.com>
References: <20160711180711.17537-1-killertofu@gmail.com> <20160712073653.GF4663@mail.corp.redhat.com>
 <70d3efd5-0e6c-743d-e962-967210ecd753@gmail.com> <20160722090917.GB19383@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34603 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbcGVS6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2016 14:58:48 -0400
Received: by mail-vk0-f65.google.com with SMTP id w127so9663421vkh.1
        for <linux-input@vger.kernel.org>; Fri, 22 Jul 2016 11:58:48 -0700 (PDT)
In-Reply-To: <20160722090917.GB19383@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jason Gerecke <killertofu@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, Jul 22, 2016 at 2:09 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Jul 20 2016 or thereabouts, Jason Gerecke wrote:
>> On 07/12/2016 12:36 AM, Benjamin Tissoires wrote:
>> > On Jul 11 2016 or thereabouts, Jason Gerecke wrote:
>> >> "Direct" input deviecs like Cintiqs and Tablet PCs set the INPUT_=
PROP_DIRECT
>> >> property to notify userspace that the sensor and screen are overl=
ayed. This
>> >> information can also be useful elsewhere within the kernel driver=
, however,
>> >> so we introduce a new WACOM_DEVICETYPE_DIRECT that signals this t=
o other
>> >> kernel code.
>> >>
>> >> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> >> ---
>> >>  drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++-----------=
-----
>> >>  drivers/hid/wacom_wac.h |  1 +
>> >>  2 files changed, 25 insertions(+), 16 deletions(-)
>> >>
>> >> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> >> index e499cdb..2523a29 100644
>> >> --- a/drivers/hid/wacom_wac.c
>> >> +++ b/drivers/hid/wacom_wac.c
>> >> @@ -1757,8 +1757,10 @@ void wacom_wac_usage_mapping(struct hid_de=
vice *hdev,
>> >>  {
>> >>    struct wacom *wacom =3D hid_get_drvdata(hdev);
>> >>    struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> >> +  struct wacom_features *features =3D &wacom_wac->features;
>> >>
>> >>    /* currently, only direct devices have proper hid report descr=
iptors */
>> >> +  features->device_type |=3D WACOM_DEVICETYPE_DIRECT;
>> >>    __set_bit(INPUT_PROP_DIRECT, wacom_wac->pen_input->propbit);
>> >>    __set_bit(INPUT_PROP_DIRECT, wacom_wac->touch_input->propbit);
>> >
>> > nitpick: you might as well remove these additions of INPUT_PROP_DI=
RECT,
>> > as you are handling the test later and adding them no matter what.
>> >
>>
>> Are you seeing something I'm missing? The new calls in
>> wacom_setup_{pen,touch}_input_capabilities that setup INPUT_PROP_DIR=
ECT
>> won't be called for HID_GENERIC devices since we bail out at the top=
 of
>
> Oh, yes, you are right.
>
>> the functions. Perhaps you'd prefer me to move their setting of
>> INPUT_PROP_DIRECT to before the point we bail, letting me remove the=
m
>> from here?
>
> I think it would be better to set the flag in wacom_wac_usage_mapping=
()
> and rely on this flag to set INPUT_PROP_DIRECT (by moving up the
> setting of INPUT_PROP_DIRECT). It feels weird to set the flag + the
> consequences of the flag one after the other. This way, we could also
> imagine that if indirect devices are around and use generic, we could
> just remove the flag, and the INPUT_PROP will be removed without any
> extra effort.
>
>>
>> Jason
>> ---
>> Now instead of four in the eights place /
>> you=E2=80=99ve got three, =E2=80=98Cause you added one /
>> (That is to say, eight) to the two, /
>> But you can=E2=80=99t take seven from three, /
>> So you look at the sixty-fours....
>>
>> > Rest looks good to me.
>> >
>> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> >
>> > Cheers,
>> > Benjamin
>> >
>> >>
>> >> @@ -2465,6 +2467,19 @@ void wacom_setup_device_quirks(struct waco=
m *wacom)
>> >>    if (features->type =3D=3D REMOTE)
>> >>            features->device_type =3D WACOM_DEVICETYPE_PAD;
>> >>
>> >> +  if (features->type =3D=3D PL          || features->type =3D=3D=
 DTU           ||
>> >> +      features->type =3D=3D DTUS        || features->type =3D=3D=
 DTUSX         ||
>> >> +      features->type =3D=3D WACOM_21UX2 || features->type =3D=3D=
 WACOM_22HD    ||
>> >> +      features->type =3D=3D DTK         || features->type =3D=3D=
 WACOM_24HD    ||
>> >> +      features->type =3D=3D WACOM_27QHD || features->type =3D=3D=
 CINTIQ_HYBRID ||
>> >> +      features->type =3D=3D CINTIQ_COMPANION_2 || features->type=
 =3D=3D CINTIQ ||
>> >> +      features->type =3D=3D WACOM_BEE   || features->type =3D=3D=
 WACOM_13HD    ||
>> >> +      features->type =3D=3D WACOM_24HDT || features->type =3D=3D=
 WACOM_27QHDT  ||
>> >> +      features->type =3D=3D TABLETPC    || features->type =3D=3D=
 TABLETPCE     ||
>> >> +      features->type =3D=3D TABLETPC2FG || features->type =3D=3D=
 MTSCREEN      ||
>> >> +      features->type =3D=3D MTTPC       || features->type =3D=3D=
 MTTPC_B)
>> >> +      features->device_type |=3D WACOM_DEVICETYPE_DIRECT;
>
> As Bastien said, this is ugly, and a switch/case fits better.

Or have an array and iterate through it...

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
