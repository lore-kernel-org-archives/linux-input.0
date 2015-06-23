From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] touchscreen: sun4i-ts: Really fix A10 temperature
 reporting
Date: Tue, 23 Jun 2015 12:54:24 -0700
Message-ID: <20150623195424.GE40168@dtor-ws>
References: <1425893870-28715-1-git-send-email-hdegoede@redhat.com>
 <41a7a857-96fd-48ab-9778-127cfc091ef0@googlegroups.com>
 <5589B78C.4080600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5589B78C.4080600-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 23, 2015 at 09:46:20PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 06/23/2015 05:06 PM, m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >Hi Hans,
> >
> >is it possible that this patch (and the parent commit "Input: sun4i-=
ts - allow controlling filter and sensitivity via DT") has quite an adv=
ersial effect on other boards than the ones tested?
> >
> >On my Lemaker Bananapi the temperature is now being reported as somw=
here between -15=B0C to -10=B0C with the latest Kernel 4.1.0. These neg=
ative values are obviously way off. On Kernel 4.0.5 the temperature rea=
ding was usually around 40=B0C. While that might not have been accurate=
 either, it was at least plausible.
>=20
> The temperature curve for the A20 SoC was not changed, if it did chan=
ge then
> you're using an old dtb file with a new kernel, you must always updat=
e your
> dtb file together with the kernel.

Umm, we should keep compatibility with old DTS...

>=20
>=20
>=20
> >
> >Given that there is no Documentation and things seem quite board-spe=
cific, I really don't know how this could be improved, so I can merely =
report my observation.
> >
> >Kind regards,
> >
> >Timo
> >
> >
> >Am Montag, 9. M=E4rz 2015 10:38:02 UTC+1 schrieb Hans de Goede:
> >>The commit titled:
> >>"touchscreen: sun4i-ts: A10 (sun4i) has a different temperature cur=
ve"
> >>contains a math error, the offset it uses is in degrees, but the ac=
tual code
> >>applies the offset before multiplying by stepsize :|
> >>
> >>Given that this is rather backwards (every math course ever thought=
 applies
> >>the multiplication before the offset for linear functions), this co=
mmit
> >>fixes things by changing the code applying the offset to do the log=
ical
> >>thing, adjusting the offset for the other models accordingly.
> >>
> >>This has been tested on an A10, A13, A20 and A31 to make sure every=
thing really
> >>is correct now.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>---
> >>Note if possible this commit should be squashed into the original
> >>"touchscreen: sun4i-ts: A10 (sun4i) has a different temperature cur=
ve"
> >>commit as a fixup.
> >>---
> >>  drivers/input/touchscreen/sun4i-ts.c | 14 +++++++-------
> >>  1 file changed, 7 insertions(+), 7 deletions(-)
> >>
> >>diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/t=
ouchscreen/sun4i-ts.c
> >>index 66ccd5a..178d2ef 100644
> >>--- a/drivers/input/touchscreen/sun4i-ts.c
> >>+++ b/drivers/input/touchscreen/sun4i-ts.c
> >>@@ -193,7 +193,7 @@ static int sun4i_get_temp(const struct sun4i_ts=
_data *ts, long *temp)
> >>  	if (ts->temp_data =3D=3D -1)
> >>  		return -EAGAIN;
> >>
> >>-	*temp =3D (ts->temp_data - ts->temp_offset) * ts->temp_step;
> >>+	*temp =3D ts->temp_data * ts->temp_step - ts->temp_offset;
> >>
> >>  	return 0;
> >>  }
> >>@@ -255,17 +255,17 @@ static int sun4i_ts_probe(struct platform_dev=
ice *pdev)
> >>  	ts->ignore_fifo_data =3D true;
> >>  	ts->temp_data =3D -1;
> >>  	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
> >>-		/* Allwinner SDK has temperature =3D -271 + (value / 6) (C) */
> >>-		ts->temp_offset =3D 1626;
> >>+		/* Allwinner SDK has temperature (C) =3D (value / 6) - 271 */
> >>+		ts->temp_offset =3D 271000;
> >>  		ts->temp_step =3D 167;
> >>  	} else if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts")=
) {
> >>  		/*
> >>  		 * The A10 temperature sensor has quite a wide spread, these
> >>  		 * parameters are based on the averaging of the calibration
> >>  		 * results of 4 completely different boards, with a spread of
> >>-		 * temp_step from 96 - 170 and temp_offset from 1758 - 3310.
> >>+		 * temp_step from 0.096 - 0.170 and temp_offset from 176 - 331.
> >>  		 */
> >>-		ts->temp_offset =3D 2570;
> >>+		ts->temp_offset =3D 257000;
> >>  		ts->temp_step =3D 133;
> >>  	} else {
> >>  		/*
> >>@@ -273,13 +273,13 @@ static int sun4i_ts_probe(struct platform_dev=
ice *pdev)
> >>  		 * the temperature. The formula used here is from the AXP209,
> >>  		 * which is designed by X-Powers, an affiliate of Allwinner:
> >>  		 *
> >>-		 *     temperature =3D -144.7 + (value * 0.1)
> >>+		 *     temperature (C) =3D (value * 0.1) - 144.7
> >>  		 *
> >>  		 * Allwinner does not have any documentation whatsoever for
> >>  		 * this hardware. Moreover, it is claimed that the sensor
> >>  		 * is inaccurate and cannot work properly.
> >>  		 */
> >>-		ts->temp_offset =3D 1447;
> >>+		ts->temp_offset =3D 144700;
> >>  		ts->temp_step =3D 100;
> >>  	}
> >>
> >>--
> >>2.3.1
> >
>=20
> Regards,
>=20
> Hans

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
