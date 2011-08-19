From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/6] Input: elantech - use firmware provided x, y ranges
Date: Fri, 19 Aug 2011 14:19:10 +0200
Message-ID: <4E4E54BE.5000108@tudelft.nl>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-3-git-send-email-jj_ding@emc.com.tw> <20110818074756.GE10093@core.coreip.homeip.net> <87obzlu40p.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:34759 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab1HSMTO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 08:19:14 -0400
In-Reply-To: <87obzlu40p.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Op 19-08-11 11:47, JJ Ding schreef:
> Hi Dmitry,
>
> Sorry for late reply. I missed this one somehow.
>
> On Thu, 18 Aug 2011 00:47:56 -0700, Dmitry Torokhov<dmitry.torokhov@g=
mail.com>  wrote:
>> On Thu, Aug 18, 2011 at 09:57:05AM +0800, JJ Ding wrote:
>>> +
>>> +		i =3D (etd->fw_version>  0x020800&&
>>> +		     etd->fw_version<  0x020900) ? 1 : 2;
>>> +		*x_max =3D (etd->capabilities[1] - i) * 64;
>>> +		*y_max =3D (etd->capabilities[2] - i) * 64;
>>> +		*y_2ft_max =3D (*y_max - i) * 64 / 4;
>>
>> Hmm, we should have the same range for ST and MT data and scale MT d=
ata
>> if it has lower resolution to match ST.
> So I should just remove y_2ft_max and those ETP_2FT_XXXX in elantech.=
h,
> and do the scale in elantech_report_absolute_v2?
Humm, yes, I think what Dmitry wants is that both ABS_MT_POSITION_Y and=
=20
ABS_Y have the same min and max, and the scaling is done when reading=20
the data. However, it seems this already what is being tried to be done=
,=20
excepted that I mess it up in the latest patch set I sent. I just=20
noticed it now, sorry :-S

You can see in elantech_report_absolute_v2() in case of 2 fingers:
The part for updating ABS_X, ABS_Y is correct:
  input_report_abs(dev, ABS_X, x1 << 2);
  input_report_abs(dev, ABS_Y, y1 << 2);

But I forgot to do the same for MT:
  elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
That should be:
  elantech_report_semi_mt_data(dev, fingers, x1 << 2, y1 << 2, x2 << 2,=
=20
y2 << 2);

Or, even more clean, just move the shift directly into the computation,=
=20
like:
  y1 =3D etd->y_max - ((((packet[0] & 0x20) << 3) | packet[2]) << 2);

In such case you can drop completely y_2ft_max, and move the=20
input_report_abs() outside of the switch.


In addition, I have a couple of more remarks on this patch:
> +		*x_max =3D (etd->capabilities[1] - i) * 64;
> +		*y_max =3D (etd->capabilities[2] - i) * 64;
> +		*y_2ft_max =3D (*y_max - i) * 64 / 4;
This last line is probably wrong as I think it should be:
  *y_2ft_max =3D *y_max / 4;

But if you drop y_2ft_max, that shouldn't matter anymore!
> +	case 1:
> +		*x_min =3D ETP_XMIN_V1;
> +		*y_min =3D ETP_YMIN_V1;
> +		*x_max =3D ETP_XMAX_V1;
> +		*y_max =3D ETP_YMAX_V1;
> +		break;
> +
> +	case 2:
> +		if (etd->fw_version =3D=3D 0x020800 ||
> +		    etd->fw_version =3D=3D 0x020b00 ||
> +		    etd->fw_version =3D=3D 0x020030) {
> +			*x_min =3D ETP_XMIN_V2;
> +			*y_min =3D ETP_YMIN_V2;
> +			*x_max =3D ETP_XMAX_V2;
> +			*y_max =3D ETP_YMAX_V2;
> +			*y_2ft_max =3D ETP_2FT_YMAX;
> +			break;
> +		}

Actually these variables are defined as:
#define ETP_YMAX_V2	( 768 - ETP_EDGE_FUZZ_V2)

I'd suggest to remove trying being too clever and remove the=20
ETP_EDGE_FUZZ_V2. They should be just the raw resolution of the device.=
=20
Otherwise, they can cause underflow on the Y axis.

=46inally, a minor style suggestion, in "case 2:" above, only use one=20
single "break;" and put the two part in a complete "if-else" statement,=
=20
with xmin, y_min all explicit. E.g.:
case 2:
	if (etd->fw_version =3D=3D 0x020800 ||
	    etd->fw_version =3D=3D 0x020b00 ||
	    etd->fw_version =3D=3D 0x020030) {
		*x_min =3D ETP_XMIN_V2;
		*y_min =3D ETP_YMIN_V2;
		*x_max =3D ETP_XMAX_V2;
		*y_max =3D ETP_YMAX_V2;
	} else {
		i =3D (etd->fw_version > 0x020800 &&
		     etd->fw_version < 0x020900) ? 1 : 2;
		*x_min =3D 0;
		*y_min =3D 0;
		*x_max =3D (etd->capabilities[1] - i) * 64;
		*y_max =3D (etd->capabilities[2] - i) * 64;
	}
	break;

> If so, I will create another patch for this change.
>
If you could send a new version of this patch with these changes, it'd=20
be great :-)

Cheers,
=C9ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
