From: "jeffrey.lin" <yajohn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Mon, 16 May 2016 23:46:51 +0800
Message-ID: <1463413611-367-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jeesw-iQTvn4YitUrQT0dZR+AlfA@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, roger.yang-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, KP.li-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, albert.shieh-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:
I've finished issues under the format you suggested as below.

>#define RM_RESET_MSG_ADDR	0x40000004
>#define RM_FASTBOOT_MSG_ADDR	0x50000620

>#define RM_MAX_READ_SIZE	63
change maximum read size to 56 bytes
#define RM_MAX_READ_SIZE	56

>#define RM_CONTACT_X_POS	1
>#define RM_CONTACT_Y_POS	3
>#define RM_CONTACT_PRESSURE_POS	5 // XXX - check - original was 4
#define RM_CONTACT_PRESSURE_POS	5	/*FIXME, correct 5*/

>#define RM_BL_WRT_CMD_SIZE	3	/* bl flash wrt cmd size */
>#define RM_BL_WRT_PKG_SIZE	32	/* bl wrt pkg size */
>#define RM_BL_WRT_LEN		(RM_BL_WRT_PKG_SIZE + RM_BL_WRT_CMD_SIZE)
>#define RM_FW_PAGE_SIZE		128
>#define RM_MAX_FW_RETRIES	30
additional maximum firmware size for protection
#define RM_MAX_FW_SIZE		(0xD000)	/*define max firmware size*/

