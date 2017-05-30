From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 30 May 2017 10:02:25 +0200
Message-ID: <20170530080225.rgvy5too2cy5m2zp@flea.lan>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
 <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wjibihnatzfm4fzh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, fery@cypress.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com
List-Id: linux-input@vger.kernel.org


--wjibihnatzfm4fzh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

On Mon, May 29, 2017 at 04:45:37PM +0200, Myl=E8ne Josserand wrote:
> +static int cyttsp5_read(struct cyttsp5 *ts, u8 *buf, u32 max)
> +{
> +	int rc;
> +	u32 size;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	/* Read the frame to retrieve the size */
> +	rc =3D regmap_bulk_read(ts->regmap, 0, buf, 2);
> +	if (rc < 0)
> +		return rc;

You should probably use a temporary buffer here, instead of the caller
one. Otherwise, you might return an error (a bit below, in the (size >
max) test), while you modified the caller buffer, which seems a bit
odd.

> +	size =3D get_unaligned_le16(&buf[0]);

isn't &buf[0] the same thing than buf here ?

> +	if (!size || size =3D=3D 2)
> +		return 0;
> +
> +	if (size > max)
> +		return -EINVAL;
> +
> +	/* Get the real value */
> +	return regmap_bulk_read(ts->regmap, 0, buf, size);
> +}
> +
> +static int cyttsp5_write(struct cyttsp5 *ts, unsigned int reg, u8 *data,
> +			 size_t size)
> +{
> +	u8 cmd[size + 1];
> +
> +	/* High bytes of register address needed as first byte of cmd */
> +	cmd[0] =3D HI_BYTE(reg);
> +	/* Copy the rest of the data */
> +	memcpy(&cmd[1], data, size);
> +
> +	return regmap_bulk_write(ts->regmap, LOW_BYTE(reg), cmd, size + 1);

The way we need to access the buffers here is definitely not trivial,
I guess some comment about how the hardware expects the commands to be
sent would be welcome.

> +}
> +
> +static void cyttsp5_final_sync(struct input_dev *input, int max_slots,
> +			       unsigned long *ids)
> +{
> +	int t;
> +
> +	for (t =3D 0; t < max_slots; t++) {
> +		if (test_bit(t, ids))
> +			continue;
> +		input_mt_slot(input, t);
> +		input_mt_report_slot_state(input, MT_TOOL_FINGER, false);
> +	}
> +
> +	input_sync(input);
> +}
> +
> +static void cyttsp5_report_slot_liftoff(struct cyttsp5 *ts, int max_slot=
s)
> +{
> +	int t;
> +
> +	if (ts->num_prv_rec =3D=3D 0)
> +		return;
> +
> +	for (t =3D 0; t < max_slots; t++) {
> +		input_mt_slot(ts->input, t);
> +		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, false);
> +	}
> +}
> +
> +static void cyttsp5_mt_lift_all(struct cyttsp5 *ts)
> +{
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int max =3D si->tch_abs[CY_TCH_T].max;
> +
> +	if (ts->num_prv_rec !=3D 0) {
> +		cyttsp5_report_slot_liftoff(ts, max);
> +		input_sync(ts->input);
> +		ts->num_prv_rec =3D 0;
> +	}
> +}
> +
> +static void cyttsp5_get_touch_axis(int *axis, int size, int max, u8 *xy_=
data,
> +				   int bofs)
> +{
> +	int nbyte;
> +	int next;
> +
> +	for (nbyte =3D 0, *axis =3D 0, next =3D 0; nbyte < size; nbyte++) {
> +		*axis =3D *axis + ((xy_data[next] >> bofs) << (nbyte * 8));
> +		next++;

Isn't nbyte and next the same thing here ?

> +	}
> +
> +	*axis &=3D max - 1;
> +}
> +
> +static void cyttsp5_get_touch_record(struct cyttsp5 *ts,
> +				     struct cyttsp5_touch *touch, u8 *xy_data)
> +{
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	enum cyttsp5_tch_abs abs;
> +
> +	for (abs =3D CY_TCH_X; abs < CY_TCH_NUM_ABS; abs++) {
> +		cyttsp5_get_touch_axis(&touch->abs[abs],
> +				       si->tch_abs[abs].size,
> +				       si->tch_abs[abs].max,
> +				       xy_data + si->tch_abs[abs].ofs,
> +				       si->tch_abs[abs].bofs);
> +	}
> +}
> +
> +static void cyttsp5_mt_process_touch(struct cyttsp5 *ts,
> +				     struct cyttsp5_touch *touch)
> +{
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int tmp;
> +
> +	tmp =3D touch->abs[CY_TCH_X];
> +	touch->abs[CY_TCH_X] =3D touch->abs[CY_TCH_Y];
> +	touch->abs[CY_TCH_Y] =3D tmp;

Why do you need to swap the values here?

Instead of rolling your own implementation, you can use swap()

> +	/* Convert MAJOR/MINOR from mm to resolution */
> +	tmp =3D touch->abs[CY_TCH_MAJ] * 100 * si->sensing_conf_data.res_x;
> +	touch->abs[CY_TCH_MAJ] =3D tmp / si->sensing_conf_data.len_x;
> +	tmp =3D touch->abs[CY_TCH_MIN] * 100 * si->sensing_conf_data.res_x;
> +	touch->abs[CY_TCH_MIN] =3D tmp / si->sensing_conf_data.len_x;
> +}
> +
> +static void cyttsp5_get_mt_touches(struct cyttsp5 *ts,
> +				   struct cyttsp5_touch *tch, int num_cur_tch)
> +{
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int i, t =3D 0;
> +	DECLARE_BITMAP(ids, si->tch_abs[CY_TCH_T].max);
> +	u8 *tch_addr;
> +
> +	bitmap_zero(ids, si->tch_abs[CY_TCH_T].max);
> +	memset(tch->abs, 0, sizeof(tch->abs));
> +
> +	for (i =3D 0; i < num_cur_tch; i++) {
> +		tch_addr =3D si->xy_data + (i * TOUCH_REPORT_SIZE);
> +		cyttsp5_get_touch_record(ts, tch, tch_addr);
> +
> +		/* Process touch */
> +		cyttsp5_mt_process_touch(ts, tch);

Maybe you should just make that function return a structure, or fill
one directly passed as an argument. Filling only one field of a
particular structure passed as an argument to exchange data doesn't
seem very natural. Especially since you don't really use tch in that
function.

> +
> +		t =3D tch->abs[CY_TCH_T];
> +		input_mt_slot(ts->input, t);
> +		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, true);
> +		__set_bit(t, ids);
> +
> +		/* position and pressure fields */
> +		input_report_abs(ts->input, ABS_MT_POSITION_X, tch->abs[CY_TCH_X]);
> +		input_report_abs(ts->input, ABS_MT_POSITION_Y, tch->abs[CY_TCH_Y]);
> +		input_report_abs(ts->input, ABS_MT_PRESSURE, tch->abs[CY_TCH_P]);
> +
> +		/* Get the extended touch fields */
> +		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, tch->abs[CY_TCH_MAJ]);
> +		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, tch->abs[CY_TCH_MIN]);
> +	}
> +
> +	cyttsp5_final_sync(ts->input, si->tch_abs[CY_TCH_T].max, ids);
> +
> +	ts->num_prv_rec =3D num_cur_tch;
> +}
> +
> +/* read xy_data for all current touches */
> +static int cyttsp5_xy_worker(struct cyttsp5 *ts)
> +{
> +	struct device *dev =3D ts->dev;
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int max_tch =3D si->sensing_conf_data.max_tch;
> +	struct cyttsp5_touch tch;
> +	u8 num_cur_tch;
> +
> +	cyttsp5_get_touch_axis(&tch.hdr, si->tch_hdr.size,
> +			       si->tch_hdr.max,
> +			       si->xy_mode + 3 + si->tch_hdr.ofs,
> +			       si->tch_hdr.bofs);
> +
> +	num_cur_tch =3D tch.hdr;
> +	if (num_cur_tch > max_tch) {
> +		dev_err(dev, "%s: Num touch err detected (n=3D%d)\n",
> +			__func__, num_cur_tch);
> +		num_cur_tch =3D max_tch;
> +	}
> +
> +	if (num_cur_tch =3D=3D 0 && ts->num_prv_rec =3D=3D 0)
> +		return 0;
> +
> +	/* extract xy_data for all currently reported touches */
> +	if (num_cur_tch)
> +		cyttsp5_get_mt_touches(ts, &tch, num_cur_tch);
> +	else
> +		cyttsp5_mt_lift_all(ts);
> +
> +	return 0;
> +}
> +
> +static int cyttsp5_mt_attention(struct device *dev)
> +{
> +	struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int rc;
> +
> +	if (si->xy_mode[2] !=3D HID_TOUCH_REPORT_ID)
> +		return 0;
> +
> +	/* core handles handshake */
> +	mutex_lock(&ts->mt_lock);
> +	rc =3D cyttsp5_xy_worker(ts);
> +	mutex_unlock(&ts->mt_lock);
> +	if (rc < 0)
> +		dev_err(dev, "%s: xy_worker error r=3D%d\n", __func__, rc);
> +
> +	return rc;
> +}
> +
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
> +		dev_err(dev, "%s: Error, failed register input device r=3D%d\n",
> +			__func__, rc);
> +
> +	return rc;
> +}
> +
> +static int cyttsp5_parse_dt_key_code(struct device *dev)
> +{
> +	struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	struct device_node *np, *pp;
> +	int rc, i;
> +
> +	np =3D dev->of_node;
> +	if (!np)
> +		return -EINVAL;
> +
> +	if (si->num_btns) {
> +		si->btn =3D devm_kzalloc(dev,
> +				       si->num_btns * sizeof(struct cyttsp5_btn),
> +				       GFP_KERNEL);
> +		if (!si->btn)
> +			return -ENOMEM;
> +
> +		/* Initialized the button to RESERVED */
> +		for (i =3D 0; i < si->num_btns; i++) {
> +			struct cyttsp5_btn *btns =3D &si->btn[i];
> +			btns->key_code =3D KEY_RESERVED;
> +			btns->enabled =3D true;
> +		}
> +	}
> +
> +	i =3D 0;
> +	for_each_child_of_node(np, pp) {
> +		struct cyttsp5_btn *btns =3D &si->btn[i];
> +
> +		rc =3D of_property_read_u32(pp, "linux,code", &btns->key_code);
> +		if (rc) {
> +			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
> +			return -EINVAL;
> +		}
> +		btns->enabled =3D true;
> +
> +		i++;
> +	}
> +
> +	return i;
> +}
> +
> +static int cyttsp5_btn_attention(struct device *dev)
> +{
> +	struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int cur_btn;
> +	int cur_btn_state;
> +
> +	if (si->xy_mode[2] !=3D HID_BTN_REPORT_ID)
> +		return 0;
> +
> +	/* core handles handshake */
> +	mutex_lock(&ts->btn_lock);
> +
> +	/* extract button press/release touch information */
> +	if (si->num_btns > 0) {
> +		for (cur_btn =3D 0; cur_btn < si->num_btns; cur_btn++) {
> +			/* Get current button state */
> +			cur_btn_state =3D (si->xy_data[0] >> (cur_btn * CY_BITS_PER_BTN))
> +				& CY_NUM_BTN_EVENT_ID;
> +
> +			if (!si->btn[cur_btn].enabled)
> +				continue;
> +
> +			input_report_key(ts->input, si->btn[cur_btn].key_code,
> +					 cur_btn_state);
> +			input_sync(ts->input);
> +		}
> +	}
> +
> +	mutex_unlock(&ts->btn_lock);
> +
> +	return 0;
> +}
> +
> +static const u16 crc_table[16] =3D {
> +	0x0000, 0x1021, 0x2042, 0x3063,
> +	0x4084, 0x50a5, 0x60c6, 0x70e7,
> +	0x8108, 0x9129, 0xa14a, 0xb16b,
> +	0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
> +};

