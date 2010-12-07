From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v3] input: mt: Move tracking and pointer emulation to input-mt
Date: Tue, 7 Dec 2010 12:39:32 -0800
Message-ID: <AANLkTik=A5xc2RexWqDMvumFqbA6HtzynWmP=Fz6+SvE@mail.gmail.com>
References: <1291722357-22820-1-git-send-email-rydberg@euromail.se>
	<alpine.LNX.2.00.1012071553100.14806@pobox.suse.cz>
	<4CFE934D.4040309@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CFE934D.4040309@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 7, 2010 at 12:04 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> On 12/07/2010 03:53 PM, Jiri Kosina wrote:
>
>> On Tue, 7 Dec 2010, Henrik Rydberg wrote:
>>
>>> The drivers using the type B protocol all report tracking informati=
on
>>> the same way. The contact id is semantically equivalent to
>>> ABS_MT_SLOT, and the handling of ABS_MT_TRACKING_ID only complicate=
s
>>> the driver. The situation can be improved upon by providing a commo=
n
>>> pointer emulation code, thereby removing the need for the tracking =
id
>>> in the driver. =A0This patch moves all tracking event handling over=
 to
>>> the input core, simplifying both the existing drivers and the ones
>>> currently in preparation.
>>>
>>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>>> ---
>>> This is revision three of the patch, with changes to incorporate th=
e
>>> active use of ABS_MT_TOOL_TYPE. Example usages are found in pen and
>>> touch tablets and simple dual touch devices. The report_slot_state(=
)
>>> function now takes the tool type as argument, since a change in eit=
her
>>> tool type of touch state should trigger a new tracking id.
>>>
>>> Thanks,
>>> Henrik
>>>
>>> =A0drivers/hid/hid-3m-pct.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 30=
 +---------
>>
>> Acked-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Ping Cheng <pingc@wacom.com>

I do see an issue when pen coming in prox while fingers were on the
tablet. Fingers up events are missing.

Since it is unrelated to this patch, I'll submit another patch as a
bug fix later.

Ping

> Thanks Jiri. Ping, you acked a previous version, but I did not want t=
o presume
> this version was ok as well. And, as it turned out, I managed to intr=
oduce an
> error (pressure is zero or one). Corrected and properly tested on a B=
amboo
> Touch. With the patch below folded in, do I have your ack?
>
> Thanks,
> Henrik
> ---
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 4e59b93..0104e1a 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -866,17 +866,18 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2] && !wacom->sh=
ared->stylus_in_proximity;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[9 * i + 2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool touch =3D p && !wacom->shared->sty=
lus_in_proximity;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_slot(input, i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TO=
OL_FINGER, p);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TO=
OL_FINGER, touch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Touch events need to be disabled wh=
ile stylus is
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * in proximity because user's hand is=
 resting on touchpad
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and sending unwanted events. =A0Use=
r expects tablet buttons
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to continue working though.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (touch) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D get_unaligne=
d_be16(&data[9 * i + 3]) & 0x7ff;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D get_unaligne=
d_be16(&data[9 * i + 5]) & 0x7ff;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->quirks &=
 WACOM_QUIRK_BBTOUCH_LOWRES) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
