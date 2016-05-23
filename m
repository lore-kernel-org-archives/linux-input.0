From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Mon, 23 May 2016 22:43:53 +0800
Message-ID: <1464014633-20829-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:

>static int raydium_i2c_read_message(struct i2c_client *client,
>				    u32 addr, void *data, size_t len)
>{
>	__le32 le_addr;
>	size_t xfer_len;
>	u32 shift_addr;
>	int error;
>
>	while (len) {
>		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
>
>		le_addr = cpu_to_le32(addr);
>
>		shift_addr = le_addr >> 8;/*send the first 3rd byte addr.*/
Drop this. Change touch MCU setting to solve this issue
>		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
>					 &shift_addr, sizeof(le_addr));
>		if (!error)/*read from last byte addr.*/
>			error = raydium_i2c_read(client, le_addr & 0xff,
>						 data, xfer_len);
>		if (error)
>			return error;
>
>		len -= xfer_len;
>		data += xfer_len;
>		addr += xfer_len;
>	}
>
>	return 0;
>}
modify as below.

static int raydium_i2c_read_message(struct i2c_client *client,
				    u32 addr, void *data, size_t len)
{
	__le32 le_addr;
	size_t xfer_len;
	int error;

	while (len) {
		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);

		le_addr = cpu_to_le32(addr);

		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
					 &le_addr, sizeof(le_addr));
		if (!error)/*read from last byte addr.*/
			error = raydium_i2c_read(client, le_addr & 0xff,
						 data, xfer_len);
		if (error)
			return error;

		len -= xfer_len;
		data += xfer_len;
		addr += xfer_len;
	}

	return 0;
}

>
>>> static int raydium_i2c_fw_write_page(struct i2c_client *client,
>>> 				     u16 page_idx, const void *data, size_t len)
>>> {
>>> 	u8 buf[RM_BL_WRT_LEN];
>>> 	u8 pkg_idx = 1;
>>> 	size_t xfer_len;
>>> 	int error;
>>> 
>>> 	while (len) {
>>> 		xfer_len = min_t(size_t, len, RM_BL_WRT_PKG_SIZE);
>>> 		buf[BL_HEADER] = RM_CMD_BOOT_PAGE_WRT;
>>> 		/*FIXME,Touch MCU need zero index as start page*/
>>> 		buf[BL_PAGE_STR] = page_idx ? 0xff : 0;
>>> 		buf[BL_PKG_IDX] = pkg_idx++;
>>> 
>>> 		memcpy(&buf[BL_DATA_STR], data, xfer_len);
>>> 
>>> 		if (len < RM_BL_WRT_PKG_SIZE) {
>>> 			buf[BL_PKG_IDX] = 4;
Drop this one. Modfy boot loader firmware to meet this issue. So final function as below.
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
}
Otherwise, Do you have any concern about my patch? If not, I'll send new patch soon.

Thanks.

Jeffrey