This looks like a shorter version of crc_itu_t_table.

> +static u16 cyttsp5_compute_crc(u8 *buf, u32 size)
> +{
> +	u16 remainder =3D 0xFFFF;
> +	u16 xor_mask =3D 0x0000;
> +	u32 index;
> +	u32 byte_value;
> +	u32 table_index;
> +	u32 crc_bit_width =3D sizeof(u16) * 8;
> +
> +	/* Divide the message by polynomial, via the table. */
> +	for (index =3D 0; index < size; index++) {
> +		byte_value =3D buf[index];
> +		table_index =3D ((byte_value >> 4) & 0x0F)
> +			^ (remainder >> (crc_bit_width - 4));
> +		remainder =3D crc_table[table_index] ^ (remainder << 4);
> +		table_index =3D (byte_value & 0x0F)
> +			^ (remainder >> (crc_bit_width - 4));
> +		remainder =3D crc_table[table_index] ^ (remainder << 4);
> +	}
> +
> +	/* Perform the final remainder CRC. */
> +	return remainder ^ xor_mask;
> +}

Could it be that it's just using the CRC ITU-T algorithm?

> +static int cyttsp5_validate_cmd_response(struct cyttsp5 *ts, u8 code)
> +{
> +	u16 size, crc;
> +	u8 status, offset;
> +	int command_code;
> +
> +	size =3D get_unaligned_le16(&ts->response_buf[0]);
> +
> +	if (!size)
> +		return 0;
> +
> +	offset =3D ts->response_buf[HID_OUTPUT_RESPONSE_REPORT_OFFSET];
> +
> +	if (offset =3D=3D HID_BL_RESPONSE_REPORT_ID) {
> +		if (ts->response_buf[4] !=3D HID_OUTPUT_BL_SOP) {
> +			dev_err(ts->dev, "%s: HID output response, wrong SOP\n",
> +				__func__);
> +			return -EPROTO;
> +		}
> +
> +		if (ts->response_buf[size - 1] !=3D HID_OUTPUT_BL_EOP) {
> +			dev_err(ts->dev, "%s: HID output response, wrong EOP\n",
> +				__func__);
> +			return -EPROTO;
> +		}
> +
> +		crc =3D cyttsp5_compute_crc(&ts->response_buf[4], size - 7);
> +		if (ts->response_buf[size - 3] !=3D LOW_BYTE(crc)
> +		    || ts->response_buf[size - 2] !=3D HI_BYTE(crc)) {
> +			dev_err(ts->dev, "%s: HID output response, wrong CRC 0x%X\n",
> +				__func__, crc);
> +			return -EPROTO;
> +		}
> +
> +		status =3D ts->response_buf[5];
> +		if (status) {
> +			dev_err(ts->dev, "%s: HID output response, ERROR:%d\n",
> +				__func__, status);
> +			return -EPROTO;
> +		}
> +	}
> +
> +	if (offset =3D=3D HID_APP_RESPONSE_REPORT_ID) {
> +		command_code =3D ts->response_buf[HID_OUTPUT_RESPONSE_CMD_OFFSET]
> +			& HID_OUTPUT_RESPONSE_CMD_MASK;
> +		if (command_code !=3D code) {
> +			dev_err(ts->dev,
> +				"%s: HID output response, wrong command_code:%X\n",
> +				__func__, command_code);
> +			return -EPROTO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void cyttsp5_si_get_btn_data(struct cyttsp5 *ts)
> +{
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +	int i;
> +	int num_btns =3D 0;
> +	unsigned int btns =3D ts->response_buf[HID_SYSINFO_BTN_OFFSET]
> +		& HID_SYSINFO_BTN_MASK;
> +
> +	for (i =3D 0; i < HID_SYSINFO_MAX_BTN; i++) {
> +		if (btns & (1 << i))
> +			num_btns++;
> +	}
> +	si->num_btns =3D num_btns;
> +}
> +
> +static int cyttsp5_get_sysinfo_regs(struct cyttsp5 *ts)
> +{
> +	struct cyttsp5_sensing_conf_data *scd =3D &ts->sysinfo.sensing_conf_dat=
a;
> +	struct cyttsp5_sensing_conf_data_dev *scd_dev =3D
> +		(struct cyttsp5_sensing_conf_data_dev *)
> +		&ts->response_buf[HID_SYSINFO_SENSING_OFFSET];
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +
> +	cyttsp5_si_get_btn_data(ts);
> +
> +	scd->max_tch =3D scd_dev->max_num_of_tch_per_refresh_cycle;
> +	scd->res_x =3D get_unaligned_le16(&scd_dev->res_x);
> +	scd->res_y =3D get_unaligned_le16(&scd_dev->res_y);
> +	scd->max_z =3D get_unaligned_le16(&scd_dev->max_z);
> +	scd->len_x =3D get_unaligned_le16(&scd_dev->len_x);
> +	scd->len_y =3D get_unaligned_le16(&scd_dev->len_y);
> +
> +	si->xy_data =3D devm_kzalloc(ts->dev, scd->max_tch * TOUCH_REPORT_SIZE,
> +				   GFP_KERNEL);
> +	if (!si->xy_data)
> +		return -ENOMEM;
> +
> +	si->xy_mode =3D devm_kzalloc(ts->dev, TOUCH_INPUT_HEADER_SIZE, GFP_KERN=
EL);
> +	if (!si->xy_mode) {
> +		devm_kfree(ts->dev, si->xy_data);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
> +{
> +	int rc, t;
> +	u8 cmd[HID_OUTPUT_GET_SYSINFO_SIZE];
> +
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D HID_OUTPUT_GET_SYSINFO + 1;
> +	mutex_unlock(&ts->system_lock);
> +
> +	/* HI bytes of Output register address */
> +	cmd[0] =3D LOW_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> +	cmd[1] =3D HI_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> +	cmd[2] =3D HID_APP_OUTPUT_REPORT_ID;
> +	cmd[3] =3D 0x0; /* Reserved */
> +	cmd[4] =3D HID_OUTPUT_GET_SYSINFO;
> +
> +	rc =3D cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> +			   HID_OUTPUT_GET_SYSINFO_SIZE);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Failed to write command %d",
> +			__func__, rc);
> +		goto error;
> +	}
> +
> +	t =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D 0),
> +			       msecs_to_jiffies(CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT));
> +	if (IS_TMO(t)) {
> +		dev_err(ts->dev, "%s: HID output cmd execution timed out\n",
> +			__func__);
> +		rc =3D -ETIME;
> +		goto error;
> +	}
> +
> +	rc =3D cyttsp5_validate_cmd_response(ts, HID_OUTPUT_GET_SYSINFO);
> +	goto exit;
> +
> +error:
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D 0;
> +	mutex_unlock(&ts->system_lock);
> +	return rc;
> +exit:
> +	rc =3D cyttsp5_get_sysinfo_regs(ts);
> +
> +	return rc;
> +}
> +
> +static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
> +{
> +	int rc, t;
> +	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP];
> +	u16 crc;
> +
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D HID_OUTPUT_BL_LAUNCH_APP + 1;
> +	mutex_unlock(&ts->system_lock);
> +
> +	cmd[0] =3D LOW_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +	cmd[1] =3D HI_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +	cmd[2] =3D HID_BL_OUTPUT_REPORT_ID;
> +	cmd[3] =3D 0x0; /* Reserved */
> +	cmd[4] =3D HID_OUTPUT_BL_SOP;
> +	cmd[5] =3D HID_OUTPUT_BL_LAUNCH_APP;
> +	cmd[6] =3D 0x0; /* Low bytes of data */
> +	cmd[7] =3D 0x0; /* Hi bytes of data */
> +	crc =3D cyttsp5_compute_crc(&cmd[4], 4);
> +	cmd[8] =3D LOW_BYTE(crc);
> +	cmd[9] =3D HI_BYTE(crc);
> +	cmd[10] =3D HID_OUTPUT_BL_EOP;
> +
> +	rc =3D cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> +			   HID_OUTPUT_BL_LAUNCH_APP_SIZE);

