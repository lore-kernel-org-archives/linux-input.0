From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 6 Jun 2017 14:04:00 +0200
Message-ID: <20170606120400.ekfbbaai7myscitu@flea.lan>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
 <20170529144538.29187-2-mylene.josserand@free-electrons.com>
 <20170530080225.rgvy5too2cy5m2zp@flea.lan>
 <c732ffe4-e0fb-16d7-c27a-d18a1995c360@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="urdpkldrxvx74oam"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35605 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFFMEN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 08:04:13 -0400
Content-Disposition: inline
In-Reply-To: <c732ffe4-e0fb-16d7-c27a-d18a1995c360@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mylene Josserand <mylene.josserand@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, fery@cypress.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com


--urdpkldrxvx74oam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 10:03:48AM +0200, Mylene Josserand wrote:
> > > +static int cyttsp5_validate_cmd_response(struct cyttsp5 *ts, u8 code)
> > > +{
> > > +	u16 size, crc;
> > > +	u8 status, offset;
> > > +	int command_code;
> > > +
> > > +	size =3D get_unaligned_le16(&ts->response_buf[0]);
> > > +
> > > +	if (!size)
> > > +		return 0;
> > > +
> > > +	offset =3D ts->response_buf[HID_OUTPUT_RESPONSE_REPORT_OFFSET];
> > > +
> > > +	if (offset =3D=3D HID_BL_RESPONSE_REPORT_ID) {
> > > +		if (ts->response_buf[4] !=3D HID_OUTPUT_BL_SOP) {
> > > +			dev_err(ts->dev, "%s: HID output response, wrong SOP\n",
> > > +				__func__);
> > > +			return -EPROTO;
> > > +		}
> > > +
> > > +		if (ts->response_buf[size - 1] !=3D HID_OUTPUT_BL_EOP) {
> > > +			dev_err(ts->dev, "%s: HID output response, wrong EOP\n",
> > > +				__func__);
> > > +			return -EPROTO;
> > > +		}
> > > +
> > > +		crc =3D cyttsp5_compute_crc(&ts->response_buf[4], size - 7);
> > > +		if (ts->response_buf[size - 3] !=3D LOW_BYTE(crc)
> > > +		    || ts->response_buf[size - 2] !=3D HI_BYTE(crc)) {
> > > +			dev_err(ts->dev, "%s: HID output response, wrong CRC 0x%X\n",
> > > +				__func__, crc);
> > > +			return -EPROTO;
> > > +		}
> > > +
> > > +		status =3D ts->response_buf[5];
> > > +		if (status) {
> > > +			dev_err(ts->dev, "%s: HID output response, ERROR:%d\n",
> > > +				__func__, status);
> > > +			return -EPROTO;
> > > +		}
> > > +	}
> > > +
> > > +	if (offset =3D=3D HID_APP_RESPONSE_REPORT_ID) {
> > > +		command_code =3D ts->response_buf[HID_OUTPUT_RESPONSE_CMD_OFFSET]
> > > +			& HID_OUTPUT_RESPONSE_CMD_MASK;
> > > +		if (command_code !=3D code) {
> > > +			dev_err(ts->dev,
> > > +				"%s: HID output response, wrong command_code:%X\n",
> > > +				__func__, command_code);
> > > +			return -EPROTO;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void cyttsp5_si_get_btn_data(struct cyttsp5 *ts)
> > > +{
> > > +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > > +	int i;
> > > +	int num_btns =3D 0;
> > > +	unsigned int btns =3D ts->response_buf[HID_SYSINFO_BTN_OFFSET]
> > > +		& HID_SYSINFO_BTN_MASK;
> > > +
> > > +	for (i =3D 0; i < HID_SYSINFO_MAX_BTN; i++) {
> > > +		if (btns & (1 << i))
> > > +			num_btns++;
> > > +	}
> > > +	si->num_btns =3D num_btns;
> > > +}
> > > +
> > > +static int cyttsp5_get_sysinfo_regs(struct cyttsp5 *ts)
> > > +{
> > > +	struct cyttsp5_sensing_conf_data *scd =3D &ts->sysinfo.sensing_conf=
_data;
> > > +	struct cyttsp5_sensing_conf_data_dev *scd_dev =3D
> > > +		(struct cyttsp5_sensing_conf_data_dev *)
> > > +		&ts->response_buf[HID_SYSINFO_SENSING_OFFSET];
> > > +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> > > +
> > > +	cyttsp5_si_get_btn_data(ts);
> > > +
> > > +	scd->max_tch =3D scd_dev->max_num_of_tch_per_refresh_cycle;
> > > +	scd->res_x =3D get_unaligned_le16(&scd_dev->res_x);
> > > +	scd->res_y =3D get_unaligned_le16(&scd_dev->res_y);
> > > +	scd->max_z =3D get_unaligned_le16(&scd_dev->max_z);
> > > +	scd->len_x =3D get_unaligned_le16(&scd_dev->len_x);
> > > +	scd->len_y =3D get_unaligned_le16(&scd_dev->len_y);
> > > +
> > > +	si->xy_data =3D devm_kzalloc(ts->dev, scd->max_tch * TOUCH_REPORT_S=
IZE,
> > > +				   GFP_KERNEL);
> > > +	if (!si->xy_data)
> > > +		return -ENOMEM;
> > > +
> > > +	si->xy_mode =3D devm_kzalloc(ts->dev, TOUCH_INPUT_HEADER_SIZE, GFP_=
KERNEL);
> > > +	if (!si->xy_mode) {
> > > +		devm_kfree(ts->dev, si->xy_data);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
> > > +{
> > > +	int rc, t;
> > > +	u8 cmd[HID_OUTPUT_GET_SYSINFO_SIZE];
> > > +
> > > +	mutex_lock(&ts->system_lock);
> > > +	ts->hid_cmd_state =3D HID_OUTPUT_GET_SYSINFO + 1;
> > > +	mutex_unlock(&ts->system_lock);
> > > +
> > > +	/* HI bytes of Output register address */
> > > +	cmd[0] =3D LOW_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> > > +	cmd[1] =3D HI_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> > > +	cmd[2] =3D HID_APP_OUTPUT_REPORT_ID;
> > > +	cmd[3] =3D 0x0; /* Reserved */
> > > +	cmd[4] =3D HID_OUTPUT_GET_SYSINFO;
> > > +
> > > +	rc =3D cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> > > +			   HID_OUTPUT_GET_SYSINFO_SIZE);
> > > +	if (rc) {
> > > +		dev_err(ts->dev, "%s: Failed to write command %d",
> > > +			__func__, rc);
> > > +		goto error;
> > > +	}
> > > +
> > > +	t =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D 0),
> > > +			       msecs_to_jiffies(CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT));
> > > +	if (IS_TMO(t)) {
> > > +		dev_err(ts->dev, "%s: HID output cmd execution timed out\n",
> > > +			__func__);
> > > +		rc =3D -ETIME;
> > > +		goto error;
> > > +	}
> > > +
> > > +	rc =3D cyttsp5_validate_cmd_response(ts, HID_OUTPUT_GET_SYSINFO);
> > > +	goto exit;
> > > +
> > > +error:
> > > +	mutex_lock(&ts->system_lock);
> > > +	ts->hid_cmd_state =3D 0;
> > > +	mutex_unlock(&ts->system_lock);
> > > +	return rc;
> > > +exit:
> > > +	rc =3D cyttsp5_get_sysinfo_regs(ts);
> > > +
> > > +	return rc;
> > > +}
> > > +
> > > +static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
> > > +{
> > > +	int rc, t;
> > > +	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP];
> > > +	u16 crc;
> > > +
> > > +	mutex_lock(&ts->system_lock);
> > > +	ts->hid_cmd_state =3D HID_OUTPUT_BL_LAUNCH_APP + 1;
> > > +	mutex_unlock(&ts->system_lock);
> > > +
> > > +	cmd[0] =3D LOW_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> > > +	cmd[1] =3D HI_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> > > +	cmd[2] =3D HID_BL_OUTPUT_REPORT_ID;
> > > +	cmd[3] =3D 0x0; /* Reserved */
> > > +	cmd[4] =3D HID_OUTPUT_BL_SOP;
> > > +	cmd[5] =3D HID_OUTPUT_BL_LAUNCH_APP;
> > > +	cmd[6] =3D 0x0; /* Low bytes of data */
> > > +	cmd[7] =3D 0x0; /* Hi bytes of data */
> > > +	crc =3D cyttsp5_compute_crc(&cmd[4], 4);
> > > +	cmd[8] =3D LOW_BYTE(crc);
> > > +	cmd[9] =3D HI_BYTE(crc);
> > > +	cmd[10] =3D HID_OUTPUT_BL_EOP;
> > > +
> > > +	rc =3D cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> > > +			   HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> >=20
> > It seems like you'll send HID_OUTPUT_BL_LAUNCH_APP_SIZE twice here,
> > once as setup in cyttsp5_write, and once in the buffer you want to
> > send. Is that on purpose?
>=20
> I am not sure to see the second time it is sent. What do you mean by "as
> setup in cyttsp5_write"? Anyway, the size is needed in the buffer of the
> frame.

Nevermind, I confused the HID_OUTPUT_BL_LAUNCH_APP_SIZE with the
register, my bad.

> > > +	/* Call platform init function */
> > > +	ts->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_=
HIGH);
> > > +	if (IS_ERR(ts->reset_gpio)) {
> > > +		rc =3D PTR_ERR(ts->reset_gpio);
> > > +		dev_err(dev, "Failed to request reset gpio, error %d\n", rc);
> > > +		return rc;
> > > +	}
> > > +
> > > +	/* Need a delay to have device up */
> > > +	msleep(20);
> >=20
> > In the case where the device has already been out of reset, this means
> > that this alone is not sufficient to reset it and bring it out of
> > reset, which also means that you do not have any guarantee on the
> > current state of the device. I'm not sure how it would impact the
> > proper operations though.
>=20
> Okay. A reset frame can be sent to perform a "software
> reset". Should I add it on startup to be in a "known behavior"?

I guess you'd be safer just getting the GPIO with the low level by
default, and then changing to high. That way you know that you went
through a reset state, before bringing up the device.
> > > +	ts->input =3D input_allocate_device();
> > > +	if (!ts->input) {
> > > +		dev_err(dev, "%s: Error, failed to allocate input device\n",
> > > +			__func__);
> > > +		rc =3D -ENODEV;
> > > +		goto error_startup;
> > > +	}
> >=20
> > In error_startup, you never uninitialize the device. Given your
> > comment in cyttsp5_startup, this means that you might end up in a
> > situation where your driver probes again with the device initialized
> > and no longer in a bootloader mode, which is likely to cause some
> > error.
> >=20
> > Putting the call to cyttsp5_startup later will make you less likely to
> > fail (especially because of the DT parsing), and putting the device
> > back into reset will probably address the issue once and for all.
>=20
> Hm, I am not sure to understand what you want to say, here.
> Could you explain me more what you have in mind?

I meant to say that there was still an issue with the reset here, and
moving the DT parsing code further would ease the reset operation.

> Notice that the DT parsing uses a sysinfo's variable (si->num_btns)
> which is retrieved in the startup function (thanks to
> get_sysinfo). So, currently, it is not possible to move the startup
> function after the DT parsing.

Can't that be made the other way around? You parse the number of
buttons in the DT, and check the consistency with the hardware?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--urdpkldrxvx74oam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZNpowAAoJEBx+YmzsjxAgUIEP/RRYOELcu5RhVetmeLdqq3T3
nwJBjQ3CHDJmI2hD59YzdnOB0Vtw89cn2cUH03CoiWKY5vHkj23s10vyNULbhAGs
zPWe4j5VLZfG0YZhn5fJ1RVZhQUVNlWsWLWYlnHfxDvt/equVZ/6ptIcQHoYtMEe
uUqtJjx0kr3uX/MtMlBZJXT1ReyiRYiBU4n4MoSSOJUsvjayjscAeT7D2ZY8bN47
GBZQgnWzy9YuHXIIerFibF9maWy+UcMJMMhjLFyZPmq9G5BA5wYwwFEry8kUBG4+
enfzsOX7cH6XDEIUV9XQ6FMG06ldVrMRDu0dbmTbIYp+lov3L9YG5kG/KxAvFhrP
e3ZVPe2llwLqKwguwBlwBnpe7pSKsT3vkwVlFXMzqiGExo4Sr2KR1jGRZWN76M9h
6VzeXk+6pfktYC2egFQE0XmHDwsgHLvY4j71R4ofxv+iqycwZkkF5h0Qqz6ddB4c
nGvzr80dBDnxGjRqxRAt4MwHqE/+qig5wlRK8+bTFdMcGospziXzk9QFH6st0AvB
SgMNABerGXd1vHdWw77UJDZHYMFjDFf3dDbXF7yE3rQVAFEStzaZi7yux4B28F75
G3WWxUV7M665Yn/WIItBVROFqQibZi9QQSaPLC49zmLe/DLyUJra4ntN9RTAsbOL
wGREO5a9VtalMMkO5Gv5
=0WAY
-----END PGP SIGNATURE-----

--urdpkldrxvx74oam--
