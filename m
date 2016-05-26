From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Emit BTN_TOO_FINGER in function
 input_mt_report_pointer_emulation if touchpad meets hover condition
Date: Wed, 25 May 2016 17:13:50 -0700
Message-ID: <20160526001350.GB22369@dtor-ws>
References: <003101d1b67a$dce6e5c0$96b4b140$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003101d1b67a$dce6e5c0$96b4b140$@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zac.hsieh@emc.com.tw, =?utf-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, 'Charles Mooney' <charliemooney@google.com>, 'Agnes Cheng' <agnescheng@google.com>, 'jeff' <jeff.chuang@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi KT,

On Wed, May 25, 2016 at 07:44:57PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE w=
rote:
> Hi Dmitry,
>=20
> Update /input/mouse/input-mt.c
> Emit BTN_TOO_FINGER in input_mt_report_pointer_emulation if touchpad =
meets hover condition.

Please do not top-post and also do not send patches as attachments,
they should be sent inline. Please take a look at "git send-email"
command.

Thanks.

>=20
> Thanks & BR	KT
>=20
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



--=20
Dmitry