It seems like you'll send HID_OUTPUT_BL_LAUNCH_APP_SIZE twice here,
once as setup in cyttsp5_write, and once in the buffer you want to
send. Is that on purpose?

> +	if (rc) {
> +		dev_err(ts->dev, "%s: Failed to write command %d",
> +			__func__, rc);
> +		goto error;
> +	}
> +
> +	t =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D 0),
> +			       msecs_to_jiffies(CY_HID_OUTPUT_TIMEOUT));
> +	if (IS_TMO(t)) {
> +		dev_err(ts->dev, "%s: HID output cmd execution timed out\n",
> +			__func__);
> +		rc =3D -ETIME;
> +		goto error;
> +	}
> +
> +	rc =3D cyttsp5_validate_cmd_response(ts, HID_OUTPUT_BL_LAUNCH_APP);
> +	goto exit;
> +
> +error:
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D 0;
> +	mutex_unlock(&ts->system_lock);
> +exit:
> +	return rc;
> +}
> +
> +static int cyttsp5_get_hid_descriptor(struct cyttsp5 *ts,
> +				      struct cyttsp5_hid_desc *desc)
> +{
> +	struct device *dev =3D ts->dev;
> +	__le16 hid_desc_register =3D HID_DESC_REG;
> +	int rc;
> +	int t;
> +	u8 cmd[2];
> +
> +	/* Read HID descriptor length and version */
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D 1;
> +	mutex_unlock(&ts->system_lock);
> +
> +	/* Set HID descriptor register */
> +	memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
> +
> +	regmap_write(ts->regmap, HID_DESC_REG, cmd[0]);
> +	rc =3D regmap_write(ts->regmap, HID_DESC_REG, cmd[1]);
> +	if (rc < 0) {
> +		dev_err(dev, "%s: failed to get HID descriptor, rc=3D%d\n",
> +			__func__, rc);
> +		goto error;
> +	}
> +
> +	t =3D wait_event_timeout(ts->wait_q, (ts->hid_cmd_state =3D=3D 0),
> +			       msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT));
> +	if (IS_TMO(t)) {
> +		dev_err(ts->dev, "%s: HID get descriptor timed out\n",
> +			__func__);
> +		rc =3D -ETIME;
> +		goto error;
> +	}
> +
> +	memcpy((u8 *)desc, ts->response_buf, sizeof(struct cyttsp5_hid_desc));
> +
> +	/* Check HID descriptor length and version */
> +	if (le16_to_cpu(desc->hid_desc_len) !=3D sizeof(*desc) ||
> +	    le16_to_cpu(desc->bcd_version) !=3D HID_VERSION) {
> +		dev_err(dev, "%s: Unsupported HID version\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	goto exit;
> +
> +error:
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state =3D 0;
> +	mutex_unlock(&ts->system_lock);
> +exit:
> +	return rc;
> +}
> +
> +static int fill_tch_abs(struct cyttsp5_tch_abs_params *tch_abs, int repo=
rt_size,
> +			int offset)
> +{
> +	tch_abs->ofs =3D offset / 8;
> +	tch_abs->size =3D report_size / 8;
> +	if (report_size % 8)
> +		tch_abs->size +=3D 1;
> +	tch_abs->min =3D 0;
> +	tch_abs->max =3D 1 << report_size;
> +	tch_abs->bofs =3D offset - (tch_abs->ofs << 3);
> +
> +	return 0;
> +}
> +
> +static int move_button_data(struct cyttsp5 *ts, struct cyttsp5_sysinfo *=
si)
> +{
> +	memcpy(si->xy_mode, ts->input_buf, BTN_INPUT_HEADER_SIZE);
> +	memcpy(si->xy_data, &ts->input_buf[BTN_INPUT_HEADER_SIZE],
> +	       BTN_REPORT_SIZE);
> +
> +	return 0;
> +}
> +
> +static int move_touch_data(struct cyttsp5 *ts, struct cyttsp5_sysinfo *s=
i)
> +{
> +	int max_tch =3D si->sensing_conf_data.max_tch;
> +	int num_cur_tch;
> +	int length;
> +	struct cyttsp5_tch_abs_params *tch =3D &si->tch_hdr;
> +
> +	memcpy(si->xy_mode, ts->input_buf, TOUCH_INPUT_HEADER_SIZE);
> +
> +	cyttsp5_get_touch_axis(&num_cur_tch, tch->size,
> +			       tch->max, si->xy_mode + 3 + tch->ofs, tch->bofs);
> +	if (unlikely(num_cur_tch > max_tch))
> +		num_cur_tch =3D max_tch;
> +
> +	length =3D num_cur_tch * TOUCH_REPORT_SIZE;
> +
> +	memcpy(si->xy_data, &ts->input_buf[TOUCH_INPUT_HEADER_SIZE], length);
> +	return 0;
> +}
> +
> +static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
> +{
> +	struct cyttsp5 *ts =3D handle;
> +	int report_id;
> +	int size;
> +	int rc;
> +
> +	rc =3D cyttsp5_read(ts, ts->input_buf, CY_MAX_INPUT);
> +	if (!rc) {
> +		size =3D get_unaligned_le16(&ts->input_buf[0]);
> +
> +		/* check reset */
> +		if (size =3D=3D 0) {
> +			memcpy(ts->response_buf, ts->input_buf, 2);
> +
> +			ts->hid_cmd_state =3D 0;
> +			wake_up(&ts->wait_q);
> +			mutex_unlock(&ts->system_lock);

It doesn't seem like you've taken that mutex anywhere in the
interrupt. Where is it taken?

Note that taking a mutex in some code path, and releasing it in some
other is pretty confusing, and locks are complicated enough to not
introduce any confusion.

> +			return IRQ_HANDLED;
> +		}
> +
> +		report_id =3D ts->input_buf[2];
> +
> +		if (report_id =3D=3D HID_TOUCH_REPORT_ID) {
> +			move_touch_data(ts, &ts->sysinfo);
> +			cyttsp5_mt_attention(ts->dev);
> +		} else if (report_id =3D=3D HID_BTN_REPORT_ID) {
> +			move_button_data(ts, &ts->sysinfo);
> +			cyttsp5_btn_attention(ts->dev);
> +		} else {
> +			/* It is not an input but a command response */
> +			memcpy(ts->response_buf, ts->input_buf, size);
> +
> +			mutex_lock(&ts->system_lock);
> +			ts->hid_cmd_state =3D 0;
> +			mutex_unlock(&ts->system_lock);

And you take and release that lock here, which is even weirder :)

> +			wake_up(&ts->wait_q);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cyttsp5_deassert_int(struct cyttsp5 *ts)
> +{
> +	u16 size;
> +	u8 buf[2];
> +	int rc;
> +
> +	rc =3D regmap_bulk_read(ts->regmap, 0, buf, 2);
> +	if (rc < 0)
> +		return rc;
> +
> +	size =3D get_unaligned_le16(&buf[0]);
> +	if (size =3D=3D 2 || size =3D=3D 0)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int cyttsp5_fill_all_touch(struct cyttsp5 *ts)
> +{
> +	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
> +
> +	fill_tch_abs(&si->tch_abs[CY_TCH_X], REPORT_SIZE_16,
> +		     TOUCH_REPORT_DESC_X);
> +	fill_tch_abs(&si->tch_abs[CY_TCH_Y], REPORT_SIZE_16,
> +		     TOUCH_REPORT_DESC_Y);
> +	fill_tch_abs(&si->tch_abs[CY_TCH_P], REPORT_SIZE_8,
> +		     TOUCH_REPORT_DESC_P);
> +	fill_tch_abs(&si->tch_abs[CY_TCH_T], REPORT_SIZE_5,
> +		     TOUCH_REPORT_DESC_CONTACTID);
> +	fill_tch_abs(&si->tch_hdr, REPORT_SIZE_5,
> +		     TOUCH_REPORT_DESC_HDR_CONTACTCOUNT);
> +	fill_tch_abs(&si->tch_abs[CY_TCH_MAJ], REPORT_SIZE_8,
> +		     TOUCH_REPORT_DESC_MAJ);
> +	fill_tch_abs(&si->tch_abs[CY_TCH_MIN], REPORT_SIZE_8,
> +		     TOUCH_REPORT_DESC_MIN);
> +
> +	return 0;
> +}
> +
> +static int cyttsp5_startup(struct cyttsp5 *ts)
> +{
> +	int rc;
> +
> +	rc =3D cyttsp5_deassert_int(ts);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Error on deassert int r=3D%d\n",
> +			__func__, rc);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Launch the application as the device starts in bootloader mode
> +	 * because of a power-on-reset
> +	 */
> +	rc =3D cyttsp5_hid_output_bl_launch_app(ts);
> +	if (rc < 0) {
> +		dev_err(ts->dev, "%s: Error on launch app r=3D%d\n",
> +			__func__, rc);
> +		goto exit;
> +	}
> +
> +	rc =3D cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
> +	if (rc < 0) {
> +		dev_err(ts->dev, "%s: Error on getting HID descriptor r=3D%d\n",
> +			__func__, rc);
> +		goto exit;
> +	}
> +
> +	rc =3D cyttsp5_fill_all_touch(ts);
> +	if (rc < 0) {
> +		dev_err(ts->dev, "%s: Error on getting report descriptor r=3D%d\n",
> +			__func__, rc);
> +		goto exit;
> +	}
> +
> +	rc =3D cyttsp5_hid_output_get_sysinfo(ts);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Error on getting sysinfo r=3D%d\n",
> +			__func__, rc);
> +		goto exit;
> +	}
> +
> +exit:
> +
> +	return rc;
> +}
> +
> +static const struct of_device_id cyttsp5_of_match[] =3D {
> +	{ .compatible =3D "cypress,cyttsp5", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cyttsp5_of_match);

You probably want to make that conditional to CONFIG_OF (and use
of_match_ptr on the pointer to that table in your struct driver);

> +
> +static const struct i2c_device_id cyttsp5_i2c_id[] =3D {
> +	{ CYTTSP5_NAME, 0, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);
> +
> +static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int =
irq,
> +			 const char *name)
> +{
> +	struct cyttsp5 *ts;
> +	struct cyttsp5_sysinfo *si;
> +	int rc =3D 0, i;
> +
> +	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts) {
> +		rc =3D -ENOMEM;
> +		goto error_alloc_data;
> +	}
> +
> +	/* Initialize device info */
> +	ts->regmap =3D regmap;
> +	ts->dev =3D dev;
> +	si =3D &ts->sysinfo;
> +	dev_set_drvdata(dev, ts);
> +
> +	/* Initialize mutexes and spinlocks */
> +	mutex_init(&ts->system_lock);
> +	mutex_init(&ts->mt_lock);
> +	mutex_init(&ts->btn_lock);
> +
> +	/* Initialize wait queue */
> +	init_waitqueue_head(&ts->wait_q);
> +
> +	/* Call platform init function */
> +	ts->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH=
);
> +	if (IS_ERR(ts->reset_gpio)) {
> +		rc =3D PTR_ERR(ts->reset_gpio);
> +		dev_err(dev, "Failed to request reset gpio, error %d\n", rc);
> +		return rc;
> +	}
> +
> +	/* Need a delay to have device up */
> +	msleep(20);

In the case where the device has already been out of reset, this means
that this alone is not sufficient to reset it and bring it out of
reset, which also means that you do not have any guarantee on the
current state of the device. I'm not sure how it would impact the
proper operations though.

> +
> +	ts->irq =3D irq;

You don't seem to use ts->irq anywhere else, you can probably just
keep it as a local variable.

> +	rc =3D devm_request_threaded_irq(dev, ts->irq, NULL, cyttsp5_handle_irq,
> +				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				       name, ts);
> +	if (rc) {
> +		dev_err(dev, "unable to request IRQ\n");
> +		goto error_setup_irq;
> +	}
> +
> +	rc =3D cyttsp5_startup(ts);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Fail initial startup r=3D%d\n",
> +			__func__, rc);
> +		goto error_startup;
> +	}
> +
> +	rc =3D cyttsp5_parse_dt_key_code(dev);
> +	if (rc < 0) {
> +		dev_err(ts->dev, "%s: Error while parsing dts\n", __func__);
> +		goto error_startup;
> +	}
> +
> +	ts->input =3D input_allocate_device();
> +	if (!ts->input) {
> +		dev_err(dev, "%s: Error, failed to allocate input device\n",
> +			__func__);
> +		rc =3D -ENODEV;
> +		goto error_startup;
> +	}

