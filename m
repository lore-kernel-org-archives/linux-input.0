From: Florian Echtler <floe-H5Ww8s0cz1NjHglVgfe8mg@public.gmane.org>
Subject: Re: [PATCH 1/3] properly report a single frame rate of 60 FPS
Date: Fri, 13 May 2016 15:23:00 -0700
Message-ID: <573653C4.3090302@butterbrot.org>
References: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
 <573622A4.3020602@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Plg1VIxESSMmqVIuOhvm6mh1oRfDD9HkE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <573622A4.3020602-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Martin Kaltenbrunner <modin-tqKo2siBSQY@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Plg1VIxESSMmqVIuOhvm6mh1oRfDD9HkE
Content-Type: multipart/mixed; boundary="2TofxULRxf38dslLbJWg6LSqeJTSlnPko"
From: Florian Echtler <floe-H5Ww8s0cz1NjHglVgfe8mg@public.gmane.org>
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Martin Kaltenbrunner <modin-tqKo2siBSQY@public.gmane.org>
Message-ID: <573653C4.3090302-H5Ww8s0cz1NjHglVgfe8mg@public.gmane.org>
Subject: Re: [PATCH 1/3] properly report a single frame rate of 60 FPS
References: <1463164906-6273-1-git-send-email-floe-H5Ww8s0cz1NjHglVgfe8mg@public.gmane.org>
 <573622A4.3020602-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
In-Reply-To: <573622A4.3020602-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>

--2TofxULRxf38dslLbJWg6LSqeJTSlnPko
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fixed, sorry for the noise. One more question: Martin and I would also
like to see these patches in the 4.4 longterm kernel; do we have to
submit them separately, or will Greg KH pick them up eventually?

Thanks & best regards, Florian

On 13.05.2016 11:53, Hans Verkuil wrote:
> On 05/13/2016 08:41 PM, Florian Echtler wrote:
>> The device hardware is always running at 60 FPS, so report this both v=
ia
>> PARM_IOCTL and ENUM_FRAMEINTERVALS.
>=20
> Florian, can you post these three patches to linux-media as well? These=
 are all V4L2 related
> so they should be reviewed there.
>=20
> By posting to linux-media these pathes will automatically turn up in pa=
tchwork, that way
> they won't be forgotten.
>=20
> Regards,
>=20
> 	Hans
>=20
>>
>> Signed-off-by: Martin Kaltenbrunner <modin-tqKo2siBSQY@public.gmane.org>
>> Signed-off-by: Florian Echtler <floe-H5Ww8s0cz1NjHglVgfe8mg@public.gmane.org>
>> ---
>>  drivers/input/touchscreen/sur40.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchsc=
reen/sur40.c
>> index 880c40b..fcc5934 100644
>> --- a/drivers/input/touchscreen/sur40.c
>> +++ b/drivers/input/touchscreen/sur40.c
>> @@ -788,6 +788,16 @@ static int sur40_vidioc_fmt(struct file *file, vo=
id *priv,
>>  	return 0;
>>  }
>> =20
>> +static int sur40_ioctl_parm(struct file *file, void *priv,
>> +			    struct v4l2_streamparm *p)
>> +{
>> +	if (p->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE) {
>> +		p->parm.capture.timeperframe.numerator =3D 1;
>> +		p->parm.capture.timeperframe.denominator =3D 60;
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int sur40_vidioc_enum_fmt(struct file *file, void *priv,
>>  				 struct v4l2_fmtdesc *f)
>>  {
>> @@ -814,13 +824,13 @@ static int sur40_vidioc_enum_framesizes(struct f=
ile *file, void *priv,
>>  static int sur40_vidioc_enum_frameintervals(struct file *file, void *=
priv,
>>  					    struct v4l2_frmivalenum *f)
>>  {
>> -	if ((f->index > 1) || (f->pixel_format !=3D V4L2_PIX_FMT_GREY)
>> +	if ((f->index > 0) || (f->pixel_format !=3D V4L2_PIX_FMT_GREY)
>>  		|| (f->width  !=3D sur40_video_format.width)
>>  		|| (f->height !=3D sur40_video_format.height))
>>  			return -EINVAL;
>> =20
>>  	f->type =3D V4L2_FRMIVAL_TYPE_DISCRETE;
>> -	f->discrete.denominator  =3D 60/(f->index+1);
>> +	f->discrete.denominator  =3D 60;
>>  	f->discrete.numerator =3D 1;
>>  	return 0;
>>  }
>> @@ -880,6 +890,9 @@ static const struct v4l2_ioctl_ops sur40_video_ioc=
tl_ops =3D {
>>  	.vidioc_enum_framesizes =3D sur40_vidioc_enum_framesizes,
>>  	.vidioc_enum_frameintervals =3D sur40_vidioc_enum_frameintervals,
>> =20
>> +	.vidioc_g_parm =3D sur40_ioctl_parm,
>> +	.vidioc_s_parm =3D sur40_ioctl_parm,
>> +
>>  	.vidioc_enum_input	=3D sur40_vidioc_enum_input,
>>  	.vidioc_g_input		=3D sur40_vidioc_g_input,
>>  	.vidioc_s_input		=3D sur40_vidioc_s_input,
>>


--=20
SENT FROM MY DEC VT50 TERMINAL


--2TofxULRxf38dslLbJWg6LSqeJTSlnPko--

--Plg1VIxESSMmqVIuOhvm6mh1oRfDD9HkE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlc2U8QACgkQ7CzyshGvatjSIQCfeV/gIOEqCc5Mjef71YBKChf2
xvkAn0futXzBNrmeYz9L6nQhDzXa4f0w
=t8oH
-----END PGP SIGNATURE-----

--Plg1VIxESSMmqVIuOhvm6mh1oRfDD9HkE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
