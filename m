From: Marcus Folkesson <marcus.folkesson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Mon, 22 Jan 2018 21:11:09 +0100
Message-ID: <20180122201109.GA651@gmail.com>
References: <20171201153957.13053-1-mylene.josserand@free-electrons.com>
 <20171201153957.13053-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171201153957.13053-2-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mylene,

On Fri, Dec 01, 2017 at 04:39:56PM +0100, Myl=E8ne Josserand wrote:
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -0,0 +1,1110 @@
> +/*
> + * Parade TrueTouch(TM) Standard Product V5 Module.
> + * For use with Parade touchscreen controllers.
> + *
> + * Copyright (C) 2015 Parade Technologies
> + * Copyright (C) 2012-2015 Cypress Semiconductor
> + * Copyright (C) 2017 Free Electrons
> + *
> + * Author: Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, and only version 2, as published by the
> + * Free Software Foundation.

Please use SPDX license Identifier to describe the license.

E.g.
SPDX-License-Identifier: GPL-2.0

Also, the MODULE_LICENSE means GPL 2.0 or later per module.h and this does
not match the license description.

Could you make sure they are in sync?


> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/crc-itu-t.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>

#include <linux/bitops.h>

since you are using BIT()


[snip]


> +static int cyttsp5_setup_input_device(struct device *dev)
> +{
> +	struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int max_x, max_y, max_p;
> +	int max_x_tmp, max_y_tmp;
> +	int rc;
> +
> +	__set_bit(EV_ABS, ts->input->evbit);
> +	__set_bit(EV_REL, ts->input->evbit);
> +	__set_bit(EV_KEY, ts->input->evbit);
> +
> +	max_x_tmp =3D si->sensing_conf_data.res_x;
> +	max_y_tmp =3D si->sensing_conf_data.res_y;
> +	max_x =3D max_y_tmp - 1;
> +	max_y =3D max_x_tmp - 1;
> +	max_p =3D si->sensing_conf_data.max_z;
> +
> +	input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].max, 0);
> +
> +	__set_bit(ABS_MT_POSITION_X, ts->input->absbit);
> +	__set_bit(ABS_MT_POSITION_Y, ts->input->absbit);
> +	__set_bit(ABS_MT_PRESSURE, ts->input->absbit);

Not needed, input_set_abs_params() will set the bits for you below.


> +
> +	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, max_x, 0, 0);
> +	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
> +	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, max_p, 0, 0);
> +
> +	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 0);
> +	input_set_abs_params(ts->input, ABS_MT_TOUCH_MINOR, 0, MAX_AREA, 0, 0);
> +
> +	rc =3D input_register_device(ts->input);
> +	if (rc < 0)
> +		dev_err(dev, "Error, failed register input device r=3D%d\n", rc);
> +
> +	return rc;
> +}
> +
> +

[snip]

> +static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
> +				      struct cyttsp5_hid_desc *desc)
> +{
> +	struct device *dev =3D ts->dev;
> +	__le16 hid_desc_register =3D HID_DESC_REG;
> +	int rc;
> +	u8 cmd[2];
> +
> +	/* Read HID descriptor length and version */
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D HID_CMD_BUSY;
> +	mutex_unlock(&ts->system_lock);
> +
> +	/* Set HID descriptor register */
> +	memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
> +
> +	rc =3D cyttsp5_write(ts, HID_DESC_REG, NULL, 0);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to get HID descriptor, rc=3D%d\n", rc);
> +		goto error;
> +	}
> +
> +	rc =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D HID_CMD=
_DONE),
> +				msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT));
> +	if (!rc) {
> +		dev_err(ts->dev, "HID get descriptor timed out\n");
> +		rc =3D -ETIME;
> +		goto error;
> +	}
> +
> +	memcpy(desc, ts->response_buf, sizeof(struct cyttsp5_hid_desc));
> +
> +	/* Check HID descriptor length and version */
> +	if (le16_to_cpu(desc->hid_desc_len) !=3D sizeof(*desc) ||
> +	    le16_to_cpu(desc->bcd_version) !=3D HID_VERSION) {
> +		dev_err(dev, "Unsupported HID version\n");
> +		return -ENODEV;

Maybe it is supposed to return here, but all other faults use "goto
error".

> +	}
> +
> +	goto exit;
> +
> +error:
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D HID_CMD_DONE;
> +	mutex_unlock(&ts->system_lock);
> +exit:
> +	return rc;
> +}
> +