In error_startup, you never uninitialize the device. Given your
comment in cyttsp5_startup, this means that you might end up in a
situation where your driver probes again with the device initialized
and no longer in a bootloader mode, which is likely to cause some
error.

Putting the call to cyttsp5_startup later will make you less likely to
fail (especially because of the DT parsing), and putting the device
back into reset will probably address the issue once and for all.

> +	ts->input->name =3D "cyttsp5";
> +	scnprintf(ts->phys, sizeof(ts->phys), "%s/input%d", dev_name(dev), 0);
> +	ts->input->phys =3D ts->phys;
> +	ts->input->dev.parent =3D ts->dev;
> +	input_set_drvdata(ts->input, ts);
> +
> +	touchscreen_parse_properties(ts->input, true, NULL);
> +
> +	if (si) {
> +		__set_bit(EV_KEY, ts->input->evbit);
> +		for (i =3D 0; i < si->num_btns; i++)
> +			__set_bit(si->btn[i].key_code, ts->input->keybit);
> +
> +		rc =3D cyttsp5_setup_input_device(dev);
> +		if (rc)
> +			goto error_init_input;
> +	}
> +
> +	return 0;
> +
> +error_init_input:
> +	input_free_device(ts->input);
> +error_startup:
> +error_setup_irq:
> +	dev_set_drvdata(dev, NULL);
> +error_alloc_data:
> +	dev_err(dev, "%s failed.\n", __func__);