>static int raydium_i2c_read_message(struct i2c_client *client,
>				    u32 addr, void *data, size_t len)
>{
>	__be32 be_addr;
>	size_t xfer_len;
>	int error;
>	while (len) {
>		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
>
>		be_addr = cpu_to_be32(addr);
>
>		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
>					 &be_addr, sizeof(be_addr));
>		if (!error)
>			error = raydium_i2c_read(client, addr & 0xff,
>						 data, xfer_len);
Change as:
		if (!error)
			error = raydium_i2c_read(client, (be_addr >> 24) & 0xff,
						 data, xfer_len);

>static int raydium_i2c_send_message(struct i2c_client *client,
>				    u32 addr, const void *data, size_t len)
>{
>	__be32 be_addr = cpu_to_be32(addr);
>	int error;
>	error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
>				 &be_addr, sizeof(be_addr));
>	if (!error)
>		error = raydium_i2c_send(client, addr & 0xff, data, len);
Change as:
		error = raydium_i2c_send(client, (be_addr >> 24) & 0xff,
				data, len);


>static int raydium_i2c_fastboot(struct i2c_client *client)
>{
	/*FIXME;Correct, direct access mode is word alignment*/
>	u8 buf[4];
>	int error;
>
>	error = raydium_i2c_read_message(client, RM_FASTBOOT_MSG_ADDR,
>					 buf, sizeof(buf));

>static int raydium_i2c_check_fw_status(struct raydium_data *ts)
>{
>	struct i2c_client *client = ts->client;
>	static const u8 bl_area[] = { 0x62, 0x6f, 0x6f, 0x74 };
>	static const u8 main_area[] = { 0x66, 0x69, 0x72, 0x6d };
>	u8 buf[4];
>	int error;
>
>	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
>	if (!error) {
>		// XXX FIXME: why do we compare only 1st bytes? Do we even
>		// need 4-byte constants?
>		if (buf[0] == bl_area[0])
>			ts->boot_mode = RAYDIUM_TS_BLDR;
>		else if (buf[0] == main_area[0])
>			ts->boot_mode = RAYDIUM_TS_MAIN;
>		return 0;
>	}
>
>	return error;
>}
Change as below,
static int raydium_i2c_check_fw_status(struct raydium_data *ts)
{
	struct i2c_client *client = ts->client;
	static const u8 bl_ack = 0x62;
	static const u8 main_ack = 0x66;
	u8 buf[4];
	int error;

	error = raydium_i2c_read(client, RM_CMD_BOOT_READ, buf, sizeof(buf));
	if (!error) {
		/*FIXME, changed as one byte comparison*/
		if (buf[0] == bl_ack)
			ts->boot_mode = RAYDIUM_TS_BLDR;
		else if (buf[0] == main_ack)
			ts->boot_mode = RAYDIUM_TS_MAIN;
		return 0;
	}

	return error;
}

>static int raydium_i2c_fw_write_page(struct i2c_client *client,
>				     u8 page_idx, void *data, size_t len)
>{
>	u8 buf[RM_BL_WRT_LEN];
>	u8 pkg_idx = 1;
>	size_t xfer_len;
>	int error;
>
>	while (len) {
>		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
>
>		buf[BL_HEADER] = 0x0b;
>		// XXX FIXME: is this correct? Do we really want all pages
>		// after 1st to have 0xff? Should it be a counter?
>		// Why do we need both pages and packages within pages?
>		buf[BL_PAGE_STR] = page_idx ? 0 : 0xff;
>		buf[BL_PKG_IDX] = pkg_idx;
>		memcpy(&buf[BL_DATA_STR], data, xfer_len);
>
>		error = raydium_i2c_write_object(client, buf, xfer_len,
>						 RAYDIUM_WAIT_READY);
>		if (error) {
>			dev_err(&client->dev,
>				"page write command failed for page %d, chunk %d: %d\n",
>				page_idx, pkg_idx, error);
>			return error;
>		}
>
>		msleep(20);
>
>		data += xfer_len;
>		len -= xfer_len;
>		pkg_idx++;
>	}
>
>	return error;
>}
Because of need fully fill 128bytes in pages, so that function change as below:
static int raydium_i2c_fw_write_page(struct i2c_client *client,
				     u16 page_idx, const void *data, size_t len)
{
	u8 buf[RM_BL_WRT_LEN];
	u8 pkg_idx = 1;
	u8 div_cnt;
	size_t xfer_len;
	int error;
	int i;

	div_cnt = len % RM_BL_WRT_PKG_SIZE ?
		len / RM_BL_WRT_PKG_SIZE + 1:len / RM_BL_WRT_PKG_SIZE;

	for (i = 0; i < div_cnt; i++) {
		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
		/*FIXME,Touch MCU need zero index as start page*/
		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
		buf[BL_PKG_IDX] = pkg_idx++;

		memcpy(&buf[BL_DATA_STR], data, xfer_len);

		if (len == 0)
			memset(buf + BL_DATA_STR, 0xff, RM_BL_WRT_PKG_SIZE);
		else if (len < RM_BL_WRT_PKG_SIZE)
			memset(buf + BL_DATA_STR + xfer_len, 0xff,
			RM_BL_WRT_PKG_SIZE - xfer_len);

		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
						 RAYDIUM_WAIT_READY);
		if (error) {
			dev_err(&client->dev,
				"page write command failed for page %d, chunk %d: %d\n",
				page_idx, pkg_idx, error);
			return error;
		}
		data += RM_BL_WRT_PKG_SIZE;
		len -= RM_BL_WRT_PKG_SIZE;
	}

	return error;
}

>static void raydium_mt_event(struct raydium_data *ts)
>{
>	int i;
>	int error;
memory allocate
	ts->report_data = kmalloc(ts->report_size, GFP_KERNEL);
	if (!ts->report_data)
		return;
>
>	error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
>					 ts->report_data, ts->report_size);
>	if (error) {
>		dev_err(&ts->client->dev, "%s: failed to read data: %d\n",
>			__func__, error);
>		return;
		goto out_of_event;
>	}
>
>
>	for (i = 0; i < ts->report_size / ts->contact_size; i++) {
>		u8 *contact = &ts->report_data[ts->contact_size * i];
>		bool state = contact[RM_CONTACT_STATE_POS];
>		u8 wx, wy;
>
>		input_mt_slot(ts->input, i);
>		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, state);
>
>		if (!state)
>			continue;
>
>		input_report_abs(ts->input, ABS_MT_POSITION_X,
>				get_unaligned_le16(&contact[RM_CONTACT_X_POS]));
>		input_report_abs(ts->input, ABS_MT_POSITION_Y,
>				get_unaligned_le16(&contact[RM_CONTACT_Y_POS]));
>		input_report_abs(ts->input, ABS_MT_PRESSURE,
>				contact[RM_CONTACT_PRESSURE_POS]);
>
>		wx = contact[RM_CONTACT_WIDTH_X_POS];
>		wy = contact[RM_CONTACT_WIDTH_Y_POS];
>
>		input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, max(wx, wy));
>		input_report_abs(ts->input, ABS_MT_TOUCH_MINOR, min(wx, wy));
>	}
>
>	input_mt_sync_frame(ts->input);
>	input_sync(ts->input);
out_of_event:
	kfree(ts->report_data);
>}


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
