From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] Input: tl6040-vibra: Device Tree support
Date: Mon, 07 May 2012 13:49:29 +0300
Message-ID: <4FA7A8B9.4040208@ti.com>
References: <1336133113-12224-1-git-send-email-peter.ujfalusi@ti.com> <20120507070233.GB22074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120507070233.GB22074@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 05/07/2012 10:02 AM, Dmitry Torokhov wrote:
> Hi Peter,
>=20
> On Fri, May 04, 2012 at 03:05:13PM +0300, Peter Ujfalusi wrote:
>> +	if (pdata) {
>> +		info->vibldrv_res =3D pdata->vibldrv_res;
>> +		info->vibrdrv_res =3D pdata->vibrdrv_res;
>> +		info->viblmotor_res =3D pdata->viblmotor_res;
>> +		info->vibrmotor_res =3D pdata->vibrmotor_res;
>> +		vddvibl_uV =3D pdata->vddvibl_uV;
>> +		vddvibr_uV =3D pdata->vddvibr_uV;
>> +	} else {
>> +		of_property_read_u32(node, "vibldrv_res", &info->vibldrv_res);
>> +		of_property_read_u32(node, "vibrdrv_res", &info->vibrdrv_res);
>> +		of_property_read_u32(node, "viblmotor_res",
>> +				     &info->viblmotor_res);
>> +		of_property_read_u32(node, "vibrmotor_res",
>> +				     &info->vibrmotor_res);
>=20
> Since these 4 appear to be mandatory properties don't we need to
> validate they are actually present in DT?

If the property does not exist in the DT blob the variable will not be
updated - it will remain 0.
I have kept the validity check for the resistance values. This will
catch the case when something is missing from the DT blob.

I just did not wanted to complicate the code with additional checks
since the end result would be the same.

--=20
P=E9ter