I'm not sure using those __func__ everywhere is worth it, and given
your code, this error log is redundant with the "real" error log you
used before the goto.

> +	if (dev->of_node)
> +		of_node_put(dev->of_node);

I haven't seen any of_node_get, or any function that would do it,
called in your driver so far, why do you need it?

> +
> +	return rc;
> +}
> +
> +static int cyttsp5_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	static const struct regmap_config config =3D {
> +		.reg_bits =3D 8,
> +		.val_bits =3D 8,
> +	};
> +
> +	regmap =3D devm_regmap_init_i2c(client, &config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "%s: regmap allocation failed: %ld\n",
> +			__func__, PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return cyttsp5_probe(&client->dev, regmap, client->irq, client->name);
> +}
> +
> +static int cyttsp5_remove(struct device *dev)
> +{
> +	const struct of_device_id *match;
> +	struct cyttsp5 *ts =3D dev_get_drvdata(dev);
> +
> +	input_unregister_device(ts->input);
> +
> +	dev_set_drvdata(dev, NULL);
> +
> +	match =3D of_match_device(of_match_ptr(cyttsp5_of_match), dev);
> +	if (match && dev->of_node)
> +		of_node_put(dev->of_node);
> +
> +	return 0;
> +}
> +
> +static int cyttsp5_i2c_remove(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +
> +	return cyttsp5_remove(dev);
> +}
> +
> +static struct i2c_driver cyttsp5_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D CYTTSP5_NAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D cyttsp5_of_match,
> +	},
> +	.probe =3D cyttsp5_i2c_probe,
> +	.remove =3D cyttsp5_i2c_remove,
> +	.id_table =3D cyttsp5_i2c_id,
> +};
> +
> +module_i2c_driver(cyttsp5_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Touchscreen driver for Cypress TrueTouch Gen 5 Produ=
ct");
> +MODULE_AUTHOR("Myl=E8ne Josserand <mylene.josserand@free-electrons.com>"=
);

Good work cleaning it up!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wjibihnatzfm4fzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZLScRAAoJEBx+YmzsjxAg49kP/An03MYD2V0C6yVVZgt+mr36
mbrYa2PcPPm1f+hCQftW29GR9VDXO8YhzHPNWVMLV49VZE16H0lpi0wwQvLdYT1S
tddIUhxSl2qlolwEFQxlI7SiZVSOpseAJEHb8rX/HI83voNwBpUN+KqU+hQBgi9s
8oxOD6zq9KikzLyfoCQvbF/61XDROu8t0Q2KkEBGOmrozx1vGAhNwBS/JCOx4I1r
fDgqetTg8CQKu5Ngh2ebYZcckGt4Z//BiKab1fgrjNMETaLfGOyP89jxb71XESzK
S1d4KA/44X1CjRvnz7UoIrb+QKqIs/AbsWVTiYTc5LAsBI4cHRSBQzgr85KhxoUv
pwbr6pKv7Bi5bLta8w8YtihrMEqWEDJ1XfahyqweScLmcv6Lw18P+l1LnGPJ07JV
Bf3VR+q8DV9vde0LljjOf2SLmARpwOxbgBdb4RXpJ3KRsKX0feqrmThfLof3L3Gc
AFgq5L7S1Ln0NjW9EKd3LnCHypD/klf1K9EearbFn4MeslKA0/5f6iieDs74/Nh9
Sd5ThxsAr7cEDbne0y8L8R1PAzTvcnJSVVhZUz+a9SAHU3AN6TdWplnLibMi63Oi
pUQqDh7wo93Kl7W+1hSJMvKWK90Di3sn1Xe4OoPgyje5c5k8yE1p/D59GfEp+tu2
XkWr8tILZFj68Uwi5VWw
=61xS
-----END PGP SIGNATURE-----

--wjibihnatzfm4fzh--
