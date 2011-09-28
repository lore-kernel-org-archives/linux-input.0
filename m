From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH V3 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Thu, 29 Sep 2011 01:22:41 +0200
Message-ID: <CAAwP0s0Jrc4zRAw4RUBWvSpiKNT0TqxYizqQZVihkkEy5+gcMw@mail.gmail.com>
References: <1316311297-12765-1-git-send-email-martinez.javier@gmail.com>
 <1316311297-12765-2-git-send-email-martinez.javier@gmail.com> <20110927115207.GA3701@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110927115207.GA3701@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin McNeely <kev@cypress.com>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 27, 2011 at 1:52 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Javier,
>
>> Cypress TrueTouch(tm) Standard Product controllers are found in
>> a wide range of embedded devices. This driver add support for a
>> variety of TTSP controllers.
>
> please find some comments below.
>

Hello Henrik,

Thanks a lot for the review

>> +/* Slots management */
>> +#define CY_MAX_FINGER =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 4
>> +#define CY_UNUSED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0
>> +#define CY_USED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1
>
> These two look like bool, please use as bool instead.
>
>> +#define CY_MAX_ID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 15
>
> Why not 16 here?
>

Because as far as I know there are only 14 possible tracking ids
(1-14), not 16. 15 and 0 are not valid track ids.

When a contact lifts off the hardware reports a magic number (15) for
it. Also, the sequence always start with 1 which is the track id that
gets the first contact reported by the touch.

>> +
>> +/* TrueTouch Standard Product Gen3 interface definition */
>> +struct cyttsp_xydata {
>> + =C2=A0 =C2=A0 u8 hst_mode;
>> + =C2=A0 =C2=A0 u8 tt_mode;
>> + =C2=A0 =C2=A0 u8 tt_stat;
>> + =C2=A0 =C2=A0 struct cyttsp_tch tch1;
>> + =C2=A0 =C2=A0 u8 touch12_id;
>> + =C2=A0 =C2=A0 struct cyttsp_tch tch2;
>> + =C2=A0 =C2=A0 u8 gest_cnt;
>> + =C2=A0 =C2=A0 u8 gest_id;
>> + =C2=A0 =C2=A0 struct cyttsp_tch tch3;
>> + =C2=A0 =C2=A0 u8 touch34_id;
>> + =C2=A0 =C2=A0 struct cyttsp_tch tch4;
>> + =C2=A0 =C2=A0 u8 tt_undef[3];
>> + =C2=A0 =C2=A0 u8 act_dist;
>> + =C2=A0 =C2=A0 u8 tt_reserved;
>> +} __packed;
>
> Too bad the touches are not an array here...
>

Yes, the problem is that the offset between touches is not uniform.
=46or tch1 and tch2 is only 8 bits but the offset between tch2 and tch3
is 16 (u8 * 2) for example.

>> + =C2=A0 =C2=A0 int slot_curr[CY_MAX_ID];
>> + =C2=A0 =C2=A0 int slot_prev[CY_MAX_ID];
>
> These two are not needed; the input core will take care of duplicates=
,
> so slot_prev can be removed. Also, the set of current slots can be
> tracked using a temporary bitmask, so slot_curr can be removed as wel=
l.

Perfect, I'll remove both. I didn't know that the input core took care
of duplicates, sorry for not getting this from the docs.

>> +
>> +static void cyttsp_get_tch(struct cyttsp_xydata *xy_data, int idx,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct cyttsp_tch **tch)
>> +{
>> + =C2=A0 =C2=A0 switch (idx) {
>> + =C2=A0 =C2=A0 case 0:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tch =3D &xy_data->tch1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case 1:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tch =3D &xy_data->tch2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case 2:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tch =3D &xy_data->tch3;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 case 3:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *tch =3D &xy_data->tch4;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 }
>> +}
>
> How about returning a const struct cyttsp_tch* here instead.
>

Ok, will return a struct pointer instead.

>> +
>> + =C2=A0 =C2=A0 cyttsp_extract_track_ids(&xy_data, ids);
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < num_cur_tch; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_curr[ids[i] - 1=
] =3D CY_USED;
>
> Why the -1 here? Since the values are provably between 0 and 15, ther=
e
> is no need to change them further.

As I told you before is a HW thing. I looked at the track ids reported
by the touchscreen and their values are always between 1 and 14. So I
did the -1 to avoid having and unused element in the array. (I don't
have the HW datasheet so maybe I'm wrong with this)

Kevin?

>
> Also, the above line could be replaced by "used |=3D 1 << ids[i]", fo=
r instance.
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cyttsp_get_tch(&xy_data,=
 i, &tch);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x =3D be16_to_cpu(tch->x=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y =3D be16_to_cpu(tch->y=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 z =3D tch->z;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cyttsp_report_slot(ts->i=
nput, ids[i] - 1, x, y, z);
>
> Ditto, -1.
>
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < CY_MAX_ID; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts->slot_prev[i] =3D=
=3D CY_USED &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_c=
urr[i] =3D=3D CY_UNUSED)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cyttsp_report_slot_empty(ts->input, i);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_prev[i] =3D ts-=
>slot_curr[i];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_curr[i] =3D CY_=
UNUSED;
>> + =C2=A0 =C2=A0 }
>
> Input core handles duplicate calls, so the above could be simplified.
>

Perfect, will clean this code.

>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < CY_MAX_ID; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_prev[i] =3D CY_=
UNUSED;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_curr[i] =3D CY_=
UNUSED;
>> + =C2=A0 =C2=A0 }
>
> Could be removed.
>

Yes, I'll do that.

>
> Thanks,
> Henrik
>

Thanks for your comments, I will work on these issues and resubmit a
new version of the patch-set.

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
