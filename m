From: m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH] touchscreen: sun4i-ts: Really fix A10
 temperature reporting
Date: Tue, 23 Jun 2015 13:39:23 -0700 (PDT)
Message-ID: <33d3fc39-c232-4022-b7fb-47de84735987@googlegroups.com>
References: <1425893870-28715-1-git-send-email-hdegoede@redhat.com> <41a7a857-96fd-48ab-9778-127cfc091ef0@googlegroups.com>
 <5589B78C.4080600@redhat.com>
Reply-To: m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4797_2035253453.1435091964067"
Return-path: <linux-sunxi+bncBDGZFWHP6IMBB7EHU6WAKGQE253PD7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <5589B78C.4080600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: wens-jdAy2FN1RRM@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

------=_Part_4797_2035253453.1435091964067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am Dienstag, 23. Juni 2015 21:46:25 UTC+2 schrieb Hans de Goede:
> Hi,
>=20
> On 06/23/2015 05:06 PM, m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > Hi Hans,
> >
> > is it possible that this patch (and the parent commit "Input: sun4i-ts =
- allow controlling filter and sensitivity via DT") has quite an adversial =
effect on other boards than the ones tested?
> >
> > On my Lemaker Bananapi the temperature is now being reported as somwher=
e between -15=C2=B0C to -10=C2=B0C with the latest Kernel 4.1.0. These nega=
tive values are obviously way off. On Kernel 4.0.5 the temperature reading =
was usually around 40=C2=B0C. While that might not have been accurate eithe=
r, it was at least plausible.
>=20
> The temperature curve for the A20 SoC was not changed, if it did change t=
hen
> you're using an old dtb file with a new kernel, you must always update yo=
ur
> dtb file together with the kernel.

I always compile the dts that comes with the kernel tree from scratch. So t=
his is up to date. I guess I have to dig in deeper then what caused that ch=
ange. Any other hint where to look for?


>=20
>=20
>=20
> >
> > Given that there is no Documentation and things seem quite board-specif=
ic, I really don't know how this could be improved, so I can merely report =
my observation.
> >
> > Kind regards,
> >
> > Timo
> >
> >
> > Am Montag, 9. M=C3=A4rz 2015 10:38:02 UTC+1 schrieb Hans de Goede:
> >> The commit titled:
> >> "touchscreen: sun4i-ts: A10 (sun4i) has a different temperature curve"
> >> contains a math error, the offset it uses is in degrees, but the actua=
l code
> >> applies the offset before multiplying by stepsize :|
> >>
> >> Given that this is rather backwards (every math course ever thought ap=
plies
> >> the multiplication before the offset for linear functions), this commi=
t
> >> fixes things by changing the code applying the offset to do the logica=
l
> >> thing, adjusting the offset for the other models accordingly.
> >>
> >> This has been tested on an A10, A13, A20 and A31 to make sure everythi=
ng really
> >> is correct now.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> ---
> >> Note if possible this commit should be squashed into the original
> >> "touchscreen: sun4i-ts: A10 (sun4i) has a different temperature curve"
> >> commit as a fixup.
> >> ---
> >>   drivers/input/touchscreen/sun4i-ts.c | 14 +++++++-------
> >>   1 file changed, 7 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touc=
hscreen/sun4i-ts.c
> >> index 66ccd5a..178d2ef 100644
> >> --- a/drivers/input/touchscreen/sun4i-ts.c
> >> +++ b/drivers/input/touchscreen/sun4i-ts.c
> >> @@ -193,7 +193,7 @@ static int sun4i_get_temp(const struct sun4i_ts_da=
ta *ts, long *temp)
> >>   	if (ts->temp_data =3D=3D -1)
> >>   		return -EAGAIN;
> >>
> >> -	*temp =3D (ts->temp_data - ts->temp_offset) * ts->temp_step;
> >> +	*temp =3D ts->temp_data * ts->temp_step - ts->temp_offset;
> >>
> >>   	return 0;
> >>   }
> >> @@ -255,17 +255,17 @@ static int sun4i_ts_probe(struct platform_device=
 *pdev)
> >>   	ts->ignore_fifo_data =3D true;
> >>   	ts->temp_data =3D -1;
> >>   	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
> >> -		/* Allwinner SDK has temperature =3D -271 + (value / 6) (C) */
> >> -		ts->temp_offset =3D 1626;
> >> +		/* Allwinner SDK has temperature (C) =3D (value / 6) - 271 */
> >> +		ts->temp_offset =3D 271000;
> >>   		ts->temp_step =3D 167;
> >>   	} else if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts")) {
> >>   		/*
> >>   		 * The A10 temperature sensor has quite a wide spread, these
> >>   		 * parameters are based on the averaging of the calibration
> >>   		 * results of 4 completely different boards, with a spread of
> >> -		 * temp_step from 96 - 170 and temp_offset from 1758 - 3310.
> >> +		 * temp_step from 0.096 - 0.170 and temp_offset from 176 - 331.
> >>   		 */
> >> -		ts->temp_offset =3D 2570;
> >> +		ts->temp_offset =3D 257000;
> >>   		ts->temp_step =3D 133;
> >>   	} else {
> >>   		/*
> >> @@ -273,13 +273,13 @@ static int sun4i_ts_probe(struct platform_device=
 *pdev)
> >>   		 * the temperature. The formula used here is from the AXP209,
> >>   		 * which is designed by X-Powers, an affiliate of Allwinner:
> >>   		 *
> >> -		 *     temperature =3D -144.7 + (value * 0.1)
> >> +		 *     temperature (C) =3D (value * 0.1) - 144.7
> >>   		 *
> >>   		 * Allwinner does not have any documentation whatsoever for
> >>   		 * this hardware. Moreover, it is claimed that the sensor
> >>   		 * is inaccurate and cannot work properly.
> >>   		 */
> >> -		ts->temp_offset =3D 1447;
> >> +		ts->temp_offset =3D 144700;
> >>   		ts->temp_step =3D 100;
> >>   	}
> >>
> >> --
> >> 2.3.1
> >
>=20
> Regards,
>=20
> Hans

Thanks,

Timo

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_4797_2035253453.1435091964067--
