From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Wed, 18 May 2016 00:07:02 +0800
Message-ID: <1463501223-20723-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33809 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbcEQQHR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 12:07:17 -0400
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Dmitry:
> >static int raydium_i2c_read_message(struct i2c_client *client,
> >				    u32 addr, void *data, size_t len)
> >{
> >	__be32 be_addr;
> >	size_t xfer_len;
> >	int error;
> >	while (len) {
> >		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
> >
> >		be_addr = cpu_to_be32(addr);
> >
> >		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
> >					 &be_addr, sizeof(be_addr));
> >		if (!error)
> >			error = raydium_i2c_read(client, addr & 0xff,
> >						 data, xfer_len);
> Change as:
> 		if (!error)
> 			error = raydium_i2c_read(client, (be_addr >> 24) & 0xff,
> 						 data, xfer_len);

>I think it is the same on LE, and I suspect it will not work correctly
>on BE... You want to have the 8 least significant bits of the bank to be
>used as the address, right?
This function work correctly with the kernel 3.18 of chromebook in my hand. Raydium touch direct access mode can recieve the BE address after bank switch command 0xaa. For example, if we'll read 10 bytes data begin on 0x12345678. We need send the command sequences as 0xaa-> 0x12->0x34->0x56-> 0x78 and then recive 10 bytes from 0x78.

> static int raydium_i2c_fw_write_page(struct i2c_client *client,
> 				     u16 page_idx, const void *data, size_t len)
> {
> 	u8 buf[RM_BL_WRT_LEN];
> 	u8 pkg_idx = 1;
> 	u8 div_cnt;
> 	size_t xfer_len;
> 	int error;
> 	int i;
> 
> 	div_cnt = len % RM_BL_WRT_PKG_SIZE ?
> 		len / RM_BL_WRT_PKG_SIZE + 1:len / RM_BL_WRT_PKG_SIZE;
>
>Drop this. BTW, if you ever need it we have DIV_ROUND_UP macro.

> 
> 	for (i = 0; i < div_cnt; i++) {
>
>	while (len) {
>
> 		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
> 		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
> 		/*FIXME,Touch MCU need zero index as start page*/
> 		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
> 		buf[BL_PKG_IDX] = pkg_idx++;
> 
> 		memcpy(&buf[BL_DATA_STR], data, xfer_len);
>
>		/* we need to pad to full page size */
>		if (len < RM_BL_WRT_PKG_SIZE)
>			memset(&buf[BL_DATA_STR] + len, 0xff,
>				RM_BL_WRT_PKG_SIZE - len);
> 
> 		if (len == 0)
> 			memset(buf + BL_DATA_STR, 0xff, RM_BL_WRT_PKG_SIZE);
> 		else if (len < RM_BL_WRT_PKG_SIZE)
> 			memset(buf + BL_DATA_STR + xfer_len, 0xff,
> 			RM_BL_WRT_PKG_SIZE - xfer_len);
> 
> 		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
> 						 RAYDIUM_WAIT_READY);
> 		if (error) {
> 			dev_err(&client->dev,
> 				"page write command failed for page %d, chunk %d: %d\n",
> 				page_idx, pkg_idx, error);
> 			return error;
> 		}
> 		data += RM_BL_WRT_PKG_SIZE;
> 		len -= RM_BL_WRT_PKG_SIZE;
> 	}
> 
> 	return error;
> }
Modify as below.

static int raydium_i2c_fw_write_page(struct i2c_client *client,
				     u16 page_idx, const void *data, size_t len)
{
	u8 buf[RM_BL_WRT_LEN];
	u8 pkg_idx = 1;
	size_t xfer_len;
	int error;

	while (len) {
		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
		/*FIXME,Touch MCU need zero index as start page*/
		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
		buf[BL_PKG_IDX] = pkg_idx++;

		memcpy(&buf[BL_DATA_STR], data, xfer_len);

		if (len < RM_BL_WRT_PKG_SIZE) {
			buf[BL_PKG_IDX] = 4;
			memset(buf + BL_DATA_STR + xfer_len, 0xff,
				RM_BL_WRT_PKG_SIZE - xfer_len);
		}

		error = raydium_i2c_write_object(client, buf, RM_BL_WRT_LEN,
						 RAYDIUM_WAIT_READY);
		if (error) {
			dev_err(&client->dev,
				"page write command failed for page %d, chunk %d: %d\n",
				page_idx, pkg_idx, error);
			return error;
		}
		data += xfer_len;
		len -= xfer_len;
	}

	return error;
> 
> >static void raydium_mt_event(struct raydium_data *ts)
> >{
> >	int i;
> >	int error;
> memory allocate
> 	ts->report_data = kmalloc(ts->report_size, GFP_KERNEL);
> 	if (!ts->report_data)
> 		return;
>
>I thought I was allocating it after I queried the touchscreen
>parameters... If not it was oversight. I do not think we should be
>doing this on every interrupt, so please do the allocation in ->probe()
>code.
Move memory allocate to raydium_i2c_probe(). 
