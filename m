From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 30 May 2017 10:43:02 +0200
Message-ID: <20170530104302.6db658f0@free-electrons.com>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
        <20170529144538.29187-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170529144538.29187-2-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

A few more comments :)

On Mon, 29 May 2017 16:45:37 +0200, Mylène Josserand wrote:
> +struct cyttsp5 {
> +	struct device *dev;
> +	struct mutex system_lock;
> +	struct mutex btn_lock;
> +	struct mutex mt_lock;

Three mutexes for such a driver is probably excessive, especially when
they are in fact used "sequentially".

> +static int cyttsp5_parse_dt_key_code(struct device *dev)
> +{
> +	struct cyttsp5 *ts = dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> +	struct device_node *np, *pp;
> +	int rc, i;
> +
> +	np = dev->of_node;
> +	if (!np)
> +		return -EINVAL;
> +
> +	if (si->num_btns) {

Invert the test, and remove one indentation level:

	if (!si->num_btns)
		return 0;

> +		si->btn = devm_kzalloc(dev,
> +				       si->num_btns * sizeof(struct cyttsp5_btn),
> +				       GFP_KERNEL);
> +		if (!si->btn)
> +			return -ENOMEM;
> +
> +		/* Initialized the button to RESERVED */

Initialized -> Initialize

> +		for (i = 0; i < si->num_btns; i++) {
> +			struct cyttsp5_btn *btns = &si->btn[i];
> +			btns->key_code = KEY_RESERVED;
> +			btns->enabled = true;

Does it make sense to have the button as "enabled" when it in fact
isn't really? Also setting btns->enabled = true is done again below.

> +		}
> +	}
> +
> +	i = 0;
> +	for_each_child_of_node(np, pp) {
> +		struct cyttsp5_btn *btns = &si->btn[i];
> +
> +		rc = of_property_read_u32(pp, "linux,code", &btns->key_code);
> +		if (rc) {
> +			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
> +			return -EINVAL;

Propagate "rc".

> +		}

Add blank line here.

> +		btns->enabled = true;
> +
> +		i++;
> +	}

si->num_btns comes from the HW (calculated in function
cyttsp5_si_get_btn_data), but then you are trusting the DT to have the
exact same number of buttons.

If the DT has more button that si->num_btns, then you have a buffer
overflow here because you for_each_child_of_node() loop will loop after
the end of si->btn[].

> +static int cyttsp5_btn_attention(struct device *dev)
> +{
> +	struct cyttsp5 *ts = dev_get_drvdata(dev);
> +	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> +	int cur_btn;
> +	int cur_btn_state;
> +
> +	if (si->xy_mode[2] != HID_BTN_REPORT_ID)
> +		return 0;
> +
> +	/* core handles handshake */
> +	mutex_lock(&ts->btn_lock);
> +
> +	/* extract button press/release touch information */
> +	if (si->num_btns > 0) {

Invert this test:

	if (!si->num_btns)
		return 0;

and then you save one indentation level.

Of course, move the test outside the mutex lock/unlock section.


> +static void cyttsp5_si_get_btn_data(struct cyttsp5 *ts)
> +{
> +	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> +	int i;
> +	int num_btns = 0;
> +	unsigned int btns = ts->response_buf[HID_SYSINFO_BTN_OFFSET]
> +		& HID_SYSINFO_BTN_MASK;
> +
> +	for (i = 0; i < HID_SYSINFO_MAX_BTN; i++) {
> +		if (btns & (1 << i))

Replace (1 << i) by BIT(i)

> +			num_btns++;
> +	}
> +	si->num_btns = num_btns;

Does it really make sense to have a temporary variable, rather than
using si->num_btns directly?

> +static int cyttsp5_get_sysinfo_regs(struct cyttsp5 *ts)
> +{
> +	struct cyttsp5_sensing_conf_data *scd = &ts->sysinfo.sensing_conf_data;
> +	struct cyttsp5_sensing_conf_data_dev *scd_dev =
> +		(struct cyttsp5_sensing_conf_data_dev *)
> +		&ts->response_buf[HID_SYSINFO_SENSING_OFFSET];
> +	struct cyttsp5_sysinfo *si = &ts->sysinfo;
> +
> +	cyttsp5_si_get_btn_data(ts);
> +
> +	scd->max_tch = scd_dev->max_num_of_tch_per_refresh_cycle;
> +	scd->res_x = get_unaligned_le16(&scd_dev->res_x);
> +	scd->res_y = get_unaligned_le16(&scd_dev->res_y);
> +	scd->max_z = get_unaligned_le16(&scd_dev->max_z);
> +	scd->len_x = get_unaligned_le16(&scd_dev->len_x);
> +	scd->len_y = get_unaligned_le16(&scd_dev->len_y);
> +
> +	si->xy_data = devm_kzalloc(ts->dev, scd->max_tch * TOUCH_REPORT_SIZE,
> +				   GFP_KERNEL);
> +	if (!si->xy_data)
> +		return -ENOMEM;
> +
> +	si->xy_mode = devm_kzalloc(ts->dev, TOUCH_INPUT_HEADER_SIZE, GFP_KERNEL);
> +	if (!si->xy_mode) {
> +		devm_kfree(ts->dev, si->xy_data);

The point of devm_kzalloc() is to not need to do a devm_kfree(). Of
course, check you're doing this only in the ->probe() but it seems to
be the case.

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
> +	ts->hid_cmd_state = HID_OUTPUT_GET_SYSINFO + 1;
> +	mutex_unlock(&ts->system_lock);

This is called only from the _startup() function, itself called from
the _probe() function. So taking a mutex is useless here, there is no
concurrency.

This hid_cmd_state thing is a bit strange. It's set to the following
values:

+	ts->hid_cmd_state = 1;
+	ts->hid_cmd_state = HID_OUTPUT_GET_SYSINFO + 1;
+	ts->hid_cmd_state = HID_OUTPUT_BL_LAUNCH_APP + 1;

and when the interrupt occurs it's set back to 0.

So: why those values? Why this "1" and then those magic values + 1 ? Do
you need something else than BUSY/DONE ?

What about:

	enum { HID_CMD_DONE, HID_CMD_BUSY } hid_cmd_state;

> +
> +	/* HI bytes of Output register address */
> +	cmd[0] = LOW_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> +	cmd[1] = HI_BYTE(HID_OUTPUT_GET_SYSINFO_SIZE);
> +	cmd[2] = HID_APP_OUTPUT_REPORT_ID;
> +	cmd[3] = 0x0; /* Reserved */
> +	cmd[4] = HID_OUTPUT_GET_SYSINFO;
> +
> +	rc = cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> +			   HID_OUTPUT_GET_SYSINFO_SIZE);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Failed to write command %d",
> +			__func__, rc);
> +		goto error;
> +	}
> +
> +	t = wait_event_timeout(ts->wait_q, (ts->hid_cmd_state == 0),
> +			       msecs_to_jiffies(CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT));
> +	if (IS_TMO(t)) {

I don't think this IS_TMO() macro makes sense. And you case use "rc" as
the return value.

> +		dev_err(ts->dev, "%s: HID output cmd execution timed out\n",
> +			__func__);
> +		rc = -ETIME;
> +		goto error;
> +	}
> +
> +	rc = cyttsp5_validate_cmd_response(ts, HID_OUTPUT_GET_SYSINFO);
> +	goto exit;

It's really weird for the "normal" case to jump to an "exit" label. Why
don't you handle the normal case here? Also, this code means that
you're currently ignoring the return value of
cyttsp5_validate_cmd_response().

> +
> +error:
> +	mutex_lock(&ts->system_lock);
> +	ts->hid_cmd_state = 0;
> +	mutex_unlock(&ts->system_lock);
> +	return rc;
> +exit:
> +	rc = cyttsp5_get_sysinfo_regs(ts);
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
> +	ts->hid_cmd_state = HID_OUTPUT_BL_LAUNCH_APP + 1;
> +	mutex_unlock(&ts->system_lock);
> +
> +	cmd[0] = LOW_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +	cmd[1] = HI_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +	cmd[2] = HID_BL_OUTPUT_REPORT_ID;
> +	cmd[3] = 0x0; /* Reserved */
> +	cmd[4] = HID_OUTPUT_BL_SOP;
> +	cmd[5] = HID_OUTPUT_BL_LAUNCH_APP;
> +	cmd[6] = 0x0; /* Low bytes of data */
> +	cmd[7] = 0x0; /* Hi bytes of data */
> +	crc = cyttsp5_compute_crc(&cmd[4], 4);
> +	cmd[8] = LOW_BYTE(crc);
> +	cmd[9] = HI_BYTE(crc);
> +	cmd[10] = HID_OUTPUT_BL_EOP;
> +
> +	rc = cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
> +			   HID_OUTPUT_BL_LAUNCH_APP_SIZE);
> +	if (rc) {
> +		dev_err(ts->dev, "%s: Failed to write command %d",
> +			__func__, rc);
> +		goto error;
> +	}
> +
> +	t = wait_event_timeout(ts->wait_q, (ts->hid_cmd_state == 0),
> +			       msecs_to_jiffies(CY_HID_OUTPUT_TIMEOUT));
> +	if (IS_TMO(t)) {
> +		dev_err(ts->dev, "%s: HID output cmd execution timed out\n",
> +			__func__);
> +		rc = -ETIME;
> +		goto error;
> +	}
> +
> +	rc = cyttsp5_validate_cmd_response(ts, HID_OUTPUT_BL_LAUNCH_APP);
> +	goto exit;

Same comments as for the previous function.

> +	/* Set HID descriptor register */
> +	memcpy(cmd, &hid_desc_register, sizeof(hid_desc_register));
> +
> +	regmap_write(ts->regmap, HID_DESC_REG, cmd[0]);

Return value?

> +	rc = regmap_write(ts->regmap, HID_DESC_REG, cmd[1]);

Why are you sending these through two regmap_write() calls and not a
regmap_bulk_write() ?

> +	if (rc < 0) {
> +		dev_err(dev, "%s: failed to get HID descriptor, rc=%d\n",
> +			__func__, rc);
> +		goto error;
> +	}
> +
> +	t = wait_event_timeout(ts->wait_q, (ts->hid_cmd_state == 0),
> +			       msecs_to_jiffies(CY_HID_GET_HID_DESCRIPTOR_TIMEOUT));
> +	if (IS_TMO(t)) {

Same comment as above: don't use IS_TMO(), use "rc" instead of "t".

> +		dev_err(ts->dev, "%s: HID get descriptor timed out\n",
> +			__func__);
> +		rc = -ETIME;
> +		goto error;
> +	}
> +
> +	memcpy((u8 *)desc, ts->response_buf, sizeof(struct cyttsp5_hid_desc));

I don't see why the u8* cast would be needed here.

> +static int fill_tch_abs(struct cyttsp5_tch_abs_params *tch_abs, int report_size,
> +			int offset)
> +{
> +	tch_abs->ofs = offset / 8;
> +	tch_abs->size = report_size / 8;
> +	if (report_size % 8)
> +		tch_abs->size += 1;
> +	tch_abs->min = 0;
> +	tch_abs->max = 1 << report_size;
> +	tch_abs->bofs = offset - (tch_abs->ofs << 3);
> +
> +	return 0;
> +}
> +
> +static int move_button_data(struct cyttsp5 *ts, struct cyttsp5_sysinfo *si)
> +{
> +	memcpy(si->xy_mode, ts->input_buf, BTN_INPUT_HEADER_SIZE);
> +	memcpy(si->xy_data, &ts->input_buf[BTN_INPUT_HEADER_SIZE],
> +	       BTN_REPORT_SIZE);
> +
> +	return 0;
> +}
> +
> +static int move_touch_data(struct cyttsp5 *ts, struct cyttsp5_sysinfo *si)
> +{
> +	int max_tch = si->sensing_conf_data.max_tch;
> +	int num_cur_tch;
> +	int length;
> +	struct cyttsp5_tch_abs_params *tch = &si->tch_hdr;
> +
> +	memcpy(si->xy_mode, ts->input_buf, TOUCH_INPUT_HEADER_SIZE);
> +
> +	cyttsp5_get_touch_axis(&num_cur_tch, tch->size,
> +			       tch->max, si->xy_mode + 3 + tch->ofs, tch->bofs);
> +	if (unlikely(num_cur_tch > max_tch))
> +		num_cur_tch = max_tch;
> +
> +	length = num_cur_tch * TOUCH_REPORT_SIZE;
> +
> +	memcpy(si->xy_data, &ts->input_buf[TOUCH_INPUT_HEADER_SIZE], length);

Blank line here.

> +	return 0;
> +}
> +
> +static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
> +{
> +	struct cyttsp5 *ts = handle;
> +	int report_id;
> +	int size;
> +	int rc;
> +
> +	rc = cyttsp5_read(ts, ts->input_buf, CY_MAX_INPUT);
> +	if (!rc) {

Same as usual: to remove one indentation level, invert the test, by
doing:

	if (rc)
		return IRQ_HANDLED;


> +static int cyttsp5_deassert_int(struct cyttsp5 *ts)
> +{
> +	u16 size;
> +	u8 buf[2];
> +	int rc;
> +
> +	rc = regmap_bulk_read(ts->regmap, 0, buf, 2);

Which register are you reading here?

> +	scnprintf(ts->phys, sizeof(ts->phys), "%s/input%d", dev_name(dev), 0);

Why use %d if the value is always 0 ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
