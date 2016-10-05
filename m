From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 4/5] HID: sony: Send ds4 output reports on output end-point
Date: Wed, 5 Oct 2016 11:53:40 -0700
Message-ID: <CANndSKkc7Nw3p9NOSj+bSge=Mt_OfmGxiqdSHyMx6jYL3YfxnQ@mail.gmail.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-5-git-send-email-roderick@gaikai.com> <20161005083150.GB19261@mail.corp.redhat.com>
 <5FB6ED86-613A-449C-8D7C-60FD136075C3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34481 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbcJESxm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2016 14:53:42 -0400
Received: by mail-vk0-f53.google.com with SMTP id b186so94603050vkb.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2016 11:53:41 -0700 (PDT)
In-Reply-To: <5FB6ED86-613A-449C-8D7C-60FD136075C3@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>, Antonio Ospite <ao2@ao2.it>

On Wed, Oct 5, 2016 at 9:54 AM, Frank Praznik <frank.praznik@gmail.com> wro=
te:
>
>> On Oct 5, 2016, at 04:31, Benjamin Tissoires <benjamin.tissoires@redhat.=
com> wrote:
>>
>> [adding Frank, Simon and Antonio as they are the main developpers of
>> hid-sony]
>>
>> On Oct 04 2016 or thereabouts, Roderick Colenbrander wrote:
>>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>>
>>> Add a CRC value to each output report. This removes the need for the
>>> 'no output reports on interrupt end-point' quirk.
>>>
>>> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>> ---
>>> drivers/hid/hid-sony.c | 20 +++++++++++---------
>>> 1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
>>> index 34988ce..24f7d19 100644
>>> --- a/drivers/hid/hid-sony.c
>>> +++ b/drivers/hid/hid-sony.c
>>> @@ -1895,7 +1895,7 @@ static void dualshock4_send_output_report(struct =
sony_sc *sc)
>>>      } else {
>>>              memset(buf, 0, DS4_OUTPUT_REPORT_0x11_SIZE);
>>>              buf[0] =3D 0x11;
>>> -            buf[1] =3D 0x80;
>>> +            buf[1] =3D 0xC0; /* HID + CRC */
>>>              buf[3] =3D 0x0F;
>>>              offset =3D 6;
>>>      }
>>> @@ -1922,9 +1922,16 @@ static void dualshock4_send_output_report(struct=
 sony_sc *sc)
>>>
>>>      if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
>>>              hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x05_SIZ=
E);
>>> -    else
>>> -            hid_hw_raw_request(hdev, 0x11, buf, DS4_OUTPUT_REPORT_0x11=
_SIZE,
>>> -                            HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>>> +    else {
>>> +            /* CRC generation */
>>> +            u8 bthdr =3D 0xA2;
>>> +            u32 crc;
>>> +
>>> +            crc =3D crc32_le(0xFFFFFFFF, &bthdr, 1);
>>> +            crc =3D ~crc32_le(crc, buf, DS4_OUTPUT_REPORT_0x11_SIZE-4)=
;
>>> +            put_unaligned_le32(crc, &buf[74]);
>>> +            hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x11_SIZ=
E);
>>> +    }
>>
>> nitpicking:
>> hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x11_SIZE); could be
>> factorized out if you add the crc only for BT devices.
>>
>>> }
>>>
>>> static void motion_send_output_report(struct sony_sc *sc)
>>> @@ -2378,11 +2385,6 @@ static int sony_input_configured(struct hid_devi=
ce *hdev,
>>>              sony_init_output_report(sc, sixaxis_send_output_report);
>>>      } else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
>>>              if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
>>> -                    /*
>>> -                     * The DualShock 4 wants output reports sent on th=
e ctrl
>>> -                     * endpoint when connected via Bluetooth.
>>> -                     */
>>> -                    hdev->quirks |=3D HID_QUIRK_NO_OUTPUT_REPORTS_ON_I=
NTR_EP;
>>
>> The purpose of this quirk is only to have hidraw behaving like legacy
>> when the HID low-level transport has been worked on.
>> So basically, this might potentially break userspace as the CRC doesn't
>> get added automatically by the driver when talking to the device through
>> hidraw.
>>
>> Frank, Simon, Antonio, are there any userspace application that need to
>> communicate over hidraw to the controllers or is it entirely done in the
>> kernel now?
>>
>> Cheers,
>> Benjamin
>
> The best answer I can give is "not to my knowledge=E2=80=9D.  Rumble and =
LEDs have standard
> kernel interfaces but obviously we can=E2=80=99t guarantee 100% that nobo=
dy is using hidraw
> directly.  Commercial games and engines aren't running as root and thus c=
an=E2=80=99t use
> hidraw so I think we can safely say that no major commercial software wil=
l be broken
> by this.
>
> There are people who have had to alter the reporting rate of the controll=
er for use with
> slow embedded processors.  With this change can the rate-control value be=
 altered
> from the full-speed value of C0?
>
> I guess that in these corner cases people can revert it to the old behavi=
or themselves if
> necessary since they have to customize the module anyways.
>
> Regards,
> Frank
>

To be honest I'm not sure how the rate control works. I think it is
handled outside the driver more by the bluetooth layer, but I'm not
sure. At least those few upper bits we changed don't seem to be
related to the speed.

Thanks,
Roderick
