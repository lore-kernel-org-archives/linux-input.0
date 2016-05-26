From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover event
 trigger
Date: Wed, 25 May 2016 17:11:37 -0700
Message-ID: <20160526001137.GA22369@dtor-ws>
References: <C2DEC699-8A1A-484D-83F2-637F5EF94C7B@emc.com.tw>
 <006901d1acea$8207d090$861771b0$@emc.com.tw>
 <00be01d1af65$ec37c290$c4a747b0$@emc.com.tw>
 <20160516175342.GD12752@dtor-ws>
 <00c901d1b047$4a2d3ba0$de87b2e0$@emc.com.tw>
 <20160520005137.GA39923@dtor-ws>
 <000001d1b4ff$71ee0720$55ca1560$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35467 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbcEZA0M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 20:26:12 -0400
Content-Disposition: inline
In-Reply-To: <000001d1b4ff$71ee0720$55ca1560$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zac.hsieh@emc.com.tw, =?utf-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>, 'jeff' <jeff.chuang@emc.com.tw>

Hi KT,

On Mon, May 23, 2016 at 10:28:59PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE w=
rote:
> Hi Dmitry,
>=20
> Thanks for your confirmation.
>=20
> I think the best and simplest way is to add below code to emit BTN_TO=
OL_FINGER if hover condition meets.
>=20
> input_report_key(dev, BTN_TOOL_FINGER, input_mt_get_value(dev, ABS_DI=
STANCE));
>=20
> Is it ok for you?
>=20
> 	if (use_count) {
> 		if (count =3D=3D 0 &&
> 		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&
> 		    test_bit(ABS_DISTANCE, dev->absbit) &&
> 		    input_abs_get_val(dev, ABS_DISTANCE) !=3D 0) {
>=20
> 			/* Emit BTN_TOOL_FINGER*/
> 			input_report_key(dev, BTN_TOOL_FINGER, input_mt_get_value(dev, ABS=
_DISTANCE));

I do not see why we need to emit BTN_TOOL_FINGER event twice, once
here, and second time in input_mt_report_finger_count():

- If distance is non-zero (and all other conditions are true) then coun=
t
  will be 1 and will be calling input_mt_report_finger_count(dev, 1)
  which will result in sending EV_KEY/BTN_TOOL_FINGER/1 event.

- If distance is 0 then count will remain 0 and
  input_mt_report_finger_count(dev, 0) will result in
  EV_KEY/BTN_TOOL_FINGER/0.

which is exactly what we need as far as I can see.

Thanks.

>=20
> 			count =3D 1;
> 		}
>=20
> B.R  KT
> -----Original Message-----
> From: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com]=20
> Sent: Friday, May 20, 2016 8:52 AM
> To: =E5=BB=96=E5=B4=87=E6=A6=AE
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; zac.hs=
ieh@emc.com.tw; '=E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86'; 'Char=
les Mooney'; 'Agnes Cheng'; 'jeff'
> Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER flag when hover ev=
ent trigger
>=20
> On Tue, May 17, 2016 at 10:20:40PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE=
 wrote:
> > Hi Dmitry,
> >=20
> > I want to confirm my thought for your idea to avoid misunderstandin=
g.
> > I think you want to encapsulate " BTN_TOOL_FINGER" in the [input_mt=
_report_pointer_emulation] if hover happen.
> > Vendor driver only report "ABS_DISTANCE" and let [input_mt_report_p=
ointer_emulation] emit BTN_TOOL_FINGER report without change function p=
arameter.
> >=20
> > Please let me know if my misunderstand about your idea.
>=20
> Yes, that is correct. Something like this:
>=20
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c inde=
x 54fce56..a1bbec9 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -218,8 +218,23 @@ void input_mt_report_pointer_emulation(struct in=
put_dev *dev, bool use_count)
>  	}
> =20
>  	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
> -	if (use_count)
> +
> +	if (use_count) {
> +		if (count =3D=3D 0 &&
> +		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&
> +		    test_bit(ABS_DISTANCE, dev->absbit) &&
> +		    input_abs_get_val(dev, ABS_DISTANCE) !=3D 0) {
> +			/*
> +			 * Force reporting BTN_TOOL_FINGER for devices that
> +			 * only report general hover (and not per-contact
> +			 * distance) when contact is in proximity but not
> +			 * on the surface.
> +			 */
> +			count =3D 1;
> +		}
> +
>  		input_mt_report_finger_count(dev, count);
> +	}
> =20
>  	if (oldest) {
>  		int x =3D input_mt_get_value(oldest, ABS_MT_POSITION_X);
>=20
> --
> Dmitry
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
