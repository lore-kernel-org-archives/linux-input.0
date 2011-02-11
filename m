From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/4] input - wacom : process pen data in its own routine
Date: Fri, 11 Feb 2011 12:13:20 -0800
Message-ID: <AANLkTim-t6Djv=Cn7CrygdkQo+8ZxxdNicHJe_xofSuN@mail.gmail.com>
References: <1297387943-13685-1-git-send-email-pinglinux@gmail.com>
	<20110211192754.GB1905@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41212 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab1BKUNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 15:13:21 -0500
Received: by wwa36 with SMTP id 36so2974598wwa.1
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 12:13:20 -0800 (PST)
In-Reply-To: <20110211192754.GB1905@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Fri, Feb 11, 2011 at 11:27 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> Hi Ping,
>
> On Thu, Feb 10, 2011 at 05:32:23PM -0800, Ping Cheng wrote:
>> So it would be easier for patch reviewers to follow the data path
>
> Please develop the commit message a bit.

Well, there is no real code change. Just to move the block out to its
own routine for reviewers to following the other changes later. This
was suggested by Chris. What exact commit message are you looking for
here?

>> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =A0drivers/input/tablet/wacom_wac.c | =A0 73 +++++++++++++++++++++--=
---------------
>> =A01 files changed, 40 insertions(+), 33 deletions(-)
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index 5488c61..15bab99 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -722,13 +722,47 @@ static void wacom_tpc_touch_in(struct wacom_wa=
c *wacom, size_t len)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> -static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>> +static int wacom_tpc_pen(struct wacom_wac *wacom)
>> =A0{
>> =A0 =A0 =A0 struct wacom_features *features =3D &wacom->features;
>> =A0 =A0 =A0 char *data =3D wacom->data;
>> =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>> - =A0 =A0 int prox =3D 0, pressure;
>> - =A0 =A0 int retval =3D 0;
>> + =A0 =A0 int prox, pressure;
>> +
>> + =A0 =A0 prox =3D data[1] & 0x20;
>> +
>> + =A0 =A0 if (!wacom->shared->stylus_in_proximity) { /* first in pro=
x */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Going into proximity select tool */
>> + =A0 =A0 =A0 =A0 =A0 =A0 wacom->tool[0] =3D (data[1] & 0x0c) ? BTN_=
TOOL_RUBBER : BTN_TOOL_PEN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->tool[0] =3D=3D BTN_TOOL_PEN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D STYLUS_DE=
VICE_ID;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D ERASER_DE=
VICE_ID;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_proximity =3D tru=
e;
>> + =A0 =A0 }
>> + =A0 =A0 input_report_key(input, BTN_STYLUS, data[1] & 0x02);
>> + =A0 =A0 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>> + =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&dat=
a[2]));
>> + =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&dat=
a[4]));
>> + =A0 =A0 pressure =3D ((data[7] & 0x01) << 8) | data[6];
>> + =A0 =A0 if (pressure < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features->pressure_max + pres=
sure + 1;
>
> Hm... what if data[6] was u8 instead?

What do you suggest us to do here? This was the original code. We only
moved it here.

>> + =A0 =A0 input_report_abs(input, ABS_PRESSURE, pressure);
>> + =A0 =A0 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>> + =A0 =A0 if (!prox) { /* out-prox */
>> + =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_proximity =3D fal=
se;
>> + =A0 =A0 }
>> + =A0 =A0 input_report_key(input, wacom->tool[0], prox);
>> +
>> + =A0 =A0 return 1;
>> +}
>> +
>> +static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>> +{
>> + =A0 =A0 char *data =3D wacom->data;
>> + =A0 =A0 int prox =3D 0;
>>
>> =A0 =A0 =A0 dbg("wacom_tpc_irq: received report #%d", data[0]);
>>
>> @@ -757,37 +791,10 @@ static int wacom_tpc_irq(struct wacom_wac *wac=
om, size_t len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep prox bit to send proper out-prox=
 event */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[1] =3D prox;
>> - =A0 =A0 } else if (data[0] =3D=3D WACOM_REPORT_PENABLED) { /* Pena=
bled */
>> - =A0 =A0 =A0 =A0 =A0 =A0 prox =3D data[1] & 0x20;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!wacom->shared->stylus_in_proximity) {=
 /* first in prox */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Going into proximity se=
lect tool */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->tool[0] =3D (data[1=
] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->tool[0] =3D=3D =
BTN_TOOL_PEN)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[=
0] =3D STYLUS_DEVICE_ID;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[=
0] =3D ERASER_DEVICE_ID;
>> + =A0 =A0 } else if (data[0] =3D=3D WACOM_REPORT_PENABLED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_pen(wacom);
>
> mixed if {} and else ;

else only have one statement. The other } will be removed later too.

>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_p=
roximity =3D true;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS, data[1=
] & 0x02);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, data[=
1] & 0x10);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpu=
p((__le16 *)&data[2]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpu=
p((__le16 *)&data[4]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D ((data[7] & 0x01) << 8) | dat=
a[6];
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (pressure < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features->pre=
ssure_max + pressure + 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, pres=
sure);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, data[1]=
 & 0x05);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!prox) { /* out-prox */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_p=
roximity =3D false;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, wacom->tool[0], pr=
ox);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MISC, wacom->i=
d[0]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 retval =3D 1;
>> - =A0 =A0 }
>> - =A0 =A0 return retval;
>> + =A0 =A0 return 0;
>> =A0}
>>
>> =A0static int wacom_bpt_touch(struct wacom_wac *wacom)
>> --
>
> Thanks,
> Henrik

Thank you for reviewing the patch.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