[snip]

> +static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int =
irq,
> +			 const char *name)
> +{
> +	struct cyttsp5 *ts;
> +	struct cyttsp5_sysinfo *si;
> +	int rc =3D 0, i;
> +
> +	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	/* Initialize device info */
> +	ts->regmap =3D regmap;
> +	ts->dev =3D dev;
> +	si =3D &ts->sysinfo;
> +	dev_set_drvdata(dev, ts);
> +
> +	/* Initialize mutexes and spinlocks */

No spinlocks here :-)

> +	mutex_init(&ts->system_lock);
> +
> +	/* Initialize wait queue */
> +	init_waitqueue_head(&ts->wait_q);
> +
> +	/* Reset the gpio to be in a reset state */
> +	ts->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ts->reset_gpio)) {
> +		rc =3D PTR_ERR(ts->reset_gpio);
> +		dev_err(dev, "Failed to request reset gpio, error %d\n", rc);
> +		return rc;
> +	}
> +	gpiod_set_value(ts->reset_gpio, 1);
> +

[snip]

> +static struct i2c_driver cyttsp5_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D CYTTSP5_NAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(cyttsp5_of_match),
> +	},
> +	.probe =3D cyttsp5_i2c_probe,
> +	.remove =3D cyttsp5_i2c_remove,
> +	.id_table =3D cyttsp5_i2c_id,
> +};
> +
> +module_i2c_driver(cyttsp5_i2c_driver);
> +
> +MODULE_LICENSE("GPL");

=46rom linux/module.h:

/*
 * The following license idents are currently accepted as indicating free
 * software modules
 *
 *	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]



> +MODULE_DESCRIPTION("Touchscreen driver for Cypress TrueTouch Gen 5 Produ=
ct");
> +MODULE_AUTHOR("Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>"=
);
> --=20
> 2.11.0
>=20

Best regards
Marcus Folkesson

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpmRVgACgkQiIBOb1ld
UjKgZhAA0saajnKQiVvztDIpYEjHeDLD9xPgyrHnU7ZMrZkyJfUNKOsYh5wGRxPn
wDfzRKAW6eH/6QGF6rnxIvdGoiqXi4NukTyiPQbg6ztWgLOrSlZMC+YA744Y7XC7
kT/FliZ8AZFQWDWop7QL+SlW8WRgrhhhTxHDHmy2bD/0nww/dn4jPfIjrafxcJN2
9oyFkn+CKSmKF5mBNg5EO2vT4HARJWnFtfe91YjCBXf4Pp/hVyWXtL00xiVCITeb
H9Yc5E16IvHEsM+oCBQOSMwgFh6cyFSC/5VFMO9Gxk9dVqMkqFDPre7JdeYqXHiV
6+OyrOXGoqfCmyFEP3q3w4Cp3L1PcuCGnSDxIq/N27DmhqPDuxQqosu3BPxZ+dc3
S8TuuEQwIuHns0P0f7ZeVO2oH4pqOPoF+l9cAdA+N88QgZrrkdy1Q/6pgmg5iCxo
bLjpeqxHTP4Wbnt/Q324ZxQTcCMhAg7F4p9ohn1g3VpsAxfFGU33EgMa8brCDIF1
whsz6rPZDzxaYVobtQfCy54BMdQXCD5WlXR3sId5XX0nJTdRxmzHoragPECulVuk
uIwYUIxhQW80ahRhT9hzRf7K8wWGm2hM4UqXbRC8INsPDJXMocMWycKRNJL3QtZ8
ByYbrpQs4sBtWwV4+Gklnmyef+DYTGYUO0u0HnN3SYrF4aKZRXc=
=G/K9
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
